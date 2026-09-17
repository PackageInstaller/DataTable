local this = class("pageGameActivityParty", G_UIPageBase)
local _PartyGameTpl = L_GameTpl:getGameEventsPartygameTpl()
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local _heroTpl = L_GameTpl:getHeroTpl()
local _unitTpl = L_GameTpl:getUnitTpl()
local _elementTpl = L_GameTpl:getElementTypeTpl()
local PARTY_DISPLAY_SCENE_PATH = "Program/UIScene/Event/pre_partypanel_ui_01.prefab"
local PARTY_VIRTUAL_CAMERA_PATH = "Program/Camera/pre_cinemachineVirtualCamera.prefab"
local PARTY_DISPLAY_VCAM_PRIORITY = 50000
local PARTY_MAIN_CAM_FORCE_SYNC_SQR_DIST = 2500
local PARTY_VCAM_FOV = 35
local PARTY_FIXED_CAM_POS = CS.UnityEngine.Vector3(557.85, 106.7, 575.5)
local PARTY_FIXED_CAM_ROT = CS.UnityEngine.Vector3(-2, 104.76, -1.638)
local PARTY_CAM_SWING_SPEED = 0.43
local PARTY_CAM_SWING_YAW_AMPLITUDE = 2.3
local PARTY_PREVIEW_HERO_LOCAL_X = -21.03
local PARTY_PREVIEW_HERO_LOCAL_Y = 0.38
local PARTY_PREVIEW_HERO_LOCAL_Z = 6.4
local _rawHeroConfigData = false

local function partyTryManualUpdateBrain()
  pcall(function()
    if C_CameraManager and C_CameraManager.GetMainCameraBrain then
      local brain = C_CameraManager.GetMainCameraBrain()
      if brain and brain.ManualUpdate then
        brain:ManualUpdate()
      end
    end
  end)
end

local function partyForceMainCameraToDisplayVcam(self)
  if not self or not L_CommonUtil.isValid(self.displayCameraGo) then
    return
  end
  pcall(function()
    local main = C_CameraManager and C_CameraManager.mainCamera
    if not main then
      return
    end
    local vt = self.displayCameraGo.transform
    local mp = main.transform.position
    local vp = vt.position
    local dx, dy, dz = mp.x - vp.x, mp.y - vp.y, mp.z - vp.z
    if dx * dx + dy * dy + dz * dz <= PARTY_MAIN_CAM_FORCE_SYNC_SQR_DIST then
      return
    end
    main.transform.position = vp
    main.transform.rotation = vt.rotation
    local vc = self.displayVirtualCamera
    if vc and vc.m_Lens then
      main.fieldOfView = vc.m_Lens.FieldOfView
    end
  end)
end

local function partySyncMainCameraAfterDisplay(self)
  partyTryManualUpdateBrain()
  partyForceMainCameraToDisplayVcam(self)
end

local function partyResetVcamPipelineChildLocal(displayCameraGo)
  if not L_CommonUtil.isValid(displayCameraGo) or displayCameraGo.transform.childCount < 1 then
    return
  end
  local cm = displayCameraGo.transform:GetChild(0)
  pcall(function()
    L_Vector3.setLocalPos(cm, L_Vector3.zero)
    L_Vector3.setLocalRot(cm, L_Vector3.zero)
    cm.localScale = CS.UnityEngine.Vector3.one
  end)
end

local function partyDisableVcamCinemachineModifiers(vc)
  if not vc then
    return
  end
  for i = 0, 1 do
    local comp = vc:GetCinemachineComponent(i)
    if comp then
      pcall(function()
        comp.enabled = false
      end)
    end
  end
end

local function partyGetMainCameraAdditionalData()
  local main = C_CameraManager and C_CameraManager.mainCamera
  if not main or not C_UniversalAdditionalCameraData then
    return nil, nil
  end
  local data
  pcall(function()
    data = main:GetComponent(typeof(C_UniversalAdditionalCameraData))
  end)
  return main, data
end

local function partyEvaluateDisplayCameraSwing(self, targetTrans)
  local time = tonumber(self and self._displayCameraSwingTime) or 0
  local yawOffset = math.sin(time * PARTY_CAM_SWING_SPEED) * PARTY_CAM_SWING_YAW_AMPLITUDE
  if not L_CommonUtil.isValid(targetTrans) then
    local rot = CS.UnityEngine.Vector3(PARTY_FIXED_CAM_ROT.x, PARTY_FIXED_CAM_ROT.y + yawOffset, PARTY_FIXED_CAM_ROT.z)
    return PARTY_FIXED_CAM_POS, rot
  end
  local targetPos = targetTrans.position
  local baseOffset = CS.UnityEngine.Vector3(PARTY_FIXED_CAM_POS.x - targetPos.x, PARTY_FIXED_CAM_POS.y - targetPos.y, PARTY_FIXED_CAM_POS.z - targetPos.z)
  local swingQuat = CS.UnityEngine.Quaternion.Euler(0, yawOffset, 0)
  local offset = swingQuat * baseOffset
  local pos = CS.UnityEngine.Vector3(targetPos.x + offset.x, targetPos.y + offset.y, targetPos.z + offset.z)
  local rot = CS.UnityEngine.Vector3(PARTY_FIXED_CAM_ROT.x, PARTY_FIXED_CAM_ROT.y + yawOffset, PARTY_FIXED_CAM_ROT.z)
  return pos, rot
end

local function partyApplyDisplayCameraSwing(self, targetTrans)
  if not self or not L_CommonUtil.isValid(self.displayCameraGo) then
    return
  end
  local rootTrans = self.displayCameraGo.transform
  local pos, rot = partyEvaluateDisplayCameraSwing(self, targetTrans)
  rootTrans.position = pos
  rootTrans.rotation = CS.UnityEngine.Quaternion.Euler(rot)
end

local function forceShowModelRenderers(heroObj)
  if not L_CommonUtil.isValid(heroObj) then
    return
  end
  heroObj:SetActive(true)
  local skinned = heroObj:GetComponentsInChildren(typeof(CS.UnityEngine.SkinnedMeshRenderer), true)
  if skinned then
    for i = 0, skinned.Length - 1 do
      local s = skinned[i]
      if s then
        s.updateWhenOffscreen = true
      end
    end
  end
end

local function isMainHeroConfigId(heroConfigId)
  return heroConfigId == L_GameUtil.getDefaultHeroId(L_Const.sexType.male) or heroConfigId == L_GameUtil.getDefaultHeroId(L_Const.sexType.female)
end

local function getPartyRawHeroTpl(heroConfigId)
  if _rawHeroConfigData == false then
    local data
    if loadfile then
      local filePaths = {
        "Lua/config/chs/hero.lua",
        "Client/Lua/config/chs/hero.lua"
      }
      pcall(function()
        if CS and CS.UnityEngine and CS.UnityEngine.Application then
          local projectHeroPath = CS.UnityEngine.Application.dataPath .. "/../Lua/config/chs/hero.lua"
          table.insert(filePaths, projectHeroPath)
        end
      end)
      for _, filePath in ipairs(filePaths) do
        local okChunk, chunk = pcall(loadfile, filePath)
        if okChunk and chunk then
          local okExec, result = pcall(chunk)
          if okExec and type(result) == "table" then
            data = result
            break
          end
        end
      end
    end
    _rawHeroConfigData = data
  end
  if type(_rawHeroConfigData) ~= "table" then
    return nil
  end
  return _rawHeroConfigData[heroConfigId]
end

local function getPartyPreviewHeroLocalRot(heroConfigId)
  local heroTplData = getPartyRawHeroTpl(heroConfigId)
  if heroTplData and _heroTpl.getPartyMainTransEuler then
    local rot = _heroTpl:getPartyMainTransEuler(heroTplData)
    if rot then
      return rot
    end
  end
  return L_Vector3.new(0, -60, 0)
end

local function getPartyPreviewHeroLocalPos(heroConfigId)
  local heroTplData = getPartyRawHeroTpl(heroConfigId)
  if heroTplData and _heroTpl.getPartyMainTransOffset then
    local pos = _heroTpl:getPartyMainTransOffset(heroTplData)
    if pos then
      return pos
    end
  end
  return L_Vector3.new(PARTY_PREVIEW_HERO_LOCAL_X, PARTY_PREVIEW_HERO_LOCAL_Y, PARTY_PREVIEW_HERO_LOCAL_Z)
end

local function getPartyPreviewHeroLocalScale(heroConfigId)
  local heroTplData = getPartyRawHeroTpl(heroConfigId)
  if heroTplData and _heroTpl.getPartyMainTransScale then
    local scale = _heroTpl:getPartyMainTransScale(heroTplData)
    if scale then
      return scale
    end
  end
  return L_Vector3.one
end

local function getPartyPreviewHeroMainAction(heroConfigId)
  local heroTplData = getPartyRawHeroTpl(heroConfigId)
  if heroTplData and _heroTpl.getPartyMainAction then
    local action = _heroTpl:getPartyMainAction(heroTplData)
    if type(action) == "string" and action ~= "" then
      return action
    end
  end
  return "Idle"
end

local function applyPartyPreviewHeroTransform(heroTrans, heroConfigId)
  if not heroTrans then
    return
  end
  L_Vector3.setLocalPos(heroTrans, getPartyPreviewHeroLocalPos(heroConfigId))
  L_Vector3.setLocalRot(heroTrans, getPartyPreviewHeroLocalRot(heroConfigId))
  L_Vector3.setScale(heroTrans, getPartyPreviewHeroLocalScale(heroConfigId))
end

local function getPartyHeroPlayableAnimator(heroEntity, heroObj)
  local animator = heroEntity and heroEntity.playableAnimator or nil
  if animator then
    return animator
  end
  if L_CommonUtil.isValid(heroObj) then
    return L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), heroObj)
  end
end

local function partyGetHHMMSSInfo(value)
  local hour, minute, second = L_TimeUtil.getDateTimeInfor(tonumber(value) or 0)
  return math.floor(tonumber(hour) or 0), math.floor(tonumber(minute) or 0), math.floor(tonumber(second) or 0)
end

local function partyGetSecondsOfDay(value)
  local hour, minute, second = partyGetHHMMSSInfo(value)
  return hour * 3600 + minute * 60 + second
end

local function partyGetServerSecondsOfDay()
  local serverTime = L_TimeUtil:getServerTime()
  if C_TimeUtility and C_TimeUtility.TimestampToDateTime then
    local ok, dateTime = pcall(function()
      return C_TimeUtility.TimestampToDateTime(serverTime)
    end)
    if ok and dateTime then
      local hour = tonumber(dateTime.Hour) or 0
      local minute = tonumber(dateTime.Minute) or 0
      local second = tonumber(dateTime.Second) or 0
      return hour * 3600 + minute * 60 + second
    end
  end
  local nowInfo = L_TimeUtil.getDateInfo(serverTime)
  return (tonumber(nowInfo.hour) or 0) * 3600 + (tonumber(nowInfo.min) or 0) * 60 + (tonumber(nowInfo.sec) or 0)
