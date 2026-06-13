local M = Util.create_class()

function M:_init()
  self.magic_set = 0
end

function M:on_room_change(npc)
  if npc ~= self.npc then
    return
  end
  if get_npc_attr(self.npc, 1) / get_npc_attr(self.npc, 4) < 0.15 then
    cast_magic(self.npc, self.npc, 6021040, 1)
  end
end

return M
