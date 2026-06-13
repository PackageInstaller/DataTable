local M = Util.create_class()
local tool = import("common.tool")
local roleTool = import("common.role_tool")
local time_sphere = get_god_npc()

function M:on_start()
end

function M:_init(npc)
end

function M:before_damage_target(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  if (2 == get_role_kind(target) or 3 == get_role_kind(target) or 4 == get_role_kind(target)) and get_magic_kind_num(target, 10) >= 1 then
    local level = get_ability_level(20024) or 1
    cast_magic(self.npc, target, 61706381, level)
  end
end

return M
