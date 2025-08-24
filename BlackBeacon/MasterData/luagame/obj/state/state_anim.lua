local Base = require("obj.state.state_obj_base")
local Const = require("const")
local M = Util.create_child_mt(Base)
local ANIM_IDLE = "idle"
local STATE_NAME = Config.STATE_NAME

function M:state_on_enter(anim_id, time, callback)
  Base.state_on_enter(self)
  self.v_forbidden_idle = nil
  if self.v_owner:is_hero() and self.v_owner:is_on_riding() then
    self.v_forbidden_idle = true
    self.v_owner:unride()
    self.v_forbidden_idle = false
  end
  self:_play_action(anim_id, time, callback)
end

function M:state_update_value(anim_id, time, callback)
  Base.state_update_value(self)
  self:_play_action(anim_id, time, callback)
end

function M:_play_action(anim_id, time, callback)
  self.v_enter_time = Date.time()
  self.v_need_run_time = time
  self.v_is_success = false
  self.v_callback = callback
  local anim_name = ShareRes.create("act_name_map", anim_id)
  anim_name = anim_name and anim_name.name
  if nil == anim_name then
    anim_name = ANIM_IDLE
  elseif self.v_owner:is_hero() then
    self:sync_act(anim_id)
  end
  self.v_state_manager:try_action(anim_name)
end

function M:sync_act(anim_id)
  Network:call_no_waiting("do_action", {action = anim_id})
  self.v_last_async_anim_id = anim_id > 0 and anim_id or nil
end

function M:state_update()
  if Date.time() - self.v_enter_time >= self.v_need_run_time then
    self.v_is_success = true
    self.v_owner.state_manager:to_idle_state()
  end
end

function M:state_on_leave()
  Base.state_on_leave(self)
  if self.v_last_async_anim_id then
    self:sync_act(0)
  end
  if self.v_callback then
    self.v_callback(self.v_is_success)
  end
  self.v_callback = nil
end

function M:state_get_name()
  return Config.STATE_NAME.anim
end

function M:state_can_transit(state_name, param)
  if not Base.state_can_transit(self, state_name) then
    if state_name == STATE_NAME.idle and self.v_forbidden_idle then
      return false
    else
      return true
    end
  end
  return true
end

return M
