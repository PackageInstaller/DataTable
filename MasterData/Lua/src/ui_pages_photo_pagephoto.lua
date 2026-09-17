local this = class("pagePhoto", G_UIPageBase)
local _heroTpl = L_GameTpl:getHeroTpl()
local _MovieTimeLimit = L_GameTpl:getGameConstTpl():getData("PHOTO_MOVIE_TIME", L_Const.GameTplType.int)
local _PhotographParamTpl = L_GameTpl:getPhotographParamTpl()
local _gameClientTpl = L_GameTpl:getGameClientTpl()
local cameraPreset = _gameClientTpl:getData("PHOTO_CAMERA_SNAPSHOT", L_Const.GameTplType.list_float)
local _heroTpl = L_GameTpl:getHeroTpl()
local cameraPresetName = {
  [1] = "notice_pagePhoto_07",
  [2] = "notice_pagePhoto_08",
  [3] = "notice_pagePhoto_09"
}
local CAMERA_PRESET_TYPE = {
  FAR = 1,
  MIDDLE = 2,
  NEAR = 3
}
local LEFT_TOP_COLOR = {LIGHT = "#1c170719", DARK = "#1c170780"}

function this.bind()
  return {
    goCloseHide = false,
    goFuncPanel = true,
    goBasePanel = true,
    goCommonBg = true,
    goGrid = false,
    goCaptureArea = false,
    goWhiteCut = false,
    goMenu = true,
    goRecorder = false,
    goRetarget = false,
    txtRecord = "",
    imgRecordIcon = false,
    bgLeft = true,
    active_moveJoyStick = false,
    active_mobileNode = false,
    menu = {
      moduleName = "pages/photo/modulePhotoMenu"
    },
    bev = {
      moduleName = "pages/photo/modulePhotoBev"
    },
    listHeroHeads = {
      moduleName = "modulePages/cellHeroHeadItemCircle"
    },
    activeListHeroHeads = false,
    activeBtnChangeHero = true,
    changeHeroBtnImg = "",
    changeHeroBtnImgIn = {
      moduleName = "modulePages/cellHeroHeadItemCircle"
    },
    activeTogList = true,
    activeTogTakeMode = false,
    activeBgR1 = nil,
    activeBgR2 = nil,
    activeBev = nil,
    activeReset = nil,
    color_leftTop = C_Vector4(1, 1, 1, 1)
  }
end

function this.methods()
  return {
    onValueChanged_ui = function(self, isOn)
      self.mediator.isUI = false
    end,
    onValueChanged_viewLine = function(self, isOn)
      local mediator = L_PhotoManager:getMediator()
      local isActive = mediator:getSettingOrDefault(L_Const.photoParam.player)
      if isActive then
        self.mediator.isViewLine = not self.mediator.isViewLine
      else
        L_FlyMsgManager:showNormalMsgByKey("notice_pagePhoto_06")
      end
    end,
    onValueChanged_grid = function(self, isOn)
      self.mediator.isGrid = not self.mediator.isGrid
    end,
    onClick_closeHide = function(self)
      self.mediator.isUI = true
    end,
    onValueChanged_takeMode = function(self, isOn)
      self.mediator.takeMode = isOn and L_Const.photoTakeMode.normal or L_Const.photoTakeMode.street
    end,
    onClick_retarget = function(self)
    end,
    onClick_reset = function(self)
      self.modules.bev:resetScreen()
    end,
    bev = {
      onClick_capture = this.capture,
      onClick_recording = this.recording
    },
    onClick_changeHero = function(self)
      self:onClickChangeHeroBtn()
    end,
    onClick_quit = function(self)
      self:escHandle()
    end,
    listHeroHeads = {
      onClick = function(self, bind)
        self:showListHeroHeads(false)
        self:onClickHeroHead(bind)
      end
    }
  }
end

function this:created(...)
  this.super.created(self, ...)
  local addModuleGeneric = xlua.get_generic_method(self.csharpPage:GetType(), "AddModule", 1)
  if not L_DeviceTpl:getIsPc() then
    local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.ModuleMovementBlockMobile, CS.UnityEngine.GameObject)
    self.mobileMoveBlock = addModule(self.csharpPage, self.csharpPage, self.bindComponents.moblieMoveBlockTran.gameObject)
    self.bind.active_moveJoyStick = true
    self.bind.active_mobileNode = true
  end
end

function this:check(options, callback)
  if L_BattleDataManager:checkPlayerBattle() then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.PhotographEntrance))
    callback(false)
    return
  end
  if AzurWorld.FunctionModuleForbidMgr:CheckIsFunctionModuleForbid(C_EForbidModuleType.Photo, true) then
    callback(false)
    return
  end
  if L_PlayerManager:inKiBoTransformMainControl() then
    L_FlyMsgManager:showNormalMsgByKey("notice_pagePhoto_05")
    callback(false)
    return
  end
  if AzurWorld.photoMgr.isBattleRelation then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.PhotographEntrance))
    callback(false)
    return
  end
  local isPhotoTask = options and options.isPhotoTask
  local result = isPhotoTask or C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.photo)
  if result then
    result = not L_BattleStore:getIsInBattle() and L_PhotoManager:getMainControlIsFree() and not L_PlayerStore:getIsNewPlayer()
    result = result and CS.Lens.Gameplay.UI.Util.PhotoPlayUtil.CanPlayerSkillInputPhoto()
    local multi = AzurWorld.MultiPlayerCityMgr:IsInMultiPlayerCity()
    local mount = AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount()
    if multi and mount then
      result = false
    end
    if not result then
      L_FlyMsgManager:showNormalMsgByKey("notice_pagePhoto_04")
    end
  end
  if result then
    self:fadeIn()
  end
  callback(result)
end

