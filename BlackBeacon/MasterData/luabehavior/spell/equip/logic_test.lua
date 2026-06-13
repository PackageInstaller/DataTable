local M = Util.create_class()

function M:_init()
end

function M:can_cast_magic(skill_id)
  for _, v in pairs(skill) do
    if v == skill_id then
      return true
    end
  end
  return false
end

function M:on_skill_begin(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  local skill_type = get_skill_cfg(skill_id).SkillType
  if 2 == skill_type then
    cast_magic(self.npc, self.npc, 100197, 0)
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  local skill_type = get_skill_cfg(skill_id).SkillType
  if check_magic(self.npc, 100197) and 1 == skill_type then
    abort_magic_by_id(self.npc, 100197)
  end
end

function M:on_skill_break(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  local skill_type = get_skill_cfg(skill_id).SkillType
  if check_magic(self.npc, 100197) and 1 == skill_type then
    abort_magic_by_id(self.npc, 100197)
  end
end

function M:on_frame()
end

function M:on_input(input_id)
end

function M:on_touch_up(input_id)
end

return M
