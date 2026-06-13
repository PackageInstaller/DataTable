local M = Util.create_class()

function M._init(M, npc)
  M.npc = npc
  print("901加上")
end

function M.on_frame()
end

function M:on_target_self_magic_begin(npc, magic_id, magic_level, magic_kind, magic_type)
  if 1080410801 == magic_id then
  end
end

function M:on_target_self_magic_end(npc, magic_id, magic_kind, magic_type, is_break)
  if 1080410801 == magic_id then
  end
end

return M
