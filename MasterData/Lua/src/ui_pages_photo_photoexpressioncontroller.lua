local this = class("photoExpressionController")
local _NormalFaceLayerName = "expression"
local _SingleFaceLayerName = "singleExpression"

function this:ctor()
end

function this:destroy()
  self:resetTarget()
end

function this:setTarget(target)
  self:resetTarget()
  self.target = target
  if self.target then
    self.animator = self.target.entity.data.animator
    self.faceLayerIdx = self.animator:GetLayerIndex(_SingleFaceLayerName)
    self.normalFaceLayerIdx = self.animator:GetLayerIndex(_NormalFaceLayerName)
  else
    self.animator = nil
  end
end

function this:play(animName, loop, callback)
  if not self.animator then
    return
  end
  self.animator:SetLayerWeight(self.faceLayerIdx, 1)
  self.animator:SetLayerWeight(self.normalFaceLayerIdx, 0)
  self.animName = animName
  self.animState = self.animator:GetState(self.animName, self.faceLayerIdx)
  self.loop = loop
  if self.animState then
    self.animator:Play(self.animName, self.faceLayerIdx, 0)
  else
    errorf("角色缺少动画状态机缺少动画 " .. self.animName)
  end
  if self.timer then
    self.timer:stop()
    self.timer = nil
  end
  if not self.animState then
    if callback then
      callback()
    end
    return
  end
  if self.loop then
    self.timer = Timer.repeated(self.animState.length, function()
      self.timer = nil
      self.animator:Play(self.animName, self.faceLayerIdx, 0)
      if callback then
        callback()
      end
    end, self)
  else
    self.timer = Timer.once(self.animState.length, function()
      self.timer = nil
      if callback then
        callback()
      end
    end, self)
  end
end

function this:stop()
  if not self.animState then
    return
  end
  self.animator:SetLayerWeight(self.faceLayerIdx, 0)
  self.animator:SetLayerWeight(self.normalFaceLayerIdx, 1)
  self.animState = nil
  if self.timer then
    self.timer:stop()
  end
end

function this:resetTarget()
  self:stop()
end

return this
