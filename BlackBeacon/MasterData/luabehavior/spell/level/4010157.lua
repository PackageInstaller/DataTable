local M = Util.create_class()

function M:_init()
  self.magic_set = 0
end

function M:on_frame()
end

function M:on_input(input_id)
  if 18 == input_id or 19 == input_id and 0 == self.magic_set then
    self.magic_set = 1
    abort_magic_by_id(self.npc, 4010156)
    abort_magic_by_id(self.npc, 4010157)
  end
end

return M
