local M = Util.create_class()

function M:_init()
end

function M:on_npc_born(npc)
  local kind = get_role_kind(npc)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind and 7 ~= kind then
    return
  end
  cast_magic(npc, npc, 4033020301)
end

return M
