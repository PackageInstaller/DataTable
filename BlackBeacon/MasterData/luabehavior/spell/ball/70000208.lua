local M = Util.create_class()

function M:_init()
end

function M:on_start()
  if get_come_on_hero() ~= self.npc then
    cast_magic(self.npc, self.npc, 7000020801, 1)
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc == self.npc and false == is_showup then
    cast_magic(self.npc, self.npc, 7000020801, 1)
  elseif npc == self.npc and true == is_showup then
    abort_magic_by_id(self.npc, 7000020801, 1)
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  if npc == self.npc and 7 == damage_sign and check_element_ab_state(target) then
    cast_magic(self.npc, self.npc, 7000020802, 1)
  end
end

return M
