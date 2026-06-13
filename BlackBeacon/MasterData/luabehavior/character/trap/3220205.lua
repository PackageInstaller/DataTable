local M = Util.create_class()

function M:_init(npc)
  enable_shadow(npc, false)
  npc.search = {}
  cast_magic(npc, npc, 4032905, 1)
  set_npc_floating_text_hud_visible(npc)
  set_can_searched(npc, false)
  cast_magic(npc, npc, 399001, 1)
end

return M
