local M = Util.create_class()
local hero = get_come_on_hero()

function M:_init(npc)
  self.CD = 0
  self.CD_levelup = 5
end

function M:on_start()
  self.level = get_ability_level(60013) or 1
  if self.level > 1 then
    self.CD_levelup = 2.5
  end
end

function M:on_room_change(npc)
  self.level = get_ability_level(60013) or 1
  if self.level > 1 then
    self.CD_levelup = 2.5
  end
end

function M:after_damage_self(npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if check_npc_die(self.npc) or self.npc ~= get_come_on_hero() then
    return
  end
  local kind = get_role_kind(npc)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  local shield = get_npc_attr(self.npc, 71)
  if self.CD < get_npc_time(self.npc) and check_magic(self.npc, 61710011) and shield > 0 then
    cast_missile3(self.npc, nil, nil, nil, 61710910403, 1)
    cast_missile3(self.npc, nil, nil, nil, 61710910404, 1)
    self.CD = get_npc_time(self.npc) + self.CD_levelup
  end
end

return M
