local CS_UnityEngine_Input = CS.UnityEngine.Input
local CS_UnityEngine_Camera = CS.UnityEngine.Camera
local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterFeatureBase = require("Game.Fight.Character.Feature.DormFightCharacterFeatureBase")
local DormFightKeyboardInputController = class("DormFightKeyboardInputController", DormFightCharacterFeatureBase)

function DormFightKeyboardInputController:ctor()
  self._modelCtrl = nil
  self._cameraTrans = nil
end

function DormFightKeyboardInputController:OnInit()
  self._modelCtrl = self:GetFeature(DormFightConst.FeatureEnum.ModelController)
  self._cameraTrans = CS_UnityEngine_Camera.main.transform
end

function DormFightKeyboardInputController:OnUpdate(_)
  self:UpdateAttack()
  self:UpdateMovement()
end

function DormFightKeyboardInputController:UpdateAttack()
  if CS_UnityEngine_Input.GetKeyDown(CS.UnityEngine.KeyCode.Keypad1) then
    self._modelCtrl:PostEvent(DormFightConst.EventEnum.Attack)
  end
end

function DormFightKeyboardInputController:UpdateMovement()
  local axisH = CS_UnityEngine_Input.GetAxis("Horizontal")
  local axisV = CS_UnityEngine_Input.GetAxis("Vertical")
  if math.abs(axisH) <= 1.0E-5 and math.abs(axisV) <= 1.0E-5 then
    self._modelCtrl:PostEvent(DormFightConst.EventEnum.StopMoving)
    return
  end
  local cameraDir = Quaternion.Euler(0, self._cameraTrans.rotation.eulerAngles.y, 0)
  local target = Vector3.New(axisH, 0, axisV)
  local targetDir = Vector3.Normalize(target) * cameraDir
  if CS_UnityEngine_Input.GetKeyDown(CS.UnityEngine.KeyCode.Keypad2) then
    self._modelCtrl:PostEvent(DormFightConst.EventEnum.Run, targetDir)
  else
    self._modelCtrl:PostEvent(DormFightConst.EventEnum.Move, targetDir)
  end
end

return DormFightKeyboardInputController
