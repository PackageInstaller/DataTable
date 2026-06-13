local M = Util.create_class()

function M:_init()
  self.death_set = 0
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc and 0 == self.death_set then
    if get_npc_attr(self.npc, 2) / get_npc_attr(self.npc, 5) >= 0 and get_npc_attr(self.npc, 2) / get_npc_attr(self.npc, 5) < 0.75 then
      cast_magic(self.npc, self.npc, 6021040, 1)
    elseif get_npc_attr(self.npc, 2) / get_npc_attr(self.npc, 5) >= 0.9 then
      cast_magic(self.npc, self.npc, 6021047, 1)
    end
    cast_magic(self.npc, self.npc, 6021050, 1)
    self.death_set = 1
  end
end

return M