function this:escHandle()
  local quitTxt
  if L_PhotoManager.sceneId ~= nil then
    quitTxt = "notice_photo_sceneQuit"
  else
    quitTxt = "notice_pagePhoto_03"
  end
  L_GameUtil.showCommonTip({
    txtContent = L_WordsTpl:getValue(quitTxt),
    confirmCallback = function()
      if L_PhotoManager.sceneId ~= nil then
        L_PhotoManager:backToNormalScene()
        L_PhotoManager.isGoScene = false
      else
        L_UI:close(self.pageName)
        if self.isBackToMain then
          L_UI:open("pageMainMenu")
        end
      end
    end
  })
end

function this:StartAlpha()
  self.bindComponents.photoCanvasGroup.alpha = 0.1
end

function this:EndAlpha()
  self.bindComponents.photoCanvasGroup.alpha = 1
end

function this:OpenBg()
  self.bind.bgLeft = true
  if L_DeviceTpl:getIsPc() then
    local _, color = C_ColorUtility.TryParseHtmlString("#1c170780")
    self.bind.color_leftTop = color
  else
    local _, color = C_ColorUtility.TryParseHtmlString("#1c170780")
    self.bind.color_leftTop = color
  end
end

function this:HideBg()
  self.bind.bgLeft = false
  if L_DeviceTpl:getIsPc() then
    local _, color = C_ColorUtility.TryParseHtmlString("#1c170780")
    self.bind.color_leftTop = color
  else
    local _, color = C_ColorUtility.TryParseHtmlString("#1c170780")
    self.bind.color_leftTop = color
  end
end

function this:preOpen(options)
  AzurWorld.photoMgr.pagePhotoOpened = true
  AzurWorld.photoMgr:EnterPagePhoto()
  self.bind.activeBtnChangeHero = not C_PhotoPlayUtil.IsMainControlInPLatform()
  AzurWorld.InteractMgr:AddWhiteListConfigId(114)
  self.isPhotoTask = options and options.isPhotoTask or false
  L_PhotoManager:sendEvent(L_PhotoManager.event.pagePhotoOpen)
  self.mediator = L_PhotoManager:enterPhoto()
  local entity = options and options.entity or AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
  self.isBackToMain = options and options.isBackToMain or false
  AzurWorld.photoMgr.isPhotoTask = self.isPhotoTask
  if L_DeviceTpl:getIsPc() then
    self:setShortcutGuidePCActive(true)
  end
  L_PhotoManager:addListener(L_PhotoManager.event.pagePhotoWhiteCut, self.onEvent_whiteCut, self)
  
  local function endDo()
    if not self.isBind then
      return
    end
    L_PhotoManager.util:translatePet(false)
    C_GameTime.ActiveUITimeAgent()
    C_GameTime.SetTimeOfDayTickFactor(0)
    C_CameraManager.ActivateTactics(C_ECameraType.Photo, C_CinemachineBlendType.Cut, 0)
    printf("", "pagePhoto SwitchToPhoto ")
    L_PlayerManager:stopIdleAnim()
    L_PhotoManager:addListener(L_PhotoManager.event.selectPhotoHeroChange, self.onEvent_selectPhotoHeroChange, self)
    L_ShortCutManager:addListener(L_ShortCutConst.event.Mount, self.onEvent_ShortCutMount, self)
    L_ShortCutManager:addListener(L_ShortCutConst.event.MountFly, self.onEvent_ShortCutMountFly, self)
    L_PhotoManager:addListener(L_PhotoManager.event.changeStartAlpha, self.StartAlpha, self)
    L_PhotoManager:addListener(L_PhotoManager.event.changeEndAlpha, self.EndAlpha, self)
    L_PhotoManager:addListener(L_PhotoManager.event.isActiveBg, self.OpenBg, self)
    L_PhotoManager:addListener(L_PhotoManager.event.isActiveBgFalse, self.HideBg, self)
    L_PhotoManager:registerCreateHeroFunc(handler(self, self.switchPhotoHero))
    local isMount = AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount()
    L_PhotoManager:setMediatorTarget(entity)
    if not self.isPhotoTask then
      C_CameraManager.GetTactics(C_ECameraType.Photo):RefreshFixedFollow()
    elseif isMount then
      local mountId = C_EntityManager.ControllingEntity.entity.data.entityId
      AzurWorld.visbleMgr:SetEntityVisible(false, mountId, CS.Lens.Gameplay.Modules.BigWorld.EEntityHideSource.PlayerUnit)
    end
    self.mediator.photoFilter = self.bindComponents.photoFilter
    self.mediator.volume = self.bindComponents.volume
    self.updateHeadBoardHandle = L_CommonUtil.handle(self.updateHeadBoard, self)
    self.modules.bev:InitChangeCamTabList()
    self:injectMediator()
    self:initZoom()
    self:initHeroList()
    local wind = C_RealWeather.GetWeatherWind()
    if wind then
      wind:SetMagicaDirectionalWind(self.bindComponents.magicWind)
    end
    AzurWorld.HomeMgr:LockAllEffect(true)
    if not self.isPhotoTask and not isMount then
      local uuid = options and options.heroUUID or entity.data.UUID
      AzurWorld.photoMgr:SwitchHero(uuid, function(e)
        if not self.isBind then
          return
        end
        local mainHeroEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
        L_PhotoManager:setMediatorTarget(mainHeroEntity)
        if C_CameraManager.GetTactics(C_ECameraType.Photo) then
          C_CameraManager.GetTactics(C_ECameraType.Photo):RefreshFixedFollow()
        end
        if options and options.targetPos and mainHeroEntity ~= nil then
          mainHeroEntity.entity:SafeSetPosition(C_Vector3(options.targetPos.x, options.targetPos.y, options.targetPos.z))
        end
      end)
    end
    if self.isPhotoTask then
      self:onPhotoTask()
      local page = C_UIMgr.GetPage(self.pageName)
      if page then
        page.overrideInputMap = C_InputManager_MapType.PagePhotoTask
      end
      C_CameraManager.uiCanScaleView = true
    end
    L_PhotoManager.useHighResolution = self.mediator:getSettingOrDefault(L_Const.photoParam.highResolution)
    self:sceneFunc(options)
  end
  
  self.isMount = AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount()
  if self.isMount then
    endDo()
  else
    AzurWorld.photoMgr:CreatePlayerUnitAdapter(endDo)
    AzurWorld.playerMgr.myPlayerUnitAdapter.pause = true
  end
  L_AudioUtil.playSound("Play_SFX_System_UI_Situation_Menu_Open")
  if L_DeviceTpl:getIsMobile() then
    C_UniversalRenderPipeline.SetMobilePunctualLight(true)
  end
  local _, color = C_ColorUtility.TryParseHtmlString(LEFT_TOP_COLOR.DARK)
  self.bind.color_leftTop = color
