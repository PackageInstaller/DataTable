local GyroscopeManager = require("Managers.GyroscopeManager")
local RectTransform = CS.UnityEngine.RectTransform
local TextMeshProUGUI = CS.TMPro.TextMeshProUGUI
local ANNOUNCE_CHECK_DURATION = 60
local AWAKER_SUBTITLE_ROLL_TIMES = 200
local AWKAER_SUBTITLE_SHOW_LINE = 3
local BTN_GROUP_CONTENT_TOP = 0
local BTN_GROUP_CONTENT_BOTTOM = 160
local INTERVAL = 5
local TransformUtil = CS.Framework.TransformUtil
local MainPanel, Super = System.NewClass("MainPanel", UIBasePanel)
MainPanel.uiResCls = UI_Main_Panel_1Resource

function MainPanel:ctor()
  Super.ctor(self)
end

function MainPanel:OnBind(binder)
  self.binder = binder
  local model = binder:createModel(MainPanelModel, self.ui)
  self.model = model
  binder:LoadAllLangFont(self.ui.Text_MQ_Level)
  binder:LoadAllLangFont(self.ui.Text_Player_Name)
  self:_BindAwakerPortrait()
  self:_InitDefineBtn(binder, model)
  self:_InitChildUIList(binder, model, MainPanelDefine.ItemUICfg)
  self:_InitUIBothSidesUI()
  self:_BindAwakerVoice()
  self:_BindCurrency()
  self:_BindToAnnouncementRed()
  self:_BindPlayerHead(binder, model)
  self:_BindPlayerLevelBg(binder, model)
  self:_BindHudHideBtn(binder, model)
  self:_BindChatGroup(binder, model)
  self:_BindSummonEntry()
  self:_BindShopEntryRed()
  self:_BindGuideNoteEntryRed()
  self:_BindCollectionEntryRed()
  self:_BindFormation()
  self:_BindActivityBanner()
  self:_BindAwakerChat()
  self:_BindSummonBanner()
  self:_CheckGuideMask()
  self:_BindInvitationBtn()
  self:_BindBgCg()
  self:_BindTimeEnd()
  self:_BindGuideNode()
  CopyBackJumpUtils.Reset()
  self:UpdateGameServerNode()
  FriendMatchMgr.Instance:OpenInvitePopBubble()
  AddLuaCompOnce(self.ui.Container_Awaker, GyroscopeOrientatedCtrl)
  GlobalDispatcher:AddListener(NotifyId.OnDeviceOrientationChanged, self._OnDeviceOrientationChanged, self)
  binder:BindEvent(EventMgr.Instance.PlayUnlockBtnFx, System.fn(self, self.PlayUnlockFx))
  binder:BindEvent(EventMgr.Instance.OnCareerLevelDataChanged, System.fn(self, self._OnCareerLevelDataChanged))
  binder:BindEvent(EventMgr.Instance.OnRemainCompositeTimeChanged, System.fn(self, self._OnRemainCompositeTimeChanged))
  self:_InitCameraPos()
  TrinketSortingModel.Instance:StartCalSortingParams()
  Super.SetRendered(self, UIManager.Instance:GetTopFullScreenPanel() == Urls.MainPanel)
  PvpController.Instance:OnPvpDraftRecover()
end

function MainPanel:_OnCareerLevelDataChanged()
  self:_InitDefineBtn(self.binder, self.model)
end

function MainPanel:_OnRemainCompositeTimeChanged()
  self:_InitDefineBtn(self.binder, self.model)
end

function MainPanel:_InitCameraPos()
  self.cameraComp = CS.UnityEngine.GameObject.Find("Main Camera")
  if not self.cameraComp then
    return
  end
  CS.Framework.TransformUtil.SetPos(self.cameraComp.transform, 0, 0, 0)
  CS.Framework.TransformUtil.SetLocalEulerAngles(self.cameraComp.transform, 0, 0, 0)
end

function MainPanel:_OnDeviceOrientationChanged()
  self:_InitCameraPos()
end

function MainPanel:GetTempDependenciesResources()
  local Scene_MainInterface_P = GyroscopeManager.Instance:GetGyroscopeBgByUrl(Urls.MainPanel)
  return {Scene_MainInterface_P}
end

