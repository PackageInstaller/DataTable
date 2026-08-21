require("homeland_input_controller_char_base")
require("homeland_input_controller_char_pc")
_class("HomelandInputControllerStoryPC", HomelandInputControllerCharPC)
HomelandInputControllerStoryPC = HomelandInputControllerStoryPC

function HomelandInputControllerStoryPC:Constructor()
  HomelandInputControllerStoryPC.super.Constructor(self)
  self._moveActive = true
  self._rotActive = true
  self._scaleActive = true
end

function HomelandInputControllerStoryPC:OnUpdate(deltaTimeMS)
  if self._moveActive then
    self._inputX = 0
    self._inputZ = 0
    if self._input.GetKey(UnityEngine.KeyCode.W) then
      self._inputZ = 1
    elseif self._input.GetKey(UnityEngine.KeyCode.S) then
      self._inputZ = -1
    end
    if self._input.GetKey(UnityEngine.KeyCode.A) then
      self._inputX = -1
    elseif self._input.GetKey(UnityEngine.KeyCode.D) then
      self._inputX = 1
    end
    if self._inputX ~= 0 or self._inputZ ~= 0 then
      local movement = self._followCameraController:CalcMovement(Vector3(self._inputX, 0, self._inputZ)):SetNormalize()
      self._mainCharacterController:Move(movement, HomelandCharMoveType.Run, deltaTimeMS)
    end
  end
  if self._rotActive and self._input.GetMouseButton(0) and not self._currentEvent:IsPointerOverGameObject() then
    local mx = self._input.GetAxis("Mouse X")
    local my = self._input.GetAxis("Mouse Y")
    self._followCameraController:HandleRotate(mx, my)
  end
  if self._scaleActive then
    local mouseWheel = self._input.GetAxis("Mouse ScrollWheel")
    if mouseWheel ~= 0 then
      self._followCameraController:HandleScale(mouseWheel)
    end
    if self._input.GetKey(UnityEngine.KeyCode.UpArrow) or self._input.GetKey(UnityEngine.KeyCode.DownArrow) or self._input.GetKey(UnityEngine.KeyCode.LeftArrow) or self._input.GetKey(UnityEngine.KeyCode.RightArrow) then
      local mx = 0
      local my = 0
      if self._input.GetKey(UnityEngine.KeyCode.UpArrow) then
        my = 0.1
      elseif self._input.GetKey(UnityEngine.KeyCode.DownArrow) then
        my = -0.1
      end
      if self._input.GetKey(UnityEngine.KeyCode.RightArrow) then
        mx = 0.1
      elseif self._input.GetKey(UnityEngine.KeyCode.LeftArrow) then
        mx = -0.1
      end
      self._followCameraController:HandleRotate(mx, my)
    end
  end
end

function HomelandInputControllerStoryPC:ActiveMove(active)
  self._moveActive = active
end

function HomelandInputControllerStoryPC:ActiveRot(active)
  self._rotActive = active
end

function HomelandInputControllerStoryPC:ActiveScale(active)
  self._scaleActive = active
end

function HomelandInputControllerStoryPC:HandleRotateInInteract(v2)
  if self._rotActive then
    self._followCameraController:HandleRotate(v2.x, v2.y)
  end
end