end

function this:close()
  AzurWorld.photoMgr.pagePhotoOpened = false
  L_PhotoManager.util:translatePet(true)
  AzurWorld.InteractMgr:RemoveWhiteListConfigId(114)
  C_GameTime.SetTimeOfDayTickFactor(1)
  C_GameTime.InactiveUITimeAgent()
  AzurWorld.HomeMgr:LockAllEffect(false)
  self:shutdownHeadBoard()
  self:cleanupHeadBoardCallback()
  if L_DeviceTpl:getIsPc() then
    self:setShortcutGuidePCActive(false)
  end
  self.mediator:revertSetting()
  if AzurWorld.playerMgr.myPlayerUnitAdapter ~= nil then
    AzurWorld.playerMgr.myPlayerUnitAdapter.pause = false
  end
  C_CameraManager.DeactivateTactics(C_ECameraType.Photo)
  printf("", "pagePhoto RevertCam ")
  local isMount = AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount()
  if not isMount then
    L_PhotoManager:destroyAllStateMachine()
    AzurWorld.photoMgr:DisposePlayerUnitAdapter()
    if AzurWorld.playerMgr.myPlayerUnitAdapter ~= nil then
      AzurWorld.playerMgr.myPlayerUnitAdapter:ResumePlayerUnit(nil, true)
    end
  end
  if isMount then
    local controllingEntity = C_EntityManager.ControllingEntity.entity
    local data = controllingEntity.data
    local target = self.mediator.target
    if target and target == data.rider then
      target.entity.transform.localRotation = C_Quaternion.identity
    end
    if self.isPhotoTask then
      local mountId = data.entityId
      AzurWorld.visbleMgr:SetEntityVisible(true, mountId, CS.Lens.Gameplay.Modules.BigWorld.EEntityHideSource.PlayerUnit)
    end
  end
  L_PhotoManager:setMediatorTarget()
  L_PhotoManager:exitPhoto()
  L_PlayerManager:initIdleAnim()
  L_PhotoManager:removeListener(L_PhotoManager.event.selectPhotoHeroChange, self.onEvent_selectPhotoHeroChange, self)
  L_ShortCutManager:removeListener(L_ShortCutConst.event.Mount, self.onEvent_ShortCutMount, self)
  L_ShortCutManager:removeListener(L_ShortCutConst.event.MountFly, self.onEvent_ShortCutMountFly, self)
  L_PhotoManager:removeListener(L_PhotoManager.event.changeStartAlpha, self.StartAlpha, self)
  L_PhotoManager:removeListener(L_PhotoManager.event.changeEndAlpha, self.EndAlpha, self)
  L_PhotoManager:removeListener(L_PhotoManager.event.isActiveBg, self.OpenBg, self)
  L_PhotoManager:removeListener(L_PhotoManager.event.isActiveBgFalse, self.HideBg, self)
  L_PhotoManager:removeListener(L_PhotoManager.event.pagePhotoWhiteCut, self.onEvent_whiteCut, self)
  if self.isRecording then
    self:cancelRecord()
  end
  local wind = C_RealWeather.GetWeatherWind()
  if wind then
    wind:SetMagicaDirectionalWind(nil)
  end
  if self.expressionCtrl then
    self.expressionCtrl:destroy()
  end
  L_PhotoManager:releaseHead(self)
  if self.isPhotoTask then
  end
  if L_DeviceTpl:getIsMobile() then
    C_UniversalRenderPipeline.SetMobilePunctualLight(false)
  end
  C_RealWeather.MarkWeatherDirty()
  AzurWorld.photoMgr:ExitPagePhoto()
end

function this:show()
  self.bind.goWhiteCut = false
  self.isWaitingCapture = false
  self:bindScreenTouch("+")
  self.batlleStartHandler = handler(self, self.onBattleStart)
  L_BattleManager:addListener(L_BattleManager.event.battleStart, self.batlleStartHandler)
  C_InputManager.ignoreLock = true
end

function this:hide()
  self:bindScreenTouch("-")
  if self.isRecording then
    self:cancelRecord()
  end
  if self.batlleStartHandler then
    L_BattleManager:removeListener(L_BattleManager.event.battleStart, self.batlleStartHandler)
    self.batlleStartHandler = nil
  end
  C_InputManager.ignoreLock = false
end

function this:onBattleStart()
  L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.PhotographEntrance))
  L_UI:close(self.pageName)
end

function this:fadeIn()
  local data = {
    coverdTime = 0.9,
    fadeOut = true,
    fadeIn = false,
    isCompleteClose = true
  }
end

function this:initTop()
  C_IntegrateMgr.TopBarModule:setTopBarCloseFunc(function()
    if L_PhotoManager.sceneId ~= nil then
      L_GameUtil.showCommonTip({
        txtContent = L_WordsTpl:getValue("notice_photo_sceneQuit"),
        confirmCallback = function()
          L_PhotoManager:backToNormalScene()
          L_PhotoManager.isGoScene = false
        end
      })
    else
      L_UI:close(self.pageName)
    end
  end)