function MainPanel:_BindSummonEntry()
  self.binder:UpdateLocalizedTextAndResouce(self.ui.UI_Common_Item_Hint)
  self.binder:BindToRaw(function(cBinder, result)
    cBinder:BindToVisible(self.ui.Com_RedDot_Recruit, function()
      return not result.isHint and not result.isShow
    end)
    cBinder:BindToVisible(self.ui.UI_Common_Item_Hint, function()
      if result.isLuckyBag then
        cBinder:BindToText(self.ui.Text_C_Recommend, function()
          do return LT.Text end
          return LT.Text, "LuckyBagRedDotText"
        end)
      else
        cBinder:BindToText(self.ui.Text_C_Recommend, function()
          do return LT.Text end
          return LT.Text, "IsNewDotText"
        end)
      end
      return result.isHint or result.isShow
    end)
  end, function()
    local isHint, isLuckyBag = SummonDataUtils.CheckSummonHint()
    local result = {
      isShow = RedPointDataUtils.IsShowSummonRecommend(),
      isHint = isHint,
      isLuckyBag = isLuckyBag
    }
    return result
  end)
end

function MainPanel:RefreshGyroscopeBg()
  local bgTid = ArtCollectionModel.Instance:GetBgCfgId()
  local isDefault = bgTid == DT.GetConstant("DefaultDormitoryBgTid")
  GyroscopeManager.Instance:ChangeDormitoryTex(isDefault)
  self.ui.UI_Main_VX_Maininterface_Room:SetActive(isDefault)
end

function MainPanel:BindActivityPrefabBg(cbinder)
  if self._activityPrefabBg then
    self._activityPrefabBg.binder:teardown()
    self._activityPrefabBg = nil
  end
  local actDefine = ArtCollectionModel.Instance:GetBgActivityDefine()
  if actDefine then
    local isPlayMusic = true
    self._activityPrefabBg = self.binder:BindNewComponent(self.ui.Content_Bg_Prefab, CGActivityComp, actDefine.resPath, actDefine, isPlayMusic)
  end
end

function MainPanel:_BindAwakerPortrait()
  local curGender = PlayerDataUtils.GetGender()
  self.binder:BindToRaw(function(cbinder, actDefine)
    if actDefine then
      cbinder:BindTimer(0.01, 0, nil, function()
        local otherUICount = UIManager.Instance:GetUICountByLayer(UIDefine.LayerCfg.FixedRoot)
        self._isDelayCreateActivityPrefabBg = otherUICount > 0
        if not self._isDelayCreateActivityPrefabBg then
          self:BindActivityPrefabBg()
        end
      end)
      if actDefine.changeBgImage then
        cbinder:BindToRaw(function(_, gender)
          if gender ~= curGender then
            curGender = gender
            self:BindActivityPrefabBg()
          end
        end, function()
          do return end
          return PlayerDataUtils.GetGender, nil
        end)
      end
    end
  end, function()
    do return ArtCollectionModel.Instance.GetBgActivityDefine end
    return ArtCollectionModel.Instance.GetBgActivityDefine, ArtCollectionModel.Instance
  end)
  self.binder:BindEvent(EventMgr.Instance.CGActivityPlayed, function(resPath)
    if self:IsRendering() then
      return
    end
    local activityDefine = ArtCollectionModel.Instance:GetBgActivityDefine()
    if activityDefine and activityDefine.resPath == resPath then
      self._isDelayCreateActivityPrefabBg = true
    end
  end)
  self.binder:BindToVisible(self.ui.Container_Awaker, function()
    local bgTid = ArtCollectionModel.Instance:GetBgCfgId()
    do return ArtCollectionModel.Instance.IsAllowShowAwaker, ArtCollectionModel.Instance end
    return ArtCollectionModel.Instance.IsAllowShowAwaker, ArtCollectionModel.Instance, bgTid
  end)
  self.binder:BindToVisible(self.ui.Image_Awaker_Click, function()
    local bgTid = ArtCollectionModel.Instance:GetBgCfgId()
    do return ArtCollectionModel.Instance.IsAllowShowAwaker, ArtCollectionModel.Instance end
    return ArtCollectionModel.Instance.IsAllowShowAwaker, ArtCollectionModel.Instance, bgTid
  end)
  self.binder:BindToRaw(function(cBinder, awakerTidOrResNum)
    self:StopPlayAwakerVoice()
    if self.portaitComp then
      PortraitManager.Instance:RemoveAwakerPortrait(self.portaitComp)
      self.portaitComp = nil
    end
    local awakerTid = tonumber(awakerTidOrResNum)
    local resNum = not awakerTid and awakerTidOrResNum
    local extParams = {animationMode = true, allowFaceChange = true}
    self.portaitComp = cBinder:BindComponent(AwakerPortraitComp(self.ui.Container_Awaker, awakerTid, resNum, nil, nil, extParams))
    PortraitManager.Instance:AddAwakerPortrait(self.portaitComp)
  end, function()
    local awakerTid = self.model.showAwakerTid
    local dressedSkinTid = AwakerSkinUtils.GetAwakerDressedSkin(awakerTid, true)
    local resNum
    if dressedSkinTid and dressedSkinTid ~= CommonDefine.DefaultSkinTid then
      resNum = AwakerSkinUtils.GetSkinResNum(dressedSkinTid)
    end
    return resNum or awakerTid
  end)
