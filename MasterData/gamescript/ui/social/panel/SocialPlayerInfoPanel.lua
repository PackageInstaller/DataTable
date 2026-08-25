local PlayerInfoPage = SocialDefine.PlayerInfoPage
local SocialPlayerInfoPanel, Super = System.NewClass("SocialPlayerInfoPanel", UIBasePanel)
SocialPlayerInfoPanel.uiResCls = UI_Social_Panel_DataResource

function SocialPlayerInfoPanel:ctor(initData)
  Super.ctor(self)
  self.initData = initData
end

function SocialPlayerInfoPanel:OnBind(binder)
  self.binder = binder
  self:_InitData(self.binder)
  self:_BindButtons(self.binder)
  self:_BindToggles(self.binder)
  self:_BindPageCompShow(self.binder)
  self:_ReqPanelData()
  binder:BindToVisible(self.ui.Group_Uid, function()
    local isMyInfo = self.model and self.model.isMyInfo
    local isReplayPage = self.model and self.model.page == PlayerInfoPage.BattleReplayView
    if isMyInfo and isReplayPage then
      return false
    end
    return true
  end)
  self.binder:BindToText(self.ui.Text_Uid, function()
    local uid = self.model:GetUid()
    if not uid then
      return
    end
    do return LT.Textf, "GMUserIdText" end
    return LT.Textf, "GMUserIdText", uid
  end)
  GlobalDispatcher:AddListener(NotifyId.OnTrinketBoundDataChanged, self._OnTrinketBoundDataChanged, self)
end

function SocialPlayerInfoPanel:_OnTrinketBoundDataChanged(awakerTid)
  if not self.model or not self.model.isMyInfo then
    return
  end
  local assistAwaker = self.model:GetAssistAwaker()
  if not (assistAwaker and assistAwaker.tid) or 0 == assistAwaker.tid then
    return
  end
  if assistAwaker.tid ~= awakerTid and AwakerDataUtils.GetChangerForm(awakerTid) ~= assistAwaker.tid then
    return
  end
  SocialDataUtils.ReqQueryAwaker(DataCenter.playerData.DRole.uid, assistAwaker.tid, function(data)
    SocialDataUtils.SetPreviewAwakerData(data)
    if self.model then
      self.model:InitAwakerDetailData()
    end
  end)
end

function SocialPlayerInfoPanel:_ReqPanelData()
  local playerUid = self.initData.targetPlayerUid
  local isMyInfo = playerUid == DataCenter.playerData.DRole.uid
  local isSocialDataReady = false
  local isPvPDetailsReady = true
  local isAssistAwakerDataReady = false
  
  local function _CheckPanelDataReady()
    if isSocialDataReady and isPvPDetailsReady and isAssistAwakerDataReady then
      self:_OnSocialPlayerInfoPanelDataReady()
    end
  end
  
  local function _ReqPreviewAwakerData(tid)
    SocialDataUtils.ReqQueryAwaker(playerUid, tid, function(data)
      SocialDataUtils.SetPreviewAwakerData(data)
      isAssistAwakerDataReady = true
      _CheckPanelDataReady()
    end)
  end
  
  local function _OnSocialBasicInfoBack(svrData)
    isSocialDataReady = true
    if svrData and svrData.facade then
      if svrData.facade.uid ~= PlayerDataUtils.GetPlayerUid() then
        self.initData.otherPlayerData = svrData
      else
        self.initData.otherPlayerData = SocialDataUtils.GetMyPlayer()
      end
      local assistAwakerData = svrData.facade.team and svrData.facade.team.assistAwaker
      if assistAwakerData and 0 ~= assistAwakerData.tid then
        _ReqPreviewAwakerData(assistAwakerData.tid)
        return
      end
    end
    isAssistAwakerDataReady = true
    _CheckPanelDataReady()
  end
  
  if isMyInfo then
    SocialDataUtils.ReqOnGetSocialBasicInfo(_OnSocialBasicInfoBack)
  else
    SocialDataUtils.ReqOnSocialVisit(playerUid, _OnSocialBasicInfoBack)
  end
end

function SocialPlayerInfoPanel:_InitData(binder)
  if not self.initData then
    self.initData = {
      page = PlayerInfoPage.Overview,
      targetPlayerUid = nil,
      playerPanelType = nil
    }
  end
  SocialDataUtils.ResetPreviewAwakerData()
  self.comps = {
    [PlayerInfoPage.Overview] = {
      resource = UI_Social_Item_Data_OverviewResource,
      compScript = SocialPlayerOverviewComp,
      compObj = nil,
      toggleObj = self.ui.Btn_Data,
      featureId = nil,
      Title = LT.Text("GoodSourceSocial")
    },
    [PlayerInfoPage.BattleReplayView] = {
      resource = UI_Social_Item_PvpResource,
      compScript = SocialPlayerBattleRecordComp,
      compObj = nil,
      toggleObj = self.ui.Btn_PVP,
      Title = LT.Text("ReplayTabTitle"),
      RuleTipsTitle = "RuleTipsTitle",
      RuleDesc = "ReplayTabRule"
    }
  }
  self.model = binder:createModel(SocialPlayerInfoModel, self.initData)
end

function SocialPlayerInfoPanel:_OnReqDataCallback()
  Logger.Info("[social] 社交个人资料数据请求完成回调.")
end

