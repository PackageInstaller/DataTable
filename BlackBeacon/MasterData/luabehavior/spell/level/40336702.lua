local M = Util.create_class()

function M:_init()
  self.castMagic = true
end

function M:on_start()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == self.npc and 2 == skill_type then
    self.castMagic = true
  end
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break, behavior_abort)
  if npc == self.npc and 2 == get_skill_cfg(skill_id).SkillType and self.castMagic then
    local role = self.npc:get_behavior()
    local skill = role.skills[skill_id]
    local roleAct = skill and skill.skAct
    if not roleAct then
      return
    end
    if roleAct:isDash() and not roleAct:isPerfect() then
      cast_magic(self.npc, self.npc, 4033670201, 1)
    end
  end
end

return M
