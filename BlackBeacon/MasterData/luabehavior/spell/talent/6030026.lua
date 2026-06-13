local M = Util.create_class()

function M:_init()
end

function M:on_npc_removed(npc)
  if npc ~= self.npc then
    cast_magic(self.npc, self.npc, 6031058, 1)
    cast_magic(self.npc, self.npc, 6031059, 1)
    cast_magic(self.npc, self.npc, 6031060, 1)
  end
end

return M
