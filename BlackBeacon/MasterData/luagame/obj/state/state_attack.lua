local Base = require("obj.state.state_obj_base")
local SkillDefine = require("manager.fight.skill_define")
local SKILL_MOVE_TYPE = SkillDefine.SKILL_MOVE_TYPE
local STATE_NAME = Config.STATE_NAME
local M = Util.create_child_mt(Base)

function M:state_update_value(skill_cfg, start_frame)
  self.v_skill_cfg = skill_cfg
  self.v_time = 0
  local before_time = skill_cfg.BeforeTime or 0
  self.v_abort_skill_delay = skill_cfg.MoveAbortSkillDelay or 0
  self.v_cast_Time = skill_cfg.CastTime + before_time
  self.v_exit_time = before_time + skill_cfg.CastTime + skill_cfg.AfterTime
  self.v_rest_idel = skill_cfg.SkillToArderIdle
  if skill_cfg.SkillToRun then
    self.v_state_manager:set_dir_to_run(true)
  end
  self.v_count = self.v_count + 1
  self.v_owner.act_ctrl:try_action(skill_cfg.Animation, 0, nil, nil, nil, nil, nil, start_frame or 0)
end

function M:state_on_enter(skill_cfg)
  self.v_skill_cfg = skill_cfg
  Base.state_on_enter(self, skill_cfg)
  self.v_count = 0
end

function M:state_on_leave()
  Base.state_on_leave(self)
  self.v_count = 0
  self.v_skill_cfg = nil
end

function M:state_update()
  Base.state_update(self)
  local cur_skill_elapse = self.v_owner.skill_mgr:get_cur_skill_elapse()
  if cur_skill_elapse then
    self.v_time = cur_skill_elapse
  else
    self.v_time = self.v_time + self.v_owner.time_mgr:get_dt_time()
  end
  if self.v_time >= self.v_exit_time then
    if self.v_skill_cfg.SkillToRun or self.v_owner.state_manager:is_in_state(STATE_NAME.run) then
      self.v_owner.state_manager:exit_state(STATE_NAME.attack)
    else
      self.v_owner.state_manager:to_idle_state(self.v_rest_idel)
    end
  end
end

function M:state_get_name()
  return STATE_NAME.attack
end

function M:state_can_reenter()
  return true
end

function M:is_cast_time(is_exit_time)
  if is_exit_time then
    return self.v_time < self.v_exit_time
  end
  return self.v_time < self.v_cast_Time
end

function M:can_move()
  if not self.v_state_manager:get_skill_to_move_enable() then
    return false
  end
  if self.v_skill_cfg and self.v_skill_cfg.SkillMoveType == SKILL_MOVE_TYPE.DEFAULT then
    return true
  end
  local cast_time = self.v_cast_Time + self.v_abort_skill_delay
  return cast_time <= self.v_time
end

return M