end

function this:initZoom()
  local fixFollow = C_CameraManager.GetFixedFollow()
  if fixFollow then
    local function fix(isVolume)
      local target = self.mediator.target
      
      self.faceIn = isVolume
      if target then
        self:translateIK(self.mediator.isViewLine, false, self.mediator.target)
      end
      local cameraController = C_CameraManager.GetTactics(C_ECameraType.Photo)
      if not isVolume and cameraController and cameraController.ResetDistanceLimit ~= nil then
        cameraController:ResetDistanceLimit()
      end
    end
    
    function fixFollow.zoomInAction()
      fix(true)
    end
    
    function fixFollow.zoomOutAction()
      fix(false)
    end
  end
end

function this:bindScreenTouch(sign)
  self.onDragStartHandle = self.onDragStartHandle or L_CommonUtil.handle(self.onTouch_dragStart, self)
  self.onDragHandle = self.onDragHandle or L_CommonUtil.handle(self.onTouch_drag, self)
  self.onDragEndHandle = self.onDragEndHandle or L_CommonUtil.handle(self.onTouch_dragEnd, self)
  self.onClickEmptyHandle = self.onClickEmptyHandle or L_CommonUtil.handle(self.onClickEmpty, self)
  C_ScreenTouch.OnUI_DragStart(sign, self.onDragStartHandle)
  C_ScreenTouch.OnUI_Drag(sign, self.onDragHandle)
  C_ScreenTouch.OnUI_DragEnd(sign, self.onDragEndHandle)
  C_ScreenTouch.On_Click(sign, self.onClickEmptyHandle)
end

function this:onTouch_dragStart(gesture)
  self.touchViewHold = gesture.go == self.bindComponents.viewHold.gameObject
  if self.touchViewHold then
    self:startHeadBoard()
  end
end

function this:onTouch_drag(gesture)
  if not self.touchViewHold then
    return
  end
  local parent = self.bindComponents.viewHold.parent
  local width = parent.rect.width * 0.48
  local height = parent.rect.height * 0.48
  local temp = L_GameUtil.spToLpInRectangle(parent, gesture.position)
  temp.x = math.clamp(temp.x, -width, width)
  temp.y = math.clamp(temp.y, -height, height)
  L_Vector3.setAnchored(self.bindComponents.viewHold, temp)
  self:ikReadViewHold(self.mediator.target)
end

function this:onTouch_dragEnd()
  if self.touchViewHold then
    self:startHideHeadBoard()
  end
  self.touchViewHold = nil
end

function this:startHeadBoard()
  self:shutdownHeadBoard()
  self.bindComponents.headBoard.gameObject:ActiveTrans(true)
  self:refreshHeadBoard()
end

function this:startHideHeadBoard()
  if self.headTimer then
    return
  end
  self.headTimer = Timer.once(3, function()
    self.bindComponents.headBoard.gameObject:ActiveTrans(false)
    self.headTimer = nil
  end, nil, self.gameObject)
end

function this:updateHeadBoard()
  local target = self.mediator.target
  if target and target.entity.transform.gameObject.activeSelf then
    local headBoard = self.bindComponents.headBoard
    if headBoard.gameObject.activeSelf then
      self:refreshHeadBoard()
    end
  else
    self:shutdownHeadBoard()
  end
end

function this:shutdownHeadBoard()
  if self.headTimer == nil then
    return
  end
  self.bindComponents.headBoard.gameObject:ActiveTrans(false)
  Timer.remove(self.headTimer)
  self.headTimer = nil
end

function this:cleanupHeadBoardCallback()
  if not self.mediator then
    return
  end
  local target = self.mediator.target
  if target and target.model then
    local grounderIK = target.model:GetComponentByType(typeof(C_GrounderIK))
    if grounderIK then
      grounderIK.OnPostIK = nil
    else
      local characterControlProperty = target.data.characterControlProperty
      characterControlProperty:RemovePostUpdate(target)
    end
  end
end

function this:refreshHeadBoard()
  local headBoard = self.bindComponents.headBoard
  local target = self.mediator.target
  if target then
    local headCenter = L_Vector3.getTransformPoint(target.entity.data.characterControlProperty.headTran, -0.06, 0, 0)
    local camera = C_CameraManager.mainCamera
    local view = camera:WorldToScreenPoint(headCenter)
    local pos = L_Vector3.screenToLocalInRectangle(headBoard.parent, view)
    L_Vector3.setAnchored(headBoard, pos)
    local dis = C_CameraManager.GetTactics(C_ECameraType.Photo):GetCameraDis()
    local fov = 60 / C_CameraManager.GetTactics(C_ECameraType.Photo):GetCameraFov()
    dis = dis / fov
    local size = 0
    if 1 <= dis then
      size = 50 + 300 / (dis * dis)
    else
      size = 50 + 300 / dis
    end
    L_Vector3.setUISize(headBoard, L_Vector3.getTemp(size, size))
  end
end

function this:injectMediator()
  local calls = {
    target = handler(self, self.translateTarget),
    isUI = handler(self, self.translateUI),
    isViewLine = handler(self, self.translateIK),
    bevMode = handler(self, self.translateBevMode),
    takeMode = handler(self, self.translateTakeMode),
    playFaceActionId = handler(self, self.translateFaceActionId)
  }
  local bevMediator = self.modules.bev:getMediators()
  self.mediator:addHandlers(calls)
  self.mediator:addHandlers(bevMediator)
  L_PhotoManager.util:injectMediator_setting()
  self.mediator:invokeAll()
  L_PhotoManager:createOriWorldData()
end

