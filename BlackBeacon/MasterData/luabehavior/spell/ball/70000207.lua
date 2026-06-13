local M = Util.create_class()

function M:_init()
end

function M:on_start()
end

function M:on_skill_begin(npc, skill_id, skill_type)
end

function M:on_element_aborn_start(npc, element, skill_id, attacker)
  if 6 == element and attacker == self.npc then
    if check_element_ab_state(npc, 3) then
      cast_magic(attacker, npc, 7000020701, 2)
      cast_magic(attacker, npc, 7000020702, 2)
    else
      cast_magic(attacker, npc, 7000020701, 1)
    end
  end
  if 3 == element and attacker == self.npc then
    if check_element_ab_state(npc, 5) then
      cast_magic(attacker, npc, 7000020701, 2)
      cast_magic(attacker, npc, 7000020702, 2)
    else
      cast_magic(self.npc, npc, 7000020702, 1)
    end
  end
end

function M:on_element_aborn_end(npc, element, attacker)
  if 6 == element and attacker == self.npc then
    abort_magic_by_id(npc, 7000020701, 1)
    if check_element_ab_state(npc, 3) then
      abort_magic_by_id(npc, 7000020702, 1)
      cast_magic(npc, npc, 7000020702, 1)
    end
  end
  if 3 == element and attacker == self.npc then
    abort_magic_by_id(npc, 7000020702, 1)
    if check_element_ab_state(npc, 5) then
      abort_magic_by_id(npc, 7000020701, 1)
      cast_magic(npc, npc, 7000020701, 1)
    end
  end
end

return M