end

local function partyFormatOpenTimeValue(value)
  local hour, minute, second = partyGetHHMMSSInfo(value)
  return string.format("%02d:%02d", hour, minute)
end

local function partyGetMatchOpenPeriodRangeText(startTime, endTime)
  if not startTime or not endTime then
    return ""
  end
  return string.format("%s - %s", partyFormatOpenTimeValue(startTime), partyFormatOpenTimeValue(endTime))
end

local function partyGetMatchOpenPeriodDisplayText(startTime, endTime)
  local rangeText = partyGetMatchOpenPeriodRangeText(startTime, endTime)
  if rangeText == "" then
    return ""
  end
  if L_WordsTpl and L_WordsTpl.getValue then
    local ok, text = pcall(function()
      return L_WordsTpl:getValue("ui_partygame_match_time", {
        [0] = rangeText
      })
    end)
    if ok and type(text) == "string" and text ~= "" then
      return text
    end
  end
  return string.format("匹配开放时间：每日%s", rangeText)
end

function this.bind()
  return {
    color_BeginBtnTxt01 = C_Color(1.0, 1.0, 1.0, 1),
    color_BeginBtnTxt02 = C_Color(1.0, 1.0, 1.0, 1),
    color_BeginBtnTxt03 = C_Color(1.0, 1.0, 1.0, 1),
    color_BeginBtnTxt04 = C_Color(1.0, 1.0, 1.0, 1),
    text_score = "",
    text_score_max = "",
    text_time = "",
    text_matchOpenTime = false,
    go_displayContainer = nil,
    text_heroName = "",
    img_reward = "",
    text_reward = "",
    btn_match = false,
    btn_cancelMatch = false,
    matchtime_txt = "",
    Successmatch = false,
    go_loadingMask = false,
    go_btnMatchLocked = false,
    go_MatchStateTip = false,
    go_MatchLockedTip = true,
    go_lockShadow = true,
    btn_role = nil,
    moduleActivitytitle = nil,
    right_content = nil
  }
end

function this.methods()
  return {
    OnClick_Skill = function(self)
      self:onClickSkill()
    end,
    OnClick_PTShop = function(self)
      self:onClickShop()
    end,
    OnClick_Reward = function(self)
      self:onClickReward()
    end,
    OnClick_Role = function(self)
      self:onClickRole()
    end,
    OnClick_Model = function(self)
      self:onClickModel()
    end,
    OnClick_BtnMatch = function(self)
      self:onClickBtnMatch()
    end
  }
end

function this:setDisplaySceneCameraEnabled(enabled)
  local cameraComp = self.displaySceneCameraComp
  if cameraComp then
    pcall(function()
      cameraComp.enabled = false
    end)
    local cameraGo = cameraComp.gameObject
    if L_CommonUtil.isValid(cameraGo) then
      cameraGo:SetActive(false)
    end
  end
  if enabled ~= true then
    if self.displayVirtualCamera then
      self.displayVirtualCamera.enabled = false
    end
    self:restoreDisplaySceneDepthOfField()
    return
  end
  self:ensureDisplayCameraTactics()
  if L_CommonUtil.isValid(self.cameraTactics) and self.cameraTactics.SetPriority then
    pcall(function()
      self.cameraTactics:SetPriority(PARTY_DISPLAY_VCAM_PRIORITY)
    end)
  end
  self:refreshDisplayCameraTactics()
  if self.displayVirtualCamera then
    self.displayVirtualCamera.enabled = true
  end
  self:applyDisplaySceneDepthOfField()
  partySyncMainCameraAfterDisplay(self)
end

function this:updateSceneVisibleTag(active)
  local pageName = self.pageName or "pageGameActivityParty"
  pcall(function()
    C_UISceneManager.SetSceneVisibleTag(active == true, pageName)
    C_UISceneManager.SetSceneVisible()
  end)
end

function this:ensureDisplayCameraTactics()
  if not C_CameraManager then
    return
  end
  if not L_CommonUtil.isValid(self.displayCameraGo) then
    local ok, go = pcall(function()
      return C_PrefabManager:Instantiate(PARTY_VIRTUAL_CAMERA_PATH, C_EAssetOperationModule.Camera)
    end)
    if ok and L_CommonUtil.isValid(go) then
      self.displayCameraGo = go
    end
  end
  if not L_CommonUtil.isValid(self.displayCameraGo) then
    return
  end
  if not L_CommonUtil.isValid(self.cameraTactics) then
    self.cameraTactics = C_CameraManager.CreateCommonTactics(self.displayCameraGo, C_CinemachineBlendType.Cut, true, PARTY_DISPLAY_VCAM_PRIORITY)
    if self.cameraTactics and self.cameraTactics.GetVirtualCamera then
      pcall(function()
        self.displayVirtualCamera = self.cameraTactics:GetVirtualCamera()
      end)
    end
  end
end

function this:refreshDisplayCameraTactics()
  if not L_CommonUtil.isValid(self.displayCameraGo) then
    return
  end
  local targetTrans = self.displayCameraTargetTrans or self.modelRootTrans
  if not L_CommonUtil.isValid(targetTrans) then
    return
  end
  local rootTrans = self.displayCameraGo.transform
  partyResetVcamPipelineChildLocal(self.displayCameraGo)
  partyApplyDisplayCameraSwing(self, targetTrans)
  if self.displayVirtualCamera then
    pcall(function()
      local vc = self.displayVirtualCamera
      vc.Follow = nil
      vc.LookAt = nil
      vc.enabled = true
      partyDisableVcamCinemachineModifiers(vc)
      if vc.m_Lens then
        vc.m_Lens.FieldOfView = PARTY_VCAM_FOV
      end
    end)
  end
  if L_CommonUtil.isValid(self.cameraTactics) and self.cameraTactics.SetCameraFov then
    pcall(function()
      self.cameraTactics:SetCameraFov(PARTY_VCAM_FOV)
    end)
  end
  if L_CommonUtil.isValid(self.cameraTactics) and self.cameraTactics.collider then
    pcall(function()
      self.cameraTactics.collider.enabled = false
    end)
  end
  self.displayCameraGo:SetActive(true)
  if self.displayVirtualCamera and self.displayVirtualCamera.enabled then
    partySyncMainCameraAfterDisplay(self)
  end
end

function this:ensureDisplayCameraSwingUpdate()
  if self._displayCameraSwingLateUpdateHandle or not C_UpdateSource then
    return
  end
  self._displayCameraSwingLateUpdateHandle = L_CommonUtil.handle(self.onLateUpdate_displayCameraSwing, self)
  C_UpdateSource.AddLateUpdateEventHandler(self._displayCameraSwingLateUpdateHandle, "pageGameActivityParty.cameraSwing")
end

function this:disposeDisplayCameraSwingUpdate()
  if self._displayCameraSwingLateUpdateHandle and C_UpdateSource then
    C_UpdateSource.RemoveLateUpdateEventHandler(self._displayCameraSwingLateUpdateHandle)
  end
  self._displayCameraSwingLateUpdateHandle = nil
end

function this:onLateUpdate_displayCameraSwing()
  if self._isPageClosed or not L_CommonUtil.isValid(self.gameObject) then
    return
  end
  if not L_CommonUtil.isValid(self.displayCameraGo) then
    return
  end
  if not self.displayVirtualCamera or not self.displayVirtualCamera.enabled then
    return
  end
  local targetTrans = self.displayCameraTargetTrans or self.modelRootTrans
  if not L_CommonUtil.isValid(targetTrans) then
    return
  end
  local dt = C_Time.unscaledDeltaTime or C_Time.deltaTime or 0
  if dt <= 0 then
    return
  end
  self._displayCameraSwingTime = (tonumber(self._displayCameraSwingTime) or 0) + dt
  partyApplyDisplayCameraSwing(self, targetTrans)
  partyTryManualUpdateBrain()
end

function this:applyDisplaySceneDepthOfField()
  local _, cameraData = partyGetMainCameraAdditionalData()
  if cameraData and self._mainCameraOriginalSourceType == nil then
    self._mainCameraOriginalSourceType = cameraData.CameraSourceType
  end
  if cameraData then
    pcall(function()
      cameraData.CameraSourceType = CS.UnityEngine.Rendering.Azur.CameraSourceType.UseSceneSettings
    end)
  end
  if not L_CommonUtil.isValid(self.displaySceneDepthVolumeComp) then
    local searchRoot = self.sceneObj and self.sceneObj.transform or nil
    local volumeTrans = searchRoot and self:findChildByNameDeep(searchRoot, "volume") or nil
    if L_CommonUtil.isValid(volumeTrans) then
      pcall(function()
        self.displaySceneDepthVolumeComp = volumeTrans:GetComponent(typeof(CS.UnityEngine.Rendering.Azur.Volume))
      end)
    end
  end
  if L_CommonUtil.isValid(self.displaySceneDepthVolumeComp) then
    pcall(function()
      self.displaySceneDepthVolumeComp.enabled = true
      self.displaySceneDepthVolumeComp.weight = 1
    end)
  end
  partyTryManualUpdateBrain()
end

function this:restoreDisplaySceneDepthOfField()
  local _, cameraData = partyGetMainCameraAdditionalData()
  if cameraData and self._mainCameraOriginalSourceType ~= nil then
    pcall(function()
      cameraData.CameraSourceType = self._mainCameraOriginalSourceType
    end)
  end
end

function this:disposeDisplayCameraTactics()
  if self.displayVirtualCamera then
    self.displayVirtualCamera.enabled = false
    self.displayVirtualCamera = nil
  end
  if L_CommonUtil.isValid(self.cameraTactics) then
    C_CameraManager.ExitAndCompleteCamera(self.cameraTactics)
    self.cameraTactics:Dispose()
    C_CameraManager.RemoveTactics(self.cameraTactics)
    self.cameraTactics = nil
  end
  if L_CommonUtil.isValid(self.displayCameraGo) then
    C_GameObject.Destroy(self.displayCameraGo)
    self.displayCameraGo = nil
  end
end

function this:disablePartyModelRootAnchorFit()
  self._partyLayoutManualOnly = true
  if not L_CommonUtil.isValid(self.modelRootTrans) then
    return
  end
  local anchorFit = self.modelRootTrans:GetComponent(typeof(CS.Lens.Gameplay.UI.CharacterAnchorFit))
  if not L_CommonUtil.isValid(anchorFit) then
    return
  end
  pcall(function()
    anchorFit.followTrans = nil
    anchorFit.isAdjustUpdate = false
  end)
  pcall(function()
    anchorFit.xFitType = CS.Lens.Gameplay.UI.CharacterAnchorFit.AxisXFitType.None
    anchorFit.yFitType = CS.Lens.Gameplay.UI.CharacterAnchorFit.AxisYFitType.None
  end)
  pcall(function()
    anchorFit.enabled = false
  end)
