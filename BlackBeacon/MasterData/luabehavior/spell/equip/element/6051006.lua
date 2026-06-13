local M = Util.create_class()

function M:_init()
  self.cast_set = false
  self.target = nil
end

function M:on_magic_end(npc, target, magic_id)
  if (1999011 == magic_id or 60510041 == magic_id or 60510051 == magic_id) and math.random() * 100 <= 30 then
    self.cast_set = true
    self.target = target
    cast_magic(self.target, self.target, 60510061, 1)
    cast_magic(self.target, self.target, 60510062, 1)
  end
end

function M:on_frame()
end

return M
