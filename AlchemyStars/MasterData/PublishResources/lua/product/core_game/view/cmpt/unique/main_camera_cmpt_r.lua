_class("MainCameraComponent", Object)
MainCameraComponent = MainCameraComponent

function MainCameraComponent:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self.camera = nil
  self._hudCamera = nil
  self._hudCameraResPath = "HUD Camera.prefab"
  self._hudCameraRequest = nil
  self._hudBgResPath = "hud_bg.prefab"
  self._hudBgRequest = nil
  self._hudBgObj = nil
  self._hudBgImg = nil
  self._hudDarkCameraResPath = "dark_hud_camera.prefab"
  self._hudDarkCameraRequest = nil
  self._darkSceneCameraResPath = "dark_scene_camera.prefab"
  self._darkSceneCameraRequest = nil
  self._hudCanvasResPath = "HUDCanvas.prefab"
  self._hudCanvasRequest = nil
  self._hudCanvas = nil
  self._darkSceneCamera = nil
  self._darkHUDCamera = nil
  self._focusPlayer = false
  self._effectCamera = nil
  self._effectCameraResPath = "EffectCamera.prefab"
  self._effectCameraRequest = nil
  self._toFocusTweener = nil
  self._toNormalTweener = nil
  self._fovTweener = nil
  self._movingToNormal = false
  self._movingToFocus = false
  self._sceneCameraResPath = "scene_camera.prefab"
  self._sceneCameraRequest = nil
  self._sceneCamera = nil
  self._cameraFocusTargetPos = nil
  self._goScreenEffPoint = nil
  self._cameraFocusMoving = false
  self._auroraTimeFxResPath = "eff_jgsk.prefab"
  self._auroraTimeFxRequest = nil
  self._auroraTimeFx = nil
  self._auroraTimeFxAnimation = nil
  self._auroraTimeFxActive = false
  self._curMainCameraPos = nil
  self._MainCameraName = "MainCamera"
  self._request = nil
  self._goEffRuchangActorpoint = nil
  self._enalbeTileShift = false
  self._csTex2dSceneCameraScreenshot = nil
  self._darkCameraValue = 0
  self._enableDarkCamera = false
end

function MainCameraComponent:Dispose()
  self:_DisposeRes()
  self._auroraTimeFxRequest = nil
  self._auroraTimeFx = nil
  self._auroraTimeFxAnimation = nil
  self.camera = nil
  self._hudCameraRequest = nil
  self._hudCamera = nil
  self._hudBgRequest = nil
  self._hudBgObj = nil
  self._hudBgImg = nil
  self._hudDarkCameraRequest = nil
  self._darkSceneCameraRequest = nil
  self._hudCanvasRequest = nil
  self._hudCanvas = nil
  self._darkSceneCamera = nil
  self._darkHUDCamera = nil
  self._effectCamera = nil
  self._effectCameraRequest = nil
  self._sceneCamera = nil
  self._sceneCameraRequest = nil
  self._toFocusTweener = nil
  self._toNormalTweener = nil
  self._fovTweener = nil
  self._postProcessingCmpt = nil
  self._request = nil
  self._goEffRuchangActorpoint = nil
  if self._csTex2dSceneCameraScreenshot and tostring(self._csTex2dSceneCameraScreenshot) ~= "null" then
    self._csTex2dSceneCameraScreenshot:Destroy()
    self._csTex2dSceneCameraScreenshot = nil
  end
  local darkParamName = "H3DDarkLevel"
  UnityEngine.Shader.SetGlobalFloat(darkParamName, 0)
end