function SocialPlayerInfoPanel:_BindPageCompShow(binder)
  binder:BindToRaw(function(childBinder, nPage, oPage)
    if nPage then
      local compInfo = self.comps[nPage]
      if not compInfo then
        return
      end
      binder:SetText(self.ui.Text_C_Title, compInfo.Title)
      if compInfo.RuleTipsTitle and compInfo.RuleDesc then
        binder:SetActive(self.ui.UI_Common_Btn_Question, true)
        binder:BindZ1Button(self.ui.UI_Common_Btn_Question, function()
          UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text(compInfo.RuleTipsTitle), LT.Text(compInfo.RuleDesc))
        end)
      else
        binder:SetActive(self.ui.UI_Common_Btn_Question, false)
      end
      local compObj
      if nPage == PlayerInfoPage.BattleReplayView and not self.initCopy and not self.model.isMyInfo then
        self.initCopy = true
        local uid = self.initData.targetPlayerUid
        CopyRecordsController.Instance:ReqQueryFacadeFields(uid, {Type = "CopyReview"}, function(facade)
          if not self.binder then
            return
          end
          local widQueue = facade and facade.copyReview and facade.copyReview.widQueue
          CopyRecordsModel.Instance:SetOtherRecordWidList(widQueue)
          CopyRecordsModel.Instance:SetOtherRecordUid(uid)
          compObj = childBinder:BindNewComponent(self.ui.Group_Content, compInfo.compScript, compInfo.resource, self.model)
          self.comps[nPage].comp = compObj
          compObj:Show()
        end)
        return
      else
        compObj = childBinder:BindNewComponent(self.ui.Group_Content, compInfo.compScript, compInfo.resource, self.model)
        self.comps[nPage].comp = compObj
        compObj:Show()
      end
    end
    if oPage then
      local compInfo = self.comps[oPage]
      if not compInfo or not compInfo.comp then
        return
      end
      local compObj = compInfo.comp
      if compObj then
        compObj:Hide()
        self.comps[oPage].comp = nil
      end
    end
  end, function()
    print("---------------page change = ", self.model.page)
    return self.model.page
  end)
end

function SocialPlayerInfoPanel:_BindToggles(binder)
  if not self.comps then
    return
  end
  for page, compInfo in pairs(self.comps) do
    if compInfo and compInfo.toggleObj then
      if compInfo.featureId then
        local _, isUnlock = PlayerDataUtils.IsFeatureUnlock(compInfo.featureId, 0)
        compInfo.toggleObj:SetActive(isUnlock)
      end
      binder:BindToZ1Toggle(compInfo.toggleObj, nil, function(isOn)
        if isOn then
          self:_SetPage(page)
        end
      end, function()
        return self.model.page == page
      end, nil, function()
        do return self._IsHideReview, self end
        return self._IsHideReview, self, page
      end, function()
        Alert.Show("SocialRecordHideTips")
      end)
    end
  end
  local playerPanelType = self.initData.playerPanelType
  if playerPanelType == CommonDefine.PlayerPanelType.PVP or playerPanelType == CommonDefine.PlayerPanelType.PVE then
    self.initData.page = SocialDefine.PlayerInfoPage.BattleReplayView
  end
end

function SocialPlayerInfoPanel:_IsHideReview()
  return false
end

function SocialPlayerInfoPanel:_SetPage(page)
  self.model:SetPage(page)
end

function SocialPlayerInfoPanel:_BindButtons(binder)
  binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, System.fn(self, self.Close)))
  binder:SetActive(self.ui.Btn_Setup, self.model.isMyInfo)
  binder:SetActive(self.ui.Btn_Forward, false)
  self.binder:BindZ1Button(self.ui.Btn_Click_Uid, function()
    local uid = self.model:GetUid()
    StrUtils.CopyToClipboard(uid)
    Alert.Show(10746)
  end)
  if self.model.isMyInfo then
    binder:BindZ1Button(self.ui.Btn_Setup, System.fn(self, self._OnClickSetup))
  end
end

function SocialPlayerInfoPanel:_OnClickShare()
  SdkMgr.Instance:GetShare():OpenSharePlayerInfoPanel()
end

function SocialPlayerInfoPanel:_OnClickSetup()
  UIManager.Instance:Reopen(Urls.SettingMainPanel)
end

function SocialPlayerInfoPanel:Close()
  if self.comps and self.comps[self.model.page] then
    local compInfo = self.comps[self.model.page]
    local compObj = compInfo.comp
    if compObj then
      compObj:Hide()
    end
  end
  Super.Close(self)
  if not SceneMgr.Instance:IsInTown() then
    SceneMgr.Instance:EnterTown()
  end
end

function SocialPlayerInfoPanel:OnUnbind()
  GlobalDispatcher:RemoveListener(NotifyId.OnTrinketBoundDataChanged, self._OnTrinketBoundDataChanged, self)
  self.binder = nil
  ItemDataUtils.CloseHandleMockDataLock(Urls.SocialPlayerInfoPanel)
  AwakerDataUtils.CloseHandleMockDataLock(Urls.SocialPlayerInfoPanel)
  ItemDataUtils.ResetMockItemData()
  AwakerDataUtils.ResetMockAwakerMap()
end

function SocialPlayerInfoPanel:_OnSocialPlayerInfoPanelDataReady()
  self.model:RefreshByInitData(self.initData)
  EventMgr.Instance.OnPanelServerDataReturn:Dispatch(self.initData.targetPlayerUid)
end

return SocialPlayerInfoPanel
