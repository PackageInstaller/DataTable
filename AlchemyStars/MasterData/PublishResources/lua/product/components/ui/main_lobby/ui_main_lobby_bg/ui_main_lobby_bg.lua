_class("UIMainLobbyBg", UICustomWidget)
UIMainLobbyBg = UIMainLobbyBg

function UIMainLobbyBg:OnShow()
  self._petAudioModule = self:GetModule(PetAudioModule)
  self._roleModule = GameGlobal.GetModule(RoleModule)
  self._freeTime = 0
  self._maxFreeTime = Cfg.cfg_global.MainUIFreeTime.IntValue * 1000
  self._playWelcome = false
  local oldType = GameGlobal.UIStateManager():GetLastStateType()
  if oldType == UIStateType.Login or oldType == UIStateType.LoginEmpty or oldType == UIStateType.UIAircraft or oldType == UIStateType.UIDiscovery then
    self._playWelcome = true
  end
  self:AttachEvent(GameEventType.ClosePetAudio, self.ClosePetAudio)
  self:AttachEvent(GameEventType.OnAssistantChanged, self.OnAssistantChanged)
  self:AttachEvent(GameEventType.SwitchSkinStaticOrDynamic, self.StaticAndDynamicOnClick)
  self._cgGo = self:GetGameObject("cg")
  self._cg = self:GetUIComponent("RawImageLoader", "cg")
  self:AttachEvent(GameEventType.OnMainCgChangeSave, self.SaveCancelChangeCgRoot)
  self:AttachEvent(GameEventType.OnMainLobbyHideAssistant, self.OnMainLobbyHideAssistant)
  self._cgSpineGo = self:GetGameObject("posAndScale")
  self._spineGo = self:GetGameObject("spine")
  self._spine = self:GetUIComponent("SpineLoader", "spine")
  self._voiceTex = self:GetUIComponent("UILocalizationText", "voiceTex")
  self._voiceTex2 = self:GetUIComponent("UILocalizationText", "voiceTex2")
  self._voiceCanvasGroup = self:GetUIComponent("CanvasGroup", "VOICE")
  self:AttachEvent(GameEventType.ChangeMainBg, self.SetMainBg)
  self._voiceRootCanvasGroup = self:GetUIComponent("CanvasGroup", "VoiceRoot")
  self._voiceGo = self:GetGameObject("VOICE")
  self._voiceAnim = self:GetUIComponent("Animation", "VOICE")
  self:AttachEvent(GameEventType.OnMainCgChangePos, self.ChangeCgRootPos)
  self:AttachEvent(GameEventType.OnMainCgChangeScale, self.ChangeCgRootScale)
  self._changePetPosAndScaleRoot = self:GetUIComponent("RectTransform", "posAndScale")
  self._spineBgRoot = self:GetUIComponent("RectTransform", "spineHolder")
  self._spineLoader2 = self:GetUIComponent("SpineLoader", "bg_spine2")
  self._spineLoaderObj2 = self:GetGameObject("bg_spine2")
  self._spineLoader1 = self:GetUIComponent("SpineLoader", "bg_spine1")
  self._spineLoaderObj1 = self:GetGameObject("bg_spine1")
  self._mainBg = self:GetUIComponent("RawImageLoader", "bg")
  self._mainBgRect = self:GetUIComponent("RectTransform", "bg")
  self._mainBg2Rect = self:GetUIComponent("RectTransform", "bg2")
  self._mainBgAlpha1 = self:GetUIComponent("CanvasGroup", "bg")
  self._mainBg2 = self:GetUIComponent("RawImageLoader", "bg2")
  self._mainBgAlpha2 = self:GetUIComponent("CanvasGroup", "bg2")
  self._bgRoot = self:GetUIComponent("RectTransform", "bgRoot")
  self._bgRootObj = self:GetGameObject("bgRoot")
  self:AttachEvent(GameEventType.OnShowChangeMainCg, self.OnShowChangeMainCg)
  self._enterSpineGo = self:GetGameObject("enter_spine")
  self._enterSpine = self:GetUIComponent("SpineLoader", "enter_spine")
  self._enterSpineSubGoGen = self:GetUIComponent("UISelectObjectPath", "enterSpineSubGo")
  self._enterSpineSubGo = self:GetGameObject("enterSpineSubGo")
  self._enterSpineGoShowFinish = true
  self:InitOnDrag()
end

function UIMainLobbyBg:OnHide()
  if self._defaultPetID and self._defaultPetID ~= 0 then
    self._petAudioModule:ReleaseAdx2VoiceCueSheetByAnyAudioId("MainLobbyInteract", self._defaultPetID)
  end
  if self._bgSpine1Event then
    GameGlobal.Timer():CancelEvent(self._bgSpine1Event)
    self._bgSpine1Event = nil
    self._playBgSpine1Anim = false
  end
  if self._spineEvent then
    GameGlobal.Timer():CancelEvent(self._spineEvent)
    self._spineEvent = nil
    self._playSpineAnim = false
  end
  if self._enterSpineSubGoCloseEvent then
    GameGlobal.Timer():CancelEvent(self._enterSpineSubGoCloseEvent)
    self._enterSpineSubGoCloseEvent = nil
  end
end

function UIMainLobbyBg:SetData(disableWelcomeAudio)
  if self._playWelcome == true and not disableWelcomeAudio then
    self:WelcomeAudio()
  end
  self:InitDressUpInfos()
  self:ShowCurrentAssistant()
  self:SetBgRootPosAndScale()
  self:SetRootPosAndScale()
end

function UIMainLobbyBg:InitOnDrag()
  self.dragBGObj = self:GetGameObject("DragBG")
  self.animImage = self:GetUIComponent("Image", "animImage")
  self.animImage:DOColor(Color(0, 0, 0, 0), 0)
  self.originPos = Vector3(0, 0, 0)
  self.endDragPos = Vector3(0, 0, 0)
  UIEventTriggerListener.Get(self.dragBGObj).onBeginDrag = function(go)
    self.originPos = go.position
  end
  UIEventTriggerListener.Get(self.dragBGObj).onEndDrag = function(go)
    self.endDragPos = go.position
    local deltaX = self.endDragPos.x - self.originPos.x
    if self:OpenDressCount() <= 1 then
      return
    end
    if deltaX < -300 then
      local nextIndex = self:CalcuNextDressIndex()
      self:RefreshDressUp(nextIndex)
    end
    if 300 < deltaX then
      local preIndex = self:CalcuPreDressIndex()
      self:RefreshDressUp(preIndex)
    end
  end
end

function UIMainLobbyBg:RefreshDressUp(dressIndex)
  self:StartTask(self.Task_ShowDress, self, dressIndex)
end

function UIMainLobbyBg:Task_ShowDress(TT, dressIndex)
  self:Lock("UIMainLobbyBg_Task_ShowDress")
  self._petAudioModule:StopAll()
  self.animImage:DOColor(Color(0, 0, 0, 1), 0.1)
  YIELD(TT, 100)
  local dressInfos = self._signInModule:GetDressInfos()
  self:SetIndexDress(dressIndex, dressInfos)
  local targetInfo = dressInfos[dressIndex]
  self._dragShow = true
  self._spineLoaded = false
  self._cgLoaded = false
  self:ShowCurrentAssistant()
  self:SetRootPosAndScale()
  self:SetBgRootPosAndScale(targetInfo.spine_id)
  if targetInfo.pet_cfg_id ~= -1 or not self._assistantNull then
    if targetInfo.is_static == nil then
      targetInfo.is_static = false
    end
    GameGlobal.TaskManager():StartTask(self.Task_SetExtFlag, self, targetInfo.is_static)
    local staticValue = DynamicAndStaticState.Dynamic
    if targetInfo.is_static then
      staticValue = DynamicAndStaticState.Static
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SwitchSkinStaticOrDynamic, staticValue)
  end
  local res, replay = self._signInModule:HandleCurMainDressUpReq(TT, dressIndex)
  if res:GetSucc() then
  end
  self.animImage:DOColor(Color(0, 0, 0, 0), 0.1)
  YIELD(TT, 100)
  self._dragShow = false
  self:WelcomeAudio()
  self:UnLock("UIMainLobbyBg_Task_ShowDress")
