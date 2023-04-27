--[[
    title: Which Book
    aouthor: Zombine
    date: 27/04/2023
    version: 1.2.4
]]

local mod = get_mod("which_book")
local MissionObjectiveTemplates = require("scripts/settings/mission_objective/mission_objective_templates")

local is_scripture = function(icon)
    return icon == MissionObjectiveTemplates.side_mission.objectives.side_mission_tome.icon
end

mod:hook("MissionBoardView", "init", function(func, self, settings)
    local side_mission_objectives = MissionObjectiveTemplates.side_mission.objectives

    Managers.package:load("packages/ui/hud/player_weapon/player_weapon", "MissionBoardView", nil)
    side_mission_objectives.side_mission_grimoire.icon = mod:get("wb_grimoire")
    side_mission_objectives.side_mission_tome.icon = mod:get("wb_scripture")

    func(self, settings)
end)

mod:hook_safe("MissionBoardView", "_populate_mission_widget", function(self, widget)
    local icon = widget.content.objective_2_icon
    local style = widget.style.objective_2_icon

    if icon then
        style.size_addition = nil
        if mod:get("wb_scrip_color") and is_scripture(icon) then
            style.color = {mod:get("wb_scrip_a"), mod:get("wb_scrip_r"), mod:get("wb_scrip_g"), mod:get("wb_scrip_b")}
        elseif mod:get("wb_custom_color") then
            style.color = {mod:get("wb_custom_a"), mod:get("wb_custom_r"), mod:get("wb_custom_g"), mod:get("wb_custom_b")}
        end
    end
end)

mod:hook_safe("MissionBoardView", "on_exit", function()
    local side_mission_objectives = MissionObjectiveTemplates.side_mission.objectives
    local default_icon = "content/ui/materials/icons/mission_types/mission_type_08"

    side_mission_objectives.side_mission_grimoire.icon = default_icon
    side_mission_objectives.side_mission_tome.icon = default_icon
end)