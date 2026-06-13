local M = Util.create_class()

function M:_init()
end

function M:on_self_skill_end(skill_id, is_time_out, is_break, behavior_abort)
  replace_ragdoll_power_profile(self.npc, 0)
end

function M:on_self_skill_begin(skill_id, skill_type)
  replace_ragdoll_power_profile(self.npc, 1)
end

return M
