local M = Util.create_class()

function M:_init()
  self.dam_target = nil
end

function M:on_frame()
  self.dam_target = search_npc(self.npc, 4, 20, 0, 1)
  if not check_magic(self.npc, 100470) and self.dam_target then
    cast_magic(self.npc, self.npc, 100470, 1)
    cast_magic(self.npc, self.dam_target, 201036001, 1)
  else
    return
  end
end

return M