end

function this:resolveDisplaySceneCamera(searchRoot)
  if not L_CommonUtil.isValid(searchRoot) then
    return nil, nil
  end
  local cameraTrans = self:findChildByNameDeep(searchRoot, "Capture")
  local cameraComp
  if L_CommonUtil.isValid(cameraTrans) then
    pcall(function()
      cameraComp = cameraTrans:GetComponent(typeof(CS.UnityEngine.Camera))
    end)
    if not cameraComp then
      pcall(function()
        cameraComp = cameraTrans:GetComponentInChildren(typeof(CS.UnityEngine.Camera), true)
      end)
    end
  end
  return cameraTrans, cameraComp
end

function this:preOpen(params)
  self.bind.go_MatchStateTip = false
  self.bind.btn_match = false
  self.bind.go_MatchLockedTip = true
  self.bind.go_lockShadow = true
  self:cleanupBeforeOpen()
  self:updateSceneVisibleTag(true)
  self._isPageClosed = false
  self._enterCutinClosed = false
  self._enterCutinClosing = false
  self._loadingMaskGo = nil
  self._openingRolePage = false
  self._escLockedByButton = false
  self._escPressedDuringButtonLock = false
  self._buttonActionLockTimer = nil
  self.actId = params.actId or 0
  self.timer = nil
  self.endTime = 0
  self.curTpl = nil
  self.displayedHeroGuid = nil
  self.idleTimer = nil
  self.sceneObj = nil
  self.heroModelObj = nil
  self.heroEntity = nil
  self.modelRootTrans = nil
  self.displaySceneCameraComp = nil
  self.displayCameraTargetTrans = nil
  self.displaySceneDepthVolumeComp = nil
  self.displayCameraGo = nil
  self.displayVirtualCamera = nil
  self.cameraTactics = nil
  self._displayCameraSwingTime = 0
  self._mainCameraOriginalSourceType = nil
  self.matchTimer = nil
  self.matchSuccessTimer = nil
  self.sceneLoadTimer = nil
  self.aniCallbackTimer = nil
  self.sceneLoadHandle = nil
  self._loadedHeroGuid = 0
  self._heroLoadToken = 0
  self:ensureMatchLogicMgr()
  if self.actId == 0 then
    L_GameUtil.showCommonTip({
      txtContent = "活动ID无效",
      hideCancel = true,
      confirmText = "确定"
    })
    return
  end
  self:loadActivityConfig()
  self:initUI()
  self:_rememberCurrentScreenSize()
  self:startScreenPollTimer()
  self:initCommonTopModule()
  self:setupActivityTime()
  self:startTimer()
  self:initMatchUI()
  self:registerMatchListeners()
  self:normalizeMatchStateOnEnter()
  self:updateMatchUIByState()
  self:initDisplayAsync()
  self:ensureDisplayCameraSwingUpdate()
end

function this:open()
  if AzurWorld.popperPartyMgr:HasGetKickNotify() then
    AzurWorld.popperPartyMgr:ShowKickTip()
  end
end

function this:setupWideScreenState()
  local w, h = C_Screen.width, C_Screen.height
  local isSuperWidthScene = C_ResolutionUtility.CheckSuperWidthScreen() or 0 < h and 2.3333 < w / h
  local layout = isSuperWidthScene and PARTY_UI_LAYOUT_SUPER_WIDTH or PARTY_UI_LAYOUT_DEFAULT
  self.bind.btn_role = layout.btn_role
  self.bind.moduleActivitytitle = layout.moduleActivitytitle
  self.bind.right_content = layout.right_content
end

function this:_pollScreenSizeForWideState()
  if not (self.isBind and self.gameObject) or not self.gameObject.activeInHierarchy then
    return
  end
  local w, h = C_Screen.width, C_Screen.height
  if self._lastPartyScreenW == w and self._lastPartyScreenH == h then
    return
  end
  self._lastPartyScreenW = w
  self._lastPartyScreenH = h
end

function this:_rememberCurrentScreenSize()
  self._lastPartyScreenW = C_Screen.width
  self._lastPartyScreenH = C_Screen.height
end

function this:startScreenPollTimer()
  self:stopScreenPollTimer()
  if not self.gameObject then
    return
  end
  self._screenPollTimer = Timer.repeated(0.15, function()
    self:_pollScreenSizeForWideState()
  end, self, self.gameObject)
end

function this:stopScreenPollTimer()
  if self._screenPollTimer then
    self._screenPollTimer:stop()
    Timer.remove(self._screenPollTimer)
    self._screenPollTimer = nil
  end
end

function this:onTopBarRefresh()
  self:initCommonTopModule()
end

function this:refreshTopBarDeferred()
  if self.topBarRefreshTimer then
    Timer.remove(self.topBarRefreshTimer)
    self.topBarRefreshTimer = nil
  end
  self.topBarRefreshTimer = Timer.once(0, function()
    if L_CommonUtil.isValid(self.gameObject) and not self._isPageClosed then
      self:initCommonTopModule()
    end
    self.topBarRefreshTimer = nil
  end, self, self.gameObject)
end

function this:initCommonTopModule()
  if not C_IntegrateMgr or not C_IntegrateMgr.TopBarModule then
    return
  end
  local topBar = C_IntegrateMgr.TopBarModule
  if topBar.SetTopBarCloseFunc then
    topBar:SetTopBarCloseFunc(handler(self, self.escHandle))
  end
  if topBar.SetTopBarMainBtnFunc then
    topBar:SetTopBarMainBtnFunc(handler(self, self.escHandle))
  end
  if topBar.SetTopBarMainBtnVisible then
    topBar:SetTopBarMainBtnVisible(true)
  end
end

function this:isUiStateReady()
  return not self._isPageClosed and L_CommonUtil.isValid(self.gameObject) and type(self.bind) == "table"
end

function this:ensureMatchLogicMgr()
  if self.MatchLogicMgr then
    return true
  end
  local okData, matchData = pcall(require, L_R.store .. "popperparty.MatchData")
  if okData then
    self.MatchData = matchData
  end
  local okStore, store = pcall(require, L_R.store .. "popperparty.matchStore")
  if okStore and store and store.getInstance then
    self.MatchLogicMgr = store:getInstance()
  end
  return self.MatchLogicMgr ~= nil
end

function this:onShow()
  this.super.onShow(self)
  self:initCommonTopModule()
  self:refreshTopBarDeferred()
  self:normalizeMatchStateOnEnter()
  self:updateMatchUIByState()
  if self.actId > 0 and L_CommonUtil.isValid(self.gameObject) then
    self:setDisplaySceneActive(true)
    local pendingHeroGuid = tonumber(self._pendingHeroRefreshGuid) or 0
    local restoreAfterRolePage = self._restoreHeroAfterRolePage == true
    self._restoreHeroAfterRolePage = false
    self:loadDisplayRecord()
    if 0 < pendingHeroGuid then
      self.displayedHeroGuid = pendingHeroGuid
    end
    if not self.sceneObj or not L_CommonUtil.isValid(self.modelRootTrans) then
      self:initDisplayAsync()
      return
    end
    if restoreAfterRolePage then
      local targetHeroGuid = tonumber(self.displayedHeroGuid) or 0
      if 0 < targetHeroGuid then
        self:cleanupHeroModel()
        Timer.once(0.1, function()
          if not L_CommonUtil.isValid(self.gameObject) then
            return
          end
          if self._restoreHeroAfterRolePage then
            return
          end
          self:selectHero(targetHeroGuid)
        end, self, self.gameObject)
        return
      end
    end
    if not (not (0 < pendingHeroGuid) and L_CommonUtil.isValid(self.heroModelObj)) or self._loadedHeroGuid ~= self.displayedHeroGuid then
      self:selectHero(self.displayedHeroGuid)
    end
  end
end

function this:show()
  self:initCommonTopModule()
  self:refreshTopBarDeferred()
  self:updateSceneVisibleTag(true)
  if self.sceneObj and L_CommonUtil.isValid(self.modelRootTrans) then
    self:setDisplaySceneCameraEnabled(true)
  end
  self:setDisplaySceneActive(true)
end

function this:hide()
  self:updateSceneVisibleTag(false)
  self:setDisplaySceneActive(false)
  self:setDisplaySceneCameraEnabled(false)
end

function this:cleanupBeforeOpen()
  self:disposeDisplayCameraSwingUpdate()
  self:restoreDisplaySceneDepthOfField()
  self:stopAllTimers()
  self:updateSceneVisibleTag(false)
  self:cleanupHeroModel()
  self:disposeDisplayCameraTactics()
  self:recycleSceneLoaderHandle()
  self.sceneObj = nil
  self.modelRootTrans = nil
  self.displaySceneCameraComp = nil
  self.displayCameraTargetTrans = nil
  self.displaySceneDepthVolumeComp = nil
  self._loadedHeroGuid = 0
  self._heroLoadToken = 0
  self._displayCameraSwingTime = 0
  self._mainCameraOriginalSourceType = nil
  self._partyLayoutManualOnly = false
  self._pendingHeroRefreshGuid = nil
end

function this:loadActivityConfig()
  self.curTpl = _GameEventTpl:getTplById(self.actId)
  if not self.curTpl or next(self.curTpl) == nil then
    return false
  end
  local ok, tplOrErr = pcall(function()
    return _PartyGameTpl:getTplById(self.actId)
  end)
  if ok then
    self.partyGameTpl = tplOrErr
  else
    self.partyGameTpl = nil
  end
  return true
end

function this:initUI()
  self:setupEntryButtons()
  self:setupScore()
  self:refreshMatchOpenPeriodDisplay()
  self:refreshMatchOpenPeriodState(true)
end

function this:setupEntryButtons()
  local rewardName, rewardIcon
  if self.partyGameTpl then
    rewardName = self.partyGameTpl.rewardEntryName or self.partyGameTpl.rewardName or self.partyGameTpl.rewardname or self.partyGameTpl.reward_name
    rewardIcon = self.partyGameTpl.rewardEntryIcon or self.partyGameTpl.rewardIcon or self.partyGameTpl.rewardicon or self.partyGameTpl.reward_icon
  end
  self.bind.text_reward = tostring(rewardName)
  if type(rewardIcon) == "string" and rewardIcon ~= "" then
    self.bind.img_reward = rewardIcon
  end
end

