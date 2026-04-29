require("homelandpet_component_base")
_class("HomelandPetComponentSwim", HomelandPetComponentBase)
HomelandPetComponentSwim = HomelandPetComponentSwim
local HomelandPetSwimBehaviorType = {
  Float = 1,
  Swim = 2,
  FastSwim = 3,
  MAX = 3
}
_enum("HomelandPetSwimBehaviorType", HomelandPetSwimBehaviorType)

function HomelandPetComponentSwim:Constructor(componentType, pet, behavior)
  HomelandPetComponentSwim.super.Constructor(self, componentType, pet, behavior)
  self._building = nil
  self._animation = self._pet:GetAnimation()
end

function HomelandPetComponentSwim:ReLoadPetComponent()
  self._animation = self._pet:GetAnimation()
end

function HomelandPetComponentSwim:Init()
  self._moveComponent = self._behavior:GetComponent(HomelandPetComponentType.Move)
end

function HomelandPetComponentSwim:Play(building)
  self._building = building
  self.state = HomelandPetComponentState.Running
  self._finishTime = GameGlobal:GetInstance():GetCurrentTime()
end

function HomelandPetComponentSwim:OnExcute()
  if self.state == HomelandPetComponentState.Resting and not self._animation then
    self._animation = self._pet:GetAnimation()
  end
end

function HomelandPetComponentSwim:Update(dms)
  HomelandPetComponentSwim.super.Update(self, dms)
  if self.state == HomelandPetComponentState.Running then
    if not self._building then
      self:Exit()
    end
    local swimFinish = (self._swimBehaviorType == HomelandPetSwimBehaviorType.Swim or self._swimBehaviorType == HomelandPetSwimBehaviorType.FastSwim) and self._moveComponent.state == HomelandPetComponentState.Success
    local timeFinish = GameGlobal:GetInstance():GetCurrentTime() >= self._finishTime
    if swimFinish or timeFinish then
      self:NextBehavior()
    end
  end
end

function HomelandPetComponentSwim:NextBehavior()
  self._swimBehaviorType = math.random(1, HomelandPetSwimBehaviorType.Swim)
  local time = 10000
  self._finishTime = GameGlobal:GetInstance():GetCurrentTime() + time
  self._moveComponent:Stop()
  self._moveComponent:Resting()
  if self._swimBehaviorType == HomelandPetSwimBehaviorType.Float then
    self:OnFloat()
  elseif self._swimBehaviorType == HomelandPetSwimBehaviorType.Swim then
    self:OnSwim()
  end
end

function HomelandPetComponentSwim:OnFloat()
end

function HomelandPetComponentSwim:OnSwim()
  local targetPos = self._building:GetSwimRandomPos()
  self._moveComponent:SetTarget(targetPos)
  self._pet:SetSpeed(self._pet.walkSpeed)
end

function HomelandPetComponentSwim:OnFastSwim()
  local targetPos = self._building:GetSwimRandomPos()
  self._moveComponent:SetTarget(targetPos)
  self._pet:SetSpeed(self._pet.runSpeed)
end

function HomelandPetComponentSwim:Exit()
  HomelandPetComponentSwim.super.Exit(self)
  self.state = HomelandPetComponentState.Success
  self._pet:SetSpeed(self._pet.walkSpeed)
  self._building = nil
end

function HomelandPetComponentSwim:Dispose()
  HomelandPetComponentSwim.super.Dispose()
  self._pet:SetSpeed(self._pet.walkSpeed)
  self._building = nil
end
