_class("UIPlayerInfoBg", UICustomWidget)
UIPlayerInfoBg = UIPlayerInfoBg

function UIPlayerInfoBg:OnShow()
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
  self._cgGo = self:GetGameObject("cg")
  self._cg = self:GetUIComponent("RawImageLoader", "cg")
  self:AttachEvent(GameEventType.OnMainCgChangeSave, self.SaveCancelChangeCgRoot)
  self:AttachEvent(GameEventType.OnMainLobbyHideAssistant, self.OnMainLobbyHideAssistant)
  self._cgSpineGo = self:GetGameObject("posAndScale")
  self._spineGo = self:GetGameObject("spine")
  self._spine = self:GetUIComponent("SpineLoader", "spine")
  self._voiceTex = self:GetUIComponent("UILocalizationText", "voiceTex")
  self._voiceCanvasGroup = self:GetUIComponent("CanvasGroup", "VOICE")
  self:AttachEvent(GameEventType.ChangeMainBg, self.SetMainBg)
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
end

function UIPlayerInfoBg:OnHide()
  if self._defaultPetID and self._defaultPetID ~= 0 then
    self._petAudioModule:ReleaseAdx2VoiceCueSheetByAnyAudioId("MainLobbyInteract", self._defaultPetID)
  end
  if self._spineEvent then
    GameGlobal.Timer():CancelEvent(self._spineEvent)
    self._spineEvent = nil
  end
end

function UIPlayerInfoBg:SetData(isFriendMode, friendData, BGWidth)
  if self._playWelcome == true then
  end
  self.isFriendMode = isFriendMode
  self.friendData = friendData
  if self.isFriendMode and self.friendData == nil then
    return
  end
  self:ShowCurrentAssistant()
  self:SetBgRootPosAndScale(BGWidth)
  self:SetRootPosAndScale()
end

function UIPlayerInfoBg:GetBgIDAndType()
  return self._currentMainBgID, self._currentMainBgType
end

function UIPlayerInfoBg:GetBgSetting()
  return self._deltaBgPos, self._deltaBgScale, self._bgRoot.sizeDelta
end

function UIPlayerInfoBg:ChangeCgRootScale(type, scale)
  if type == UIChooseAssistantType.Bg2MainLobby then
    self._deltaBgScale = scale
  elseif type == UIChooseAssistantType.Cg2MainLobby then
    self._deltaScale = scale
  end
end

function UIPlayerInfoBg:ChangeCgRootPos(type, pos)
  if type == UIChooseAssistantType.Bg2MainLobby then
    self._deltaBgPos = pos
  elseif type == UIChooseAssistantType.Cg2MainLobby then
    self._deltaPos = pos
    self._changePetPosAndScaleRoot.anchoredPosition = Vector2.zero
  end
end

function UIPlayerInfoBg:BgOnClick()
  local forbidPlayAni = true
  if forbidPlayAni then
    return
  end
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
          Log.fatal("###[UIPlayerInfoBg] pet cfg is nil ! id --> ", self._defaultPetID, "| grade --> ", self._assistantGrade)
          return
        end
        voiceSkinID = gradeCfg.SkinId
      else
        local gradeCfg = Cfg.cfg_pet_grade({
          PetID = self._defaultPetID,
          Grade = self._assistantGrade
        })[1]
        if not gradeCfg then
          Log.fatal("###[UIPlayerInfoBg] grade cfg is nil ! id --> ", self._defaultPetID, "| grade --> ", self._assistantGrade)
          return
        end
        voiceSkinID = gradeCfg.SkinId
      end
    else
      voiceSkinID = self._assistantSkinID
    end
    self:PlaySpineAnim(voiceSkinID)
  end
end

