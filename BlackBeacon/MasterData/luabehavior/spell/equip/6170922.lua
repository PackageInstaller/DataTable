local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local water_dot_enemy = 61709222
local add_time = 0

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if magic_id == water_dot_enemy and get_magic_num(self.npc, 61709223) < 5 then
    cast_magic(self.npc, self.npc, 61709223, self.level)
  end
end

function M:_init(npc)
  rogueMgr.dot_enemy = true
  self.level = get_ability_level(30013) or 1
end

function M:on_room_pass(room_id)
  if check_magic(self.npc, 61709223) then
    abort_magic_by_id(self.npc, 61709223)
  end
  self.level = get_ability_level(30013) or 1
end

function M:on_remove()
  local bool, num = tool:checkMagicToTeam(6170922)
  if 0 == num then
    rogueMgr.dot_enemy = false
  end
end

return M