function this:initMatchUI()
  self.bind.btn_match = true
  self.bind.btn_cancelMatch = false
  self.bind.Successmatch = false
  self.bind.matchtime_txt = "匹配"
  self.bind.go_MatchStateTip = false
  self:stopMatchUITimer()
  self:refreshMatchOpenPeriodState(true)
end

function this:getMatchOpenPeriodRange()
  if not self.partyGameTpl or not _PartyGameTpl.getOpenPeriod then
    return nil, nil
  end
  local openPeriod = _PartyGameTpl:getOpenPeriod(self.partyGameTpl)
  if type(openPeriod) ~= "table" or #openPeriod < 2 then
    return nil, nil
  end
  local startTime = tonumber(openPeriod[1]) or 0
  local endTime = tonumber(openPeriod[2]) or 0
  if startTime <= 0 or endTime <= 0 then
    return nil, nil
  end
  return startTime, endTime
end

function this:getMatchOpenPeriodDisplayText()
  local startTime, endTime = self:getMatchOpenPeriodRange()
  if not startTime or not endTime then
    return ""
  end
  return partyGetMatchOpenPeriodDisplayText(startTime, endTime)
end

function this:ensureMatchOpenTimeNodes()
  if self._matchOpenTimeNodesInited then
    return
  end
  self._matchOpenTimeNodesInited = true
  if not L_CommonUtil.isValid(self.gameObject) then
    return
  end
  local root = self:findChildByNameDeep(self.gameObject.transform, "MatchOpenTime")
  if root then
    self._matchOpenTimeRoot = root.gameObject
    local textTrans = root:Find("matchtime_txt") or self:findChildByNameDeep(root, "matchtime_txt")
    if textTrans then
      self._matchOpenTimeText = textTrans:GetComponent(typeof(C_LTextMeshProUGUI))
    end
  end
  local lockedTipRoot = self:findChildByNameDeep(self.gameObject.transform, "MatchLockedTip")
  if lockedTipRoot then
    self._matchLockedTipRoot = lockedTipRoot.gameObject
    local lockedTipTextTrans = lockedTipRoot:Find("matchtime_txt") or self:findChildByNameDeep(lockedTipRoot, "matchtime_txt")
    if lockedTipTextTrans then
      self._matchLockedTipText = lockedTipTextTrans:GetComponent(typeof(C_LTextMeshProUGUI))
    end
  end
end

function this:refreshMatchOpenPeriodDisplay()
  local displayText = self:getMatchOpenPeriodDisplayText()
  local show = type(displayText) == "string" and displayText ~= ""
  self.bind.text_matchOpenTime = show
  self:ensureMatchOpenTimeNodes()
  if self._matchOpenTimeRoot then
    self._matchOpenTimeRoot:SetActive(show)
  end
  if not show then
    return
  end
  if self._matchOpenTimeText then
    self._matchOpenTimeText.text = displayText
  end
  if self._matchLockedTipText then
    self._matchLockedTipText.text = displayText
  end
end

function this:isInMatchOpenPeriod()
  local startTime, endTime = self:getMatchOpenPeriodRange()
  if not startTime or not endTime then
    return true
  end
  local nowSeconds = partyGetServerSecondsOfDay()
  local startSeconds = partyGetSecondsOfDay(startTime)
  local endSeconds = partyGetSecondsOfDay(endTime)
  if startSeconds <= endSeconds then
    return nowSeconds >= startSeconds and nowSeconds <= endSeconds
  end
  return nowSeconds >= startSeconds or nowSeconds <= endSeconds
end

function this:refreshMatchOpenPeriodState(canStartMatch)
  local startTime = self:getMatchOpenPeriodRange()
  local hasOpenPeriodConfig = startTime ~= nil
  local shouldLock = hasOpenPeriodConfig and canStartMatch and not self:isInMatchOpenPeriod()
  if L_CommonUtil.isValid(self._matchOpenTimeRoot) then
    self._matchOpenTimeRoot:SetActive(hasOpenPeriodConfig and canStartMatch)
  end
  self.bind.go_lockShadow = shouldLock
  self.bind.color_BeginBtnTxt01 = shouldLock and C_Color(0.5804, 0.6275, 0.6706, 1) or C_Color(1.0, 1.0, 1.0, 1)
  self.bind.color_BeginBtnTxt02 = shouldLock and C_Color(0.5804, 0.6275, 0.6706, 1) or C_Color(1.0, 1.0, 1.0, 1)
  self.bind.color_BeginBtnTxt03 = shouldLock and C_Color(0.5804, 0.6275, 0.6706, 1) or C_Color(1.0, 1.0, 1.0, 1)
  self.bind.color_BeginBtnTxt04 = shouldLock and C_Color(0.5804, 0.6275, 0.6706, 1) or C_Color(1.0, 1.0, 1.0, 1)
  if self:isMatchingInProgress() or self:isMatchTransitionLocked() then
    self.bind.go_MatchLockedTip = false
  else
    self.bind.go_MatchLockedTip = true
  end
end

function this:normalizeMatchStateOnEnter()
  if not (self:ensureMatchLogicMgr() and self.MatchData) or not self.MatchData._data then
    return
  end
  local bs = self.MatchLogicMgr:getBusinessStatusEnum()
  local currentState = self.MatchLogicMgr:getBusinessState()
  local currentActId = tonumber(self.MatchLogicMgr:getActId()) or 0
  local targetActId = tonumber(self.actId) or 0
  if currentState == bs.MATCHING or currentState == bs.EXTRA_WAIT then
    return
  end
  if currentActId ~= 0 and targetActId ~= 0 and currentActId ~= targetActId then
    self.MatchData:reset()
    self.MatchData:initMatchConfig(targetActId)
    return
  end
  if currentState == bs.PRE_START or currentState == bs.GAME_START or currentState == bs.GAME_END or currentState == bs.CANCELED or currentState == bs.TIMEOUT or currentState == bs.QUIT_TIMEOUT then
    self.MatchData:reset()
    self.MatchData:initMatchConfig(targetActId)
  end
end

function this:isMatchingInProgress()
  if not self:ensureMatchLogicMgr() then
    return false
  end
  local bs = self.MatchLogicMgr:getBusinessStatusEnum()
  local state = self.MatchLogicMgr:getBusinessState()
  return state == bs.MATCHING or state == bs.EXTRA_WAIT
end

function this:isMatchTransitionLocked()
  if self._matchEnteringGame then
    return true
  end
  if not self:ensureMatchLogicMgr() then
    return false
  end
  local bs = self.MatchLogicMgr:getBusinessStatusEnum()
  local state = self.MatchLogicMgr:getBusinessState()
  return state == bs.PRE_START or state == bs.GAME_START
end

function this:dismissMatchExitPrompt()
  if not self._matchExitPromptShowing then
    return
  end
  self._matchExitPromptShowing = false
  if L_UI then
    pcall(function()
      L_UI:close("pageCommonTip")
    end)
  end
end

local PRE_ACTION_ESC_LOCK_TIME = 0.2
local POST_ACTION_ESC_LOCK_TIME = 0.3

local function releaseEscButtonLock(self)
  self._escLockedByButton = false
  self._escPressedDuringButtonLock = false
  if self._buttonActionLockTimer then
    Timer.remove(self._buttonActionLockTimer)
    self._buttonActionLockTimer = nil
  end
end

local function performEscAction(self)
  if self._openingRolePage then
    return
  end
  if self:isMatchTransitionLocked() then
    self:dismissMatchExitPrompt()
    return
  end
  self:tryClosePageWithMatchPrompt()
end

local function runWithEscButtonLock(self, action, delayTime)
  if type(action) ~= "function" then
    return
  end
  if self._escLockedByButton then
    return
  end
  self._escLockedByButton = true
  self._escPressedDuringButtonLock = false
  delayTime = tonumber(delayTime)
  if not delayTime or delayTime < PRE_ACTION_ESC_LOCK_TIME then
    delayTime = PRE_ACTION_ESC_LOCK_TIME
  end
  if self._buttonActionLockTimer then
    Timer.remove(self._buttonActionLockTimer)
    self._buttonActionLockTimer = nil
  end
  self._buttonActionLockTimer = Timer.once(delayTime, function()
    self._buttonActionLockTimer = nil
    local shouldRunAction = not self._escPressedDuringButtonLock
    if not self:isUiStateReady() then
      releaseEscButtonLock(self)
      return
    end
    if shouldRunAction then
      action()
      if not self:isUiStateReady() then
        releaseEscButtonLock(self)
        return
      end
      self._escPressedDuringButtonLock = false
      self._buttonActionLockTimer = Timer.once(POST_ACTION_ESC_LOCK_TIME, function()
        releaseEscButtonLock(self)
      end, self, self.gameObject)
      return
    end
    releaseEscButtonLock(self)
    performEscAction(self)
  end, self, self.gameObject)
end

function this:tryClosePageWithMatchPrompt()
  if self:isMatchTransitionLocked() then
    self:dismissMatchExitPrompt()
    return
  end
  if self:isMatchingInProgress() then
    self._matchExitPromptShowing = true
    L_GameUtil.showCommonTip({
      txtContent = "当前正在匹配中，确定要退出界面并取消匹配吗？",
      confirmText = "退出界面",
      cancelText = "继续匹配",
      confirmCallback = function()
        self._matchExitPromptShowing = false
        if L_CommonUtil.isValid(self.gameObject) then
          L_UI:close(self.pageName)
          self.bind.go_MatchLockedTip = true
        end
      end,
      cancelCallback = function()
        self._matchExitPromptShowing = false
      end,
      closeCallback = function()
        self._matchExitPromptShowing = false
      end,
      pageClosedCallback = function()
        self._matchExitPromptShowing = false
      end
    })
    return
  end
  L_UI:close(self.pageName)
end

function this:tagRestoreToPartyMain()
  if not (c_UIRestore and c_UIRestore.TagUIRestoreData and self.actId) or self.actId <= 0 then
    return
  end
  local options = {
    actId = self.actId
  }
  if L_UI and L_UI.getOptions then
    options = L_UI:getOptions(options)
  end
  c_UIRestore.TagUIRestoreData("pageGameActivityParty", options)
end