function UIPlayerInfoBg:PlaySpineAnim(skinid)
  if self._cgState == DynamicAndStaticState.Dynamic then
    if self._playSpineAnim then
      return
    end
    local cfg_pet_skin = Cfg.cfg_pet_skin[skinid]
    if not cfg_pet_skin then
      Log.error("###[UIPlayerInfoBg] cfg_pet_skin is nil ! id --> ", skinid)
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
      Log.error("###[UIPlayerInfoBg] animList is nil ! skinid --> ", skinid)
      return
    end
    local randomVal = math.random(#animList)
    local anim = animList[randomVal]
    local animationName = anim
    if not self._dcgHandle then
      Log.debug("###[UIPlayerInfoBg] not self._dcgHandle spine --> ", self._dynamicSpineSettings)
      return
    end
    local entry = self._dcgHandle:SetAnimationWithTrackEntryReturn(0, animationName, false)
    self._dcgHandle:SetAnimMixTime(0)
    self._dcgHandle:Update(0)
    if not entry then
      return
    end
    local anim = entry.Animation
    local duration = anim.Duration
    local yieldTime = math.floor(duration * 1000)
    self._playSpineAnim = true
    if self._spineEvent then
      GameGlobal.Timer():CancelEvent(self._spineEvent)
      self._spineEvent = nil
    end
    self._spineEvent = GameGlobal.Timer():AddEvent(yieldTime, function()
      self._playSpineAnim = false
      local animationName = "idle"
      self._dcgHandle:SetAnimation(0, animationName, true)
      self._dcgHandle:SetAnimMixTime(0)
      self._dcgHandle:Update(0)
    end)
    Log.debug("###[UIPlayerInfoBg] spine 动画名字[", animationName, "] 动画时长[", duration, "]")
  end
end

function UIPlayerInfoBg:_GetResId()
  if not self.isFriendMode then
    return self._roleModule:GetResId()
  else
    return self.friendData:GetTemplateID()
  end
end

function UIPlayerInfoBg:_UI_GetMainBgID()
  if not self.isFriendMode then
    return self._roleModule:UI_GetMainBgID()
  else
    return self.friendData:GetBackID()
  end
end

function UIPlayerInfoBg:_UI_IsHandleOperate()
  if not self.isFriendMode then
    return self._roleModule.m_choose_painting.is_hand_operate
  else
    return self.friendData:GetIsHandOperate()
  end
end

function UIPlayerInfoBg:_UI_GetHandleOperateSpineIndex()
  if not self.isFriendMode then
    return self._roleModule.m_choose_painting.spine_id
  else
    return self.friendData:GetHandOperateSpineId()
  end
end

function UIPlayerInfoBg:_UI_GetBackgroundType()
  if not self.isFriendMode then
    return self._roleModule.m_choose_painting.background_type
  else
    return self.friendData:GetBackgroundType()
  end
end

function UIPlayerInfoBg:_UI_GetPetGrade()
  if not self.isFriendMode then
    return self._roleModule.m_choose_painting.pet_grade
  else
    return self.friendData:GetPetGrade()
  end
end

function UIPlayerInfoBg:_UI_GetSkinId()
  if not self.isFriendMode then
    return self._roleModule.m_choose_painting.skin_id
  else
    return self.friendData:GetSkinId()
  end
end

function UIPlayerInfoBg:_UI_GetBoardPet()
  if not self.isFriendMode then
    local asid = self._roleModule.m_choose_painting.board_pet
    if asid == 3400050 then
      asid = 10015
    end
    return asid
  else
    return self.friendData:GetBoardPet()
  end
end

function UIPlayerInfoBg:_UI_GetShowSpine()
  if not self.isFriendMode then
    return self._roleModule:GetExtFlag(CharExtFlag.CEFT_MAIN_UI_SHOW_SPINE)
  else
    return false
  end
end

function UIPlayerInfoBg:_GetSpineSettings()
  if not self.isFriendMode then
    return ChooseAssistantHelper.GetSpineSettings()
  else
    return self:_SelfGetSpineSettings()
  end
end

function UIPlayerInfoBg:_SelfGetSpineSettings()
  local petid = self:_GetResId()
  local defaultPetID = 0
  local grade, skin, asid, staticSpineSettings, dynamicSpineSettings
  if petid and petid ~= 0 then
    defaultPetID = petid
    grade = self:_UI_GetPetGrade()
    skin = self:_UI_GetSkinId()
    asid = self:_UI_GetBoardPet()
  else
    defaultPetID = Cfg.cfg_global.main_default_spine_pet_id.IntValue
    grade = 0
    skin = 0
    asid = 0
  end
  local cfg_pet
  if 0 < grade then
    cfg_pet = Cfg.cfg_pet_grade({PetID = defaultPetID, Grade = grade})[1]
  else
    cfg_pet = Cfg.cfg_pet[defaultPetID]
  end
  if asid and asid ~= 0 then
    local cfg_as = Cfg.cfg_only_assistant[asid]
    if not cfg_as then
      asid = 0
    end
  end
  if cfg_pet then
    if asid and asid ~= 0 then
      local cfg_as = Cfg.cfg_only_assistant[asid]
      if not cfg_as then
        Log.error("###[UIChooseMainCgController] cfg_as is nil ! id --> ", asid)
      end
      staticSpineSettings = cfg_as.CG
      dynamicSpineSettings = cfg_as.Spine
    else
      staticSpineSettings = HelperProxy:GetInstance():GetMainLobbyStaticBody(defaultPetID, grade, skin, PetSkinEffectPath.NO_EFFECT)
      staticSpineSettings = staticSpineSettings or HelperProxy:GetInstance():GetPetStaticBody(defaultPetID, grade, skin, PetSkinEffectPath.NO_EFFECT)
      dynamicSpineSettings = HelperProxy:GetInstance():GetMainLobbySpine(defaultPetID, grade, skin, PetSkinEffectPath.NO_EFFECT)
      if not dynamicSpineSettings then
        dynamicSpineSettings = HelperProxy:GetInstance():GetPetSpine(defaultPetID, grade, skin, PetSkinEffectPath.NO_EFFECT)
      end
    end
  else
    staticSpineSettings = defaultPetID .. "_cg"
    dynamicSpineSettings = defaultPetID .. "_spine_idle"
  end
  return staticSpineSettings, dynamicSpineSettings
end

function UIPlayerInfoBg:SetAsActive(changeAsHide)
  if changeAsHide then
    local petid = self:_GetResId()
    self._assistantNull = false
    if petid and petid ~= 0 and petid == -1 then
      self._assistantNull = true
    end
    self._cgSpineGo:SetActive(not self._assistantNull)
    self._voiceGo:SetActive(not self._assistantNull)
  end
end

function UIPlayerInfoBg:SetMainBg(type, id, anim, isSaveBtn, save, changeAsHide)
  self:SetAsActive(changeAsHide)
  id = id and id or self:_UI_GetMainBgID()
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
    if cfg.Spine then
      self:ChangeSpineBG(cfg, type, anim, isSaveBtn, save)
    elseif cfg.StaticPic then
      self:ChangeCGPicBG(cfg, type, anim, isSaveBtn, save)
    end
  end
end

function UIPlayerInfoBg:ChangePicBG(cfg, type, anim, isSaveBtn, save)
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
  if anim then
    self:Lock("UIPlayerInfoBg:SetMainBg")
    self._mainBg2:LoadImage(cfg.BG)
    self._mainBgAlpha1.alpha = 1
    self._mainBgAlpha2.alpha = 0
    self._mainBgAlpha1:DOFade(0, 0.25)
    self._mainBgAlpha2:DOFade(1, 0.25):OnComplete(function()
      self._mainBg:LoadImage(cfg.BG)
      self._mainBgAlpha1.alpha = 1
      self._mainBgAlpha2.alpha = 0
      self:UnLock("UIPlayerInfoBg:SetMainBg")
    end)
  else
    self._mainBg:LoadImage(cfg.BG)
    self._mainBgAlpha1.alpha = 1
    self._mainBgAlpha2.alpha = 0
  end
end

function UIPlayerInfoBg:ChangeBGSpine(cfg, type, anim, isSaveBtn, save)
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
    ChooseAssistantHelper.SaveAssistantBgSetting(self._deltaBgPos, self._deltaBgScale, type, cfg.ID)
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

function UIPlayerInfoBg:ChangeCGPicBG(cfg, type, anim, isSaveBtn, save)
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
  if anim then
    self:Lock("UIPlayerInfoBg:SetMainBg")
    self._mainBg2:LoadImage(cfg.StaticPic)
    self._mainBgAlpha1.alpha = 1
    self._mainBgAlpha2.alpha = 0
    self._mainBgAlpha1:DOFade(0, 0.25)
    self._mainBgAlpha2:DOFade(1, 0.25):OnComplete(function()
      self._mainBg:LoadImage(cfg.StaticPic)
      self._mainBgAlpha1.alpha = 1
      self._mainBgAlpha2.alpha = 0
      self:UnLock("UIPlayerInfoBg:SetMainBg")
    end)
  else
    self._mainBg:LoadImage(cfg.StaticPic)
    self._mainBgAlpha1.alpha = 1
    self._mainBgAlpha2.alpha = 0
  end
end

function UIPlayerInfoBg:ChangeSpineBG(cfg, type, anim, isSaveBtn, save)
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
  if 1 < table.count(cfg.Spine) then
    self._spineLoaderObj2:SetActive(true)
    self._spineLoader2:LoadSpine(cfg.Spine[2])
  end
  self._spineLoader1:LoadSpine(cfg.Spine[1])
end

function UIPlayerInfoBg:SaveCancelChangeCgRoot(type, state, id, bgType)
  if type == UIChooseAssistantType.Bg2MainLobby or type == UIChooseAssistantType.Cg2MainLobby then
    if state == UIChooseAssistantState.Save then
      self._currentMainBgID = id and id or self._currentMainBgID
      self._currentMainBgType = bgType and bgType or self._currentMainBgType
    elseif state == UIChooseAssistantState.Cancel then
      Log.debug("###[UIPlayerInfoBg] cgroot cancel change !")
      self:SetRootPosAndScale()
      self:SetBgRootPosAndScale()
      local open_id = GameGlobal.GameLogic():GetOpenId()
      local key = "MAIN_BG_AS_ACTIVE" .. open_id
      local bgState = LocalDB.GetInt(key)
      self:OnMainLobbyHideAssistant(bgState == 1)
    elseif state == UIChooseAssistantState.Default then
      self:_ChangeCgRootToDefault(type)
    end
  end
end

function UIPlayerInfoBg:_ChangeCgRootToDefault(type)
  if type == UIChooseAssistantType.Cg2MainLobby then
    self._deltaPos = Vector2(0, 0)
    self._deltaScale = 1
    self._changePetPosAndScaleRoot.anchoredPosition = Vector2.zero
  elseif type == UIChooseAssistantType.Bg2MainLobby then
    self._deltaBgPos = Vector2(0, 0)
    self._deltaBgScale = 1
    self:SetBgRootPosAndScale()
  end
end

function UIPlayerInfoBg:OnMainLobbyHideAssistant(hideAs)
  self._cgSpineGo:SetActive(not hideAs)
  self._voiceGo:SetActive(not hideAs)
end

function UIPlayerInfoBg:SetRootPosAndScale()
  local posOffset, scaleOffset = ChooseAssistantHelper.GetAssistantPetSetting()
  self._changePetPosAndScaleRoot.anchoredPosition = Vector2.zero
  self._deltaPos = posOffset
  self._deltaScale = scaleOffset
end

function UIPlayerInfoBg:SetBgRootPosAndScale(BGWidth)
  self._bg_posOffset = Vector2(0, 0)
  self._bg_scaleOffset = 1
  self._currentMainBgID = self:_UI_GetMainBgID()
  self._currentMainBgType = self:_UI_GetBackgroundType()
  self._current_is_hand_operate = self:_UI_IsHandleOperate()
  self._current_hand_spine_index = self:_UI_GetHandleOperateSpineIndex()
  self._currentMainBgID = self._currentMainBgID == 0 and 2 or self._currentMainBgID
  self._currentMainBgType = self._currentMainBgType == 0 and 1 or self._currentMainBgType
  self._current_hand_spine_index = self._current_hand_spine_index == 0 and 1 or self._current_hand_spine_index
  local size = Vector2(2539, 1439)
  local realWidth = ResolutionManager.RealWidth()
  local realHeight = ResolutionManager.RealHeight()
  local safeArea = Vector2(realWidth, realHeight)
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
      local spineIndex = 1
      local num = #cfg.Spine
      if self._current_is_hand_operate then
        spineIndex = self._current_hand_spine_index
        if spineIndex < 1 or num <= spineIndex then
          spineIndex = 1
        end
      else
        spineIndex = num
      end
      self._spineLoaderObj1:SetActive(true)
      self._bgRootObj:SetActive(false)
      self._spineLoader1:LoadSpine(cfg.Spine[spineIndex])
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
  local playerCfgConst1 = Cfg.cfg_player_const[1].data
  local move = BGWidth / 2 - (size.x / 2 + playerCfgConst1)
  self._bg_posOffset = Vector2(move, 0)
  self._bgRoot.anchoredPosition = self._bg_posOffset
  self._bgRoot.localScale = Vector3(self._bg_scaleOffset, self._bg_scaleOffset, self._bg_scaleOffset)
  self._spineBgRoot.anchoredPosition = self._bg_posOffset
  self._spineBgRoot.localScale = Vector3(self._bg_scaleOffset, self._bg_scaleOffset, self._bg_scaleOffset)
  self._deltaBgPos = self._bg_posOffset
  self._deltaBgScale = self._bg_scaleOffset
  self._bgRoot.sizeDelta = size
end

function UIPlayerInfoBg:WelcomeAudio()
  self:StartTask(function(TT)
    YIELD(TT)
  end)
end

function UIPlayerInfoBg:ShowCurrentAssistant()
  local petid = self:_GetResId()
  local old_pet_id = self._defaultPetID
  self._assistantNull = false
  self._defaultPetID = 0
  local grade, skin, asid
  if petid and petid ~= 0 then
    self._defaultPetID = petid
    if petid == -1 then
      self._assistantNull = true
    end
    grade = self:_UI_GetPetGrade()
    skin = self:_UI_GetSkinId()
    if skin == 0 or not GameGlobal.GetModule(PetModule):HaveSkin(skin) then
    end
    asid = self:_UI_GetBoardPet()
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
  self._dynamicSpineAnim = nil
  if cfg_pet and asid and asid ~= 0 then
    local cfg_as = Cfg.cfg_only_assistant[asid]
    if cfg_as then
      self._dynamicSpineAnim = cfg_as.SpineAnim
    end
  end
  self._staticSpineSettings, self._dynamicSpineSettings = self:_GetSpineSettings()
  local flagValue = self:_UI_GetShowSpine()
  if flagValue then
    self._cgState = DynamicAndStaticState.Static
  else
    self._cgState = DynamicAndStaticState.Dynamic
  end
  self:ChangeDynamicAndStatic(self._cgState)
end

function UIPlayerInfoBg:ChangeDynamicAndStatic(state)
  if state == DynamicAndStaticState.Dynamic then
    if not self._dcgHandle then
      self._dcgHandle = DynamicCG.SyncLoad(self._dynamicSpineSettings, self._spine)
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
        UICG.SetTransform(self._spineGo.transform, "UIPlayerInfoController", self._dynamicSpineSettings)
      else
        self._spineGo.transform.localPosition = Vector3(0, 0, 0)
        self._spineGo.transform.localScale = Vector3(1, 1, 1)
      end
    end
    if self._dynamicSpineAnim then
      local function tryFunc()
        if self._dcgHandle then
          self._dcgHandle:InitializeSpine()
          
          self._dcgHandle:SetAnimation(0, self._dynamicSpineAnim, true)
          self._dcgHandle:SetAnimMixTime(0)
          self._dcgHandle:Update(0)
        end
      end
      
      local succ = pcall(tryFunc)
      if not succ then
        Log.error("###[UIPlayerInfoBg] set _dynamicSpineAnim fail ! spine:", self._dynamicSpineSettings, ",anim:", self._dynamicSpineAnim)
      end
    end
    self._spineGo:SetActive(true)
    self._cgGo:SetActive(false)
    local skinid = self._assistantSkinID
    if skinid then
      local skin_cfg = Cfg.cfg_pet_skin[skinid]
      if skin_cfg then
        local spineAnim = skin_cfg.EnterAnim
        if spineAnim then
          if not self._dcgHandle then
            Log.debug("###[UIPlayerInfoBg] self._dcgHandle is nil spine --> ", self._dynamicSpineSettings)
            return
          end
          do
            local entry
            
            local function _f()
              self._dcgHandle:InitializeSpine()
              entry = self._dcgHandle:SetAnimationWithTrackEntryReturn(0, spineAnim, false)
              self._dcgHandle:SetAnimMixTime(0)
              self._dcgHandle:Update(0)
            end
            
            local succ = pcall(_f)
            if not succ then
              Log.error("###[UIPlayerInfoBg] set spine anim fail ! spine[", self._dynamicSpineSettings, "] anim[", spineAnim, "]")
              return
            end
            if not entry then
              Log.error("###[UIPlayerInfoBg] entry is nil ! spine[", self._dynamicSpineSettings, "] anim[", spineAnim, "]")
              return
            end
            local anim = entry.Animation
            local duration = anim.Duration
            local yieldTime = math.floor(duration * 1000)
            self._playSpineAnim = true
            if self._spineEvent then
              GameGlobal.Timer():CancelEvent(self._spineEvent)
              self._spineEvent = nil
            end
            self._spineEvent = GameGlobal.Timer():AddEvent(yieldTime, function()
              self._playSpineAnim = false
              local animationName = "idle"
              self._dcgHandle:SetAnimation(0, animationName, true)
              self._dcgHandle:SetAnimMixTime(0)
              self._dcgHandle:Update(0)
            end)
          end
        end
      end
    end
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
        UICG.SetTransform(self._cgGo.transform, "UIPlayerInfoController", self._staticSpineSettings)
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
    self._cgGo:SetActive(true)
    self._spineGo:SetActive(false)
  end
end

function UIPlayerInfoBg:ClosePetAudio(normalClose)
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

function UIPlayerInfoBg:OnAudioEndPlay()
  if self._audioPlayID then
    self._voiceAnim:Play("uieff_mainlobby_voicefade")
    self._audioPlayID = nil
  end
end

function UIPlayerInfoBg:OnUpdate(deltaTimeMS)
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
      self._freeTime = 0
    end
  end
end

function UIPlayerInfoBg:PlayPetAudio(filed)
  local voiceSkinID
  if self._assistantAsID and self._assistantAsID ~= 0 then
    voiceSkinID = nil
  elseif self._assistantSkinID == 0 then
    if self._assistantGrade == 0 then
      local gradeCfg = Cfg.cfg_pet[self._defaultPetID]
      if not gradeCfg then
        Log.fatal("###[UIPlayerInfoBg] pet cfg is nil ! id --> ", self._defaultPetID, "| grade --> ", self._assistantGrade)
        return
      end
      voiceSkinID = gradeCfg.SkinId
    else
      local gradeCfg = Cfg.cfg_pet_grade({
        PetID = self._defaultPetID,
        Grade = self._assistantGrade
      })[1]
      if not gradeCfg then
        Log.fatal("###[UIPlayerInfoBg] grade cfg is nil ! id --> ", self._defaultPetID, "| grade --> ", self._assistantGrade)
        return
      end
      voiceSkinID = gradeCfg.SkinId
    end
  else
    voiceSkinID = self._assistantSkinID
  end
  if not (filed == "MainLobbyWelcome" and self._roleModule:TodayIsFirstLogin()) or self._audioPlayID == nil then
  else
  end
  if self._audioPlayID == nil then
    return
  end
end
