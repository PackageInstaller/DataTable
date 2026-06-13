local M = Util.create_class()

function M:_init()
  self.target = 0
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 12, nil, 1)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type)
  if npc ~= self.npc then
    return
  end
end

function M:on_frame()
  self:search_target()
end

function M:on_npc_hp_zero(npc)
  if not self.target then
    return
  end
  if npc == self.npc then
    return
  end
  if get_npc_attr(self.npc, 71) / get_npc_attr(self.npc, 4) >= 0.3 then
    cast_magic(self.npc, self.npc, 6021028, 1)
  else
    cast_magic(self.npc, self.npc, 6021027, 1)
  end
end

return M
