local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.target = nil
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 12, nil, 1)
end

function M:on_frame()
  self:search_target()
  if 0 == self.magic_set then
    cast_magic(self.npc, self.target, 6021035, 1)
    self.magic_set = 1
  end
end

return M