function MainCameraComponent:_DisposeRes()
  if self._hudCameraRequest ~= nil then
    self._hudCameraRequest:Dispose()
  end
  if self._hudBgRequest ~= nil then
    self._hudBgRequest:Dispose()
  end
  if self._hudDarkCameraRequest ~= nil then
    self._hudDarkCameraRequest:Dispose()
  end
  if self._darkSceneCameraRequest ~= nil then
    self._darkSceneCameraRequest:Dispose()
  end
  if self._darkSceneCameraRequest ~= nil then
    self._darkSceneCameraRequest:Dispose()
  end
  if self._hudCanvasRequest ~= nil then
    self._hudCanvasRequest:Dispose()
  end
  if self._effectCameraRequest then
    self._effectCameraRequest:Dispose()
  end
  if self._sceneCameraRequest then
    self._sceneCameraRequest:Dispose()
  end
  if self._auroraTimeFxRequest then
    self._auroraTimeFxRequest:Dispose()
  end
end

function MainCameraComponent:Initialize()
end

function MainCameraComponent:Camera()
  if not tolua.isnull(self.camera) and self.camera ~= nil then
    return self.camera
  end
  local go = UnityEngine.GameObject.Find(self._MainCameraName)
  if not go then
    self._request = UnityResourceService:GetInstance():LoadGameObject(self._MainCameraName .. ".prefab")
    go = self._request.Obj
    go.name = self._MainCameraName
  end
  self.camera = go:GetComponent("Camera")
  self.darkCameraHelperGo = UnityEngine.GameObject:New("DarkCameraHelperGo")
  self.darkCameraHelperGo.transform.parent = go.transform
  self._postProcessingCmpt = go:GetComponent("UnityEngine.H3DPostProcessing.PostProcessing")
  return self.camera
end

function MainCameraComponent:HUDCamera()
  if self._hudCamera ~= nil then
    return self._hudCamera
  end
end

function MainCameraComponent:HUDCanvas()
  if self._hudCanvas ~= nil then
    return self._hudCanvas
  end
end

function MainCameraComponent:GetFocusTargetPos()
  return self._cameraFocusTargetPos
end

function MainCameraComponent:ClearDarkCameraValue()
  self._darkCameraValue = 0
  self:EnableDarkCamera(false)
end

function MainCameraComponent:AddDarkCameraValue(value)
  self._darkCameraValue = value + self._darkCameraValue
  if self._darkCameraValue < 0 then
    self._darkCameraValue = 0
  end
  self:EnableDarkCamera(true, self._darkCameraValue)
end

function MainCameraComponent:SetDarkShaderValue(value)
  local darkParamName = "H3DDarkLevel"
  local darkVal = UnityEngine.Shader.GetGlobalFloat(darkParamName)
  local duration = BattleConst.DarkShaderDuration
  if self.darkCameraHelperGo then
    local helpTrans = self.darkCameraHelperGo.transform
    if self.darkFadeTweener then
      self.darkFadeTweener:Kill()
      self.darkFadeTweener = nil
    end
    helpTrans.localPosition = Vector3(0, 0, darkVal)
    self.darkFadeTweener = helpTrans:DOLocalMoveZ(value, duration):OnUpdate(function()
      local num = helpTrans.localPosition.z
      UnityEngine.Shader.SetGlobalFloat(darkParamName, num)
    end):OnComplete(function()
      UnityEngine.Shader.SetGlobalFloat(darkParamName, value)
    end)
  else
    if self.darkFadeTweener then
      self.darkFadeTweener:Kill()
      self.darkFadeTweener = nil
    end
    UnityEngine.Shader.SetGlobalFloat(darkParamName, value)
  end
end

function MainCameraComponent:EnableDarkCamera(enable, value)
  local goEnable = enable
  if self._darkCameraValue ~= 0 then
    goEnable = true
  end
  self._darkHUDCamera.gameObject:SetActive(goEnable)
  self._darkSceneCamera.gameObject:SetActive(goEnable)
  self._hudBgObj:SetActive(goEnable)
  self._enableDarkCamera = enable
  if enable == true then
    value = value or BattleConst.DarkShaderValue
    self:SetDarkShaderValue(value)
  else
    self:SetDarkShaderValue(self._darkCameraValue)
  end
end