end

function UIMainLobbyBg:Task_SetExtFlag(TT, isStatic)
  self:Lock("UIMainLobbyBg_Task_SetExtFlag")
  local roleModule = GameGlobal.GetModule(RoleModule)
  roleModule:SetExtFlag(TT, CharExtFlag.CEFT_MAIN_UI_SHOW_SPINE, isStatic)
  self:UnLock("UIMainLobbyBg_Task_SetExtFlag")
end

function UIMainLobbyBg:OpenDressCount()
  local dressInfos = self._signInModule:GetDressInfos()
  local OpenCount = 0
  for i = 1, #dressInfos do
    if dressInfos[i].range_select == 1 then
      OpenCount = OpenCount + 1
    end
  end
  return OpenCount
end

function UIMainLobbyBg:CalcuNextDressIndex()
  local dressIndex = self._signInModule:GetMainDressUpCurIndex()
  local dressInfos = self._signInModule:GetDressInfos()
  local calcuCount = 1
  local needCalcuCount = #dressInfos - 1
  while calcuCount <= needCalcuCount do
    calcuCount = calcuCount + 1
    dressIndex = dressIndex + 1
    if dressIndex > #dressInfos then
      dressIndex = 1
    end
    if dressInfos[dressIndex].range_select == 1 then
      calcuCount = #dressInfos
    end
  end
  return dressIndex
end

function UIMainLobbyBg:CalcuPreDressIndex()
  local dressIndex = self._signInModule:GetMainDressUpCurIndex()
  local dressInfos = self._signInModule:GetDressInfos()
  local calcuCount = 1
  local needCalcuCount = #dressInfos - 1
  while calcuCount <= needCalcuCount do
    calcuCount = calcuCount + 1
    dressIndex = dressIndex - 1
    if dressIndex <= 0 then
      dressIndex = #dressInfos
    end
    if dressInfos[dressIndex].range_select == 1 then
      calcuCount = #dressInfos
    end
  end
  return dressIndex
end

function UIMainLobbyBg:InitDressUpInfos()
  self._signInModule = self:GetModule(SignInModule)
  local dressIndex = self._signInModule:GetMainDressUpCurIndex()
  local dressInfos = self._signInModule:GetDressInfos()
  self:SetIndexDress(dressIndex, dressInfos)
end

function UIMainLobbyBg:SetIndexDress(dressIndex, dressInfos)
  if #dressInfos == 0 then
    return
  end
  if dressInfos[dressIndex] == nil then
    return
  end
  local targetInfo = dressInfos[dressIndex]
  self._cgID = targetInfo.pet_cfg_id
  self._grade = targetInfo.pet_grade
  self._skinID = targetInfo.pet_skin_id
  self._asID = targetInfo.board_pet
  self._bgId = targetInfo.bg_id
  self._bgType = targetInfo.bg_type
  self._roleModule.m_choose_painting.spine_id = targetInfo.spine_id
  ChooseAssistantHelper:SaveTmpChooseCgPaintingData(true, self._cgID, self._grade, self._skinID, self._asID)
  ChooseAssistantHelper:SaveTmpChooseBgPaintingData(true, self._bgId, self._bgType)
  local petPos = Vector2(targetInfo.pet_x, targetInfo.pet_y)
  local petScale = targetInfo.pet_scale
  if petScale == 0 then
    petScale = 1
  end
  ChooseAssistantHelper.SaveAssistantPetSetting(petPos, petScale)
  local bgPos = Vector2.zero
  if targetInfo.bg_x ~= nil and targetInfo.bg_y ~= nil then
    bgPos = Vector2(targetInfo.bg_x, targetInfo.bg_y)
  end
  local bgScale = targetInfo.bg_scale
  Log.debug("[FX] bgScale ", targetInfo.bg_scale)
  if bgScale == 0 or bgScale == nil then
    Log.debug("[FX] bgScale2222 ", bgScale)
    bgScale = 1
    targetInfo.bg_scale = 1
  end
  local spineIndex = targetInfo.spine_id
  ChooseAssistantHelper.SaveAssistantBgSetting(bgPos, bgScale, self._bgType, self._bgId, false, spineIndex)
end

function UIMainLobbyBg:SetWatchMode(showUiBtnCallback)
  self._showUiBtnCallback = showUiBtnCallback
  self:GetGameObject("VoiceRoot"):SetActive(self._showUiBtnCallback == false)
end

function UIMainLobbyBg:GetBgIDAndType()
  return self._currentMainBgID, self._currentMainBgType
end

function UIMainLobbyBg:GetBgSetting()
  return self._deltaBgPos, self._deltaBgScale, self._bgRoot.sizeDelta
end

function UIMainLobbyBg:ChangeCgRootScale(type, scale)
  if type == UIChooseAssistantType.Bg2MainLobby then
    self._deltaBgScale = scale
    self._bgRoot.localScale = Vector3(self._deltaBgScale, self._deltaBgScale, self._deltaBgScale)
    self._spineBgRoot.localScale = Vector3(self._deltaBgScale, self._deltaBgScale, self._deltaBgScale)
  elseif type == UIChooseAssistantType.Cg2MainLobby then
    self._deltaScale = scale
    self._changePetPosAndScaleRoot.localScale = Vector3(self._deltaScale, self._deltaScale, self._deltaScale)
  end
end

function UIMainLobbyBg:ChangeCgRootPos(type, pos)
  if type == UIChooseAssistantType.Bg2MainLobby then
    self._deltaBgPos = pos
    self._bgRoot.anchoredPosition = self._deltaBgPos
    self._spineBgRoot.anchoredPosition = self._deltaBgPos
  elseif type == UIChooseAssistantType.Cg2MainLobby then
    self._deltaPos = pos
    self._changePetPosAndScaleRoot.anchoredPosition = self._deltaPos
  end
end

function UIMainLobbyBg:BgOnClick()
  if self._showUiBtnCallback then
    self._showUiBtnCallback()
  end
  self:SpineBgOnClick(true)
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_DIALOG)
  if not self._assistantNull then
    GameGlobal.UAReportForceGuideEvent("UIMainClick", {
      "Click_ChangeGuider"
    }, true)
    local voiceSkinID
    if self._assistantAsID and self._assistantAsID ~= 0 then
      voiceSkinID = nil
    elseif self._assistantSkinID == 0 then
      if self._assistantGrade == 0 then
        local gradeCfg = Cfg.cfg_pet[self._defaultPetID]
        if not gradeCfg then
          Log.fatal("###[UIMainLobbyFinal] pet cfg is nil ! id --> ", self._defaultPetID, "| grade --> ", self._assistantGrade)
          return
        end
        voiceSkinID = gradeCfg.SkinId
      else
        local gradeCfg = Cfg.cfg_pet_grade({
          PetID = self._defaultPetID,
          Grade = self._assistantGrade
        })[1]
        if not gradeCfg then
          Log.fatal("###[UIMainLobbyFinal] grade cfg is nil ! id --> ", self._defaultPetID, "| grade --> ", self._assistantGrade)
          return
        end
        voiceSkinID = gradeCfg.SkinId
      end
    else
      voiceSkinID = self._assistantSkinID
    end
    self:PlayPetAudio("MainLobbyInteract", true)
    self:PlaySpineAnim(voiceSkinID)
  end
end

