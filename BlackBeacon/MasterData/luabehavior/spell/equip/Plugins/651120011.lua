local M = Util.create_class()

function M:_init()
  self.cast_time = 0
  self.cd = 0
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if self.npc ~= get_come_on_hero() and get_npc_time(self.npc) >= self.cast_time + self.cd then
    if 2 == get_active_char_element(self.npc) then
      cast_magic(self.npc, self.npc, 651120012, self.level)
    end
    if 3 == get_active_char_element(self.npc) then
      cast_magic(self.npc, self.npc, 651120013, self.level)
    end
    if 4 == get_active_char_element(self.npc) then
      cast_magic(self.npc, self.npc, 651120014, self.level)
    end
    if 5 == get_active_char_element(self.npc) then
      cast_magic(self.npc, self.npc, 651120015, self.level)
    end
    if 6 == get_active_char_element(self.npc) then
      cast_magic(self.npc, self.npc, 651120016, self.level)
    end
    self.cast_time = get_npc_time(self.npc)
    self.cd = 0.3
  end
end

function M:on_start()
  self.level = get_develop_level(self.npc, 6, 651120011)
end

return M
