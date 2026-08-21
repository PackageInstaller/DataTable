require("homeland_input_controller_char_base")
require("homeland_input_controller_char_mobile")
_class("HomelandInputControllerStoryMobile", HomelandInputControllerCharMobile)
HomelandInputControllerStoryMobile = HomelandInputControllerStoryMobile

function HomelandInputControllerStoryMobile:Constructor()
  HomelandInputControllerStoryMobile.super.Constructor(self)
  self._moveActive = true
  self._rotActive = true
  self._scaleActive = true
end

function HomelandInputControllerStoryMobile:OnUpdate(deltaTimeMS)
  if self._moveActive then
    if self._mainCharacterController:State() == HomelandActorStateType.Dash then
      return
    end
    if self._moveInput or self._rotateInput then
      if self._inputMoveVec.x ~= 0 or self._inputMoveVec.y ~= 0 then
        self._movementVec = self._followCameraController:CalcMovement(Vector3(self._inputMoveVec.x, 0, self._inputMoveVec.y))
      else
        self._movementVec = nil
      end
      self._moveInput = false
    end
    if self._movementVec then
      self._mainCharacterController:Move(self._movementVec:SetNormalize(), self._moveType, deltaTimeMS)
    end
  end
end

function HomelandInputControllerStoryMobile:HandleMove(moveVec, moveState)
  if self._moveActive then
    self._inputMoveVec = moveVec
    self._moveType = moveState
    self._moveInput = true
  end
end

function HomelandInputControllerStoryMobile:HandleRotate(rotateVec)
  if self._rotActive then
    self._followCameraController:HandleRotate(rotateVec.x * self._rotateFactorX, rotateVec.y * self._rotateFactorY)
    self._rotateInput = true
  end
end

function HomelandInputControllerStoryMobile:HandleScale(scale)
  if self._scaleActive then
    self._followCameraController:HandleScale(scale)
  end
end

function HomelandInputControllerStoryMobile:ActiveMove(active)
  self._moveActive = active
end

function HomelandInputControllerStoryMobile:ActiveRot(active)
  self._rotActive = active
end

function HomelandInputControllerStoryMobile:ActiveScale(active)
  self._scaleActive = active
end

function HomelandInputControllerStoryMobile:HandleRotateInInteract(rotateVec)
  if self._rotActive then
    self._followCameraController:HandleRotate(rotateVec.x, rotateVec.y)
  end
end