function UIMainLobbyBg:SpineBgOnClick(callFromBgOnClick)
  if not callFromBgOnClick and self._showUiBtnCallback then
    self._showUiBtnCallback()
  end
  if not self._assistantNull then
    return
  end
  if self._playBgSpine1Anim then
    return
  end
  if self.isMultiSpineSkin and self.multiSpineName then
    local cfg = Cfg.cfg_multi_spine_cg_ani({
      Spine = self.multiSpineName
    })
    if not (cfg and cfg[1]) or not cfg[1].ClickAni then
      return
    end
    local clickAni = cfg[1].ClickAni
    self:PlayBgSpineAnim(clickAni)
  end
end

function UIMainLobbyBg:PlayBgSpineAnim(clickAni)
  self._bgSpine1Ske = self._spineLoader1.CurrentSkeleton
  if not self._bgSpine1Ske then
    self._bgSpine1Ske = self._spineLoader1.CurrentMultiSkeleton
  end
  if not self._bgSpine1Ske then
    return
  end
  local animList = {}
  for i = 1, #clickAni do
    local spineAnim = clickAni[i]
    table.insert(animList, spineAnim)
  end
  if #animList == 0 then
    return
  end
  local randomVal = math.random(#animList)
  local anim = animList[randomVal]
  local animationName = anim
  local entry = self._bgSpine1Ske.AnimationState:SetAnimation(0, animationName, false)
  self._spineLoader1.AnimationState.Data.DefaultMix = 0
  self._bgSpine1Ske:Update(0)
  if not entry then
    return
  end
  local anim = entry.Animation
  local duration = anim.Duration
  local yieldTime = math.floor(duration * 1000)
  if self._bgSpine1Event then
    GameGlobal.Timer():CancelEvent(self._bgSpine1Event)
    self._bgSpine1Event = nil
    self._playBgSpine1Anim = false
  end
  self._playBgSpine1Anim = true
  self._bgSpine1Event = GameGlobal.Timer():AddEvent(yieldTime, function()
    self._playBgSpine1Anim = false
    local animationName = "idle"
    self._bgSpine1Ske.AnimationState:SetAnimation(0, animationName, true)
    self._spineLoader1.AnimationState.Data.DefaultMix = 0
    self._bgSpine1Ske:Update(0)
  end)
end

function UIMainLobbyBg:PlaySpineAnim(skinid)
  if self._cgState == DynamicAndStaticState.Dynamic then
    if self._playSpineAnim then
      return
    end
    local cfg_pet_skin = Cfg.cfg_pet_skin[skinid]
    if not cfg_pet_skin then
      Log.error("###[UIMainLobbyFinal] cfg_pet_skin is nil ! id --> ", skinid)
      return
    end
    local spineAnims = cfg_pet_skin.MainLobbySpineAnim
    if not spineAnims then
      return
    end
    local animList = {}
    for i = 1, #spineAnims do
      local spineAnim = spineAnims[i]
      table.insert(animList, spineAnim)
    end
    if #animList == 0 then
      Log.error("###[UIMainLobbyFinal] animList is nil ! skinid --> ", skinid)
      return
    end
    local randomVal = math.random(#animList)
    local anim = animList[randomVal]
    local animationName = anim
    if not self._dcgHandle then
      Log.debug("###[UIMainLobbyFinal] self._dcgHandle is nil --> ", self._dynamicSpineSettings)
      return
    end
    local entry = self._dcgHandle:SetAnimationWithTrackEntryReturn(0, animationName, false)
    self._dcgHandle:SetAnimMixTime(0)
    self._dcgHandle:Update(0)
    if self._dcgHandle:GetCurDynamicCGType() == DynamicCGType.Spine or self._dcgHandle:GetCurDynamicCGType() == DynamicCGType.None then
      self:PlayClickAnimBackIdleBySpine(entry)
    elseif self._dcgHandle:GetCurDynamicCGType() == DynamicCGType.Live2D then
      self:PlayClickAnimBackIdleByLive2d(entry)
    end
  end
end

function UIMainLobbyBg:PlayClickAnimBackIdleBySpine(entry)
  if not entry then
    return
  end
  local anim = entry.Animation
  local duration = anim.Duration
  local yieldTime = math.floor(duration * 1000)
  if self._spineEvent then
    GameGlobal.Timer():CancelEvent(self._spineEvent)
    self._spineEvent = nil
    self._playSpineAnim = false
  end
  self._playSpineAnim = true
  self._spineEvent = GameGlobal.Timer():AddEvent(yieldTime, function()
    self._playSpineAnim = false
    local animationName = "idle"
    self._dcgHandle:SetAnimation(0, animationName, true)
    self._dcgHandle:SetAnimMixTime(0)
    self._dcgHandle:Update(0)
  end)
  Log.debug("###[UIMainLobbyFinal] spine 动画名字[", animationName, "] 动画时长[", duration, "]")
end

function UIMainLobbyBg:PlayClickAnimBackIdleByLive2d(anim)
  if anim then
    local duration = anim.length
    local yieldTime = math.floor(duration * 1000)
    if self._spineEvent then
      GameGlobal.Timer():CancelEvent(self._spineEvent)
      self._spineEvent = nil
      self._playSpineAnim = false
    end
    self._playSpineAnim = true
    self._spineEvent = GameGlobal.Timer():AddEvent(yieldTime, function()
      self._playSpineAnim = false
      local animationName = "idle"
      self._dcgHandle:SetAnimationWithTrackEntryReturn(0, animationName, true)
    end)
  end
end

function UIMainLobbyBg:SetAsActive(changeAsHide)
  if changeAsHide then
    local petid = self._roleModule:GetResId()
    self._assistantNull = false
    if petid and petid ~= 0 and petid == -1 then
      self._assistantNull = true
    end
    self._cgSpineGo:SetActive(not self._assistantNull)
    self._voiceGo:SetActive(not self._assistantNull)
  end
end

function UIMainLobbyBg:SetMainBg(type, id, anim, isSaveBtn, save, changeAsHide, spineIndex)
  if self._bgSpine1Event then
    GameGlobal.Timer():CancelEvent(self._bgSpine1Event)
    self._bgSpine1Event = nil
    self._playBgSpine1Anim = false
  end
  self:SetAsActive(changeAsHide)
  id = id and id or self._roleModule:UI_GetMainBgID()
  id = id == 0 and 1 or id
  if type == UIChooseAssistantBgType.Normal then
    local cfg = Cfg.cfg_main_bg[id]
    if not cfg then
      return
    end
    if cfg.Spine then
      self:ChangeBGSpine(cfg, type, anim, isSaveBtn, save)
    elseif cfg.BG then
      self:ChangePicBG(cfg, type, anim, isSaveBtn, save)
    end
  elseif type == UIChooseAssistantBgType.Story or type == UIChooseAssistantBgType.Skin or type == UIChooseAssistantBgType.Season then
    local cfg = Cfg.cfg_cg_book[id]
    if not cfg then
      return
    end
    if cfg.Type == UIChooseAssistantBgType.MultiSpineSkin then
      self:ChangeSpineBG(cfg, type, anim, isSaveBtn, save, spineIndex)
    elseif cfg.Spine then
      self:ChangeSpineBG(cfg, type, anim, isSaveBtn, save)
    elseif cfg.StaticPic then
      self:ChangeCGPicBG(cfg, type, anim, isSaveBtn, save)
    end
  end
  local currentMainBgID = self._roleModule:UI_GetMainBgID()
  local currentMainBgType = self._roleModule.m_choose_painting.background_type
  local currentMainBgID = currentMainBgID == 0 and 2 or currentMainBgID
  local currentMainBgType = currentMainBgType == 0 and 1 or currentMainBgType
  if id == currentMainBgID and type == currentMainBgType then
    self:SetBgRootPosAndScale(spineIndex)
  end
end

function UIMainLobbyBg:ChangePicBG(cfg, type, anim, isSaveBtn, save)
  self._spineLoaderObj1:SetActive(false)
  self._spineLoaderObj2:SetActive(false)
  self._bgRootObj:SetActive(true)
  local realWidth = ResolutionManager.RealWidth()
  local realHeight = ResolutionManager.RealHeight()
  local safeArea = Vector2(realWidth, realHeight)
  self._bg_posOffset = Vector2(0, 0)
  self._bg_scaleOffset = 1
  if isSaveBtn and save then
    self._currentMainBgType = type
    self._currentMainBgID = cfg.ID
    ChooseAssistantHelper.SaveAssistantBgSetting(self._deltaBgPos, self._deltaBgScale, type, cfg.ID, false, 1)
    self._bg_posOffset = self._deltaBgPos
    self._bg_scaleOffset = self._deltaBgScale
  end
  local size = Vector2(2539, 1439)
  if cfg.Size then
    size = Vector2(cfg.Size[1], cfg.Size[2])
  end
  local rate_x = 1
  local rate_y = 1
  if size.x * self._bg_scaleOffset < safeArea.x then
    rate_x = size.x * self._bg_scaleOffset / safeArea.x
  end
  if size.y * self._bg_scaleOffset < safeArea.y then
    rate_y = size.y * self._bg_scaleOffset / safeArea.y
  end
  if rate_x < 1 or rate_y < 1 then
    local changex = true
    if rate_x < rate_y then
      changex = true
    else
      changex = false
    end
    if changex then
      self._bg_scaleOffset = self._bg_scaleOffset / rate_x
    else
      self._bg_scaleOffset = self._bg_scaleOffset / rate_y
    end
  end
  self._deltaBgPos = self._bg_posOffset
  self._deltaBgScale = self._bg_scaleOffset
  self._bgRoot.anchoredPosition = self._bg_posOffset
  self._bgRoot.localScale = Vector3(self._bg_scaleOffset, self._bg_scaleOffset, self._bg_scaleOffset)
  self._bgRoot.sizeDelta = size
  if anim then
    self:Lock("UIMainLobbyFinal:SetMainBg")
    self._mainBg2:LoadImage(cfg.BG)
    self._mainBgAlpha1.alpha = 1
    self._mainBgAlpha2.alpha = 0
    self._mainBgAlpha1:DOFade(0, 0.25)
    self._mainBgAlpha2:DOFade(1, 0.25):OnComplete(function()
      self._mainBg:LoadImage(cfg.BG)
      self._mainBgAlpha1.alpha = 1
      self._mainBgAlpha2.alpha = 0
      self:UnLock("UIMainLobbyFinal:SetMainBg")
    end)
  else
    self._mainBg:LoadImage(cfg.BG)
    self._mainBgAlpha1.alpha = 1
    self._mainBgAlpha2.alpha = 0
  end
end

function UIMainLobbyBg:ChangeBGSpine(cfg, type, anim, isSaveBtn, save)
  local realWidth = ResolutionManager.RealWidth()
  local realHeight = ResolutionManager.RealHeight()
  local safeArea = Vector2(realWidth, realHeight)
  self._spineLoaderObj1:SetActive(true)
  self._bgRootObj:SetActive(false)
  self._bg_posOffset = Vector2(0, 0)
  self._bg_scaleOffset = 1
  self._currentMainBgType = type
  self._currentMainBgID = cfg.ID
  if isSaveBtn and save then
    self._bg_posOffset = self._deltaBgPos
    self._bg_scaleOffset = self._deltaBgScale
    ChooseAssistantHelper.SaveAssistantBgSetting(self._deltaBgPos, self._deltaBgScale, type, cfg.ID, false, 1)
  end
  local size = Vector2(2539, 1439)
  if cfg.Size then
    size = Vector2(cfg.Size[1], cfg.Size[2])
  end
  local rate_x = 1
  local rate_y = 1
  if size.x * self._bg_scaleOffset < safeArea.x then
    rate_x = size.x * self._bg_scaleOffset / safeArea.x
  end
  if size.y * self._bg_scaleOffset < safeArea.y then
    rate_y = size.y * self._bg_scaleOffset / safeArea.y
  end
  if rate_x < 1 or rate_y < 1 then
    local changex = true
    if rate_x < rate_y then
      changex = true
    else
      changex = false
    end
    if changex then
      self._bg_scaleOffset = self._bg_scaleOffset / rate_x
    else
      self._bg_scaleOffset = self._bg_scaleOffset / rate_y
    end
  end
  self._spineBgRoot.anchoredPosition = self._bg_posOffset
  self._spineBgRoot.localScale = Vector3(self._bg_scaleOffset, self._bg_scaleOffset, self._bg_scaleOffset)
  self._deltaBgPos = self._bg_posOffset
  self._deltaBgScale = self._bg_scaleOffset
  if 1 < table.count(cfg.Spine) then
    self._spineLoaderObj2:SetActive(true)
    self._spineLoader2:LoadSpine(cfg.Spine[2])
  end
  self._spineLoader1:LoadSpine(cfg.Spine[1])
end

function UIMainLobbyBg:ChangeCGPicBG(cfg, type, anim, isSaveBtn, save)
  self._spineLoaderObj1:SetActive(false)
  self._spineLoaderObj2:SetActive(false)
  self._bgRootObj:SetActive(true)
  local realWidth = ResolutionManager.RealWidth()
  local realHeight = ResolutionManager.RealHeight()
  local safeArea = Vector2(realWidth, realHeight)
  self._bg_posOffset = Vector2(0, 0)
  self._bg_scaleOffset = 1
  if isSaveBtn and save then
    self._currentMainBgType = type
    self._currentMainBgID = cfg.ID
    self._bg_posOffset = self._deltaBgPos
    self._bg_scaleOffset = self._deltaBgScale
    ChooseAssistantHelper.SaveAssistantBgSetting(self._deltaBgPos, self._deltaBgScale, type, cfg.ID, false, 1)
  end
  local size = Vector2(2539, 1439)
  if cfg.Size then
    size = Vector2(cfg.Size[1], cfg.Size[2])
  end
  local rate_x = 1
  local rate_y = 1
  if size.x * self._bg_scaleOffset < safeArea.x then
    rate_x = size.x * self._bg_scaleOffset / safeArea.x
  end
  if size.y * self._bg_scaleOffset < safeArea.y then
    rate_y = size.y * self._bg_scaleOffset / safeArea.y
  end
  if rate_x < 1 or rate_y < 1 then
    local changex = true
    if rate_x < rate_y then
      changex = true
    else
      changex = false
    end
    if changex then
      self._bg_scaleOffset = self._bg_scaleOffset / rate_x
    else
      self._bg_scaleOffset = self._bg_scaleOffset / rate_y
    end
  end
  self._deltaBgPos = self._bg_posOffset
  self._deltaBgScale = self._bg_scaleOffset
  self._bgRoot.anchoredPosition = self._bg_posOffset
  self._bgRoot.localScale = Vector3(self._bg_scaleOffset, self._bg_scaleOffset, self._bg_scaleOffset)
  self._bgRoot.sizeDelta = size
  if anim then
    self:Lock("UIMainLobbyFinal:SetMainBg")
    self._mainBg2:LoadImage(cfg.StaticPic)
    self._mainBgAlpha1.alpha = 1
    self._mainBgAlpha2.alpha = 0
    self._mainBgAlpha1:DOFade(0, 0.25)
    self._mainBgAlpha2:DOFade(1, 0.25):OnComplete(function()
      self._mainBg:LoadImage(cfg.StaticPic)
      self._mainBgAlpha1.alpha = 1
      self._mainBgAlpha2.alpha = 0
      self:UnLock("UIMainLobbyFinal:SetMainBg")
    end)
  else
    self._mainBg:LoadImage(cfg.StaticPic)
    self._mainBgAlpha1.alpha = 1
    self._mainBgAlpha2.alpha = 0
  end
end

function UIMainLobbyBg:ChangeSpineBG(cfg, type, anim, isSaveBtn, save, spineIndex)
  local realWidth = ResolutionManager.RealWidth()
  local realHeight = ResolutionManager.RealHeight()
  local safeArea = Vector2(realWidth, realHeight)
  self._spineLoaderObj1:SetActive(true)
  self._bgRootObj:SetActive(false)
  self._bg_posOffset = Vector2(0, 0)
  self._bg_scaleOffset = 1
  self._currentMainBgType = type
  self._currentMainBgID = cfg.ID
  local handle_operate = false
  local spineId = 1
  if cfg.Type == UIChooseAssistantBgType.MultiSpineSkin and spineIndex then
    handle_operate = spineIndex ~= #cfg.Spine
    spineId = spineIndex
  end
  self.handle_operate = handle_operate
  self.handle_operate_spine_index = spineId
  if isSaveBtn and save then
    self._bg_posOffset = self._deltaBgPos
    self._bg_scaleOffset = self._deltaBgScale
    ChooseAssistantHelper.SaveAssistantBgSetting(self._deltaBgPos, self._deltaBgScale, type, cfg.ID, handle_operate, spineId)
  end
  local size = Vector2(2539, 1439)
  if cfg.Size then
    size = Vector2(cfg.Size[1], cfg.Size[2])
  end
  local rate_x = 1
  local rate_y = 1
  if size.x * self._bg_scaleOffset < safeArea.x then
    rate_x = size.x * self._bg_scaleOffset / safeArea.x
  end
  if size.y * self._bg_scaleOffset < safeArea.y then
    rate_y = size.y * self._bg_scaleOffset / safeArea.y
  end
  if rate_x < 1 or rate_y < 1 then
    local changex = true
    if rate_x < rate_y then
      changex = true
    else
      changex = false
    end
    if changex then
      self._bg_scaleOffset = self._bg_scaleOffset / rate_x
    else
      self._bg_scaleOffset = self._bg_scaleOffset / rate_y
    end
  end
  self._spineBgRoot.anchoredPosition = self._bg_posOffset
  self._spineBgRoot.localScale = Vector3(self._bg_scaleOffset, self._bg_scaleOffset, self._bg_scaleOffset)
  self._deltaBgPos = self._bg_posOffset
  self._deltaBgScale = self._bg_scaleOffset
  self.isMultiSpineSkin = nil
  if cfg.Type == UIChooseAssistantBgType.MultiSpineSkin and spineIndex then
    self._spineLoader1:LoadSpine(cfg.Spine[spineIndex])
    self.isMultiSpineSkin = true
    self.multiSpineName = cfg.Spine[spineIndex]
  else
    if 1 < table.count(cfg.Spine) then
      self._spineLoaderObj2:SetActive(true)
      self._spineLoader2:LoadSpine(cfg.Spine[2])
    end
    self._spineLoader1:LoadSpine(cfg.Spine[1])
  end
end

function UIMainLobbyBg:SaveCancelChangeCgRoot(type, state, id, bgType, preDressIndex)
  if type == UIChooseAssistantType.Bg2MainLobby or type == UIChooseAssistantType.Cg2MainLobby then
    if state == UIChooseAssistantState.Save then
      local dressIndex = self._signInModule:GetMainDressUpCurIndex()
      local dressInfos = self._signInModule:GetDressInfos()
      if type == UIChooseAssistantType.Bg2MainLobby and preDressIndex ~= nil then
        dressIndex = preDressIndex
      end
      self:SetIndexDress(dressIndex, dressInfos)
      self._currentMainBgID = id and id or self._currentMainBgID
      self._currentMainBgType = bgType and bgType or self._currentMainBgType
      ChooseAssistantHelper.SaveAssistantPetSetting(self._deltaPos, self._deltaScale)
      ChooseAssistantHelper.SaveAssistantBgSetting(self._deltaBgPos, self._deltaBgScale, self._currentMainBgType, self._currentMainBgID, self.handle_operate or false, self.handle_operate_spine_index or 1)
    elseif state == UIChooseAssistantState.Cancel then
      if type == UIChooseAssistantType.Cg2MainLobby then
        Log.debug("###[UIMainLobbyFinal] cgroot cancel change !")
        local dressIndex = self._signInModule:GetMainDressUpCurIndex()
        local dressInfos = self._signInModule:GetDressInfos()
        self:SetIndexDress(dressIndex, dressInfos)
        self:SetRootPosAndScale()
        self:SetBgRootPosAndScale()
        local open_id = GameGlobal.GameLogic():GetOpenId()
      elseif type == UIChooseAssistantType.Bg2MainLobby then
        Log.debug("###[UIMainLobbyFinal] cgroot cancel change !")
        local dressIndex = self._signInModule:GetMainDressUpCurIndex()
        local dressInfos = self._signInModule:GetDressInfos()
        if preDressIndex ~= nil then
          dressIndex = preDressIndex
        end
        self:SetIndexDress(dressIndex, dressInfos)
        self:SetRootPosAndScale()
        self:SetBgRootPosAndScale()
        local open_id = GameGlobal.GameLogic():GetOpenId()
      end
    elseif state == UIChooseAssistantState.Default then
      self:_ChangeCgRootToDefault(type)
    end
  end
end

function UIMainLobbyBg:_ChangeCgRootToDefault(type)
  if type == UIChooseAssistantType.Cg2MainLobby then
    self._deltaPos = Vector2(0, 0)
    self._deltaScale = 1
    self._changePetPosAndScaleRoot.anchoredPosition = self._deltaPos
    self._changePetPosAndScaleRoot.localScale = Vector3(self._deltaScale, self._deltaScale, self._deltaScale)
  elseif type == UIChooseAssistantType.Bg2MainLobby then
    self._deltaBgPos = Vector2(0, 0)
    self._deltaBgScale = 1
    local mainController = GameGlobal.UIStateManager():GetController("UIMainLobbyController")
    local bgStartPos, bgStartScale = Vector2(0, 0), 1
    local bgSize = ChooseAssistantHelper.GetAssistantBgSize(self._currentMainBgType, self._currentMainBgID)
    if mainController then
      bgStartPos, bgStartScale = mainController:GetBgSetting()
    end
    local realWidth = ResolutionManager.RealWidth()
    local realHeight = ResolutionManager.RealHeight()
    local rate_x = 1
    local rate_y = 1
    if realWidth > bgSize.x * bgStartScale then
      rate_x = bgSize.x * bgStartScale / realWidth
    end
    if realHeight > bgSize.y * bgStartScale then
      rate_y = bgSize.y * bgStartScale / realHeight
    end
    if rate_x < 1 or rate_y < 1 then
      local changex = true
      if rate_x < rate_y then
        changex = true
      else
        changex = false
      end
      if changex then
        bgStartScale = bgStartScale / rate_x
      else
        bgStartScale = bgStartScale / rate_y
      end
    end
    self._deltaBgPos = bgStartPos
    self._deltaBgScale = bgStartScale
    self._bgRoot.anchoredPosition = self._deltaBgPos
    self._spineBgRoot.anchoredPosition = self._deltaBgPos
    self._bgRoot.localScale = Vector3(self._deltaBgScale, self._deltaBgScale, self._deltaBgScale)
    self._spineBgRoot.localScale = Vector3(self._deltaBgScale, self._deltaBgScale, self._deltaBgScale)
  end
end

function UIMainLobbyBg:OnMainLobbyHideAssistant(hideAs)
  self._cgSpineGo:SetActive(not hideAs)
  self._voiceGo:SetActive(not hideAs)
end

function UIMainLobbyBg:SetRootPosAndScale()
  local posOffset, scaleOffset = ChooseAssistantHelper.GetAssistantPetSetting()
  self._changePetPosAndScaleRoot.anchoredPosition = posOffset
  self._changePetPosAndScaleRoot.localScale = Vector3(scaleOffset, scaleOffset, scaleOffset)
  self._deltaPos = posOffset
  self._deltaScale = scaleOffset
end

function UIMainLobbyBg:SetBgRootPosAndScale(spineIndex)
  self._bg_posOffset = Vector2(0, 0)
  self._bg_scaleOffset = 1
  self._currentMainBgID = self._roleModule:UI_GetMainBgID()
  self._currentMainBgType = self._roleModule.m_choose_painting.background_type
  self._current_is_hand_operate = self._roleModule.m_choose_painting.is_hand_operate
  self._current_hand_spine_index = self._roleModule.m_choose_painting.spine_id
  Log.debug("[FX] self._current_hand_spine_index ", self._current_hand_spine_index)
  self._currentMainBgID = self._currentMainBgID == 0 and 2 or self._currentMainBgID
  self._currentMainBgType = self._currentMainBgType == 0 and 1 or self._currentMainBgType
  self._current_hand_spine_index = self._current_hand_spine_index == 0 and 1 or self._current_hand_spine_index
  local size = Vector2(2539, 1439)
  local realWidth = ResolutionManager.RealWidth()
  local realHeight = ResolutionManager.RealHeight()
  local safeArea = Vector2(realWidth, realHeight)
  self.isMultiSpineSkin = nil
  if self._currentMainBgType == UIChooseAssistantBgType.Normal then
    local cfg = Cfg.cfg_main_bg[self._currentMainBgID]
    if not cfg then
      self._currentMainBgID = 1
      cfg = Cfg.cfg_main_bg[self._currentMainBgID]
    end
    if cfg.Size then
      size = Vector2(cfg.Size[1], cfg.Size[2])
    end
    if cfg.Spine then
      self._spineLoaderObj1:SetActive(true)
      self._bgRootObj:SetActive(false)
      if 1 < table.count(cfg.Spine) then
        self._spineLoaderObj2:SetActive(true)
        self._spineLoader2:LoadSpine(cfg.Spine[2])
      end
      self._spineLoader1:LoadSpine(cfg.Spine[1])
    elseif cfg.BG then
      self._spineLoaderObj1:SetActive(false)
      self._spineLoaderObj2:SetActive(false)
      self._bgRootObj:SetActive(true)
      self._mainBg:LoadImage(cfg.BG)
    end
  elseif self._currentMainBgType == UIChooseAssistantBgType.Skin or self._currentMainBgType == UIChooseAssistantBgType.Story or self._currentMainBgType == UIChooseAssistantBgType.Season then
    local cfg = Cfg.cfg_cg_book[self._currentMainBgID]
    if not cfg then
      return
    end
    if cfg.Size then
      size = Vector2(cfg.Size[1], cfg.Size[2])
    end
    if cfg.Type == UIChooseAssistantBgType.MultiSpineSkin then
      self._spineLoaderObj1:SetActive(true)
      self._bgRootObj:SetActive(false)
      local sIndex = spineIndex
      sIndex = sIndex or self._current_hand_spine_index
      self._spineLoader1:LoadSpine(cfg.Spine[sIndex])
      self.isMultiSpineSkin = true
      self.multiSpineName = cfg.Spine[sIndex]
    elseif cfg.Spine then
      self._spineLoaderObj1:SetActive(true)
      self._bgRootObj:SetActive(false)
      if 1 < table.count(cfg.Spine) then
        self._spineLoaderObj2:SetActive(true)
        self._spineLoader2:LoadSpine(cfg.Spine[2])
      end
      self._spineLoader1:LoadSpine(cfg.Spine[1])
    elseif cfg.StaticPic then
      self._spineLoaderObj1:SetActive(false)
      self._spineLoaderObj2:SetActive(false)
      self._bgRootObj:SetActive(true)
      self._mainBg:LoadImage(cfg.StaticPic)
    end
  end
  self._bg_posOffset, self._bg_scaleOffset = ChooseAssistantHelper.GetAssistantBgSetting(self._currentMainBgType, self._currentMainBgID)
  local rate_x = 1
  local rate_y = 1
  if self._bg_scaleOffset == nil or self._bg_scaleOffset == nil then
    Log.debug("[FX] _bg_scaleOffset", self._bg_scaleOffset)
    self._bg_scaleOffset = 1
  end
  if size.x * self._bg_scaleOffset < safeArea.x then
    rate_x = size.x * self._bg_scaleOffset / safeArea.x
  end
  if size.y * self._bg_scaleOffset < safeArea.y then
    rate_y = size.y * self._bg_scaleOffset / safeArea.y
  end
  if rate_x < 1 or rate_y < 1 then
    local changex = true
    if rate_x < rate_y then
      changex = true
    else
      changex = false
    end
    if changex then
      self._bg_scaleOffset = self._bg_scaleOffset / rate_x
    else
      self._bg_scaleOffset = self._bg_scaleOffset / rate_y
    end
  end
  self._bgRoot.anchoredPosition = self._bg_posOffset
  self._bgRoot.localScale = Vector3(self._bg_scaleOffset, self._bg_scaleOffset, self._bg_scaleOffset)
  self._spineBgRoot.anchoredPosition = self._bg_posOffset
  self._spineBgRoot.localScale = Vector3(self._bg_scaleOffset, self._bg_scaleOffset, self._bg_scaleOffset)
  self._deltaBgPos = self._bg_posOffset
  self._deltaBgScale = self._bg_scaleOffset
  self._bgRoot.sizeDelta = size
end

function UIMainLobbyBg:WelcomeAudio()
  self:StartTask(function(TT)
    YIELD(TT)
    self:PlayPetAudio("MainLobbyWelcome")
  end)
end

function UIMainLobbyBg:ShowCurrentAssistant()
  local petid = self._roleModule:GetResId()
  local old_pet_id = self._defaultPetID
  self._assistantNull = false
  self._defaultPetID = 0
  local grade, skin, asid
  if petid and petid ~= 0 then
    self._defaultPetID = petid
    if petid == -1 then
      self._assistantNull = true
    end
    grade = self._roleModule.m_choose_painting.pet_grade
    skin = self._roleModule.m_choose_painting.skin_id
    if skin == -1 then
      skin = 0
    end
    if skin ~= 0 and not GameGlobal.GetModule(PetModule):HaveSkin(skin) then
      Log.error("背包中没有皮肤，恢复默认皮肤")
      skin = 0
    end
    asid = self._roleModule.m_choose_painting.board_pet
    if asid == 3400050 then
      asid = 10015
    end
  else
    self._defaultPetID = Cfg.cfg_global.main_default_spine_pet_id.IntValue
    grade = 0
    skin = 0
    asid = 0
  end
  self._assistantGrade = grade
  self._assistantSkinID = skin
  self._assistantAsID = asid
  self._cgSpineGo:SetActive(not self._assistantNull)
  self._voiceGo:SetActive(not self._assistantNull)
  self:SetPetLocalValueByServer()
  if self._assistantNull then
    return
  end
  if old_pet_id ~= self._defaultPetID then
    local playPetID
    if old_pet_id and old_pet_id ~= 0 then
      playPetID = old_pet_id
    else
      playPetID = self._defaultPetID
    end
    if not self._dragShow then
      self:PlayPetAudio("MainLobbyInteract")
    end
  end
  local petModule = self:GetModule(PetModule)
  local cfg_pet
  if 0 < grade then
    cfg_pet = Cfg.cfg_pet_grade({
      PetID = self._defaultPetID,
      Grade = grade
    })[1]
  else
    cfg_pet = Cfg.cfg_pet[self._defaultPetID]
  end
  local hideStaticBtn = false
  self._dynamicSpineAnim = nil
  if cfg_pet then
    if asid and asid ~= 0 then
      local cfg_as = Cfg.cfg_only_assistant[asid]
      if cfg_as then
        self._dynamicSpineAnim = cfg_as.SpineAnim
      end
    else
      self._enterSpineName = HelperProxy:GetInstance():GetMainLobbyEnterSpine(self._defaultPetID, grade, skin, PetSkinEffectPath.NO_EFFECT)
      Log.debug("[lobbyspine] _enterSpineName ", self._enterSpineName)
      self._enterSpineSubGoName = HelperProxy:GetInstance():GetMainLobbyEnterSpineSubGo(self._defaultPetID, grade, skin, PetSkinEffectPath.NO_EFFECT)
    end
  end
  self._staticSpineSettings, self._dynamicSpineSettings = ChooseAssistantHelper.GetSpineSettings()
  if hideStaticBtn then
    self._cgState = DynamicAndStaticState.Dynamic
    self:ChangeDynamicAndStatic(self._cgState)
  else
    local flagValue = self._roleModule:GetExtFlag(CharExtFlag.CEFT_MAIN_UI_SHOW_SPINE)
    if flagValue then
      self._cgState = DynamicAndStaticState.Static
    else
      self._cgState = DynamicAndStaticState.Dynamic
    end
    self:ChangeDynamicAndStatic(self._cgState)
  end
end

function UIMainLobbyBg:OnAssistantChanged(resetPos)
  if self._spineEvent then
    GameGlobal.Timer():CancelEvent(self._spineEvent)
    self._spineEvent = nil
    self._playSpineAnim = false
  end
  if resetPos then
    ChooseAssistantHelper.SaveAssistantPetSetting(Vector2(0, 0), 1)
  end
  self:SetRootPosAndScale()
  self._spineLoaded = false
  self._cgLoaded = false
  if self._enterDcgHandle then
    self._enterDcgHandle:DestroyCurrentCG()
    self._enterDcgHandle = nil
  end
  self:ShowCurrentAssistant()
  self._audioPlayID = self:PlayPetAudio("Appointment")
  if self._audioPlayID == nil then
    return
  end
  self._voiceAnim:Play("uieff_mainlobby_voice")
  local cfg_audio = AudioHelperController.GetCfgAudio(self._audioPlayID)
  if cfg_audio then
    self._voiceTex:SetText(HelperProxy:GetInstance():ReplacePlayerName(StringTable.Get(cfg_audio.Content)))
    self._voiceTex2:SetText(HelperProxy:GetInstance():ReplacePlayerName(StringTable.Get(cfg_audio.Content)))
  end
end

function UIMainLobbyBg:ChangeDynamicAndStatic(state)
  self._staticSpineSettings, self._dynamicSpineSettings = ChooseAssistantHelper.GetSpineSettings()
  if state == DynamicAndStaticState.Dynamic then
    if not self._spineLoaded then
      if not self._dcgHandle then
        self._dcgHandle = DynamicCG.SyncLoad(self._dynamicSpineSettings, self._spine)
      else
        self._dcgHandle:ChangeDynamicCGSync(self._dynamicSpineSettings)
      end
      if self._enterSpineName ~= nil then
        if not self._enterDcgHandle then
          self._enterDcgHandle = DynamicCG.SyncLoad(self._enterSpineName, self._enterSpine)
        else
          self._enterDcgHandle:ChangeDynamicCGSync(self._enterSpineName)
        end
      end
      local uicg = true
      if self._assistantSkinID and self._assistantSkinID > 0 then
        local cfg = Cfg.cfg_pet_skin[self._assistantSkinID]
        if cfg then
          local mainSize = cfg.MainLobbySize
          if mainSize then
            uicg = false
          end
        end
      end
      if uicg then
        UICG.SetTransform(self._spineGo.transform, self.uiOwner:GetName(), self._dynamicSpineSettings)
      else
        self._spineGo.transform.localPosition = Vector3(0, 0, 0)
        self._spineGo.transform.localScale = Vector3(1, 1, 1)
      end
      self._spineLoaded = true
    end
    if self._dynamicSpineAnim then
      local function tryFunc()
        self._dcgHandle:InitializeSpine()
        
        self._dcgHandle:SetAnimation(0, self._dynamicSpineAnim, true)
        self._dcgHandle:SetAnimMixTime(0)
        self._dcgHandle:Update(0)
      end
      
      local succ = pcall(tryFunc)
      if not succ then
        Log.error("###[UIMainLobbyFinal] set _dynamicSpineAnim fail ! spine:", self._dynamicSpineSettings, ",anim:", self._dynamicSpineAnim)
      end
    end
    self._spineGo:SetActive(true)
    self._cgGo:SetActive(false)
    self:ShowLobbyEnterSpine()
  else
    if not self._cgLoaded then
      local size = Cfg.cfg_global.ui_interface_common_size.ArrayValue
      self._cgGo:GetComponent("RectTransform").sizeDelta = Vector2(size[1], size[2])
      self._cg:LoadImage(self._staticSpineSettings)
      local uicg = true
      local mainSize
      if self._assistantSkinID and self._assistantSkinID > 0 then
        local cfg = Cfg.cfg_pet_skin[self._assistantSkinID]
        if cfg then
          mainSize = cfg.MainLobbySize
          if mainSize then
            uicg = false
          end
        end
      end
      local cgRect = self._cgGo:GetComponent(typeof(UnityEngine.RectTransform))
      if uicg then
        local size = Vector2(2048, 2048)
        cgRect.sizeDelta = size
        UICG.SetTransform(self._cgGo.transform, self.uiOwner:GetName(), self._staticSpineSettings)
      else
        local setSize
        if not mainSize then
          setSize = Vector2(2539, 1439)
        else
          setSize = Vector2(mainSize[1], mainSize[2])
        end
        cgRect.sizeDelta = setSize
        cgRect.anchoredPosition = Vector2(0, 0)
        cgRect.localScale = Vector3(1, 1, 1)
      end
      self._cgLoaded = true
    end
    self._enterSpineGo:SetActive(false)
    self._enterSpineSubGo:SetActive(false)
    self._cgGo:SetActive(true)
    self._spineGo:SetActive(false)
  end
end

function UIMainLobbyBg:PlayNoLoopSpineWithCallBack(dcgHandle, spinename, spineAnim, func)
  local entry
  
  local function playAniSpineFunc()
    dcgHandle:InitializeSpine()
    entry = dcgHandle:SetAnimationWithTrackEntryReturn(0, spineAnim, false)
    dcgHandle:SetAnimMixTime(0)
    dcgHandle:Update(0)
  end
  
  local succ = pcall(playAniSpineFunc)
  if not succ then
    Log.error("###[UIMainLobbyControllerOld] set spine anim fail ! spine[", spinename, "] anim[", spineAnim, "]")
    return
  end
  if not entry then
    Log.error("###[UIMainLobbyControllerOld] entry is nil ! spine[", spinename, "] anim[", spineAnim, "]")
    return
  end
  local anim = entry.Animation
  local duration = anim.Duration
  local yieldTime = math.floor(duration * 1000)
  if self._spineEvent then
    GameGlobal.Timer():CancelEvent(self._spineEvent)
    self._spineEvent = nil
  end
  self._spineEvent = GameGlobal.Timer():AddEvent(yieldTime, func)
end

function UIMainLobbyBg:ShowLobbyEnterSpine()
  self._enterSpineGo:SetActive(false)
  self._enterSpineSubGo:SetActive(false)
  if not self._dcgHandle then
    Log.debug("###[UIMainLobbyControllerOld] self._dcgHandle is nill --> ", self._dynamicSpineSettings)
    return
  end
  self._enterSpineSke = nil
  if self._enterSpineName ~= nil and not self._enterDcgHandle then
    Log.debug("###[UIMainLobbyControllerOld] self._enterDcgHandle is nil --> ", self._enterSpineName)
    return
  end
  local skinid = self._assistantSkinID
  if skinid == 0 or skinid == nil then
    return
  end
  local skin_cfg = Cfg.cfg_pet_skin[skinid]
  if skin_cfg == nil then
    return
  end
  local spineAnim = skin_cfg.EnterAnim
  if spineAnim == nil then
    return
  end
  self._playSpineAnim = true
  
  local function loopSpinePlayFunc()
    self._playSpineAnim = false
    local animationName = "idle"
    self._dcgHandle:SetAnimation(0, animationName, true)
  end
  
  local dynamicSpineSettings = self._dynamicSpineSettings
  
  local function idleSpinePlayFunc()
    self._enterSpineGo:SetActive(false)
    self:_DelayHideEnterSpineSubGo()
    if dynamicSpineSettings == self._dynamicSpineSettings then
      self:PlayNoLoopSpineWithCallBack(self._dcgHandle, self._dynamicSpineSettings, spineAnim, loopSpinePlayFunc)
    end
  end
  
  if self._enterDcgHandle ~= nil then
    self._enterSpineGo:SetActive(true)
    self._enterSpineGoShowFinish = false
    self:PlayNoLoopSpineWithCallBack(self._enterDcgHandle, self._enterSpineName, spineAnim, idleSpinePlayFunc)
    self._dcgHandle:SetStartAnimation(spineAnim)
    local bShowSubGo = self._enterSpineSubGoName ~= nil
    if bShowSubGo and self._enterSpineSubGoGen then
      if self._enterSpineSubGoName ~= self._oldEnterSpineSubGoName and self._oldEnterSpineSubGoName ~= nil then
        self._enterSpineSubGoGen:ClearWidgets()
      end
      self._enterSpineSubGoGen.dynamicInfoOfEngine:SetObjectName(self._enterSpineSubGoName)
      self._enterSpineSubGoGen:SpawnObject("UIMainLobbyEnterSpineSubGo")
      self._oldEnterSpineSubGoName = self._enterSpineSubGoName
    end
    self._enterSpineSubGo:SetActive(bShowSubGo)
  else
    idleSpinePlayFunc()
  end
end

function UIMainLobbyBg:_DelayHideEnterSpineSubGo()
  if self._enterSpineSubGoCloseEvent then
    GameGlobal.Timer():CancelEvent(self._enterSpineSubGoCloseEvent)
    self._enterSpineSubGoCloseEvent = nil
  end
  self._enterSpineSubGoCloseEvent = GameGlobal.Timer():AddEvent(1000, function()
    self._enterSpineSubGo:SetActive(false)
  end)
  self._enterSpineGoShowFinish = true
end

function UIMainLobbyBg:OnShowChangeMainCg(type, isShowPet)
  if type == UIPetAndBgMoveType.None then
    self._cgSpineGo.transform.parent.gameObject:SetActive(true)
  elseif type == UIPetAndBgMoveType.Pet then
    self._cgSpineGo.transform.parent.gameObject:SetActive(true)
  elseif type == UIPetAndBgMoveType.Bg and not isShowPet then
    self._cgSpineGo.transform.parent.gameObject:SetActive(false)
  end
end

function UIMainLobbyBg:ClosePetAudio(normalClose)
  if self._audioPlayID == nil then
    return
  end
  if normalClose then
    self:OnAudioEndPlay()
  else
    self._voiceCanvasGroup.alpha = 0
    if self._audioPlayID then
      self._audioPlayID = nil
    end
  end
end

function UIMainLobbyBg:OnAudioEndPlay()
  if self._audioPlayID then
    self._voiceAnim:Play("uieff_mainlobby_voicefade")
    self._audioPlayID = nil
  end
end

function UIMainLobbyBg:StaticAndDynamicOnClick(state)
  self._cgState = state
  if self._spineEvent then
    GameGlobal.Timer():CancelEvent(self._spineEvent)
    self._spineEvent = nil
    self._playSpineAnim = false
  end
  self:ChangeDynamicAndStatic(self._cgState)
end

function UIMainLobbyBg:OnUpdate(deltaTimeMS)
  if not self._assistantNull then
    local cc = UnityEngine.Input.GetMouseButtonDown(0) or UnityEngine.Input.GetMouseButton(0) or UnityEngine.Input.GetMouseButtonUp(0) or not GameGlobal.UIStateManager():IsTopUI(self.uiOwner:GetName())
    if cc == true then
      self._freeTime = 0
    elseif self._freeTime then
      self._freeTime = self._freeTime + deltaTimeMS
    else
      self._freeTime = 0
    end
    if self._freeTime and self._maxFreeTime and self._freeTime > self._maxFreeTime then
      self:PlayPetAudio("Leisure")
      self._freeTime = 0
    end
  end
end

function UIMainLobbyBg:PlayPetAudio(filed, click)
  local voiceSkinID
  if self._assistantAsID and self._assistantAsID ~= 0 then
    voiceSkinID = nil
  elseif self._assistantSkinID == 0 then
    if self._assistantGrade == 0 then
      local gradeCfg = Cfg.cfg_pet[self._defaultPetID]
      if not gradeCfg then
        Log.fatal("###[UIMainLobbyFinal] pet cfg is nil ! id --> ", self._defaultPetID, "| grade --> ", self._assistantGrade)
        return
      end
      voiceSkinID = gradeCfg.SkinId
    else
      local gradeCfg = Cfg.cfg_pet_grade({
        PetID = self._defaultPetID,
        Grade = self._assistantGrade
      })[1]
      if not gradeCfg then
        Log.fatal("###[UIMainLobbyFinal] grade cfg is nil ! id --> ", self._defaultPetID, "| grade --> ", self._assistantGrade)
        return
      end
      voiceSkinID = gradeCfg.SkinId
    end
  else
    voiceSkinID = self._assistantSkinID
  end
  if filed == "MainLobbyWelcome" and self._roleModule:TodayIsFirstLogin() then
    self._audioPlayID = self._petAudioModule:PlayPetAudio("FirstMainLobbyWelcome", self._defaultPetID, false, false, voiceSkinID)
    if self._audioPlayID == nil then
      self._audioPlayID = self._petAudioModule:PlayPetAudio(filed, self._defaultPetID, false, false, voiceSkinID)
    end
  else
    self._audioPlayID = self._petAudioModule:PlayPetAudio(filed, self._defaultPetID, false, false, voiceSkinID, click)
  end
  if self._audioPlayID == nil then
    return
  end
  self._voiceAnim:Play("uieff_mainlobby_voice")
  local cfg_audio = AudioHelperController.GetCfgAudio(self._audioPlayID)
  if cfg_audio then
    self._voiceTex:SetText(HelperProxy:GetInstance():ReplacePlayerName(StringTable.Get(cfg_audio.Content)))
    self._voiceTex2:SetText(HelperProxy:GetInstance():ReplacePlayerName(StringTable.Get(cfg_audio.Content)))
  end
end

function UIMainLobbyBg:SetPetLocalValueByServer()
  local open_id = GameGlobal.GameLogic():GetOpenId()
  local key = "MAIN_BG_AS_ACTIVE" .. open_id
  local localValue = LocalDB.GetInt(key)
  local localPetNull = localValue == 1
  if self._assistantNull ~= localPetNull then
    local changeValue = self._assistantNull and 1 or 0
    LocalDB.SetInt(key, changeValue)
  end
end

function UIMainLobbyBg:SetVoiceCanvasGroup(value)
  if self._voiceRootCanvasGroup then
    self._voiceRootCanvasGroup.alpha = value
  end
end
