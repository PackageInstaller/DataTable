local M = Util.create_class()

function M:_init()
  self.cast_time = 0
  self.cd = 0
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if self.npc ~= get_come_on_hero() and get_npc_time(self.npc) >= self.cast_time + self.cd then
    cast_magic(self.npc, self.npc, 651120022, self.level)
    self.cast_time = get_npc_time(self.npc)
    self.cd = 0.3
  end
end

function M:on_start()
  self.level = get_develop_level(self.npc, 6, 651120021)
end

return M