end

function MainPanel:_BindToAnnouncementRed()
  if not self.binder then
    return
  end
  SdkMgr.Instance:GetNoticeEntranceRed("Normal", nil, nil, AnnouncementRedUtils.SetEntranceRed)
  if self.ui.Red_Notice then
    self.binder:BindComponent(UICompRedDotNewVue(self.ui.Red_Notice, RedDotDefine.DynamicRedDotID.AnnouncementEntrance))
  end
  self.binder:BindTimer(ANNOUNCE_CHECK_DURATION, -1, function()
    SdkMgr.Instance:GetNoticeEntranceRed("Normal", nil, nil, AnnouncementRedUtils.SetEntranceRed)
    RedDotController.Instance:RefreshAllRedDots()
  end)
end

function MainPanel:_BindPlayerHead(binder, model)
  local itemData = {
    clickCb = function()
      SocialDataUtils.OpenPlayerInfoPanel(SocialDefine.PlayerInfoPage.Overview)
    end,
    redFunc = function()
      do return end
      return RedPointDataUtils.GetMainHeadRed, nil
    end,
    refreshOnDay = true
  }
  binder:BindComponent(CommonHeadItem(self.ui.UI_Common_Head, itemData))
end

function MainPanel:_BindPlayerLevelBg(binder, model)
  binder:BindToVisible(self.ui.Image_Player_Level_Bg, function()
    return not model:IsMaxPlayerLevel()
  end)
end

function MainPanel:_InitBtns(binder, model, btnName, btn, btnCfg)
  local featureId, subFeatureId = btnCfg.FeatureId, btnCfg.SubFeatureId
  subFeatureId = subFeatureId or 0
  if featureId and btnCfg.LockUI and self.ui[btnCfg.LockUI] then
    binder:BindToVisible(self.ui[btnCfg.LockUI], function()
      local _, unlocked = PlayerDataUtils.IsFeatureUnlock(featureId, subFeatureId or 0)
      local isInUnlockQueue = PlayerDataUtils.IsBtnInUnlockQueue(btnName)
      if isInUnlockQueue then
        return true
      end
      return not unlocked
    end)
  end
  binder:BindButtonClick(btn, function()
    if featureId then
      local _, unlocked = PlayerDataUtils.IsFeatureUnlock(featureId, subFeatureId)
      if not unlocked then
        PlayerDataUtils.AlertLockedTips(featureId, subFeatureId)
        return
      end
    end
    if btnCfg.AlertID then
      Alert.Show(btnCfg.AlertID)
    else
      local modelBtnFunc = btnCfg.BtnClickFunc and model[btnCfg.BtnClickFunc]
      if modelBtnFunc then
        modelBtnFunc(model, btn)
      end
      if btnCfg.FeatureId == CommonDefine.FeatureId.Task and not btnCfg.SubFeatureId then
        TaskDataUtils.OpenTaskMainPanel()
      elseif btnCfg.PanelUrls == Urls.SummonPanel then
        SummonDataUtils.OpenSummonPanel()
      elseif btnCfg.Name == "Btn_MQ" then
        UIManager.Instance:Reopen(btnCfg.PanelUrls)
      elseif btnCfg.PanelUrls then
        UIManager.Instance:Reopen(btnCfg.PanelUrls)
      end
    end
  end)
  local childItems = btnCfg.ChildItems or {}
  self:_InitChildUIList(binder, model, childItems)
end

