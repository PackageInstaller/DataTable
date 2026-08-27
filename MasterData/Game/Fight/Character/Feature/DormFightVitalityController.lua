local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterFeatureBase = require("Game.Fight.Character.Feature.DormFightCharacterFeatureBase")
local DormFightVitalityController = class("DormFightVitalityController", DormFightCharacterFeatureBase)
local State2ResumeRatePropertyKeyList = {
  {
    state = DormFightConst.StateEnum.AttackLayer_Attack,
    key = DormFightConst.PropertyEnum.AttackVitalityResumeRate
  },
  {
    state = DormFightConst.StateEnum.AttackLayer_Hit,
    key = DormFightConst.PropertyEnum.HitVitalityResumeRate
  },
  {
    state = DormFightConst.StateEnum.MovementLayer_Idle,
    key = DormFightConst.PropertyEnum.IdleVitalityResumeRate
  },
  {
    state = DormFightConst.StateEnum.MovementLayer_Move,
    key = DormFightConst.PropertyEnum.WalkVitalityResumeRate
  },
  {
    state = DormFightConst.StateEnum.MovementLayer_Run,
    key = DormFightConst.PropertyEnum.RunVitalityResumeRate
  },
  {
    state = DormFightConst.StateEnum.MovementLayer_KnockOut,
    key = DormFightConst.PropertyEnum.KnockOutVitalityResumeRate
  }
}

function DormFightVitalityController:ctor()
  self._propertyCtrl = nil
  self._modelCtrl = nil
  self._vitality = 0
end

function DormFightVitalityController:OnInit()
  self._modelCtrl = self:GetFeature(DormFightConst.FeatureEnum.ModelController)
  self._propertyCtrl = self:GetFeature(DormFightConst.FeatureEnum.PropertyController)
  self._vitality = self._propertyCtrl:GetProperty(DormFightConst.PropertyEnum.InitialVitality)
end

function DormFightVitalityController:GetVitalityRatio()
  local maxVitality = self._propertyCtrl:GetProperty(DormFightConst.PropertyEnum.MaxVitality)
  return self._vitality / maxVitality
end

function DormFightVitalityController:OnUpdate(deltaTime)
  local resumeValue = 0
  for _, v in ipairs(State2ResumeRatePropertyKeyList) do
    if self._modelCtrl:IsInState(v.state) then
      resumeValue = self._propertyCtrl:GetProperty(v.key) or 0
      break
    end
  end
  local maxVitality = self._propertyCtrl:GetProperty(DormFightConst.PropertyEnum.MaxVitality)
  local value = self._vitality + math.floor(resumeValue * deltaTime)
  self._vitality = math.clamp(value, 0, maxVitality)
end

function DormFightVitalityController:ShouldKnockOut()
  local maxVitality = self._propertyCtrl:GetProperty(DormFightConst.PropertyEnum.MaxVitality)
  local knockOutRate = self._propertyCtrl:GetProperty(DormFightConst.PropertyEnum.KnockOutVitalityRate)
  if self._vitality > maxVitality * knockOutRate then
    return false
  end
  local diff = math.floor((knockOutRate - self._vitality / maxVitality) * 100)
  local baseProbability = self._propertyCtrl:GetProperty(DormFightConst.PropertyEnum.KnockOutBasicRatio)
  local upRate = self._propertyCtrl:GetProperty(DormFightConst.PropertyEnum.KnockOutRatioUpRate)
  return math.random() < baseProbability + upRate * diff * 0.01
end

function DormFightVitalityController:OnAttacked()
  local lossValue = self._propertyCtrl:GetProperty(DormFightConst.PropertyEnum.AttackedVitalityLoss)
  local maxVitality = self._propertyCtrl:GetProperty(DormFightConst.PropertyEnum.MaxVitality)
  local value = self._vitality + lossValue
  self._vitality = math.clamp(value, 0, maxVitality)
end

function DormFightVitalityController:OnHitWall()
  local lossValue = self._propertyCtrl:GetProperty(DormFightConst.PropertyEnum.HitWallVitalityLoss)
  local maxVitality = self._propertyCtrl:GetProperty(DormFightConst.PropertyEnum.MaxVitality)
  local value = self._vitality + lossValue
  self._vitality = math.clamp(value, 0, maxVitality)
end

return DormFightVitalityController
