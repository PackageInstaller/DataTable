local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:on_start()
  rogueMgr.level_6170834 = get_ability_level(50020) or 1
end

function M:on_room_change(npc)
  rogueMgr.level_6170834 = get_ability_level(50020) or 1
end

function M:before_damage_target(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  if (2 == get_role_kind(target) or 3 == get_role_kind(target) or 4 == get_role_kind(target)) and not check_magic(target, 61708341) then
    cast_magic(self.npc, target, 61708341)
  end
end

return M
