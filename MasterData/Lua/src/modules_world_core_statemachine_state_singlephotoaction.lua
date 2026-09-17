local this = class("state_singlePhotoAction", require(L_R.world.core .. "stateMachine.baseState"))

function this:ctor(...)
  self.super.ctor(self, ...)
end

function this:onEnter(args)
  this.super.onEnter(self, args)
  local state = self.animator:GetState(args.animName)
  self.args = args
  if state then
    self.animator.applyRootMotion = false
    self.beginCallback = args.beginCallback
    self.leaveCallback = args.callback
    self:doAction(state, args.isLoop, args.callback)
    self:setRevertCondition()
  else
    self:complete()
  end
end

function this:onLeave(state)
  if self.leaveCallback then
    self.leaveCallback()
  end
  if state and state == L_Const.stateStep.replace then
  else
    self.animator.applyRootMotion = true
    if self.state then
      local speed = self.animator.speed
      local dt = (0.99 - math.min(self.state.normalizedTime, 1)) * self.state.length * speed
      C_MediaPackUtility.AnimatorTimelineEvaluate(self.csEntity, dt)
    end
    self.animator.speed = 1
    C_MediaPackUtility.ChangeEffectSpeed(self.csEntity, 1, true)
    self.state = nil
    if not L_PhotoManager:isHeroCaressing(self.csEntity) then
      self.animator:CrossFade(L_Const.anim.idle, 0, -1, 0, 0)
    end
    L_PhotoManager:sendEvent(L_PhotoManager.event.exitSingleAction, self.csEntity)
  end
  for _, v in pairs(self.timers) do
    Timer.remove(v)
  end
  self.timers = {}
  this.super.onLeave(self)
end

function this:destroy()
  this.super.destroy(self)
  self:removeRevertCondition()
  for _, v in pairs(self.timers) do
    Timer.remove(v)
  end
  self.timers = {}
end

function this:invokeCallBack()
  if self.beginCallback then
    self.beginCallback()
    self.beginCallback = nil
  end
end

function this:doAction(state, isLoop, callback)
  self.animator:Play(state.stateName, -1, self.args.normalize or 0)
  if self.args.setPause ~= nil then
    self.animator.speed = self.args.setPause and 0 or 1
  end
  self.state = state
  self.timers.action = L_GameTimer.repeated(0, function()
    if not state.isRunning or state.normalizedTime >= 0.999 then
      if isLoop then
        self.animator:Play(state.stateName, -1, 0)
      else
        self.complete()
      end
    end
  end, self, self.csEntity.transform.gameObject)
  self:invokeCallBack()
end

return this
