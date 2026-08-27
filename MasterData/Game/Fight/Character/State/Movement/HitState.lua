local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local MovementHitState = class("MovementHitState", DormFightCharacterStateBase)

function MovementHitState:ctor()
  self._timer = 0
  self._hasSendHitWallEvent = false
  self._propertyCtrl = nil
end

function MovementHitState:OnInit()
  self._propertyCtrl = self._owner:GetFeature(DormFightConst.FeatureEnum.PropertyController)
  self._vitalityCtrl = self._owner:GetFeature(DormFightConst.FeatureEnum.VitalityController)
end

function MovementHitState:OnEnter(_)
  self._timer = 0
  self._hasSendHitWallEvent = false
end

function MovementHitState:OnUpdate(deltaTime)
  if not self._hasSendHitWallEvent and self:CheckHitWall() then
    self._hasSendHitWallEvent = true
    if self._vitalityCtrl ~= nil then
      self._vitalityCtrl:OnHitWall()
    end
  end
  self._timer = self._timer + deltaTime
  if self._timer >= self._propertyCtrl:GetProperty(DormFightConst.PropertyEnum.HitShieldTime) then
    self:TransferTo(DormFightConst.StateEnum.MovementLayer_Idle)
  end
end

return MovementHitState