function MainCameraComponent:SetHudBgAlpha(targetAlpha)
  local color = self._hudBgImg.color
  color.a = targetAlpha
  self._hudBgImg.color = color
end

function MainCameraComponent:ScreenPointToRay(point)
  local camera = self:Camera()
  return camera:ScreenPointToRay(point)
end

function MainCameraComponent:IsFocusPlayer()
  return self._focusPlayer
end

function MainCameraComponent:IsNormalState()
  return self._focusPlayer == false and self._movingToNormal == false and self._movingToFocus == false
end

function MainCameraComponent:SetCameraPos(pos)
  self._curMainCameraPos = pos
end

function MainCameraComponent:_MoveCameraToNormal()
  self._focusPlayer = false
  self._movingToNormal = true
  local cameraTransform = self:Camera().gameObject.transform
  local levelConfigData = self._configService:GetLevelConfigData()
  local cameraParam = levelConfigData:GetCameraParam()
  local targetFov = cameraParam:GetFov()
  local originalCameraPos = self._curMainCameraPos or cameraParam:GetCameraPosition()
  local duration = BattleConst.FocusToNormalTimeLen
  self._toNormalTweener = cameraTransform:DOMove(originalCameraPos, duration):OnComplete(function()
    local guideService = self._world:GetService("Guide")
    guideService:HandleCameraMoveToNormalTrigger()
    guideService:HandlePLLCameraMoveToNormalTrigger()
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      YIELD(TT, 200)
      self._movingToNormal = false
    end)
  end)
end

function MainCameraComponent:_MoveCameraToFocus(dur)
  self._movingToFocus = true
  self._cameraFocusMoving = true
  local targetFov = BattleConst.FocusPlayerFov
  local duration = BattleConst.FocusFovTimeLen
  if dur then
    duration = dur
  end
  local cameraTransform = self:Camera().gameObject.transform
  local levelConfigData = self._configService:GetLevelConfigData()
  local cameraParam = levelConfigData:GetCameraParam()
  local originalCameraPos = cameraParam:GetCameraPosition()
  local targetPos = self:_CalcZoomToPlayerTarget()
  self._cameraFocusTargetPos = targetPos
  local easeType = DG.Tweening.Ease.OutCubic
  self._toFocusTweener = cameraTransform:DOMove(targetPos, duration):OnComplete(function()
    self._movingToFocus = false
    self._focusPlayer = true
  end):SetEase(easeType)
  local guideService = self._world:GetService("Guide")
  guideService:HandleCameraMoveToFocusTrigger()
  guideService:HandlePLLCameraMoveToFocusTrigger()
end

function MainCameraComponent:IsMovingToFocus()
  return self._movingToFocus
end

function MainCameraComponent:MoveCameraToFocusImmediately()
  if self._toFocusTweener then
    self._toFocusTweener:Kill()
    self._toFocusTweener = nil
    local cameraTransform = self:Camera().gameObject.transform
    cameraTransform.position = self._cameraFocusTargetPos
  end
  self._movingToFocus = false
  self._focusPlayer = true
end

function MainCameraComponent:_CalcZoomToPlayerTarget()
  local cameraTransform = self:Camera().gameObject.transform
  local cameraPos = cameraTransform.position
  local playerWorldPos = self:_GetMainCameraPlayerRenderPos()
  local pickUpCmpt = self._world:PickUp()
  local skillID = pickUpCmpt:GetCurActiveSkillID()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local activeSkillPickUpType = skillConfigData:GetSkillPickType()
  if activeSkillPickUpType == SkillPickUpType.Moye then
    local previewEntity = self._world:GetPreviewEntity()
    local previewLinkLineCmpt = previewEntity:PreviewLinkLine()
    local chainPath = previewLinkLineCmpt:GetPreviewChainPath()
    if 0 < #chainPath then
      local pieceSvc = self._world:GetService("Piece")
      local entity = pieceSvc:FindPieceEntity(chainPath[1])
      playerWorldPos = entity:Location().Position
    end
  end
  local configService = self._configService
  local levelConfig = configService:GetLevelConfigData()
  local centerPos = levelConfig:GetBoardCenterPos()
  local battleRenderCmpt = self._world:BattleRenderConfig()
  local curWaveBoardCenter = battleRenderCmpt:GetCurWaveBoardCenter()
  if curWaveBoardCenter then
    centerPos = curWaveBoardCenter
  end
  local playerToCenterDistance = Vector3.Distance(playerWorldPos, centerPos)
  local moveDistance = BattleConst.CameraNormalTranslate
  if playerToCenterDistance > BattleConst.BorderDistance then
    moveDistance = BattleConst.CameraMaxTranslate
  end
  local moveDir = Vector3.Normalize(playerWorldPos - cameraPos)
  local targetPos = cameraPos + moveDir:Mul(moveDistance)
  return targetPos