function MainPanel:PlayUnlockFx(btnName, featureTid)
  if not self.ui[btnName] or IsNil(self.ui[btnName]) then
    return
  end
  local tf = self.ui[btnName].transform
  local Image_Icon = tf:Find("Image_Icon")
  local fxAsset = self.binder:LoadAsset(CommonRes.UIMainVxUnlock)
  local fx = self.binder:Instantiate(fxAsset, Image_Icon or tf)
  fx.transform.localPosition = CS.UnityEngine.Vector3.zero
  fx.transform.localScale = CS.UnityEngine.Vector3.one
  fx.transform.localRotation = CS.UnityEngine.Quaternion.identity
  if "Btn_Collection" == btnName then
    self.btnGroupContentRT.anchoredPosition = CS.UnityEngine.Vector2(0, BTN_GROUP_CONTENT_BOTTOM)
    self.model:SetBtnGroupInTop(false)
  end
  if featureTid then
    local featureCfg = DT.FeatureUnlock[featureTid]
    if featureCfg and featureCfg.Parameter and tonumber(featureCfg.Parameter) then
      Alert.Show(tonumber(featureCfg.Parameter))
    end
  end
end

function MainPanel:_InitChildUIList(binder, model, childUIList)
  for _, childItem in ipairs(childUIList) do
    local childUI = self.ui[childItem.ChildItemName]
    if childUI then
      if childItem.ChildClsName then
        local values = self:GetModelFuncValue(model, childItem.ChildClsValueFunc) or {}
        binder:BindComponent(UsingNow(childItem.ChildClsName)(childUI, table.unpack(values)))
      end
      if childItem.LangId then
        binder:SetText(childUI, LT.Text(childItem.LangId, true))
      elseif childItem.TextFunc then
        local func = System.bind(self.GetModelFuncValue, self, model, childItem.TextFunc)
        binder:BindToText(childUI, func)
      elseif childItem.VisibleFunc then
        local func = System.bind(self.GetModelFuncValue, self, model, childItem.VisibleFunc)
        binder:BindToVisible(childUI, func)
      elseif childItem.FillAmoutFunc then
        local func = System.bind(self.GetModelFuncValue, self, model, childItem.FillAmoutFunc)
        binder:BindToImageFillAmount(childUI, func)
      elseif childItem.ImageFunc then
        local func = System.bind(self.GetModelFuncValue, self, model, childItem.ImageFunc)
        binder:BindToImage(childUI, func, true)
      elseif childItem.ImageFuncNoNative then
        local func = System.bind(self.GetModelFuncValue, self, model, childItem.ImageFuncNoNative)
        binder:BindToImage(childUI, func, false)
      end
    else
      Logger.Warn("控件不存在" .. childItem.ChildItemName)
    end
  end
end

function MainPanel:_InitDefineBtn(binder, model)
  for btnName, panelInfo in pairs(MainPanelDefine.BtnCfg) do
    local btn = self.ui[btnName]
    if btn and not panelInfo.SkipBindButton then
      self:_InitBtns(binder, model, btnName, btn, panelInfo)
    end
  end
  binder:BindZ1Button(self.ui.Btn_Top, function()
    if model.btnGroupInTop then
      self.btnGroupContentRT.anchoredPosition = CS.UnityEngine.Vector2(0, BTN_GROUP_CONTENT_BOTTOM)
      model:SetBtnGroupInTop(false)
    else
      self.btnGroupContentRT.anchoredPosition = CS.UnityEngine.Vector2(0, BTN_GROUP_CONTENT_TOP)
      model:SetBtnGroupInTop(true)
    end
  end)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_Btn_Top, nil, nil, function()
    if not model.btnGroupInTop then
      return false
    end
    do return end
    return RedPointDataUtils.IsShowMainPanelRightBottomBtnRedPoint, nil
  end))
  self.btnGroupContentRT = self.ui.Content_Btn_Group:GetComponent(typeof(RectTransform))
  binder:BindTimer(0.1, -1, function()
    if IsNil(self.btnGroupContentRT) then
      return
    end
    local _, anchoredPositionY = TransformUtil.GetAnchoredPos(self.btnGroupContentRT)
    if anchoredPositionY <= BTN_GROUP_CONTENT_TOP + INTERVAL then
      model:SetBtnGroupInTop(true)
    elseif anchoredPositionY >= BTN_GROUP_CONTENT_BOTTOM - INTERVAL then
      model:SetBtnGroupInTop(false)
    end
  end)
  binder:BindToVisible(self.ui.Group_Normal, function()
    return model.btnGroupInTop
  end)
  binder:BindToVisible(self.ui.Group_High, function()
    return not model.btnGroupInTop
  end)
end

