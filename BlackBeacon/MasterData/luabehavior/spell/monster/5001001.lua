local M = Util.create_class()

function M:_init()
end

function M:on_npc_born(npc)
  if npc ~= self.npc then
    return
  end
  local monster = self.npc:get_behavior()
  if not monster then
    Util.debug_output("monster is lost")
    return
  end
  cast_magic(monster.npc, monster.npc, 500100102, 1)
  monster:go_mad()
  abort_magic_by_id(self.npc, 5000001, 1)
end

return M
