local M = Util.create_class()

function M:_init()
  self.effect_list = {}
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    return
  end
  if check_magic(npc, 1999020) then
    local dead_pos = get_npc_pos(npc)
    cast_missile(self.npc, nil, dead_pos.x, dead_pos.z, 10019010601, 1)
  end
end

return M