end

function MainCameraComponent:_GetMainCameraPlayerRenderPos()
  if self._world:GetRunningPosition() == WorldRunPostion.Performance then
    return Vector2(0, 0)
  end
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamLeaderEntity = teamEntity:GetTeamLeaderPetEntity()
  local playerWorldPos = teamEntity:Location().Position
  return playerWorldPos
end

function MainCameraComponent:DoMoveCamera(isMoveToFocus)
  if isMoveToFocus == true then
    if self._movingToNormal == true then
      if self._toNormalTweener ~= nil then
        self._toNormalTweener:Kill()
      end
      if self._fovTweener ~= nil then
        self._fovTweener:Kill()
      end
      self:_MoveCameraToFocus()
    elseif self._movingToFocus == false then
      self:_MoveCameraToFocus()
    end
    self._movingToNormal = false
  else
    if self._movingToFocus == true then
      if self._toFocusTweener ~= nil then
        self._toFocusTweener:Kill()
      end
      if self._fovTweener ~= nil then
        self._fovTweener:Kill()
      end
      self:_MoveCameraToNormal()
    elseif self._movingToNormal == false then
      self:_MoveCameraToNormal()
    end
    self._movingToFocus = false
  end
end

function MainCameraComponent:LoadHUDCamera()
  self._hudCameraRequest = UnityResourceService:GetInstance():LoadGameObject(self._hudCameraResPath)
  local hudCameraObj = self._hudCameraRequest.Obj
  self._hudCamera = hudCameraObj:GetComponent("Camera")
  self._hudCanvasRequest = UnityResourceService:GetInstance():LoadGameObject(self._hudCanvasResPath)
  local hudCanvasObj = self._hudCanvasRequest.Obj
  self._hudCanvas = hudCanvasObj:GetComponent("Canvas")
  self._hudCanvas.worldCamera = self._hudCamera
  self._hudDarkCameraRequest = UnityResourceService:GetInstance():LoadGameObject(self._hudDarkCameraResPath)
  local hudDarkCameraObj = self._hudDarkCameraRequest.Obj
  self._darkHUDCamera = hudDarkCameraObj:GetComponent("Camera")
  self._hudDarkCameraRequest.Obj:SetActive(false)
  self._hudBgRequest = UnityResourceService:GetInstance():LoadGameObject(self._hudBgResPath)
  self._hudBgObj = self._hudBgRequest.Obj
  local canvasTransform = GameObjectHelper.FindChild(self._hudBgObj.transform, "Canvas")
  local canvasCmpt = canvasTransform.gameObject:GetComponent("Canvas")
  canvasCmpt.worldCamera = self._darkHUDCamera
  self._hudBgObj:SetActive(false)
  local hudImgCanvasTransform = GameObjectHelper.FindChild(self._hudBgObj.transform, "Image")
  self._hudBgImg = hudImgCanvasTransform.gameObject:GetComponent("Image")
end

