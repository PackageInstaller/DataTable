local M = Util.create_class()

function M:_init()
end

function M:on_start()
end

function M:on_element_aborn_start(npc, element, skill_id, attacker)
  if 2 == element and attacker == self.npc then
    cast_magic(self.npc, npc, 7000020601, 0)
  end
  if 1 == element and attacker == self.npc then
    cast_magic(self.npc, npc, 7000020603, 0)
  end
end

function M:on_element_aborn_end(npc, element, attacker)
  if 2 == element and attacker == self.npc then
    abort_magic_by_id(npc, 7000020601, 1)
  end
end

return M