function MainPanel:GetModelFuncValue(model, funcName)
  local func = funcName and model[funcName]
  local values = func and func(model)
  return values
end

function MainPanel:OnUnbind()
  Super.OnUnbind(self)
  GlobalDispatcher:RemoveListener(NotifyId.OnDeviceOrientationChanged, self._OnDeviceOrientationChanged, self)
  DataCenter.mainInterfaceData.curNaviFunc = CommonDefine.MainNaviTab.Battle
  PortraitManager.Instance:RemoveAwakerPortrait(self.portaitComp)
end

function MainPanel:ClosePanel()
  self:Close()
  GyroscopeManager.Instance:DisableGyroscope()
end

function MainPanel:ShowAwakerVoice(voiceId)
  if 0 == voiceId then
    return
  end
  self.binder:SetCanvasGroup(self.ui.ScrollView, 0)
  local voiceConfig = DT.Voice[voiceId]
  local soundEventName = AwakerDataUtils.GetAwakerVoiceSound(voiceId)
  self:_UpdateSubTitle(voiceConfig.AwakerVoiceContent, soundEventName)
  FrameWaiter.OnNextFrame(function()
    self.binder:SetCanvasGroup(self.ui.ScrollView, 1)
    local txtRealHeight = self.txtTmpComp.textBounds.size.y
    local startPosY = 0
    local overFlowHeight = txtRealHeight - self.ui.Text_Awaker_Desc.transform.sizeDelta.y
    if overFlowHeight > 0 then
      startPosY = startPosY - overFlowHeight / 2
    end
    self.rollAwakerSubTitleRT.anchoredPosition = CS.UnityEngine.Vector2(0, startPosY)
    self:_RefreshGroupDescVisible()
    local textLineCnt = self:_GetTextLineCnt()
    local duration = AudioManager.Instance:GetEventDuration(soundEventName)
    self:ClearTimer()
    if textLineCnt > AWKAER_SUBTITLE_SHOW_LINE then
      local endPos = (textLineCnt - AWKAER_SUBTITLE_SHOW_LINE) * (txtRealHeight / textLineCnt)
      local delta = endPos - startPosY
      local perMovePosY = delta / AWAKER_SUBTITLE_ROLL_TIMES
      local showVal = startPosY
      self.voiceCloseTimer = self.binder:BindTimer(duration / AWAKER_SUBTITLE_ROLL_TIMES, AWAKER_SUBTITLE_ROLL_TIMES, function()
        self.rollAwakerSubTitleRT.anchoredPosition = CS.UnityEngine.Vector2(0, showVal)
        showVal = showVal + perMovePosY
      end, function()
        self:_UpdateSubTitle("", "")
        self:_RefreshGroupDescVisible()
        AwakerFaceManager.Instance:StopSwitchFace()
      end)
    else
      self.voiceCloseTimer = self.binder:BindTimer(duration, 1, nil, function()
        self:_UpdateSubTitle("", "")
        self:_RefreshGroupDescVisible()
        AwakerFaceManager.Instance:StopSwitchFace()
      end)
    end
    AudioManager.Instance:PostSoundEvent(soundEventName)
    AwakerFaceManager.Instance:SwitchFace(voiceConfig.AwakerID, voiceConfig.FacialExpressionSwitch)
  end)
end

function MainPanel:_ListenFirstClickBoardGirl()
  TutorialDataUtils.ReqClickBoardGirl()
end

function MainPanel:StopPlayAwakerVoice()
  AudioManager.Instance:PostSoundEvent("Stop_VO_Chr_All")
  self:_UpdateSubTitle("", "")
  self:_RefreshGroupDescVisible()
end

function MainPanel:ClearTimer()
  if self.voiceCloseTimer ~= nil then
    self.binder:StopTimer(self.voiceCloseTimer)
    self.time = nil
  end
end

function MainPanel.IsInMainPanel()
  local hideLayers = {
    UIDefine.LayerCfg.NormalRoot.name,
    UIDefine.LayerCfg.FixedRoot.name,
    UIDefine.LayerCfg.PopUpRoot.name
  }
  local panelCount = 0
  for _, layer in ipairs(hideLayers) do
    local uids = UIManager.Instance:GetAllShowWindowIdsByLayer(layer)
    panelCount = panelCount + #uids
  end
  return 1 == panelCount
end

