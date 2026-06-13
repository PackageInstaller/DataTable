local M = Util.create_class()

function M:_init()
end

function M:on_start()
  cast_magic(self.npc, self.npc, 7000020101, 0)
end

function M:on_element_aborn_start(npc, element, skill_id, attacker)
  if 3 == element and attacker == self.npc then
    cast_magic(npc, npc, 7000020102, 0)
  end
end

function M:on_element_aborn_end(npc, element, attacker)
  if 3 == element and attacker == self.npc then
    abort_magic_by_id(npc, 7000020102, 1)
  end
end

return M
