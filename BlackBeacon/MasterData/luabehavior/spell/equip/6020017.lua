local M = Util.create_class()

function M:_init()
  self.death_set = 0
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc and 0 == self.death_set then
    cast_magic(self.npc, self.npc, 6021020, 1)
    self.death_set = 1
  end
end

return M
