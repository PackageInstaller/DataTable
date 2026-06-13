local M = Util.create_class()
local magicNum = true

function M:_init()
end

function M:on_npc_born(npc)
  local kind = get_role_kind(npc)
  if 2 == kind and magicNum and math.random(1, 5) > 2 then
    cast_magic(npc, npc, 40331902, 1)
  end
end

return M
