local M = Util.create_class()

function M:_init()
end

function M:on_before_npc_hp_zero(npc)
  if npc == self.npc then
    cast_missile(self.npc, self.npc, nil, nil, 60400000103, 0)
    cast_missile(self.npc, self.npc, nil, nil, 60400000104, 0)
  end
end

return M
