local M = Util.create_class()

function M:_init()
  self.search_list = {}
  self.cd_timer = 0
  self.pos = nil
end

function M:on_before_npc_hp_zero(npc)
  if npc == self.npc then
    return
  end
  self.pos = get_npc_pos(npc)
  self.search_list = search_npc(npc, 2, 4, 0, 1, true)
  if not check_magic(npc, 1999040) then
    return
  end
  cast_missile(self.npc, npc, self.pos.x, self.pos.z, 10019016001, 1)
  for i, v in pairs(self.search_list) do
    cast_magic(v, v, 60540071, 1)
  end
  if get_npc_time(self.npc) >= self.cd_timer then
    cast_magic(self.npc, self.npc, 60540072, 1)
    self.cd_timer = get_npc_time(self.npc) + 10
  end
end

return M
