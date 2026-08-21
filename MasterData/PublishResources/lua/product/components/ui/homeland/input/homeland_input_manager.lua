_class("HomelandInputManager", Object)
HomelandInputManager = HomelandInputManager

function HomelandInputManager:Constructor()
  self._lastTick = 0
  self._useMobileController = true
  self._inputControllerChar = nil
  self._inputControllerBuild = nil
  self._inputControllerStory = nil
  self._inputControllerMedalWall = nil
  self._mode = HomelandMode.Normal
  self._currentInputController = nil
  self._resetCallback = {}
end

function HomelandInputManager:Init(homelandClient)
  self._homelandClient = homelandClient
  local mainCharCon = homelandClient:CharacterManager():MainCharacterController()
  local followCamCon = homelandClient:CameraManager():FollowCameraController()
  local globalCamCon = homelandClient:CameraManager():GlobalCameraController()
  local medalWallCamCon = homelandClient:CameraManager():MedalWallCameraController()
  if EDITOR or IsPc() then
    self._useMobileController = false
    self._inputControllerChar = HomelandInputControllerCharPC:New(homelandClient)
    self._inputControllerBuild = HomelandInputControllerBuildPC:New(homelandClient)
    self._inputControllerStory = HomelandInputControllerStoryPC:New(homelandClient)
    self._inputControllerMedalWall = HomelandInputControllerMedalWallPC:New(homelandClient)
  else
    UnityEngine.Input.multiTouchEnabled = true
    self._useMobileController = true
    self._inputControllerChar = HomelandInputControllerCharMobile:New(homelandClient)
    self._inputControllerBuild = HomelandInputControllerBuildMobile:New(homelandClient)
    self._inputControllerStory = HomelandInputControllerStoryMobile:New(homelandClient)
    self._inputControllerMedalWall = HomelandInputControllerMedalWallMobile:New(homelandClient)
  end
  self._inputControllerChar:Init(mainCharCon, followCamCon)
  self._inputControllerBuild:Init(mainCharCon, globalCamCon)
  self._inputControllerStory:Init(mainCharCon, globalCamCon)
  self._inputControllerMedalWall:Init(mainCharCon, medalWallCamCon)
  self._currentInputController = self._inputControllerChar
end

function HomelandInputManager:Update(deltaTimeMS)
  self._currentInputController:Update(deltaTimeMS)
end

function HomelandInputManager:Dispose()
  self._inputControllerChar:Dispose()
  self._inputControllerBuild:Dispose()
  self._inputControllerStory:Dispose()
  self._inputControllerMedalWall:Dispose()
  UnityEngine.Input.multiTouchEnabled = false
end

function HomelandInputManager:ResetCurController()
  if self._currentInputController.Reset then
    self._currentInputController:Reset()
  end
  for i = 1, #self._resetCallback do
    self._resetCallback[i]()
  end
end

function HomelandInputManager:AddResetCallback(callback)
  table.insert(self._resetCallback, callback)
end

function HomelandInputManager:RemoveResetCallback(callback)
  table.removev(self._resetCallback, callback)
end

function HomelandInputManager:UseMobileController()
  return self._useMobileController
end

function HomelandInputManager:GetControllerChar()
  return self._inputControllerChar
end

function HomelandInputManager:GetControllerBuild()
  return self._inputControllerBuild
end

function HomelandInputManager:GetControllerStory()
  return self._inputControllerStory
end

function HomelandInputManager:GetControllerMedalWall()
  return self._inputControllerMedalWall
end

function HomelandInputManager:OnModeChanged(mode)
  if self._currentInputController and self._currentInputController.Leave then
    self._currentInputController:Leave()
  end
  self._mode = mode
  if mode == HomelandMode.Normal then
    self._currentInputController = self._inputControllerChar
    self._currentInputController:Enter()
  elseif mode == HomelandMode.Build then
    self._currentInputController = self._inputControllerBuild
    self._currentInputController:Enter()
  elseif mode == HomelandMode.Story then
    self._currentInputController = self._inputControllerStory
    self._currentInputController:Enter()
  end
end

function HomelandInputManager:HandleRotateInInteract(v2)
  self._inputControllerChar:HandleRotateInInteract(v2)
end

function HomelandInputManager:ChangeMedalWallController(isMedalWall, cameraTransform)
  if self._currentInputController and self._currentInputController.Leave then
    self._currentInputController:Leave()
  end
  if isMedalWall then
    self._currentInputController = self._inputControllerMedalWall
  elseif self._mode == HomelandMode.Normal then
    self._currentInputController = self._inputControllerChar
  elseif self._mode == HomelandMode.Build then
    self._currentInputController = self._inputControllerBuild
  elseif self._mode == HomelandMode.Story then
    self._currentInputController = self._inputControllerStory
  end
  self._currentInputController:Enter(cameraTransform)
end
