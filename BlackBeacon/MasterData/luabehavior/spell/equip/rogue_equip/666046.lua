local M = Util.create_class()

function M:_init()
end

function M:on_self_skill_begin(skill_id, skill_type)
  self.target = search_npc(self.npc, 4, 10, nil, false, true)
  if not self.target then
    return
  elseif self.target then
    for k, v in pairs(self.target) do
      self.check_counting = k
    end
  end
  if 1 == self.check_counting then
    cast_magic(self.npc, self.npc, 66604601)
  end
end

function M:on_self_skill_end(skill_id, is_time_out, is_break, behavior_abort)
  if check_magic(self.npc, 66604601) then
    abort_magic_by_id(self.npc, 66604601)
  end
end

return M
