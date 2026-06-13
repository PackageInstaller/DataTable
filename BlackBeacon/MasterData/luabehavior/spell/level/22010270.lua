local M = Util.create_class()

function M:_init(npc)
  local COPY_ATTR_MAP = {
    [4] = 12500,
    [20] = 25000
  }
  copy_attr_to_npc(npc, npc, COPY_ATTR_MAP)
end

return M
