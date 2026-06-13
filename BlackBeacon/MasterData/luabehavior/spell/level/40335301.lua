local M = Util.create_class()

function M:_init()
  self.addMagic = true
end

function M:on_start()
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc == self.npc and not is_showup then
    abort_magic_by_id(self.npc, 4033530101)
    self.addMagic = true
  end
end

function M:on_frame()
  if get_npc_attr(self.npc, 2) >= get_npc_attr(self.npc, 5) then
    if self.addMagic then
      cast_magic(self.npc, self.npc, 4033530101, 1)
      self.addMagic = false
      print("满精力获得伤害提升")
    end
  elseif get_npc_attr(self.npc, 2) < get_npc_attr(self.npc, 5) and not self.addMagic then
    abort_magic_by_id(self.npc, 4033530101)
    self.addMagic = true
    print("精力减少")
  end
end

return M
