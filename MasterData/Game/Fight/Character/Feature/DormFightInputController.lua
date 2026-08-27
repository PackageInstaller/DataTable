local CS_UnityEngine_Camera = CS.UnityEngine.Camera
local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterFeatureBase = require("Game.Fight.Character.Feature.DormFightCharacterFeatureBase")
local DormFightInputController = class("DormFightInputController", DormFightCharacterFeatureBase)

function DormFightInputController:ctor()
  self._isInputRunning = false
  self._modelCtrl = nil
  self._cameraTrans = nil
end

function DormFightInputController:OnInit()
  self._modelCtrl = self:GetFeature(DormFightConst.FeatureEnum.ModelController)
  self._cameraTrans = CS_UnityEngine_Camera.main.transform
  local fightUi = UIManager:GetWindow(UIWindowTypeID.FightScene)
  local moveCb = BindCallback(self, self.OnMoveUpdate)
  local runPressDownCb = BindCallback(self, self.OnRunningBegin)
  local runPressUpCb = BindCallback(self, self.OnRunningEnd)
  local attackCb = BindCallback(self, self.OnAttackInput)
  fightUi:Bind(moveCb, runPressDownCb, runPressUpCb, attackCb)
end

function DormFightInputController:OnMoveUpdate(axisH, axisV)
  if math.abs(axisH) <= 1.0E-5 and math.abs(axisV) <= 1.0E-5 then
    self._modelCtrl:PostEvent(DormFightConst.EventEnum.StopMoving)
    return
  end
  local cameraDir = Quaternion.Euler(0, self._cameraTrans.rotation.eulerAngles.y, 0)
  local target = Vector3.New(axisH, 0, axisV)
  local targetDir = Vector3.Normalize(target) * cameraDir
  if self._isInputRunning then
    self._modelCtrl:PostEvent(DormFightConst.EventEnum.Run, targetDir)
  else
    self._modelCtrl:PostEvent(DormFightConst.EventEnum.Move, targetDir)
  end
end

function DormFightInputController:OnRunningBegin()
  self._isInputRunning = true
end

function DormFightInputController:OnRunningEnd()
  self._isInputRunning = false
end

function DormFightInputController:OnAttackInput()
  self._modelCtrl:PostEvent(DormFightConst.EventEnum.Attack)
end

return DormFightInputController
