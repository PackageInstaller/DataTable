local M = Util.create_class()

function M:_init()
  self.elementType = nil
  self.check = true
end

function M:on_start()
end

function M:on_element_aborn_start(npc, element)
  if self.npc ~= get_come_on_hero() and element == self.elementType then
    cast_magic(self.npc, npc, 4033640101, 1)
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if self.check then
    self.elementType = damage_type
  end
end

return M
