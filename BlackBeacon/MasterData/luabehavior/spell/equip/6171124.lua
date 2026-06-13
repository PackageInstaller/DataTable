local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:on_start()
  self.init_time = get_npc_time(self.npc)
  self.cd = 0
  self.level = get_ability_level(10015) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(10015) or 1
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local kind = get_role_kind(target)
  if kind < 2 or kind > 4 then
    return
  end
  if 7 == damage_sign and get_npc_time(self.npc) > self.init_time + self.cd then
    cast_missile3(self.npc, self.npc, nil, nil, 61711910407, self.level)
    self.cd = 3
    self.init_time = get_npc_time(self.npc)
  end
end

function M:_init(npc)
end

return M
