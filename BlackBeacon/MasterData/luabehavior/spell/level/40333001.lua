local M = Util.create_class()

function M:_init()
end

function M:on_start()
  cast_magic(self.npc, self.npc, 4033300101, 1)
  cast_magic(self.npc, self.npc, 4033250101, 1)
end

return M
