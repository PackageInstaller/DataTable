local M = Util.create_class()

function M:_init()
end

function M:on_start()
  if get_come_on_hero() == self.npc then
    cast_magic(self.npc, get_god_npc(), 7000020201, 0)
  end
end

function M:on_element_aborn_end(npc, element, attacker)
end

return M