function this:setupScore()
  local currentScore = 0
  local dailyMaxScore = 0
  local geData = L_GameEventStore:getGameEventData(self.actId)
  if geData and geData.getGameEvent then
    local ge = geData:getGameEvent()
    local serverData = ge and ge.getData and ge:getData() or nil
    if serverData then
      currentScore = tonumber(serverData.score) or 0
      dailyMaxScore = tonumber(serverData.scoreLimit) or tonumber(serverData.score_limit) or 0
    end
  end
  if dailyMaxScore <= 0 then
    local maxScore = 0
    local geDataForReward = L_GameEventStore:getGameEventData(self.actId)
    local rewardStateList = geDataForReward and geDataForReward.getRewardStateList and geDataForReward:getRewardStateList() or nil
    if rewardStateList then
      local rewardTpl = L_GameTpl:getGameEventsRewardTpl()
      for _, reward in ipairs(rewardStateList) do
        local tpl = rewardTpl:getTplById(reward.reward_id)
        local targetScore = tpl and tonumber(rewardTpl:getPara(tpl)) or 0
        if maxScore < targetScore then
          maxScore = targetScore
        end
      end
    end
    dailyMaxScore = maxScore
  end
  self.bind.text_score = tostring(currentScore)
  self.bind.text_score_max = tostring(dailyMaxScore)
  self.currentScore = currentScore
  self.dailyMaxScore = dailyMaxScore
end

function this:setupActivityTime()
  if self.curTpl and _GameEventTpl.getTimeLimit then
    self.endTime = tonumber(C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(self.curTpl))) or 0
  end
  if (tonumber(self.endTime) or 0) <= 0 and self.curTpl and _GameEventTpl.getEndTime then
    local endTimeStr = _GameEventTpl:getEndTime(self.curTpl)
    self.endTime = L_TimeUtil.parseConfigDatetime(endTimeStr) or L_TimeUtil:getServerTime() + 604800
  elseif (tonumber(self.endTime) or 0) <= 0 then
    self.endTime = L_TimeUtil:getServerTime() + 604800
  end
  self:updateRemainingTime()
end

function this:updateRemainingTime()
  local now = L_TimeUtil:getServerTime()
  local remaining = self.endTime - now
  if remaining <= 0 then
    self.bind.text_time = L_WordsTpl:getValue("ui_game_events_day_attendance_end")
    self:clearDisplayRecord()
    self:stopTimer()
    return
  end
  local days = math.floor(remaining / 86400)
  local hours = math.floor(remaining % 86400 / 3600)
  local minutes = math.floor(remaining % 3600 / 60)
  local seconds = remaining % 60
  if 0 < days then
    self.bind.text_time = string.format("%d天%d时", days, hours)
  elseif 0 < hours then
    self.bind.text_time = string.format("%d时%d分", hours, minutes)
  else
    self.bind.text_time = string.format("d分%d秒", minutes, seconds)
  end
end

function this:startTimer()
  self:stopTimer()
  self.timer = Timer.repeated(1, function()
    self:updateRemainingTime()
    self:updateMatchUIByState()
  end, self, self.gameObject)
end

function this:stopTimer()
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

function this:initDisplayAsync()
  self:setLoadingMaskActive(true)
  self:loadDisplayRecord()
  self:ensureDisplayContainer()
  if self.sceneObj and L_CommonUtil.isValid(self.modelRootTrans) then
    self:setDisplaySceneActive(true)
    self:selectHero(self.displayedHeroGuid)
    return
  end
  self:loadDisplayScene()
end

function this:setDisplaySceneActive(active)
  if not L_CommonUtil.isValid(self.sceneObj) then
    return
  end
  if active then
    C_UISceneManager.SetSceneVisible()
  end
  self.sceneObj:SetActive(active)
end

function this:ensureDisplayContainer()
  if self.bind.go_displayContainer and L_CommonUtil.isValid(self.bind.go_displayContainer) then
    return
  end
  if self.bindComponents then
    local comp = self.bindComponents.go_displayContainer or self.bindComponents.displayContainer
    if comp then
      self.bind.go_displayContainer = L_CommonUtil.isValid(comp) and comp.gameObject or comp
      return
    end
  end
  if L_CommonUtil.isValid(self.gameObject) then
    local deep = self:findChildByNameDeep(self.gameObject.transform, "go_displayContainer") or self:findChildByNameDeep(self.gameObject.transform, "displayContainer")
    if L_CommonUtil.isValid(deep) then
      self.bind.go_displayContainer = deep.gameObject
      return
    end
  end
end

function this:ensureLoadingMask()
  if self._loadingMaskGo and L_CommonUtil.isValid(self._loadingMaskGo) then
    return self._loadingMaskGo
  end
  if self.bindComponents then
    local comp = self.bindComponents.go_loadingMask or self.bindComponents.loadingMask
    if comp then
      self._loadingMaskGo = L_CommonUtil.isValid(comp) and comp.gameObject or comp
      return self._loadingMaskGo
    end
  end
  if L_CommonUtil.isValid(self.gameObject) then
    local deep = self.gameObject.transform:Find("loadingMask") or self:findChildByNameDeep(self.gameObject.transform, "loadingMask") or self:findChildByNameDeep(self.gameObject.transform, "go_loadingMask")
    if L_CommonUtil.isValid(deep) then
      self._loadingMaskGo = deep.gameObject
      return self._loadingMaskGo
    end
  end
end

function this:setLoadingMaskActive(active)
  local loadingMaskGo = self:ensureLoadingMask()
  if loadingMaskGo and L_CommonUtil.isValid(loadingMaskGo) then
    loadingMaskGo:SetActive(active == true)
  end
end

function this:tryCloseEnterCutin(delayTime)
  if self._enterCutinClosed then
    return
  end
  
  local function closeCutinNow()
    if self._enterCutinClosed then
      return
    end
    self._enterCutinClosed = true
    self._enterCutinClosing = false
    if self.enterCutinCloseTimer then
      Timer.remove(self.enterCutinCloseTimer)
      self.enterCutinCloseTimer = nil
    end
    pcall(function()
      C_UIMgr.CloseCutin()
    end)
  end
  
  delayTime = tonumber(delayTime) or 0
  if delayTime <= 0 then
    closeCutinNow()
    return
  end
  if self._enterCutinClosing then
    return
  end
  self._enterCutinClosing = true
  self.enterCutinCloseTimer = Timer.once(delayTime, function()
    closeCutinNow()
  end, self, self.gameObject)
end

