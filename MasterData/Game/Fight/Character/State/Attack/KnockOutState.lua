local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local AttackKnockOutState = class("AttackKnockOutState", DormFightCharacterStateBase)

function AttackKnockOutState:ctor()
  self._timer = 0
  self._duration = 0
end

function AttackKnockOutState:OnInit()
  self._duration = DormFightConst.KnockOutShieldInterval
  local propertyCtrl = self._owner:GetFeature(DormFightConst.FeatureEnum.PropertyController)
  if propertyCtrl ~= nil then
    self._duration = self._duration + propertyCtrl:GetProperty(DormFightConst.PropertyEnum.KnockOutLieDownInterval)
    self._duration = self._duration + propertyCtrl:GetProperty(DormFightConst.PropertyEnum.KnockOutGetUpInterval)
  end
end

function AttackKnockOutState:OnEnter(prevState)
  self._timer = 0
end

function AttackKnockOutState:OnUpdate(deltaTime)
  self._timer = self._timer + deltaTime
  if self._timer >= self._duration then
    self:TransferTo(DormFightConst.StateEnum.AttackLayer_Idle)
  end
end

return AttackKnockOutState
