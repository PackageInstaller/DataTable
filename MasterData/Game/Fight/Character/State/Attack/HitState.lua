local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local AttackHitState = class("AttackHitState", DormFightCharacterStateBase)

function AttackHitState:ctor()
  self._timer = 0
  self._propertyCtrl = nil
end

function AttackHitState:OnInit()
  self._propertyCtrl = self._owner:GetFeature(DormFightConst.FeatureEnum.PropertyController)
end

function AttackHitState:OnEnter(_)
  self._timer = 0
end

function AttackHitState:OnUpdate(deltaTime)
  self._timer = self._timer + deltaTime
  if self._timer >= self._propertyCtrl:GetProperty(DormFightConst.PropertyEnum.HitShieldTime) then
    self:TransferTo(DormFightConst.StateEnum.AttackLayer_Idle)
  end
end

return AttackHitState