function this:loadDisplayScene()
  if not L_CommonUtil.isValid(self.gameObject) then
    self:setLoadingMaskActive(false)
    self:tryCloseEnterCutin()
    return
  end
  local containerGo = self.bind.go_displayContainer
  if not containerGo and L_CommonUtil.isValid(self.gameObject) then
    local trans = self.gameObject.transform:Find("go_displayContainer") or self.gameObject.transform:Find("displayContainer") or self:findChildByNameDeep(self.gameObject.transform, "go_displayContainer") or self:findChildByNameDeep(self.gameObject.transform, "displayContainer")
    if L_CommonUtil.isValid(trans) then
      containerGo = trans.gameObject
      self.bind.go_displayContainer = containerGo
    end
  end
  if not containerGo or not L_CommonUtil.isValid(containerGo) then
    containerGo = nil
  end
  local scenePath = L_CommonUtil.getMultiPlatformScenePath(PARTY_DISPLAY_SCENE_PATH)
  if type(scenePath) ~= "string" or scenePath == "" then
    self:setLoadingMaskActive(false)
    self:tryCloseEnterCutin()
    return
  end
  self.sceneObj = nil
  self.modelRootTrans = nil
  self.displaySceneCameraComp = nil
  self.displaySceneDepthVolumeComp = nil
  self:recycleSceneLoaderHandle()
  local loadTimeout = Timer.once(10, function()
    self:recycleSceneLoaderHandle()
    self:setLoadingMaskActive(false)
    self:tryCloseEnterCutin()
  end, self, self.gameObject)
  self.sceneLoadHandle = C_UIMgr.uiLoader:SpawnAsync(scenePath, function(instanceId, obj)
    Timer.remove(loadTimeout)
    if not L_CommonUtil.isValid(self.gameObject) then
      if instanceId then
        pcall(function()
          C_PrefabManager:RecycleByLoader(instanceId)
        end)
      end
      self:setLoadingMaskActive(false)
      self:tryCloseEnterCutin()
      return
    end
    if not L_CommonUtil.isValid(obj) then
      self:setLoadingMaskActive(false)
      self:tryCloseEnterCutin()
      return
    end
    self.sceneObj = obj
    local sceneTrans = self.sceneObj.transform
    sceneTrans:SetParent(C_LuaUtility.GetRootNode())
    L_Vector3.setPos(sceneTrans, C_UIMgr.SceneLoadDefaultPosition)
    L_Vector3.setRot(sceneTrans, L_Vector3.zero)
    self.sceneObj:SetActive(true)
    C_UISceneManager.SetSceneVisible()
    self:disableAllColliders(self.sceneObj)
    local sceneRoot = self:findChildByNameDeep(self.sceneObj.transform, "pre_partypanel_ui_01") or self.sceneObj.transform
    self.modelRootTrans = self:findChildByNameDeep(sceneRoot, "ModelRoot") or self:findChildByNameDeep(sceneRoot, "[Model]") or self:findChildByNameDeep(sceneRoot, "Character") or self:findChildByNameDeep(sceneRoot, "Model") or sceneRoot
    self.displayCameraTargetTrans = self.modelRootTrans
    local _, cameraComp = self:resolveDisplaySceneCamera(sceneRoot)
    self.displaySceneCameraComp = cameraComp
    self:setDisplaySceneCameraEnabled(true)
    local formationUI = self:findChildByNameDeep(sceneRoot, "UI_Formation")
    if L_CommonUtil.isValid(formationUI) then
      formationUI.gameObject:SetActive(false)
    end
    self:disablePartyModelRootAnchorFit()
    self:selectHero(self.displayedHeroGuid)
  end, C_LuaUtility.GetRootNode(), true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
end

function this:selectHero(heroGuid)
  if not L_CommonUtil.isValid(self.gameObject) then
    self:setLoadingMaskActive(false)
    self:tryCloseEnterCutin()
    return
  end
  if not self.sceneObj or not L_CommonUtil.isValid(self.modelRootTrans) then
    self:initDisplayAsync()
    return
  end
  if not heroGuid or heroGuid <= 0 then
    heroGuid = self:getFirstAvailableHero()
    if heroGuid <= 0 then
      self.bind.text_heroName = "暂无可用角色"
      self:setLoadingMaskActive(false)
      self:tryCloseEnterCutin()
      return
    end
  end
  local heroData = L_HeroStore:getHero(heroGuid)
  if not heroData then
    self.bind.text_heroName = "角色数据不存在"
    self:setLoadingMaskActive(false)
    self:tryCloseEnterCutin()
    return
  end
  if self._loadedHeroGuid == heroGuid and L_CommonUtil.isValid(self.heroModelObj) and self.sceneObj and L_CommonUtil.isValid(self.modelRootTrans) then
    self.displayedHeroGuid = heroGuid
    self._displayedHeroConfigId = L_HeroStore:getHeroConfigId(heroData)
    local ht = self.heroModelObj.transform
    applyPartyPreviewHeroTransform(ht, self._displayedHeroConfigId)
    self.displayCameraTargetTrans = ht
    self:refreshDisplayCameraTactics()
    self:updateHeroName(self._displayedHeroConfigId)
    self:playIdleAction()
    self:stopIdleActionTimer()
    self:startIdleActionTimer()
    self:setLoadingMaskActive(false)
    self:tryCloseEnterCutin(0.1)
    return
  end
  self.displayedHeroGuid = heroGuid
  local heroConfigId = L_HeroStore:getHeroConfigId(heroData)
  self._displayedHeroConfigId = heroConfigId
  self:cleanupHeroModel()
  self._heroLoadToken = (tonumber(self._heroLoadToken) or 0) + 1
  local loadToken = self._heroLoadToken
  self:_fetchHeroModelAsync(heroGuid, heroConfigId, function(entity, heroObj)
    if loadToken ~= self._heroLoadToken then
      if entity and entity ~= self.heroEntity then
        self:destroyHeroEntity(entity)
      end
      if L_CommonUtil.isValid(heroObj) and heroObj ~= self.heroModelObj then
        self:recycleLoaderObject(heroObj)
      end
      return
    end
    if not L_CommonUtil.isValid(heroObj) or not self.modelRootTrans then
      self:setLoadingMaskActive(false)
      self:tryCloseEnterCutin()
      return
    end
    local heroTrans = heroObj.transform
    if heroTrans.parent ~= self.modelRootTrans then
      local ok = pcall(function()
        heroTrans:SetParent(self.modelRootTrans, false)
      end)
      if not ok then
        heroTrans:SetParent(self.modelRootTrans)
      end
    end
    applyPartyPreviewHeroTransform(heroTrans, heroConfigId)
    self.displayCameraTargetTrans = heroTrans
    forceShowModelRenderers(heroObj)
    self:refreshDisplayCameraTactics()
    self:applyDisplayAnchorFit(heroObj, entity, heroConfigId)
    
    local function finishHeroDisplay()
      applyPartyPreviewHeroTransform(heroTrans, heroConfigId)
      self:refreshDisplayCameraTactics()
      self._loadedHeroGuid = heroGuid
      self._pendingHeroRefreshGuid = nil
      self:playIdleAction()
      self:stopIdleActionTimer()
      self:startIdleActionTimer()
      self:setLoadingMaskActive(false)
      self:tryCloseEnterCutin(0.1)
    end
    
    if entity then
      self:setHeroAdmission(entity, heroConfigId, finishHeroDisplay)
    else
      self:_fetchEffectModel(heroConfigId, heroObj)
      finishHeroDisplay()
    end
  end)
end

function this:applyDisplayAnchorFit(heroObj, entity, heroConfigId)
  if self._partyLayoutManualOnly then
    return
  end
  if not self.modelRootTrans or not L_CommonUtil.isValid(heroObj) then
    return
  end
  local anchorFit = self.modelRootTrans:GetComponent(typeof(CS.Lens.Gameplay.UI.CharacterAnchorFit))
  if not L_CommonUtil.isValid(anchorFit) then
    return
  end
  local modelHeight
  if (not modelHeight or modelHeight <= 0) and entity and entity.biologyData and entity.biologyData.halfHeight then
    modelHeight = entity.biologyData.halfHeight * 2
  end
  if not modelHeight or modelHeight <= 0 then
    local modelControl = heroObj:GetComponent(typeof(C_ModelControl))
    if modelControl then
      local headTrans = modelControl:GetTransByName("Head")
      if headTrans then
        modelHeight = headTrans.position.y - self.modelRootTrans.position.y + 0.2
      end
    end
  end
  if modelHeight and 0 < modelHeight then
    pcall(function()
      anchorFit:SetModelHeight(modelHeight)
    end)
  end
end

function this:_fetchHeroModelAsync(heroGuid, heroConfigId, callback)
  if not heroConfigId or heroConfigId <= 0 then
    callback(nil, nil)
    return
  end
  if not L_CommonUtil.isValid(self.gameObject) then
    callback(nil, nil)
    return
  end
  local defaultHeroGuid = L_HeroStore.getDefaultHeroGuid and (L_HeroStore:getDefaultHeroGuid() or 0) or 0
  local isPlayerHero = heroGuid == defaultHeroGuid or isMainHeroConfigId(heroConfigId)
  local unitId = L_GameUtil.getUnitIdByRole(heroConfigId, L_Const.roleType.hero)
  if not unitId then
    callback(nil, nil)
    return
  end
  local unit = _unitTpl:getTplById(unitId)
  local heroModelPath = unit and _unitTpl:getModel(unit, 1) or nil
  if type(heroModelPath) ~= "string" or heroModelPath == "" then
    heroModelPath = L_GameUtil.getAvatarModelPathByUnitId(unitId, L_Const.avatarModelIndex.UnitModel)
  end
  if type(heroModelPath) ~= "string" or heroModelPath == "" then
    callback(nil, nil)
    return
  end
  local parentTrans = self.modelRootTrans
  local initPos = getPartyPreviewHeroLocalPos(heroConfigId)
  local initRot = getPartyPreviewHeroLocalRot(heroConfigId)
  local initScale = getPartyPreviewHeroLocalScale(heroConfigId)
  local idleAction = getPartyPreviewHeroMainAction(heroConfigId)
  local needAnimaList = {
    "Idle",
    idleAction,
    "FormationAdmission",
    "Personal1"
  }
  if L_UIModelMgr and L_UIModelMgr.RecycleHeroModel then
    L_UIModelMgr:RecycleHeroModel()
  end
  L_UIModelMgr:LoadHeroModelAsync(heroModelPath, initPos, initRot, initScale, function(obj)
    if not L_CommonUtil.isValid(self.gameObject) or not L_CommonUtil.isValid(obj) then
      callback(nil, nil)
      return
    end
    local biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), obj)
    if biologyData then
      biologyData.isSync = true
    end
    local entity = L_EntityManager:generateSimpleHero(heroConfigId, obj, isPlayerHero, nil, needAnimaList, C_EEntityEntranceType.GameActivityParty)
    if entity and entity.playableAnimator then
      pcall(function()
        entity.playableAnimator:Play(idleAction)
      end)
    end
    self.heroEntity = entity
    self.heroModelObj = obj
    self:updateHeroName(heroConfigId)
    self:disableAllColliders(obj)
    forceShowModelRenderers(obj)
    if entity and entity.gameObject then
      forceShowModelRenderers(entity.gameObject)
    end
    callback(entity, obj)
  end, parentTrans)
end

function this:setHeroAdmission(heroEntity, heroConfigId, callback)
  if not heroEntity then
    if callback then
      callback()
    end
    return
  end
  local entity = heroEntity
  local heroGameObject
  pcall(function()
    heroGameObject = entity:getGameObject()
  end)
  if not L_CommonUtil.isValid(heroGameObject) then
    if callback then
      callback()
    end
    return
  end
  local animator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), heroGameObject)
  if not animator then
    if callback then
      callback()
    end
    return
  end
  animator:CrossFade("FormationAdmission", 0, -1, 0, 0)
  if callback then
    local aniState = animator:GetState("FormationAdmission")
    if aniState then
      self.aniCallbackTimer = Timer.once(aniState.length, callback, self, self.gameObject)
    else
      callback()
    end
  end
  self:_fetchEffectModel(heroConfigId, heroGameObject)
end

function this:_fetchEffectModel(heroConfigId, heroGameObject)
  if not heroConfigId or not L_CommonUtil.isValid(heroGameObject) then
    return
  end
  local tpl = _heroTpl:getTplById(heroConfigId)
  if not tpl then
    return
  end
  local elementId = _heroTpl:getElement(tpl)
  local tpl_ele = _elementTpl:getTplById(elementId)
  if not tpl_ele then
    return
  end
  local path = _elementTpl:getAdmissioneffects(tpl_ele)
  if type(path) ~= "string" or path == "" then
    return
  end
  local effectObj = L_ResPool:syncGameObject(path)
  if not L_CommonUtil.isValid(effectObj) then
    return
  end
  local targetTrans = heroGameObject.transform.childCount > 0 and heroGameObject.transform:GetChild(0) or heroGameObject.transform
  effectObj.transform:SetParent(targetTrans)
  L_Vector3.setLocalPos(effectObj.transform, L_Vector3.zero)
  effectObj:ActiveTrans(true)
end

function this:updateHeroName(heroConfigId)
  local tplData = _heroTpl:getTplById(heroConfigId)
  self.bind.text_heroName = tplData and _heroTpl:getName(tplData) or "未知角色"
end

function this:findChildByNameDeep(root, targetName)
  if not root or string.isEmpty(targetName) then
    return nil
  end
  local direct = root:Find(targetName)
  if direct then
    return direct
  end
  local queue = {root}
  local idx = 1
  while idx <= #queue do
    local node = queue[idx]
    idx = idx + 1
    for i = 0, node.childCount - 1 do
      local child = node:GetChild(i)
      if child.name == targetName then
        return child
      end
      table.insert(queue, child)
    end
  end
  return nil
end

function this:disableAllColliders(targetGo)
  if not L_CommonUtil.isValid(targetGo) then
    return
  end
  local colliders = targetGo:GetComponentsInChildren(typeof(CS.UnityEngine.Collider), true)
  if colliders then
    for i = 0, colliders.Length - 1 do
      local c = colliders[i]
      if c then
        c.enabled = false
      end
    end
  end
  local colliders2D = targetGo:GetComponentsInChildren(typeof(CS.UnityEngine.Collider2D), true)
  if colliders2D then
    for i = 0, colliders2D.Length - 1 do
      local c2 = colliders2D[i]
      if c2 then
        c2.enabled = false
      end
    end
  end
end

function this:destroyObject(obj)
  if L_CommonUtil.isValid(obj) then
    CS.UnityEngine.GameObject.Destroy(obj)
  end
end

function this:recycleLoaderObject(obj)
  if not L_CommonUtil.isValid(obj) then
    return
  end
  local recycled = false
  if C_PrefabManager and C_PrefabManager.RecycleByLoader then
    recycled = pcall(function()
      C_PrefabManager:RecycleByLoader(obj)
    end)
  end
  if not recycled and L_CommonUtil.isValid(obj) then
    CS.UnityEngine.GameObject.Destroy(obj)
  end
end

function this:destroyHeroEntity(entity)
  if entity then
    entity:onDestroy()
  end
end

function this:recycleSceneLoaderHandle()
  if not self.sceneLoadHandle then
    return
  end
  pcall(function()
    C_PrefabManager:RecycleByLoader(self.sceneLoadHandle)
  end)
  self.sceneLoadHandle = nil
end

