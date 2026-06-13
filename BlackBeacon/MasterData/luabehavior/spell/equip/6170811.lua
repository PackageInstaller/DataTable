local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:on_start()
  rogueMgr.toughness_damage_up = true
  self.level = get_ability_level(50009) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(50009) or 1
end

function M:on_remove()
  local bool, num = tool:checkMagicToTeam(6170811)
  if 0 == num then
    rogueMgr.toughness_damage_up = false
  end
end

function M:before_damage_target(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  if (2 == get_role_kind(target) or 3 == get_role_kind(target) or 4 == get_role_kind(target)) and check_npc_status(target, 14) then
    cast_magic(self.npc, self.npc, 61708111, self.level)
  end
end

return M
