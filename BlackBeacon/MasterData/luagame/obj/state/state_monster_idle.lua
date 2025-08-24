local Base = require("obj.state.state_idle")
local ACT_DEFINE = Config.ACT_DEFINE
local M = Util.create_child_mt(Base)
local BATTLE_IDLE_TIME = 2
local IDLE_ANIM_TYPE = {COMMON = 1, ANIM1 = 2}
local IDLE_ANIM_ACT = {
  [IDLE_ANIM_TYPE.COMMON] = ACT_DEFINE.Idle2,
  [IDLE_ANIM_TYPE.ANIM1] = ACT_DEFINE.Idle3
}

function M:state_update_value()
  self:_on_change_anim()
end

function M:_on_change_anim()
  if not self.v_idle_state or self.v_idle_state == IDLE_ANIM_TYPE.COMMON then
    self:_on_common()
  elseif self.v_idle_state == IDLE_ANIM_TYPE.ANIM1 then
    self:_on_idle_anim1()
  end
end

function M:_on_common()
  self.v_state_manager:try_action(IDLE_ANIM_ACT[IDLE_ANIM_TYPE.COMMON], 0, nil, nil, true)
end

function M:_on_idle_anim1()
  self.v_state_manager:try_action(IDLE_ANIM_ACT[IDLE_ANIM_TYPE.ANIM1], 0, nil, nil, true)
end

function M:switch_idle_state(state)
  self.v_idle_state = state
  self:_on_change_anim()
end

return M
