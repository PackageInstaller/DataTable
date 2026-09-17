local this = class("baseState")

function this:ctor(stateType, machine)
  self.stateType = stateType
  self.machine = machine
  self.callback = nil
  self.csEntity = self.machine.csEntity
  self.animator = self.csEntity.data.animator
  self.timers = {}
end

function this:getStateType()
  return self.stateType
end

function this:setRevertCondition()
  if self.isReverting then
    return
  end
  self.isReverting = true
  self.fsmHandle = self.fsmHandle or L_CommonUtil.handle(self.onFsm_changed, self)
  self.csEntity.handler.onFsmStateChange:Add(self.fsmHandle)
  if AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false).data.entityId == self.csEntity.data.entityId then
    self.controlMoveHandle = self.controlMoveHandle or L_CommonUtil.handle(self.onControlMove_changed, self)
    C_InputManager.AddAxisListener(L_Const.axisType.emainMoveMent, self.controlMoveHandle)
  end
end

function this:removeRevertCondition()
  if not self.isReverting then
    return
  end
  self.isReverting = nil
  self.csEntity.handler.onFsmStateChange:Remove(self.fsmHandle)
  if self.controlMoveHandle then
    C_InputManager.RemoveAxisListener(L_Const.axisType.emainMoveMent, self.controlMoveHandle)
  end
end

function this:onFsm_changed(curFsm, preFsm)
  self:complete()
end

function this:onControlMove_changed(v2)
  if v2.x == 0 and v2.y == 0 then
    return
  end
  if AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false).data.UUID == self.csEntity then
    self:complete()
  end
end

function this:canEnter(preStepType, ...)
  return true
end

function this:onEnter(...)
  self:setStep(L_Const.stateStep.inState)
end

function this:canRepeated(...)
  return true
end

function this:onRepeated(...)
  self:onLeave(L_Const.stateStep.replace)
  self:onEnter(...)
end

function this:canLeave()
  return true
end

function this:onLeave(state)
  if self.isPause then
    self:resume()
  end
  for _, v in pairs(self.timers) do
    Timer.remove(v)
  end
  self.timers = {}
  self:setStep(state or L_Const.stateStep.leave)
  self:removeRevertCondition()
  self:doCallback()
end

function this:triggerActionFrame()
  self:setStep(L_Const.stateStep.actionFrame)
  self:doCallback()
end

function this:doCallback()
  local res = false
  if self.callback then
    self.callback(self.step)
    self.callback = nil
    res = true
  end
  return res
end

function this:complete()
  self.machine:reset()
end

function this:pause()
  self.isPause = true
  for _, v in pairs(self.timers) do
    v:pause()
  end
  self.csEntity.data:SetSelfTimeScale(0)
end

function this:resume()
  self.isPause = false
  for _, v in pairs(self.timers) do
    v:resume()
  end
  self.csEntity.data:SetSelfTimeScale(1)
end

function this:setStep(step)
  self.step = step
end

function this:destroy()
end

return this