function this:translateMenu(isShow, old)
  self.modules.menu.gameObject:ActiveTrans(isShow)
end

function this:translateGrid(isShow)
  self.bind.goGrid = isShow
end

function this:translateTarget(entity, oldEntity, isQuick)
  if oldEntity and oldEntity.entity then
    self:translateIK(false, false, oldEntity)
    if oldEntity.model then
      local grounderIK = oldEntity.model:GetComponentByType(typeof(C_GrounderIK))
      if grounderIK then
        grounderIK.OnPostIK = nil
      else
        local characterControlProperty = oldEntity.data.characterControlProperty
        characterControlProperty:RemovePostUpdate(oldEntity)
      end
    end
    if oldEntity.entity and not oldEntity.data.active then
      local stateMachine = L_PhotoManager:getStateMachine(oldEntity.data.entityId)
      if stateMachine then
        stateMachine:reset()
      end
    end
  end
  if entity then
    local isMount = AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount()
    if not isMount then
      C_CameraManager.PlayBindTarget(entity.transform:GetRawTransform(), isQuick == true)
    else
      local mountEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
      C_CameraManager.PlayBindTarget(mountEntity.transform:GetRawTransform(), isQuick == true)
    end
    L_PhotoManager:sendEvent(L_PhotoManager.event.selectPhotoHeroChange, entity.data.UUID)
    self:translateIK(self.mediator.isViewLine, false, entity)
    if self.expressionCtrl then
      self.expressionCtrl:setTarget(entity)
    end
    self:populateHeroList()
  end
end

function this:translateUI(isShow, old)
  self.bind.goCloseHide = not isShow
  self.bind.goFuncPanel = isShow
  self.bind.goCommonBg = isShow
  if isShow then
    self.modules.menu:refreshMaskableList()
  end
end

function this:translateIK(isIK, old, entity)
  self.bindComponents.viewHold.gameObject:ActiveTrans(isIK)
  entity = entity or self.mediator.target
  if entity and entity.entity then
    local characterControlProperty = entity.entity.data.characterControlProperty
    if isIK then
      local point = self:ikReadViewHold(entity)
      characterControlProperty:EnableIK(entity, point)
    elseif self.faceIn then
      characterControlProperty:EnableIK(entity, C_CameraManager.mainCamera.transform)
    else
      characterControlProperty:DisableIK(entity)
    end
  end
end

function this:ikReadViewHold(csEntity)
  local characterControlProperty = csEntity.entity.data.characterControlProperty
  local point = characterControlProperty:GetForwardIKPoint(csEntity)
  local pos = L_Vector3.getAnchored(self.bindComponents.viewHold)
  local camera = C_CameraManager.mainCamera
  local transTarget = self.mediator.target.entity.transform:GetRawTransform()
  local dis = camera.transform:Distance(transTarget)
  pos = pos / 250
  local transHead = characterControlProperty.headTran
  local height = transHead:Distance(transTarget)
  local forwardCam = camera.transform.forward
  local forwardPlayer = transTarget.forward
  forwardCam.y = 0
  forwardPlayer.y = 0
  local angle = C_Vector3.Angle(forwardCam, forwardPlayer)
  local sign = angle < 90 and 1 or -1
  L_Vector3.setLocalPos(point, L_Vector3.getTemp(sign * pos.x, height + pos.y, dis))
  return point
end

function this:translateBevMode(mode)
  local isRecord = mode == L_Const.photoBevMode.recording
  if not isRecord and self.isRecording then
    self:cancelRecord()
  end
end

function this:translateTakeMode(mode)
  self.bind.goRetarget = mode == L_Const.photoTakeMode.street
end

function this:capture()
  self.bind.goWhiteCut = true
  self.bind.goCaptureArea = true
  L_PhotoManager:capture(function(t2d)
    L_UI:open("pagePhotoPreview", {
      rt = t2d,
      isPhotoTask = self.isPhotoTask,
      goWhiteCut = self.bind.goWhiteCut
    }, function()
      if not L_CommonUtil.isValid(self.gameObject) then
        return
      end
      self.bind.captureArea = false
    end)
    local sceneId = AzurWorldInstance.CurWorldId
    local worldAreaId = AzurWorld.areaManager:GetMapAreaId()
    L_AchievementUtil.req_clientBehaviourRecord(L_Const.commonCondition.RegionPhotoTimes, {
      sceneId,
      worldAreaId,
      1
    }, function()
      L_AudioUtil.playSound("Play_SFX_System_UI_Photograph_Take")
      printf("req_clientBehaviourRecord", sceneId, worldAreaId)
    end)
  end, nil, nil, true)
  xpcall(function()
    L_PhotoManager:pointLogCapture(1)
  end, function(str)
    errorf(str)
  end)
end

function this:recording(anim_bevNode, bevBind)
  if not self.isRecording then
    if self.isWaitingCapture then
      return
    end
    self.bindComponents.movieCapture.gameObject:SetActive(true)
    FrameScheduler.add(function()
      local res = self.bindComponents.movieCapture:StartCapture(handler(self, self.onRecordCompleted))
      if not res then
        return
      end
      self.isRecording = true
      self.bind.goRecorder = true
      self.isWaitingCapture = true
      self.recordSecond = 0
      self:refreshRecording()
      bevBind.filled_imgBev = 0
      self.recordTimer = Timer.repeated(0, function()
        self.recordSecond = self.recordSecond + Unity.Time.deltaTime
        if self.recordSecond >= _MovieTimeLimit then
          Timer.remove(self.recordTimer)
          self.recordTimer = nil
          if self.isRecording then
            self:recording()
          end
        else
          self:refreshRecording()
        end
        local percent = math.clamp(math.floor(self.recordSecond % 60) / _MovieTimeLimit, 0, 1)
        bevBind.filled_imgBev = math.lerp(0, 1, percent)
      end)
      anim_bevNode = anim_bevNode or self.bindComponents.anim_bevNode
      if anim_bevNode then
        anim_bevNode:Play("anim_pagephoto_bottom_press")
      end
    end, 1)
    xpcall(function()
      L_PhotoManager:pointLogCapture(2)
    end, function(str)
      errorf(str)
    end)
  else
    L_AudioUtil.playSound("Play_SFX_System_UI_Photograph_Take")
    if self.recordSecond < 0.5 then
      return
    end
    if self.recordTimer then
      Timer.remove(self.recordTimer)
      self.recordTimer = nil
    end
    self.isRecording = false
    self.bind.goRecorder = false
    self.bindComponents.movieCapture:StopCapture()
    anim_bevNode = anim_bevNode or self.bindComponents.anim_bevNode
    if anim_bevNode then
      anim_bevNode:Play("anim_pagephoto_bottom_release")
    end
  end
