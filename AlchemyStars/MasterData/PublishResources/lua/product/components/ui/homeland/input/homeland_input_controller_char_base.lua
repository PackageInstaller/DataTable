_class("HomelandInputControllerCharBase", Object)
HomelandInputControllerCharBase = HomelandInputControllerCharBase

function HomelandInputControllerCharBase:Constructor()
  self._active = false
  self._dashHolding = false
  self._rushing = false
end

function HomelandInputControllerCharBase:Init(mainCharacterController, followCameraController)
  self._mainCharacterController = mainCharacterController
  self._followCameraController = followCameraController
  self:SetActive(true)
end

function HomelandInputControllerCharBase:SetActive(active)
  self._active = active
end

function HomelandInputControllerCharBase:Dispose()
end

function HomelandInputControllerCharBase:Update(deltaTimeMS)
  if self._active then
    self:OnUpdate(deltaTimeMS)
  end
end

function HomelandInputControllerCharBase:HandleMove(moveVec, moveState)
end

function HomelandInputControllerCharBase:HandleRotate(rotateVec)
end

function HomelandInputControllerCharBase:HandleScale(scale)
end

function HomelandInputControllerCharBase:DashStart()
  self._dashHolding = true
  self._mainCharacterController:Dash(function()
    self:DashUpdateCallback()
  end)
end

function HomelandInputControllerCharBase:DashRelease()
  self._dashHolding = false
  self._rushing = false
end

function HomelandInputControllerCharBase:DashEnd()
  self._rushing = self._dashHolding
end

function HomelandInputControllerCharBase:IsRushing()
  return self._rushing
end

function HomelandInputControllerCharBase:DashUpdateCallback()
  self._followCameraController:UpdatePos(self._mainCharacterController:Position())
end

function HomelandInputControllerCharBase:Enter()
  self._followCameraController:UpdatePos(self._mainCharacterController:Position())
end
