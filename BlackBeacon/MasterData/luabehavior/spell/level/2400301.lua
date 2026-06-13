local M = Util.create_class()

function M:_init()
  self.overload_times = 0
  self.overload_target = get_sync_var("overload_target")
  local room_id = get_cur_room_id()
  self.task_id = room_id * 10 + 1
end

function M:on_target_self_element_aborn_start(attacker, element, skill_id)
  add_task_progress(self.task_id, 1)
  self.overload_times = self.overload_times + 1
  if self.overload_times >= self.overload_target then
    call_scene_logic_custom_event("win")
  end
end

return M
