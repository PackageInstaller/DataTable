local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local water_control_enemy = 61709331
local water_dot_damage = 61709211
local add_time = 0

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if npc ~= self.npc then
    return
  end
  if magic_id == water_dot_damage and get_magic_num(self.npc, 61709212) < 5 then
    cast_magic(self.npc, self.npc, 61709212, self.level)
  end
end

function M:_init(npc)
  rogueMgr.dot_friend = true
end

function M:on_start()
  self.level = get_ability_level(30012) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(30012) or 1
  if check_magic(self.npc, 61709212) then
    abort_magic_by_id(self.npc, 61709212)
  end
end

function M:on_room_pass(room_id)
  if check_magic(self.npc, 61709212) then
    abort_magic_by_id(self.npc, 61709212)
  end
end

function M:on_remove()
  local bool, num = tool:checkMagicToTeam(6170921)
  if 0 == num then
    rogueMgr.dot_friend = false
  end
end

return M