function MainPanel:_BindAwakerVoice()
  self.longPressing = false
  self.txtTmpComp = self.ui.Text_Awaker_Desc:GetComponent(typeof(TextMeshProUGUI))
  self.rollAwakerSubTitleRT = self.ui.Content_Awaker_Desc:GetComponent(typeof(RectTransform))
  self.binder:BindLongPressButton(self.ui.Image_Awaker_Click, function()
    if not self.longPressing then
      local awakerData = AwakerDataUtils.GetAwakerData(self.model.showAwakerTid)
      self.longPressing = true
      self:_ListenFirstClickBoardGirl()
      self:ShowAwakerVoice(AwakerAudioManager.Instance:GetAwakerVoiceId(CommonDefine.AwakerVoiceTrigger.LongPressAwaker, self.model.showAwakerTid, awakerData and awakerData.curSkin))
    end
  end, function()
    local awakerData = AwakerDataUtils.GetAwakerData(self.model.showAwakerTid)
    self:_ListenFirstClickBoardGirl()
    self:ShowAwakerVoice(AwakerAudioManager.Instance:GetAwakerVoiceId(CommonDefine.AwakerVoiceTrigger.ClickAwaker, self.model.showAwakerTid, awakerData and awakerData.curSkin))
  end, 1)
  self.binder:BindPressUp(self.ui.Image_Awaker_Click, function()
    self.longPressing = false
  end)
  self.binder:BindEvent(EventMgr.Instance.OpenUIPanel, function(_, _, isFullScreen)
    if self.IsInMainPanel() and isFullScreen then
      self:StopPlayAwakerVoice()
    end
  end)
end

function MainPanel:_BindCurrency()
  self.binder:BindComponent(CommonCurrencyGroupItem(self.ui.Group_Coin, DT.Constant.MainPanelCurrencies.Data))
end

function MainPanel:SetRendered(isRendered)
  self.binder:StopTimer(self._checkGainedFavorTimer)
  if true == isRendered and self.binder and self.binder.parent then
    self._checkGainedFavorTimer = self.binder:BindTimer(0.5, 0, nil, System.fn(self, self.CheckAwakerGainedFavor))
  end
  Super.SetRendered(self, isRendered)
  if isRendered and self._isDelayCreateActivityPrefabBg then
    self._isDelayCreateActivityPrefabBg = false
    self:BindActivityPrefabBg()
  end
end

function MainPanel:AfterSetRenderTrue()
end

function MainPanel:StackTopUIAudioProcess(lastCloseUI)
end

function MainPanel:ReShowInTop()
  PortraitManager.Instance:ReshowAssign(self.portaitComp)
end

function MainPanel:UpdateGameServerNode()
  LoginMgr.Instance.model:ReSetGameServerNode()
end

function MainPanel:_BindHudHideBtn(binder, model)
  binder:BindZ1Button(self.ui.Btn_Mask, function()
    model:SetHideHud(false)
    model:OnBtnGuest()
  end)
  binder:BindToVisible(self.ui.Btn_Mask, function()
    return model.hideHud
  end)
  binder:BindToVisible(self.ui.Image_Total, function()
    return not model.hideHud
  end)
end

function MainPanel:_BindChatGroup(binder, model)
  binder:BindToVisible(self.ui.Image_Chat, function()
    return false
  end)
end

function MainPanel:_GetTextLineCnt()
  return self.txtTmpComp.textInfo.lineCount
end

function MainPanel:_UpdateSubTitle(content, name)
  self.model:SetCurAwakerVoice(content, name)
  self.binder:SetText(self.ui.Text_Awaker_Desc, self.model.curAwakerVoiceContent)
end

function MainPanel:_RefreshGroupDescVisible()
  local alpha = self.model.curAwakerVoiceContent and self.model.curAwakerVoiceContent ~= "" and 1 or 0
  self.binder:SetCanvasGroup(self.ui.Group_Desc, alpha)
end

function MainPanel:_InitUIBothSidesUI()
  local leftUIGroup = {
    [self.ui.Image_left] = 0
  }
  local rightUIGroup = {
    [self.ui.ScrollView_Btn_Group] = 0
  }
  leftUIGroup, rightUIGroup = UIManager.Instance:InitBothSidesUIOriPos(leftUIGroup, rightUIGroup)
  UIManager.Instance:UIBothSidesAdaptation(leftUIGroup, rightUIGroup, CommonDefine.BothSideUILimitDeltaLen.MainPanel)
end

