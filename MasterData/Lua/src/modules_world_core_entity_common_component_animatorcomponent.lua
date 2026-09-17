local this = class("animatorComponent", L_EcsConst.component)

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this:onBindGameObject(go)
  self.animator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), go)
end

function this:onDestroy()
  this.super.onDestroy(self)
  self.animator = nil
end

function this:play(name, normalize)
  self.animator:Play(name, -1, normalize or 0)
end

function this:setSpeed(speed)
  self.animator.speed = speed
end

function this:getState(name)
  local state = self.animator:GetState(name)
  return state
end

function this:HasState(name)
  return self.animator:HasState(name)
end

return this