function this:cleanupHeroModel()
  self._heroLoadToken = (tonumber(self._heroLoadToken) or 0) + 1
  if self.idleTimer then
    Timer.remove(self.idleTimer)
    self.idleTimer = nil
  end
  if self.aniCallbackTimer then
    Timer.remove(self.aniCallbackTimer)
    self.aniCallbackTimer = nil
  end
  if self.sceneLoadTimer then
    Timer.remove(self.sceneLoadTimer)
    self.sceneLoadTimer = nil
  end
  self:destroyHeroEntity(self.heroEntity)
  self.heroEntity = nil
  self:recycleLoaderObject(self.heroModelObj)
  self.heroModelObj = nil
  self.displayCameraTargetTrans = self.modelRootTrans
  self._loadedHeroGuid = 0
end

function this:stopAllTimers()
  self:stopTimer()
  self:stopScreenPollTimer()
  if self.idleTimer then
    Timer.remove(self.idleTimer)
    self.idleTimer = nil
  end
  if self.matchTimer then
    Timer.remove(self.matchTimer)
    self.matchTimer = nil
  end
  if self.matchSuccessTimer then
    Timer.remove(self.matchSuccessTimer)
    self.matchSuccessTimer = nil
  end
  if self.aniCallbackTimer then
    Timer.remove(self.aniCallbackTimer)
    self.aniCallbackTimer = nil
  end
  if self.sceneLoadTimer then
    Timer.remove(self.sceneLoadTimer)
    self.sceneLoadTimer = nil
  end
  if self.enterCutinCloseTimer then
    Timer.remove(self.enterCutinCloseTimer)
    self.enterCutinCloseTimer = nil
  end
  if self._buttonActionLockTimer then
    Timer.remove(self._buttonActionLockTimer)
    self._buttonActionLockTimer = nil
  end
  if self.topBarRefreshTimer then
    Timer.remove(self.topBarRefreshTimer)
    self.topBarRefreshTimer = nil
  end
end

function this:startMatchUITimer()
  self:stopMatchUITimer()
  self.matchTimer = Timer.repeated(1, function()
    if not self:isUiStateReady() then
      self:stopMatchUITimer()
      return
    end
    self:updateMatchUIByState()
  end, self, self.gameObject)
end

function this:stopMatchUITimer()
  if self.matchTimer then
    Timer.remove(self.matchTimer)
    self.matchTimer = nil
  end
end

function this:formatMatchElapsed(seconds)
  seconds = math.max(0, tonumber(seconds) or 0)
  local mm = math.floor(seconds / 60)
  local ss = seconds % 60
  return string.format("%02d:%02d", mm, ss)
end

function this:loadDisplayRecord()
  local recordGuid = self:getDisplayRecordGuid()
  if recordGuid and 0 < recordGuid and L_HeroStore:getHero(recordGuid) then
    self.displayedHeroGuid = recordGuid
    return
  end
  local worldType = L_FormationConst.FormationType.world
  local worldControlGuid = L_FormationStore.getControl and L_FormationStore:getControl(worldType) or 0
  worldControlGuid = tonumber(worldControlGuid) or 0
  if 0 < worldControlGuid and L_HeroStore:getHero(worldControlGuid) then
    self.displayedHeroGuid = worldControlGuid
    return
  end
  local defaultGuid = L_HeroStore.getDefaultHeroGuid and (L_HeroStore:getDefaultHeroGuid() or 0) or 0
  if 0 < defaultGuid and L_HeroStore:getHero(defaultGuid) then
    self.displayedHeroGuid = defaultGuid
    return
  end
  local worldFormation = L_FormationStore:getFormationPosData(worldType, L_FormationStore:getUsingTeamIndex(worldType))
  for i = 1, L_FormationConst.FormationPosNum do
    local guid = worldFormation[i]
    if guid and 0 < guid and L_HeroStore:getHero(guid) then
      self.displayedHeroGuid = guid
      return
    end
  end
  local runtimeWorldGuid = self:getRuntimeWorldHeroGuid()
  if 0 < runtimeWorldGuid and L_HeroStore:getHero(runtimeWorldGuid) then
    self.displayedHeroGuid = runtimeWorldGuid
    return
  end
  if L_HeroStore.getDefaultHeroGuid then
    local fallbackGuid = L_HeroStore:getDefaultHeroGuid() or 0
    if 0 < fallbackGuid and L_HeroStore:getHero(fallbackGuid) then
      self.displayedHeroGuid = fallbackGuid
      return
    end
  end
  self.displayedHeroGuid = self:getFirstAvailableHero()
end

function this:getRuntimeWorldHeroGuid()
  local guid = 0
  if C_PlayerUnitHelper and AzurWorld and AzurWorld.playerMgr and AzurWorld.playerMgr.myPlayerId then
    local ok, entity = pcall(function()
      return AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
    end)
    if ok and entity and entity.data then
      guid = tonumber(entity.data.UUID or entity.data.uuid or entity.data.guid) or 0
    end
  end
  return guid
end

function this:_getDisplayRecordKey()
  return string.format("PartyGame_DisplayHero_%d", tonumber(self.actId) or 0)
end

function this:saveDisplayRecord(heroGuid)
  heroGuid = tonumber(heroGuid) or 0
  if heroGuid <= 0 then
    return
  end
  if not L_HeroStore:getHero(heroGuid) then
    return
  end
  local expire = tonumber(self.endTime) or 0
  L_CommonUtil.setLocalValue(self:_getDisplayRecordKey(), string.format("%d|%d", heroGuid, expire))
end

function this:clearDisplayRecord()
  if not self.actId or self.actId <= 0 then
    return
  end
  L_CommonUtil.clearLocalValue(self:_getDisplayRecordKey())
end

function this:getDisplayRecordGuid()
  if not self.actId or self.actId <= 0 then
    return 0
  end
  local val = L_CommonUtil.getLocalValue(self:_getDisplayRecordKey())
  if string.isEmpty(val) then
    return 0
  end
  local parts = string.split(val, "|")
  local guid = tonumber(parts and parts[1]) or 0
  local expire = tonumber(parts and parts[2]) or 0
  if guid <= 0 then
    self:clearDisplayRecord()
    return 0
  end
  if 0 < expire and expire < L_TimeUtil:getServerTime() then
    self:clearDisplayRecord()
    return 0
  end
  return guid
end

function this:getFirstAvailableHero()
  local allHeroes = L_HeroStore:getAllHero()
  if allHeroes and next(allHeroes) then
    for _, heroData in pairs(allHeroes) do
      local heroGuid = L_HeroStore:getHeroGuid(heroData)
      if heroGuid and 0 < heroGuid then
        return heroGuid
      end
    end
  end
  return 0
end

function this:startIdleActionTimer()
  self:stopIdleActionTimer()
  self.idleTimer = Timer.repeated(8, function()
    self:playPersonalAction()
  end, self, self.gameObject)
end

function this:stopIdleActionTimer()
  if self.idleTimer then
    Timer.remove(self.idleTimer)
    self.idleTimer = nil
  end
end

function this:playIdleAction()
  local animator = getPartyHeroPlayableAnimator(self.heroEntity, self.heroModelObj)
  if not animator then
    return
  end
  local heroConfigId = tonumber(self._displayedHeroConfigId) or 0
  local idleAction = getPartyPreviewHeroMainAction(heroConfigId)
  local ok = pcall(function()
    animator:Play(idleAction)
  end)
  if not ok then
    pcall(function()
      animator:Play("Idle")
    end)
  end
end

function this:playPersonalAction()
  local animator = getPartyHeroPlayableAnimator(self.heroEntity, self.heroModelObj)
  if not animator then
    return
  end
  local aniState = animator:GetState("Personal1")
  if not aniState then
    self:playIdleAction()
    return
  end
  animator:CrossFade("Personal1", 0, -1, 0, 0)
  if self.aniCallbackTimer then
    Timer.remove(self.aniCallbackTimer)
    self.aniCallbackTimer = nil
  end
  self.aniCallbackTimer = Timer.once(aniState.length, function()
    if not L_CommonUtil.isValid(self.gameObject) then
      return
    end
    self.aniCallbackTimer = nil
    self:playIdleAction()
  end, self, self.gameObject)
end

function this:registerMatchListeners()
  if not self:ensureMatchLogicMgr() then
    return
  end
  if self._matchListenersRegistered then
    return
  end
  self._matchListenersRegistered = true
  self.MatchLogicMgr:addStateChangeListener(function()
    if not self:isUiStateReady() then
      return
    end
    self:updateMatchUIByState()
  end)
  self.MatchLogicMgr:addMatchFailedListener(function(errMsg)
    if not self:isUiStateReady() then
      return
    end
    local bs = self.MatchLogicMgr:getBusinessStatusEnum()
    local currentState = self.MatchLogicMgr:getBusinessState()
    if currentState == bs.TIMEOUT then
      return
    end
    L_FlyMsgManager:showNormalMsg(errMsg or "匹配失败")
  end)
  self.MatchLogicMgr:addPreStartListener(function(remainingTime)
    if not self:isUiStateReady() then
      return
    end
    L_FlyMsgManager:showNormalMsg(string.format("游戏即将开始！剩余%d秒", remainingTime))
  end)
  self.MatchLogicMgr:addQuitTimeoutListener(function(remainingTime)
    if not self:isUiStateReady() then
      return
    end
    L_FlyMsgManager:showNormalMsg(string.format("即将退出匹配！剩余%d秒", remainingTime))
  end)
  self.MatchLogicMgr:addMatchSuccessListener(function(playerList)
    if not self:isUiStateReady() then
      return
    end
    self:onMatchSuccess(playerList)
  end)
end

function this:onClickMatch()
  if AzurWorld.popperPartyMgr:CheckAFkForbidLimit() then
    return
  end
  runWithEscButtonLock(self, function()
    if not self:isInMatchOpenPeriod() then
      self:refreshMatchOpenPeriodDisplay()
      self:refreshMatchOpenPeriodState(true)
      local tipText
      if L_WordsTpl and L_WordsTpl.getValue then
        local ok, text = pcall(function()
          return L_WordsTpl:getValue("notice_partygame_match_time_fail")
        end)
        if ok and type(text) == "string" and text ~= "" then
          tipText = text
        end
      end
      L_FlyMsgManager:showNormalMsg(tipText or "当前不在匹配开放时段")
      return
    end
    if not self:ensureMatchLogicMgr() then
      L_FlyMsgManager:showNormalMsg("匹配模块未就绪，请稍后重试")
      return
    end
    self:playPersonalAction()
    if not self.displayedHeroGuid or self.displayedHeroGuid <= 0 then
      self:loadDisplayRecord()
    end
    if not self.displayedHeroGuid or self.displayedHeroGuid <= 0 then
      L_FlyMsgManager:showNormalMsg("暂无可参与匹配的角色")
      return
    end
    self.MatchLogicMgr:startMatch(self.actId, self.displayedHeroGuid)
    self:updateMatchUIByState()
  end)