function MainPanel:DestroyUI()
  Super.DestroyUI(self)
  if self.monthCardTimer then
    TimerManager.Instance:StopTimer(self.monthCardTimer)
    self.monthCardTimer = nil
  end
end

function MainPanel:_BindFormation()
  self.binder:BindButtonClick(self.ui.Btn_Formation, function()
    local panelData = TeamAssignDataUtils.GetTeamBuildPanelDataWithoutStageCfg()
    DBGTeamDataUtils.EnterDBGTeamPanel(panelData)
  end)
end

function MainPanel:_BindActivityBanner()
  local refreshCounter = Vue.ref(0)
  self.binder:BindEvent(EventMgr.Instance.OnDayRefresh, function()
    refreshCounter.value = refreshCounter.value + 1
  end)
  self.binder:BindEvent(EventMgr.Instance.OnActivityDisplayChanged, function()
    refreshCounter.value = refreshCounter.value + 1
  end)
  self.binder:BindToRaw(function(cBinder, isInit)
    cBinder:BindToRaw(function(ccBinder)
      self:_BindBannerComp(ccBinder)
    end, function()
      return refreshCounter.value
    end)
  end, function()
    local _, unlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Activity, 0)
    local isInUnlockQueue = PlayerDataUtils.IsBtnInUnlockQueue("Btn_Activity")
    if isInUnlockQueue then
      return true
    end
    return unlock
  end)
end

function MainPanel:_BindSummonBanner()
  local summonRefreshCounter = Vue.ref(0)
  self.binder:BindEvent(EventMgr.Instance.OnDayRefresh, function()
    summonRefreshCounter.value = summonRefreshCounter.value + 1
  end)
  self.binder:BindEvent(EventMgr.Instance.OnSummonRefresh, function()
    summonRefreshCounter.value = summonRefreshCounter.value + 1
  end)
  self.binder:BindToRaw(function(cBinder, isInit)
    cBinder:BindToRaw(function(ccBinder)
      ccBinder:BindComponent(MainPanelSummonBannerComp(self.ui.uiNode, self))
    end, function()
      return summonRefreshCounter.value
    end)
  end, function()
    local _, unlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.DrawCard, 0)
    local isInUnlockQueue = PlayerDataUtils.IsBtnInUnlockQueue("Btn_Recruit")
    if isInUnlockQueue then
      return true
    end
    return unlock
  end)
end

function MainPanel:_BindAwakerChat()
  self.binder:BindButtonClick(self.ui.Btn_Address, function()
    if not self:_IsShowAwakerChat() then
      PlayerDataUtils.AlertLockedTips(cd.FeatureId.Communicator, 0)
      return
    end
    AwakerChatDataUtils.OpenCurrentMessagePanel()
  end)
  self.binder:BindToVisible(self.ui.Group_Address_Lock, function()
    local isInUnlockQueue = PlayerDataUtils.IsBtnInUnlockQueue("Btn_Address")
    local isUnlock = not self:_IsShowAwakerChat()
    if isInUnlockQueue then
      return true
    end
    return isUnlock
  end)
  self.binder:BindToRaw(function(_, isUnlock)
    if isUnlock and not AwakerChatDataUtils.IsHaveDialogs() then
      AwakerChatDataUtils.ReqCurrentDialogs()
    end
  end, function()
    do return self._IsShowAwakerChat end
    return self._IsShowAwakerChat, self
  end)
  local btnUI = UI_Main_Common_BtnResource(self.ui.Btn_Address)
  self.binder:BindToRaw(function(cBinder, isShow)
    if isShow then
      cBinder:BindComponent(NewRedCom(btnUI.Com_RedDot)):BindAvgCommunicate()
    else
      cBinder:SetActive(btnUI.Com_RedDot, false)
    end
  end, function()
    do return self._IsShowAwakerChat end
    return self._IsShowAwakerChat, self
  end)
end

function MainPanel:_IsShowAwakerChat()
  local _, isUnlock = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.Communicator, 0)
  return isUnlock
end

function MainPanel:_CheckGuideMask()
  NewbieGuideManager.Instance:CheckUnlockedGuide()
  if NewbieGuideManager.Instance:IsHaveGuideStep() then
    EventMgr.Instance.OpenClickMask:Dispatch("MainPanelGuide", 2)
  end
end

