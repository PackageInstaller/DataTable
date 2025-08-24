local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local TASK_STATE = Config.TASK_STATE

function M:init_sys()
  Base.init_sys(self)
  self:sys_mq_bind(Const.MSG_ON_TASK_UPDATE, self.on_compensate_task_update, self)
end

function M:request_compensate_gained_award(activity_id)
  Network:protect_call("c2gs_activity_compensate_gained_award", {activity_id = activity_id}, function(ok)
    if true == ok then
      local ui_compensate_activity = UIMgr:try_get_visible_ui("ui_compensate_activity")
      if ui_compensate_activity then
        ui_compensate_activity:refresh_dailyaward_view()
      end
      local cmpnst_dailyaward_tips = UIMgr:try_get_visible_ui("cmpnstDailyAwardTip")
      if cmpnst_dailyaward_tips then
        cmpnst_dailyaward_tips:refresh_dailyaward_state()
      end
    end
  end)
end

function M:on_gs2c_activity_compensate_info(data)
  self.v_compensate_dailyaward_data = data or {}
  self:compensate_reddot_check(data)
end

function M:get_compensate_dailyaward_data()
  return self.v_compensate_dailyaward_data
end

function M:compensate_reddot_check(data)
  local daily_state = data
  local can_receive
  if daily_state.can_gain_day > 0 then
    can_receive = true
  end
  RedPointMgr:enable_redpoint(RedEnum.COMPENSATE_DAILY_AWARD, can_receive)
end

function M:check_activity_compensate_award()
  if not self.v_compensate_dailyaward_data then
    return
  end
  self.v_compensate_cfg = ShareRes.get_compensate_cfg(self.v_compensate_dailyaward_data.activity_id)
  self.v_task_group_id = self.v_compensate_cfg.TaskGroupId
  self.v_task_list = ShareRes.get_task_group(self.v_task_group_id)
  local show_red = false
  for _, v in pairs(self.v_task_list) do
    local state = TaskMgr:get_task_state(v.Id)
    if state == TASK_STATE.COMPLETE then
      show_red = true
      RedPointMgr:enable_dynamic_redpoint(RedEnum.COMPENSATE_TASK_AWARD + v.Id, RedEnum.COMPENSATE_TASK, show_red)
      goto lbl_47
    end
  end
  ::lbl_47::
end

function M:on_compensate_task_update()
  self:check_activity_compensate_award()
end

return M
