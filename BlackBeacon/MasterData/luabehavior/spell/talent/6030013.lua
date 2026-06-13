local M = Util.create_class()

function M:_init()
end

function M:on_superarmor_break(npc, camp)
  if 2 == camp then
    cast_missile(self.npc, self.npc, nil, nil, 10019010101, 1)
  end
end

return M
