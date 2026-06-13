local M = Util.create_class()

function M:_init()
end

function M:on_critical(npc, target, magic_cfg, magic_id)
  if npc ~= self.npc then
    return
  end
  cast_magic(self.npc, self.npc, 6031051, 1)
  cast_magic(self.npc, self.npc, 6031052, 1)
  cast_magic(self.npc, self.npc, 6031053, 1)
end

return M
