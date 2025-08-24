local Base = require("utils.base_ai")
local BehaviorDef = require("utils.behavior_def")
local Math = require("base.mathx")
local Util = require("utils.util")
local BT_SUCCESS = BehaviorDef.BT_SUCCESS
local BT_RUNNING = BehaviorDef.BT_RUNNING
local M = Util.create_child_mt(Base)

function M:_init(...)
  Base._init(self, ...)
  self.v_start_idle_time = nil
  self.v_start_stay_time = nil
end

function M:play_stay_anim()
  local robot = self.robot
  if not self.v_start_stay_time then
    self.v_start_stay_time = Date.now()
  end
  local conf = robot:get_cur_point_conf()
  robot:play_idle(conf.stayAnim)
  if Date.now() - self.v_start_stay_time > conf.stayTime then
    self.v_start_stay_time = nil
    return BT_SUCCESS
  end
  if robot:is_clicked() then
    return BT_SUCCESS
  end
  return BT_RUNNING
end

function M:play_idle()
  local robot = self.robot
  if not self.v_start_idle_time then
    self.v_start_idle_time = Date.now()
  end
  if not robot.state_manager:is_idle_state() then
    robot:play_idle()
  end
  if Date.now() - self.v_start_idle_time > 10 then
    self.v_start_idle_time = nil
    robot:reset_click()
    return BT_SUCCESS
  end
  return BT_RUNNING
end

function M:inc_cycle_point_idx(...)
  local robot = self.robot
  robot:inc_cycle_point_idx()
  return BT_SUCCESS
end

function M:inc_goback_point_idx(...)
  local robot = self.robot
  robot:inc_goback_point_idx()
  return BT_SUCCESS
end

function M:is_reached_next_point(check)
  local robot = self.robot
  local x, z = robot:get_pos2()
  local conf = robot:get_cur_point_conf()
  local point = conf.position
  local dist = Math.distance2(x, z, point[1], point[3])
  if dist < 0.5 then
    return true
  end
  return false
end

function M:is_finished_all_points(...)
  local robot = self.robot
  return robot:is_finished_all_points()
end

function M:is_interaction(...)
  local robot = self.robot
  if robot:is_clicked() then
    return true
  end
  return false
end

function M:move_to_next_point()
  local robot = self.robot
  robot.state_manager:to_move_state(true)
  local conf = robot:get_cur_point_conf()
  local point = conf.position
  local speed = robot:get_move_speed()
  robot.state_manager:move_to_dst(point[1], point[3], nil, nil, nil, speed)
  if self:is_reached_next_point() then
    robot:stop_move()
    return BT_SUCCESS
  end
  if robot:is_clicked() then
    robot:stop_move()
    return BT_SUCCESS
  end
  return BT_RUNNING
end

return M