end

function this:refreshRecording()
  self.bind.imgRecordIcon = not math.isEmpty(self.recordSecond)
  self.bind.txtRecord = string.format("%02d:%02d", math.floor(self.recordSecond / 60), math.floor(self.recordSecond % 60))
end

function this:cancelRecord()
  if self.recordTimer then
    Timer.remove(self.recordTimer)
    self.recordTimer = nil
  end
  self.isRecording = false
  self.bind.goRecorder = false
  self.bindComponents.movieCapture:CancelCapture()
end

function this:onRecordCompleted(res, path)
  if res then
    L_UI:open("pagePhotoPreview", {moviePath = path})
    self:refreshRecordingProgress()
  else
    self.isWaitingCapture = false
  end
end

function this:translateFaceActionId(actionId)
  if not self.mediator.target or not actionId then
    return
  end
  if not self.expressionCtrl then
    self.expressionCtrl = require("ui.pages.photo.photoExpressionController").new()
    self.expressionCtrl:setTarget(self.mediator.target)
  end
  if actionId == L_Const.photoParam.defaultFace then
    self.expressionCtrl:stop()
  else
    local tpl = _PhotographParamTpl:getTplById(actionId)
    local param = _PhotographParamTpl:getParam(tpl)
    local animNames = string.split(param, "|")
    local index = 0
    
    local function nextAnim()
      if index < #animNames then
        index = index + 1
        self.expressionCtrl:play(animNames[index], false, nextAnim)
      end
    end
    
    nextAnim()
  end
end

function this:onEvent_ShortCutMount()
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.mount) then
    return
  end
  local mountId = L_MountStore:getEquipMountId()
  if not mountId or mountId < 1 then
  end
  if AzurWorld.playerMgr.myPlayerData.isMountMainControl then
    AzurWorld.photoMgr.unitAdapter:SwitchOutMountMainControl()
  else
    if not C_MountUtil.CheckSceneCanMount() then
      return
    end
    AzurWorld.photoMgr.unitAdapter:SwitchToMountMainControl()
  end
end

function this:onEvent_ShortCutMountFly()
  local status = L_Const.WorldMapPlayerMountStatusType.WMPMST_FLY
  if status == L_PlayerStore:getMountStatus() then
    return
  end
  if not AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount() then
    return
  end
  if not AzurWorld.mountMgr:CheckCanChangeMountStatus(C_WorldMapPlayerMountStatusType.WmpmstFly) then
    return
  end
  if not C_MountUtil.CheckCanMountSwitchToStatus(mountGuid, C_WorldMapPlayerMountStatusType.WmpmstFly) then
    return
  end
  AzurWorld.photoMgr.mountStatus = C_WorldMapPlayerMountStatusType.WmpmstFly
  AzurWorld.photoMgr.unitAdapter:SwitchMountMainControlStatus()
end

function this:initHeroList()
  if self.modeController == nil then
    self.modeController = require("ui.pages.HeroPanel.controller.heroListModeController").new()
  end
  self.heroGuidList = self:getAllHeroList()
  self._heroId2FormationData = self:getFormationData()
  self:sortHeroGuidList()
  if not self.isMount then
    if AzurWorld.playerMgr.myPlayerData.isFormationMainControl then
      self.modeController:setSelectGuid(L_FormationStore:getControl(L_FormationConst.FormationType.world), true)
    else
      self.modeController:setSelectGuid(L_HeroStore:getDefaultHeroGuid(), true)
    end
  else
    self.modeController:setSelectGuid(L_FormationStore:getControl(L_FormationConst.FormationType.world), true)
  end
  self.heroIndex = self:getHeroIndex()
  self.initHeroId = self:getHeroId()
  self:refreshChangeHeroBtn(self.initHeroId)
  self:populateHeroList()
  self.bind.activeListHeroHeads = false
  self.bind.goBasePanel = true
end

function this:switchPhotoHero(heroId, callback)
  if self.isMount then
    L_FlyMsgManager:showNormalMsgByKey("notice_photo_noswitchhero")
    return
  end
  if not AzurWorld.playerMgr.myPlayerData.isSandTableMainControl then
    return
  end
  if not L_PhotoManager:checkCanSwitchHero(heroId) then
    L_FlyMsgManager:showNormalMsgByKey("notice_pagePhoto_01")
    return
  end
  if L_PhotoManager:isHeroCaressing(self.mediator.target) then
    L_PhotoManager:showMsgCaressing()
    return
  end
  if self.mediator.target and self.mediator.target.data then
    local machine = L_PhotoManager:getStateMachine(self.mediator.target.data.entityId)
    if machine then
      machine:reset()
    end
  end
  AzurWorld.photoMgr:SwitchHero(heroId, function(entity)
    local mainHeroEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
    L_PhotoManager:setMediatorTarget(mainHeroEntity)
    if callback then
      callback(mainHeroEntity)
    end
    L_PhotoManager:sendEvent(L_PhotoManager.event.photoSwitchHero)
  end)
