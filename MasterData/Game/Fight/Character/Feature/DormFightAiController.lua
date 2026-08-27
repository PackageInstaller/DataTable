local AttackSqrDistance = 0.5
local AttackProbability = 0.1
local EscapeVitalityRatio = 0.5
local StopEscapeVitalityRatio = 1.0
local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterFeatureBase = require("Game.Fight.Character.Feature.DormFightCharacterFeatureBase")
local DormFightAiController = class("DormFightAiController", DormFightCharacterFeatureBase)

function DormFightAiController:ctor()
  self._modelCtrl = nil
  self._vitalityCtrl = nil
  self._isEscape = false
end

function DormFightAiController:OnInit()
  self._modelCtrl = self:GetFeature(DormFightConst.FeatureEnum.ModelController)
  self._vitalityCtrl = self:GetFeature(DormFightConst.FeatureEnum.VitalityController)
  self._isEscape = false
end

function DormFightAiController:OnUpdate(deltaTime)
  if self._modelCtrl == nil then
    return
  end
  local vitalityRatio = self._vitalityCtrl and self._vitalityCtrl:GetVitalityRatio()
  if not self._isEscape and vitalityRatio < EscapeVitalityRatio then
    self._isEscape = true
  elseif self._isEscape and vitalityRatio >= StopEscapeVitalityRatio - 1.0E-5 then
    self._isEscape = false
  end
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight)
  local characterCtrl = dormFightCtrl:GetCharacterCtrl()
  local comp = self._owner:GetComp()
  local position = self._owner:GetPosition()
  local tPosition = characterCtrl:GetNearestEnemyPosition(comp, position, false)
  if tPosition == nil then
    self._modelCtrl:PostEvent(DormFightConst.EventEnum.StopMoving)
    return
  end
  local dx = tPosition.x - position.x
  local dz = tPosition.z - position.z
  local sqrDistance = dx * dx + dz * dz
  if self._isEscape then
    local dir = Vector3(-dx, 0, -dz)
    self._modelCtrl:PostEvent(DormFightConst.EventEnum.Move, dir)
  elseif sqrDistance >= AttackSqrDistance then
    local dir = Vector3(dx, 0, dz)
    self._modelCtrl:PostEvent(DormFightConst.EventEnum.Move, dir)
  else
    self._modelCtrl:PostEvent(DormFightConst.EventEnum.StopMoving)
    if math.random() < AttackProbability then
      self._modelCtrl:PostEvent(DormFightConst.EventEnum.Attack)
    end
  end
end

return DormFightAiController