function MainCameraComponent:LoadDarkCamera()
  self._darkSceneCameraRequest = UnityResourceService:GetInstance():LoadGameObject(self._darkSceneCameraResPath)
  local darkSceneCameraObj = self._darkSceneCameraRequest.Obj
  self._darkSceneCameraRequest.Obj:SetActive(false)
  self._darkSceneCamera = darkSceneCameraObj:GetComponent("Camera")
  self._darkSceneCamera.fieldOfView = self.camera.fieldOfView
  self._darkSceneCamera.nearClipPlane = self.camera.nearClipPlane
  self._darkSceneCamera.farClipPlane = self.camera.farClipPlane
  self._darkSceneCamera.transform.position = self.camera.transform.position
  self._darkSceneCamera.transform.rotation = self.camera.transform.rotation
end

function MainCameraComponent:LoadEffectCamera()
  self._effectCameraRequest = UnityResourceService:GetInstance():LoadGameObject(self._effectCameraResPath)
  local effectCameraObj = self._effectCameraRequest.Obj
  self._effectCameraRequest.Obj:SetActive(false)
  self._effectCamera = effectCameraObj:GetComponent("Camera")
  self._effectCamera.fieldOfView = self.camera.fieldOfView
  self._effectCamera.nearClipPlane = self.camera.nearClipPlane
  self._effectCamera.farClipPlane = self.camera.farClipPlane
  self._effectCamera.transform.position = self.camera.transform.position
  self._effectCamera.transform.rotation = self.camera.transform.rotation
end

function MainCameraComponent:LoadSceneCamera()
  self._sceneCameraRequest = UnityResourceService:GetInstance():LoadGameObject(self._sceneCameraResPath)
  local sceneCameraObj = self._sceneCameraRequest.Obj
  self._sceneCameraRequest.Obj:SetActive(false)
  self._sceneCamera = sceneCameraObj:GetComponent("Camera")
  self._sceneCamera.fieldOfView = self.camera.fieldOfView
  self._sceneCamera.nearClipPlane = self.camera.nearClipPlane
  self._sceneCamera.farClipPlane = self.camera.farClipPlane
  self._sceneCamera.transform.position = self.camera.transform.position
  self._sceneCamera.transform.rotation = self.camera.transform.rotation
  self._sceneCamera.transform:SetParent(self.camera.transform)
end

function MainCameraComponent:LoadAuroraTimeFx()
  self._auroraTimeFxRequest = UnityResourceService:GetInstance():LoadGameObject(self._auroraTimeFxResPath)
  local auroraTimeFx = self._auroraTimeFxRequest.Obj
  self._auroraTimeFx = auroraTimeFx
  self._auroraTimeFx:SetActive(false)
  self._auroraTimeFxAnimation = auroraTimeFx:GetComponentInChildren(typeof(UnityEngine.Animation))
end

function MainCameraComponent:EnableEffectCamera(enable)
  self._effectCamera.transform.position = self.camera.transform.position
  self._effectCamera.transform.rotation = self.camera.transform.rotation
  self._effectCamera.gameObject:SetActive(enable)
end

function MainCameraComponent:ShakeCamera(oriPos, offset)
  local currentRotation = self.camera.transform.rotation
  local deltaPos = currentRotation:MulVec3(offset)
  local targetPos = oriPos + deltaPos
  self.camera.transform.position = targetPos
  self._darkSceneCamera.transform.position = targetPos
  self._effectCamera.transform.position = targetPos
end

function MainCameraComponent:EnableSceneTiltShift(enable)
  if not self._enalbeTileShift then
    return
  end
  if self._postProcessingCmpt == nil then
    Log.fatal("Can not find main camera post processing component!")
    Log.error(Log.traceback())
    return
  end
  self._postProcessingCmpt:SetTiltShiftActive(enable)
end

