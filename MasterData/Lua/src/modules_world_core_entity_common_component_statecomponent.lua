local this = class("stateComponent", L_EcsConst.component)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.stateMachine = require(L_R.world.core .. "stateMachine.stateMachine").new(self.parent.csEntity)
end

function this:onDestroy()
  this.super.onDestroy(self)
  self.stateMachine:destroy()
end

function this:addState(stateType)
  local state = self.stateMachine:getState(stateType, true)
  return state
end

function this:getState(stateType, isCreate)
  local state = self.stateMachine:getState(stateType, isCreate)
  return state
end

function this:changeState(stateType, ...)
  return self.stateMachine:changeState(stateType, ...)
end

function this:getCurStateType()
  return self.stateMachine:getCurStateType()
end

function this:getCurState()
  return self.stateMachine:getCurState()
end

function this:reset()
  self.stateMachine:reset()
end

function this:forceResetState()
  self.stateMachine:reset()
end

function this:getCanChangePlayer()
  if self:getCurStateType() ~= L_Const.stateType.free then
    return false
  end
  return true
end

function this:doSingleAction(animName, isLoop, callback, isPhoto, normalize, setPause, actionId, ignoreFsm, beginCallback)
  local fsm = self.parent.state
  if fsm == nil and not ignoreFsm then
    return
  end
  if not ignoreFsm and fsm:GetCurrentStateType() == L_Const.fsmType.swimGroup then
    if callback then
      callback(L_Const.stateStep.leave)
    end
  else
    local args = {
      animName = animName,
      isLoop = isLoop,
      callback = callback,
      normalize = normalize,
      setPause = setPause,
      actionId = actionId,
      beginCallback = beginCallback
    }
    local state
    if isPhoto then
      state = self:getState(L_Const.stateType.singlePhotoAction, true)
    end
    return self:changeState(state:getStateType(), args)
  end
  return true
end

return this
