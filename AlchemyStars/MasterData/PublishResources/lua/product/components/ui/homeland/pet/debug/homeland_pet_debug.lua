_class("HomelandPetDebug", Object)
HomelandPetDebug = HomelandPetDebug

function HomelandPetDebug:Constructor(manager, mode)
  self._homelandPetManager = manager
  self._homelandPetHUDCameraRes = "HomelandPetHUDCamera.prefab"
  self._homelandPetHUDCanvasRes = "HomelandPetHUDCanvas.prefab"
  self._homelandPetDebugInfo = "HomelandPetDebugInfo.prefab"
  self._debugInfoRequest = {}
  self._debugInfo = {}
  self._mode = mode
end

function HomelandPetDebug:Init(homelandClient)
  if self._mode == HomelandPetMode.Normal then
    return
  end
  self._homelineClient = homelandClient
  self._mainCamera = self._homelineClient:CameraManager():GetCamera()
  self._hudCameraRequest = ResourceManager:GetInstance():SyncLoadAsset(self._homelandPetHUDCameraRes, LoadType.GameObject)
  self._hudCameraRequest.Obj:SetActive(true)
  self._hudCameraRequest.Obj.transform.position = Vector3.zero
  self._hudCamera = self._hudCameraRequest.Obj:GetComponent("Camera")
  self._hudCanvasRequest = ResourceManager:GetInstance():SyncLoadAsset(self._homelandPetHUDCanvasRes, LoadType.GameObject)
  self._hunCanvasGameObject = self._hudCanvasRequest.Obj
  self._hunCanvasGameObject:SetActive(true)
  self._hunCanvasGameObject.transform.position = Vector3.zero
  self._hudCanvas = self._hunCanvasGameObject:GetComponent("Canvas")
  self._hudCanvas.worldCamera = self._hudCamera
end

function HomelandPetDebug:AddDebugPet(pet)
  if self._mode == HomelandPetMode.Normal then
    return
  end
  for _, info in pairs(self._debugInfo) do
    if not info.pet then
      info.pet = pet
      info.gameObject:SetActive(true)
      return
    end
  end
  local request = ResourceManager:GetInstance():SyncLoadAsset(self._homelandPetDebugInfo, LoadType.GameObject)
  self._debugInfoRequest[#self._debugInfoRequest + 1] = request
  local debugInfo = {}
  debugInfo.gameObject = request.Obj
  debugInfo.gameObject:SetActive(true)
  debugInfo.gameObject.transform:SetParent(self._hunCanvasGameObject.transform)
  debugInfo.gameObject.transform.localScale = Vector3.one
  debugInfo.debugText = HomelandPetDebugText:New(debugInfo.gameObject)
  debugInfo.pet = pet
  self._debugInfo[#self._debugInfo + 1] = debugInfo
end

function HomelandPetDebug:RemoveDebugPet(pet)
  if self._mode == HomelandPetMode.Normal then
    return
  end
  for _, info in pairs(self._debugInfo) do
    if info.pet == pet then
      info.pet = nil
      info.gameObject:SetActive(false)
      break
    end
  end
end

function HomelandPetDebug:Update()
  if self._mode == HomelandPetMode.Normal then
    return
  end
  for _, info in pairs(self._debugInfo) do
    if info.pet then
      local behavior = info.pet:GetPetBehavior()
      if behavior then
        local position = info.pet:GetPosition()
        position = self._mainCamera:WorldToScreenPoint(position)
        position = self._hudCamera:ScreenToWorldPoint(position)
        local behaviorType = behavior:GetCurBehaviorType()
        for key, value in pairs(HomelandPetBehaviorType) do
          if value == behaviorType then
            info.debugText:Refresh(position, key)
            break
          end
        end
      end
    end
  end
end

function HomelandPetDebug:Dispose()
  if self._hudCameraRequest then
    self._hudCameraRequest:Dispose()
    self._hudCameraRequest = nil
  end
  if self._hudCanvasRequest then
    self._hudCanvasRequest:Dispose()
    self._hudCanvasRequest = nil
  end
  for _, request in pairs(self._debugInfoRequest) do
    request:Dispose()
  end
  self._debugInfoRequest = nil
  self._debugInfo = nil
end