function MainCameraComponent:ToggleAuroraTime(active)
  if self._auroraTimeFxActive == active then
    return
  end
  self._auroraTimeFxActive = active
  if active then
    local utilStatSvc = self._world:GetService("UtilData")
    local curRound = utilStatSvc:GetStatCurWaveRoundNum()
    GameGlobal.UAReportForceGuideEvent("FightAuroraTime", {curRound}, false, true)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundAuroraTimeActive)
    self._auroraTimeFxAnimation:Play("uieff_jgsk_in")
    if self._auroraTimeFx then
      local auroraTimeFxQuad = GameObjectHelper.FindChild(self._auroraTimeFx.transform, "Quad")
      if auroraTimeFxQuad then
        auroraTimeFxQuad.transform.localPosition = Vector3(0, BattleConst.AuroraTimeFxQuadHeight, 0)
      end
    end
  else
    self._auroraTimeFxAnimation:Play("uieff_jgsk_out")
    if self._auroraTimeFx then
      local auroraTimeFxQuad = GameObjectHelper.FindChild(self._auroraTimeFx.transform, "Quad")
      if auroraTimeFxQuad then
        auroraTimeFxQuad.transform.localPosition = Vector3(0, -10, 0)
      end
    end
  end
end

function MainCameraComponent:SetAuroaTimeObjActive(active)
  if self._auroraTimeFx then
    self._auroraTimeFx:SetActive(active)
  end
end

function MainCameraComponent:CloseCamera()
  if self.camera then
    self.camera.gameObject:SetActive(false)
  end
  if self._darkSceneCamera then
    self._darkSceneCamera.gameObject:SetActive(false)
  end
  if self._darkHUDCamera then
    self._darkHUDCamera.gameObject:SetActive(false)
  end
  if self._effectCamera then
    self._effectCamera.gameObject:SetActive(false)
  end
  if self._sceneCamera then
    self._sceneCamera.gameObject:SetActive(false)
  end
end

function MainCameraComponent:AttachScreenEffPoint()
  local cam = self:Camera()
  self._goScreenEffPoint = GameObjectHelper.CreateEmpty(self:ScreenEffPoint(), cam.transform)
  self._goScreenEffPoint.transform.localPosition = Vector3(0, 0, 20)
end

function MainCameraComponent:ScreenEffPoint()
  return "ScreenEffPoint"
end

function MainCameraComponent:ScreenEffPointGo()
  return self._goScreenEffPoint
end

function MainCameraComponent:EffectCamera()
  return self._effectCamera
end

function MainCameraComponent:SetGoEffRuchangActorpoint(goEffRuchangActorpoint)
  self._goEffRuchangActorpoint = goEffRuchangActorpoint
end

function MainCameraComponent:GetGoEffRuchangActorpoint()
  return self._goEffRuchangActorpoint
end

function MainCameraComponent:SetScreenCameraScreenshot(csTex2d)
  self._csTex2dSceneCameraScreenshot = csTex2d
end

function MainCameraComponent:GetScreenCameraScreenshot()
  return self._csTex2dSceneCameraScreenshot
end

function MainCameraComponent:SetPostProcessingProfile(profile)
  self._postProcessingCmpt.profile = profile
end

function MainCameraComponent:ResetFov_ForFoldableDevice()
  if self._darkSceneCamera then
    self._darkSceneCamera.fieldOfView = self.camera.fieldOfView
  end
  if self._darkHUDCamera then
    self._darkHUDCamera.fieldOfView = self.camera.fieldOfView
  end
  if self._effectCamera then
    self._effectCamera.fieldOfView = self.camera.fieldOfView
  end
  if self._sceneCamera then
    self._sceneCamera.fieldOfView = self.camera.fieldOfView
  end
end

function MainWorld:MainCamera()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.MainCamera)
end

function MainWorld:HasMainCamera()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.MainCamera) ~= nil
end

function MainWorld:AddMainCamera()
  local index = self.BW_UniqueComponentsEnum.MainCamera
  local component = MainCameraComponent:New(self)
  component:Initialize()
  self:SetUniqueComponent(index, component)
end

function MainWorld:RemoveMainCamera()
  if self:HasMainCamera() then
    self:SetUniqueComponent(self.BW_UniqueComponentsEnum.MainCamera, nil)
  end
end