end

function this:getHeroIndex()
  for i, v in ipairs(self.heroGuidList or table.empty) do
    if self.modeController:getSelectGuid() == v then
      return i
    end
  end
  return 1
end

function this:getHeroId()
  local heroId = L_PhotoManager.cacheTempHeroId
  return heroId or self.heroGuidList[self.heroIndex]
end

function this:getFormationData()
  local formationType = L_FormationConst.FormationType.world
  local posData = L_FormationStore:getFormationPosData(formationType)
  local data = {}
  for i, guid in pairs(posData) do
    if not math.isEmpty(guid) then
      data[guid] = i
    end
  end
  return data
end

function this:getAllHeroList()
  local list = {}
  for i, v in pairs(L_HeroStore:getAllHero()) do
    table.insert(list, L_HeroStore:getHeroGuid(v))
  end
  return list
end

function this:sortHeroGuidList()
  table.sort(self.heroGuidList, function(a, b)
    local heroDataA = self.modeController:getHero(a)
    local heroDataB = self.modeController:getHero(b)
    if heroDataA == nil or heroDataB == nil then
      return a < b
    end
    local configA = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroDataA))
    local configB = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroDataB))
    local isOutA = self._heroId2FormationData[a] or math.huge
    local isOutB = self._heroId2FormationData[b] or math.huge
    if isOutA ~= isOutB then
      return isOutA < isOutB
    end
    local priorityOrder = {
      function()
        return L_HeroStore:getHeroLevel(heroDataA), L_HeroStore:getHeroLevel(heroDataB)
      end,
      function()
        return configA.quality, configB.quality
      end,
      function()
        return L_HeroStore:getHeroStar(heroDataA), L_HeroStore:getHeroStar(heroDataB)
      end
    }
    for _, getPriorityValue in ipairs(priorityOrder) do
      local valueA, valueB = getPriorityValue()
      if valueA ~= valueB then
        return valueB < valueA
      end
    end
    return a < b
  end)
end

function this:populateHeroList()
  if not self.heroGuidList then
    return
  end
  local tempData = {}
  local formationData = self:getFormationData()
  for k, v in ipairs(self.heroGuidList) do
    local heroId = v
    local hero = self.modeController:getHero(heroId)
    local heroConfigId = L_HeroStore:getHeroConfigId(hero)
    local tpl = _heroTpl:getTplById(heroConfigId)
    local elementId = _heroTpl:getElement(tpl)
    local elementTypeTpl = L_GameTpl:getElementTypeTpl()
    local bgIconPath = elementTypeTpl:getProfessionColor(elementTypeTpl:getTplById(elementId), L_Const.professionColorType.circle)
    self.bind.professionBg = bgIconPath
    local professionTpl = L_GameTpl:getProfessionTpl()
    local professionIcon = professionTpl:getIcon(professionTpl:getTplById(_heroTpl:getPosition(tpl)))
    local rarity = _heroTpl:getRarity(tpl)
    local rarityTpl = L_RarityTpl:getTplById(rarity)
    local colorCfg = L_RarityTpl:getColorCircle(rarityTpl)
    for id, _ in pairs(formationData) do
      if id == heroId then
        colorCfg = "#eaffaa"
      end
    end
    local _, color = C_ColorUtility.TryParseHtmlString(colorCfg)
    if k ~= self.heroIndex then
      table.insert(tempData, {
        id = heroId,
        txtLevel = string.format("%02d", L_HeroStore:getHeroLevel(hero)),
        imgCarrer = professionIcon,
        carrerBg = bgIconPath,
        selected = k == self.heroIndex,
        qualityColor = color,
        isPhotoHead = true
      })
    end
  end
  self.bind.listHeroHeads:clear()
  self.bind.listHeroHeads:insert_array(tempData)
end

function this:onClickHeroHead(bind)
  L_PhotoManager.cacheTempHeroId = nil
  self:switchPhotoHero(bind.id, function()
    if not self.isBind then
      return
    end
    if self.modeController:getSelectGuid() == bind.id then
      return
    end
    self.modeController:setSelectGuid(bind.id)
  end)
end

function this:onClickChangeHeroBtn()
  local isShow = not self.bind.activeListHeroHeads
  self.bind.activeListHeroHeads = isShow
  self.bind.goBasePanel = not isShow
  self:showListHeroHeads(true)
end

function this:onClickEmpty()
  if self.bind.activeListHeroHeads == true then
    self:showListHeroHeads(false)
  end
end

function this:showListHeroHeads(isShow)
  self.bind.activeListHeroHeads = isShow
  self.bind.goBasePanel = not isShow
  local animName = "anim_photogroup_heroheads_in"
  if L_DeviceTpl:getIsPc() then
    self.bindComponents.anim_heroHeads:Play(animName)
  else
    self.bindComponents.anim_heroHeads:Play(animName .. "_photo")
  end
  self.bind.activeBgR1 = not isShow
  self.bind.activeBgR2 = not isShow
  self.bind.activeBev = not isShow
  self.bind.activeReset = not isShow
  if isShow then
    self:populateHeroList()
  end
end