function MainPanel:_BindInvitationBtn()
  if not self.ui.Btn_InvitationCode then
    return
  end
  self.binder:BindToRaw(function(cbinder, isShow)
    cbinder:SetActive(self.ui.Btn_InvitationCode, isShow)
    if isShow and not InvitationCodeModel.Instance:GetInviteCode() then
      InvitationCodeController.Instance:ReqGetInviteCode()
      InvitationCodeController.Instance:ReqGetInviteTaskList()
    end
  end, function()
    local isOpenInZone = ZoneFeatureUtils.IsZoneFeatureOpen(cd.ZoneFeature.SocialInviteCode)
    local _, isUnlock = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.FriendInvitation, 0)
    return isOpenInZone and isUnlock
  end)
end

function MainPanel:CheckAwakerGainedFavor()
  if not MainPanel.IsInMainPanel() then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "GetBoardAwakerLikeGained", function(data)
    if data.gained and data.gained > 0 then
      UIManager.Instance:Reopen(Urls.AwakerFavorGainedPanel, self.model.showAwakerTid, data.gained)
    end
  end, function()
  end)
end

function MainPanel:_BindShopEntryRed()
  local refreshCounter = Vue.ref(0)
  self.binder:BindEvent(EventMgr.Instance.OnActivityDisplayChanged, function()
    refreshCounter.value = refreshCounter.value + 1
  end)
  self.binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_Store, CommonDefine.RedDotType.Dot, nil, function()
    local _ = refreshCounter.value
    local rst = RedPointDataUtils.IsShowShop()
    return rst
  end))
end

function MainPanel:_BindGuideNoteEntryRed()
  if not self.ui.Com_RedDot_DungeonNote then
    return
  end
  self.binder:BindComponent(UICompRedDotNewVue(self.ui.Com_RedDot_DungeonNote, RedDotDefine.DynamicRedDotID.GuideNoteMainEntry))
end

function MainPanel:_BindCollectionEntryRed()
  local Red_Collection = self.ui.Btn_Collection.transform:Find("Com_RedDot_Collection").gameObject
  self.binder:BindComponent(RedDotComponent(Red_Collection, CommonDefine.RedDotType.Dot, nil, function()
    do return end
    return RedPointDataUtils.NewAllCollectionReward, nil
  end))
end

function MainPanel:_BindBannerComp(cBinder)
  local _, unlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Activity, 0)
  if not unlock then
    self.binder:SetActive(self.ui.Group_Banner, false)
    return
  end
  ActivityManager.Instance:CheckHideActivity()
  cBinder:BindComponent(MainPanelActiviyBannerComp(self.ui.uiNode, self))
end

function MainPanel:_BindBgCg()
  local bgTid = ArtCollectionModel.Instance:GetBgCfgId()
  local pictureName = CollectionHallCfgUtils.GetCfgField("CnID", bgTid)
  local isCgUseGyroscope = string.contains(pictureName, "场景CG")
  if not isCgUseGyroscope then
    self.binder:BindToRaw(function(cBinder, isCg)
      self.binder:SetActive(self.ui.Image_CG, isCg)
      if isCg then
        self.binder:SetImage(self.ui.Image_CG, ArtCollectionModel.Instance:GetDomitoryBg())
      end
    end, function()
      local isCg = string.contains(pictureName, "主线CG")
      GyroscopeManager.Instance:DisableGyroscope()
      return isCg
    end)
  else
    GyroscopeManager.Instance:EnableGyroscope(Urls.MainPanel)
  end
end

function MainPanel:_BindTimeEnd()
  local binder = self.binder
  local params = {isShort = true}
  binder:BindComponent(MainTimeEndComp(self.ui.Recall_Time_End, self.model.GetRecallEndTime, params))
  binder:BindComponent(MainTimeEndComp(self.ui.Diving_Time_End, self.model.GetDivingEndTime, params))
  binder:BindComponent(MainTimeEndComp(self.ui.Pvp_Time_End, self.model.GetPvpEndTime, params))
  binder:BindComponent(MainTimeEndComp(self.ui.Abyss_Time_End, self.model.GetAbyssEndTime, params))
  binder:BindComponent(MainTimeEndComp(self.ui.Store_Time_End, self.model.GetStoreEndTime, {
    isShort = true,
    dayLessWithMinute = true,
    onEndCallback = function()
      EventMgr.Instance.OnActivityDisplayChanged:Dispatch()
    end
  }))
end

function MainPanel:_BindGuideNode()
  local _, unlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.GuideNote, 0)
  if not unlock then
    return
  end
  GuideNoteController.Instance:ReqOnOpenGuideNote()
end

return MainPanel
