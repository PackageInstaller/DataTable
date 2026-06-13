local M = Util.create_class()

function M:_init()
  self.death_set = 0
  self.death_timer = 0
end

function M:on_npc_hp_zero(npc)
  if npc ~= self.npc then
    return
  end
  local now_time = get_npc_time(self.npc)
  if npc == self.npc and 0 == self.death_set and now_time >= self.death_timer then
    cast_magic(self.npc, self.npc, 6031024, 1)
    cast_magic(self.npc, self.npc, 6031025, 1)
    cast_magic(self.npc, self.npc, 6031026, 1)
    self.death_set = 1
    self.death_timer = now_time + 120
  end
end

return M