function this:refreshHeroHead(newHeroID, oldHeroID)
  if not self.modeController then
    return
  end
  for k, v in ipairs(self.heroGuidList) do
    local heroId = v
    local heroData = self.modeController:getHero(heroId)
    local heroItem = L_ItemManager:parseHeroItem(L_HeroStore:getHeroConfigId(heroData))
    local configId = L_HeroStore:getHeroConfigId(heroData)
    local clothingId = AzurWorld.heroMgr:GetUsingClothingId(heroId, configId)
    local heroHeadAvatarTexture = L_GameUtil.getAvatarTexturePath(clothingId, L_Const.resourceIndexOfAvatarTextureInHeroTpl.small)
    if heroId == L_HeroStore:getDefaultHeroGuid() then
      heroHeadAvatarTexture = ""
    end
    local tpl = _heroTpl:getTplById(heroData.configId)
    local elementId = _heroTpl:getElement(tpl)
    local elementTypeTpl = L_GameTpl:getElementTypeTpl()
    local bgIconPath = elementTypeTpl:getProfessionColor(elementTypeTpl:getTplById(elementId), L_Const.professionColorType.circle)
    local professionTpl = L_GameTpl:getProfessionTpl()
    local professionIcon = professionTpl:getIcon(professionTpl:getTplById(_heroTpl:getPosition(tpl)))
    self.bind.listHeroHeads:change(k, {
      id = heroId,
      imgHead = heroHeadAvatarTexture,
      txtLevel = string.format("%02d", L_HeroStore:getHeroLevel(heroData)),
      colorCircle = heroItem.qualityColor,
      selected = heroId == newHeroID,
      imgCarrer = professionIcon,
      carrerBg = bgIconPath
    })
  end
end

function this:refreshChangeHeroBtn(heroID)
  heroID = heroID or self:getHeroId()
  self.modules.changeHeroBtnImgIn.bind.selected = true
  self.modules.changeHeroBtnImgIn.bind.isPhotoHead = true
  if heroID == L_HeroStore:getDefaultHeroGuid() then
    self.bind.changeHeroBtnImg = ""
    L_PhotoManager:fillMainHead(self, self.bindComponents.changeHeroBtnTrs.gameObject, nil, L_Const.avatarTextureIndex.head)
    self.pBind = self.pBind or {}
    self.modules.changeHeroBtnImgIn:setHeroGUID(heroID)
  else
    L_PhotoManager:releaseHead(self)
    if self.pBind then
      L_PhotoManager:releaseHead(self.pBind)
    end
    local heroData = self.modeController:getHero(heroID)
    local configId = L_HeroStore:getHeroConfigId(heroData)
    local heroItem = L_ItemManager:parseHeroItem(configId)
    if heroItem then
      local clothingId = AzurWorld.heroMgr:GetUsingClothingId(heroID, configId)
      local heroHeadAvatarTexture = L_GameUtil.getAvatarTexturePath(clothingId, L_Const.resourceIndexOfAvatarTextureInHeroTpl.small)
      self.bind.changeHeroBtnImg = ""
      self.bind.changeHeroBtnImg = heroHeadAvatarTexture
    end
    self.modules.changeHeroBtnImgIn:setHeroGUID(heroID)
  end
end

function this:onEvent_selectPhotoHeroChange(heroID)
  if not self.isBind or not self.modeController then
    return
  end
  self.modeController:setSelectGuid(heroID, true)
  self.heroIndex = self:getHeroIndex()
  self:refreshHeroHead(heroID)
  self:refreshChangeHeroBtn(heroID)
end

function this:update()
  if self.mediator.isViewLine then
    self:updateHeadBoard()
  end
end

function this:InitChangeCamTabList()
  local tabList = {
    CAMERA_PRESET_TYPE.FAR,
    CAMERA_PRESET_TYPE.MIDDLE,
    CAMERA_PRESET_TYPE.NEAR
  }
  self.modules.camTabList:setData(tabList, handler(self, self.onSelectCamTabId), CAMERA_PRESET_TYPE.MIDDLE)
end

function this:onSelectCamTabId(tabId)
  if self.comTabId == tabId then
    return
  end
  self.comTabId = tabId
  self:switchCameraPreset(tabId)
end

function this:switchCameraPreset(index)
  if index <= 0 or index > #cameraPreset then
    return
  end
  local dis = cameraPreset[index]
  local fixFollow = C_CameraManager.GetFixedFollow()
  local cameraController = C_CameraManager.GetTactics(C_ECameraType.Photo)
  if fixFollow then
    if index == 3 then
      C_CameraManager.GetTactics(C_ECameraType.Photo):SetCameraDis(dis)
      if C_CameraManager.isNeedShowFace then
        fixFollow:ZoomInWithTarget()
      end
    else
      fixFollow:ZoomOutWithTarget()
      cameraController:StopBehavior(CS.Lens.Gameplay.Modules.BigWorld.CameraBehaviorComponent.BehaviorEnum.EDis)
      cameraController:ResetDistanceLimit()
      cameraController:SetCameraDis(dis)
    end
  end
end

function this:onPhotoTask()
  self.bind.goMenu = false
  self.bind.activeTogList = false
  self.bind.activeTogTakeMode = false
end

function this:sceneFunc(options)
  if AzurWorldInstance.CurWorldId == 851 then
    FrameScheduler.add(function()
      local mediator = L_PhotoManager:getMediator()
      if mediator then
        mediator:setPhotoParmVal(804, 0.6)
      end
    end, 1, self.uiBinding)
  end
end

function this:setShortcutGuidePCActive(isShow)
  local args = CS.Lens.Gameplay.UI.ModuleShortcutGuidePcUiPanelEventArgs()
  args.isLuaEvent = true
  args.luaTable = {shortcutGuidePcUiPanel = 8}
  if isShow then
    C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcShowUiPanel, args)
  else
    C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcHideUiPanel, args)
  end
end

function this:refreshMoveBlockPos(groupId)
  if not self.isBind then
    return
  end
  if groupId < 0 then
    self.bindComponents.moblieMoveBlockTran.anchoredPosition = C_Vector2(-43, 11)
  else
    self.bindComponents.moblieMoveBlockTran.anchoredPosition = C_Vector2(380, 11)
  end
end

function this:refreshRecordingProgress()
  if not self.isBind then
    return
  end
  self.modules.bev.bind.filled_imgBev = 0
end

function this:onEvent_whiteCut(isShow)
  self.bind.goWhiteCut = isShow
end

return this
