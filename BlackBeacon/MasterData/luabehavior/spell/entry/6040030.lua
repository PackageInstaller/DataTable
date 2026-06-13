local M = Util.create_class()

function M:_init()
end

function M:on_before_npc_hp_zero(npc)
  if npc == self.npc then
    cast_missile(self.npc, self.npc, nil, nil, 60400000101, 1)
    cast_missile(self.npc, self.npc, nil, nil, 60400000102, 0)
  end
end

return M
