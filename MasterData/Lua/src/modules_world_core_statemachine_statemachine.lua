local this = class("stateMachine")

function this:ctor(csEntity)
  self.csEntity = csEntity
  self.stateDic = {}
  self.curState = self:getState(L_Const.stateType.free, true)
end

function this:update()
  if self.curState == nil then
    return
  end
  self.curState:update()
end

function this:getCurStateType()
  return self.curState and self.curState:getStateType()
end

function this:getCurState()
  return self.curState
end

function this:getState(stateType, isCreate)
  local state = self.stateDic[stateType]
  if state == nil and isCreate then
    state = require(L_R.world.core .. "stateMachine.state_" .. stateType).new(stateType, self)
    self.stateDic[stateType] = state
  end
  return state
end

function this:changeState(stateType, ...)
  local currentStateType = self:getCurStateType()
  if currentStateType ~= stateType then
    local nextState = self:getState(stateType)
    self.stateDic[stateType] = nextState
    if nextState and nextState:canEnter(currentStateType, ...) then
      if self.curState then
        if self.curState:canLeave() then
          self.curState:onLeave()
        else
          return false
        end
      end
      self.curState = nextState
      self.curState:onEnter(...)
    else
      return false
    end
  elseif self.curState and self.curState:canRepeated(...) then
    self.curState:onRepeated(...)
  end
  return true
end

function this:forceChangeState(stateType)
  if self.curState then
    self.curState:onLeave()
  end
  self.curState = self:getState(stateType)
  self.curState:onEnter()
  return self.curState
end

function this:reset()
  return self:changeState(L_Const.stateType.free)
end

function this:destroy()
  for _, v in pairs(self.stateDic) do
    v:destroy()
  end
  self.stateDic = {}
end

function this:doSingleAction(animName, isLoop, callback, isPhoto, normalize, setPause, actionId, ignoreFsm, beginCallback)
  local fsm = self.csEntity.state
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