end

function this:onClickBtnMatch()
  local bs = self.MatchLogicMgr:getBusinessStatusEnum()
  local currentState = self.MatchLogicMgr:getBusinessState()
  local allowMatch = currentState == bs.IDLE or currentState == bs.CANCELED or currentState == bs.TIMEOUT or currentState == bs.GAME_END
  local allowCancelMatch = currentState == bs.MATCHING or currentState == bs.EXTRA_WAIT
  if allowMatch then
    self:onClickMatch()
  elseif allowCancelMatch then
    self:onClickCancelMatch()
  end
end

function this:onClickCancelMatch()
  runWithEscButtonLock(self, function()
    if not self:ensureMatchLogicMgr() then
      return
    end
    local bs = self.MatchLogicMgr:getBusinessStatusEnum()
    local currentState = self.MatchLogicMgr:getBusinessState()
    if currentState ~= bs.MATCHING and currentState ~= bs.EXTRA_WAIT then
      self:updateMatchUIByState()
      return
    end
    local latestState = self.MatchLogicMgr:getBusinessState()
    if latestState ~= bs.MATCHING and latestState ~= bs.EXTRA_WAIT then
      self:updateMatchUIByState()
      return
    end
    self.MatchLogicMgr:cancelMatch(self.actId)
  end)
end

function this:updateMatchUIByState()
  if not self:isUiStateReady() then
    return
  end
  self:refreshMatchOpenPeriodDisplay()
  if not self:ensureMatchLogicMgr() then
    self:stopMatchUITimer()
    self.bind.btn_match = true
    self.bind.btn_cancelMatch = false
    self.bind.Successmatch = false
    self.bind.matchtime_txt = "匹配"
    self:refreshMatchOpenPeriodState(true)
    self.bind.go_MatchLockedTip = true
    return
  end
  local bs = self.MatchLogicMgr:getBusinessStatusEnum()
  local currentState = self.MatchLogicMgr:getBusinessState()
  local remainingTime = self.MatchLogicMgr:getRemainingTime()
  local matchStartTime = self.MatchData and self.MatchData._data and self.MatchData._data.matchStartTime or 0
  local hasServerMatchTime = 0 < matchStartTime
  local elapsed = hasServerMatchTime and math.max(0, L_TimeUtil:getServerTime() - matchStartTime) or 0
  self.bind.btn_match = false
  self.bind.btn_cancelMatch = false
  self.bind.Successmatch = false
  self.bind.matchtime_txt = ""
  self.bind.go_MatchStateTip = false
  if currentState == bs.IDLE then
    self._matchEnteringGame = false
    self:stopMatchUITimer()
    self.bind.btn_match = true
    self.bind.matchtime_txt = "匹配"
    self.bind.go_MatchLockedTip = true
  elseif currentState == bs.MATCHING then
    self._matchEnteringGame = false
    self:startMatchUITimer()
    self.bind.btn_cancelMatch = true
    self.bind.go_MatchStateTip = true
    self.bind.go_MatchLockedTip = false
    if hasServerMatchTime then
      self.bind.matchtime_txt = string.format("匹配中... %s", self:formatMatchElapsed(elapsed))
    else
      self.bind.matchtime_txt = "匹配中..."
    end
    print("[PopperParty][Match] MATCHING state - go_Mat")
  elseif currentState == bs.EXTRA_WAIT then
    self._matchEnteringGame = false
    self:startMatchUITimer()
    self.bind.btn_cancelMatch = true
    self.bind.go_MatchLockedTip = false
    if hasServerMatchTime then
      self.bind.matchtime_txt = string.format("等待其他玩家... 已等待%s", self:formatMatchElapsed(elapsed))
    else
      self.bind.matchtime_txt = "等待其他玩家..."
    end
  elseif currentState == bs.PRE_START then
    self._matchEnteringGame = true
    self:dismissMatchExitPrompt()
    self:startMatchUITimer()
    self.bind.Successmatch = true
    self.bind.matchtime_txt = string.format("匹配成功！%d秒后进入游戏", remainingTime)
    self.bind.go_MatchLockedTip = false
  elseif currentState == bs.GAME_START then
    self._matchEnteringGame = true
    self:dismissMatchExitPrompt()
    self:stopMatchUITimer()
    self.bind.Successmatch = true
    self.bind.matchtime_txt = "游戏进行中"
    self.bind.go_MatchLockedTip = false
  elseif currentState == bs.CANCELED then
    self._matchEnteringGame = false
    self:stopMatchUITimer()
    self.bind.btn_match = true
    self.bind.matchtime_txt = ""
    self.bind.go_MatchLockedTip = true
  elseif currentState == bs.TIMEOUT then
    self._matchEnteringGame = false
    self:stopMatchUITimer()
    self.bind.btn_match = true
    self.bind.matchtime_txt = "匹配超时，请稍后再试"
    self.bind.go_MatchLockedTip = true
  elseif currentState == bs.GAME_END then
    self._matchEnteringGame = false
    self:stopMatchUITimer()
    self.bind.btn_match = true
    self.bind.matchtime_txt = "本局结束，可重新匹配"
    self.bind.go_MatchLockedTip = true
  end
  self:refreshMatchOpenPeriodState(self.bind.btn_match == true and self.bind.btn_cancelMatch ~= true and self.bind.Successmatch ~= true)
end

function this:onMatchSuccess(playerList)
  if not self:isUiStateReady() then
    return
  end
  if self.matchSuccessTimer then
    return
  end
  self._matchEnteringGame = true
  self:dismissMatchExitPrompt()
  self:tagRestoreToPartyMain()
  self.bind.Successmatch = true
  self.bind.matchtime_txt = "匹配成功！即将进入游戏..."
  local delayTime = math.random(1, 2)
  self.matchSuccessTimer = Timer.once(delayTime, function()
    self:enterLoadingStage(playerList)
  end, self, self.gameObject)
end

function this:enterLoadingStage(playerList)
  if not self:isUiStateReady() then
    return
  end
  if self.matchSuccessTimer then
    Timer.remove(self.matchSuccessTimer)
    self.matchSuccessTimer = nil
  end
  self._matchEnteringGame = true
  self:dismissMatchExitPrompt()
  self.bind.btn_match = false
  self.bind.btn_cancelMatch = false
  self.bind.Successmatch = true
  self.bind.matchtime_txt = "正在进入游戏..."
  L_FlyMsgManager:showNormalMsg("正在进入游戏...")
end

function this:onClickReward()
  runWithEscButtonLock(self, function()
    L_UI:open("pageActivityPartyReward", {
      id = self.actId
    })
  end)
end

function this:onClickSkill()
  runWithEscButtonLock(self, function()
    L_UI:open("pageActivityPartySkill", {
      actId = self.actId
    })
  end)
end

function this:onClickShop()
end

function this:scheduleRestoreHeroAfterRolePage(heroGuid, retryCount)
  heroGuid = tonumber(heroGuid) or 0
  if heroGuid <= 0 then
    return
  end
  retryCount = retryCount or 0
  local delay = retryCount == 0 and 0.35 or 0.1
  Timer.once(delay, function()
    if not self:isUiStateReady() then
      return
    end
    if self.isShow == false and retryCount < 8 then
      self:scheduleRestoreHeroAfterRolePage(heroGuid, retryCount + 1)
      return
    end
    self.displayedHeroGuid = heroGuid
    self._pendingHeroRefreshGuid = heroGuid
    if not self.sceneObj or not L_CommonUtil.isValid(self.modelRootTrans) then
      self:initDisplayAsync()
      return
    end
    self:setDisplaySceneActive(true)
    self:setDisplaySceneCameraEnabled(true)
    self:cleanupHeroModel()
    self:selectHero(heroGuid)
  end, self, self.gameObject)
end

function this:onClickRole()
  runWithEscButtonLock(self, function()
    self._openingRolePage = true
    self._restoreHeroAfterRolePage = true
    Timer.once(0.3, function()
      if L_CommonUtil.isValid(self.gameObject) then
        self._openingRolePage = false
      end
    end, self, self.gameObject)
    L_UI:open("pageActivityPartyRole", {
      actId = self.actId,
      currentHeroGuid = self.displayedHeroGuid,
      onConfirm = function(heroGuid)
        heroGuid = tonumber(heroGuid) or 0
        if 0 < heroGuid then
          self:saveDisplayRecord(heroGuid)
          self.displayedHeroGuid = heroGuid
          self._pendingHeroRefreshGuid = heroGuid
          Timer.once(0.35, function()
            if not L_CommonUtil.isValid(self.gameObject) then
              return
            end
            if self._pendingHeroRefreshGuid == heroGuid then
              self:selectHero(heroGuid)
            end
          end, self, self.gameObject)
        end
      end,
      onCancel = function(heroGuid)
        heroGuid = tonumber(heroGuid) or tonumber(self.displayedHeroGuid) or 0
        if 0 < heroGuid then
          self.displayedHeroGuid = heroGuid
          self._pendingHeroRefreshGuid = heroGuid
          self._restoreHeroAfterRolePage = true
          self._openingRolePage = false
          self:scheduleRestoreHeroAfterRolePage(heroGuid)
        end
      end
    })
  end)
end

function this:onClickModel()
  self:playPersonalAction()
end

function this:escHandle()
  if self._escLockedByButton then
    self._escPressedDuringButtonLock = true
    return
  end
  performEscAction(self)
end

function this:close()
  self._isPageClosed = true
  self._openingRolePage = false
  self._escLockedByButton = false
  self._escPressedDuringButtonLock = false
  self._matchEnteringGame = false
  self._matchExitPromptShowing = false
  self:stopAllTimers()
  self:disposeDisplayCameraSwingUpdate()
  self:restoreDisplaySceneDepthOfField()
  self:tryCloseEnterCutin()
  if self:ensureMatchLogicMgr() then
    local bs = self.MatchLogicMgr:getBusinessStatusEnum()
    local state = self.MatchLogicMgr:getBusinessState()
    if state == bs.MATCHING or state == bs.EXTRA_WAIT then
      self.MatchLogicMgr:cancelMatch(self.actId)
    end
  end
  self:cleanupHeroModel()
  self:updateSceneVisibleTag(false)
  self:disposeDisplayCameraTactics()
  self:recycleSceneLoaderHandle()
  self.sceneObj = nil
  self.bind.go_displayContainer = nil
  self._loadingMaskGo = nil
  self.modelRootTrans = nil
  self.displaySceneCameraComp = nil
  self.displayCameraTargetTrans = nil
  self.displaySceneDepthVolumeComp = nil
  self._mainCameraOriginalSourceType = nil
end

return this
