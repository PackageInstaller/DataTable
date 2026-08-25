local SocialPlayerBattleRecordComp, Super = System.NewComponent("SocialPlayerBattleRecordComp")

function SocialPlayerBattleRecordComp:ctor(res, model)
  Super.ctor(self)
  self.ui = UI_Social_Item_PvpResource(res)
  self.model = model
  self._page = Vue.ref(model.playerPanelType or CommonDefine.PlayerPanelType.PVE)
end

function SocialPlayerBattleRecordComp:OnBind(binder)
  self.binder = binder
  self:BindTabButtons(binder)
  self:BindPageComps(binder)
  self:BindReplayButtons(binder)
  self:BindInputFieldChangeListener(binder)
  self:BindRecordDisplayToggle(binder)
  if self.model and self.model.isMyInfo then
    CopyRecordsController.Instance:ReqQueryMyRecord(1)
  else
    CopyRecordsModel.Instance:ReqOtherNextPageRecords()
  end
end

function SocialPlayerBattleRecordComp:OnUnbind()
  Super.OnUnbind(self)
  if self.model and self.model.isMyInfo then
    CopyRecordsModel.Instance:ClearMyRecords()
  else
    CopyRecordsModel.Instance:ClearOtherRecords()
  end
end

function SocialPlayerBattleRecordComp:Show()
  if not self.ui or not self.ui.uiNode then
    return
  end
  self.ui.uiNode:SetActive(true)
end

function SocialPlayerBattleRecordComp:Hide()
  if not self.ui or not self.ui.uiNode then
    return
  end
  self.ui.uiNode:SetActive(false)
end

function SocialPlayerBattleRecordComp:GetMyPageComps()
  return {
    [CommonDefine.PlayerPanelType.PVE] = {
      cls = SocialPlayerPveDataviewComp,
      gameObj = self.ui.uiNode,
      viewNode = "ScrollView_Record_Pve"
    },
    [CommonDefine.PlayerPanelType.PVP] = {
      cls = SocialPlayerPvpDataviewComp,
      gameObj = self.ui.uiNode,
      viewNode = "ScrollView_Record_Pvp"
    }
  }
end

function SocialPlayerBattleRecordComp:GetOtherPageComps()
  return {
    [CommonDefine.PlayerPanelType.PVE] = {
      cls = SocialOtherPveDataviewComp,
      gameObj = self.ui.uiNode,
      viewNode = "ScrollView_Record_Pve"
    },
    [CommonDefine.PlayerPanelType.PVP] = {
      cls = SocialPlayerPvpDataviewComp,
      gameObj = self.ui.uiNode,
      viewNode = "ScrollView_Record_Pvp"
    }
  }
end

function SocialPlayerBattleRecordComp:CreatePageComp(binder, page)
  local isMyInfo = self.model and self.model.isMyInfo
  local comps = isMyInfo and self:GetMyPageComps() or self:GetOtherPageComps()
  for p, cfg in pairs(comps) do
    self.ui[cfg.viewNode]:SetActive(p == page)
  end
  local compInfo = comps[page]
  if not compInfo then
    return
  end
  binder:BindComponent(compInfo.cls(compInfo.gameObj, self.model, compInfo.viewNode))
end

function SocialPlayerBattleRecordComp:BindTabButtons(binder)
  binder:BindZ1Button(self.ui.Btn_Pve, function()
    self:ShowPage(CommonDefine.PlayerPanelType.PVE)
  end, function()
    return self:IsPage(CommonDefine.PlayerPanelType.PVE) and cd.Z1ButtonState.High or cd.Z1ButtonState.Normal
  end)
  binder:BindZ1Button(self.ui.Btn_Pvp, function()
    self:ShowPage(CommonDefine.PlayerPanelType.PVP)
  end, function()
    return self:IsPage(CommonDefine.PlayerPanelType.PVP) and cd.Z1ButtonState.High or cd.Z1ButtonState.Normal
  end)
end

function SocialPlayerBattleRecordComp:BindReplayButtons(binder)
  binder:BindZ1Button(self.ui.Btn_Copy, System.fn(self, self.OnBtnCopy))
  binder:BindZ1Button(self.ui.Btn_Search, System.fn(self, self.OnBtnSearch))
  binder:SetButtonState(self.ui.Btn_Search, CommonDefine.Z1ButtonState.Unclickable)
end

function SocialPlayerBattleRecordComp:BindInputFieldChangeListener(binder)
  binder:BindToInputValueChange(self.ui.InputField_Code, function(input)
    local isFromPaste = false
    if not self._preInput and #input > 50 then
      isFromPaste = true
    end
    self._preInput = input
    if isFromPaste then
      local pasteStr = StrUtils.PasteFromClipboard()
      pasteStr = string.gsub(pasteStr, "\n", " ")
      self.binder:SetInputText(self.ui.InputField_Code, pasteStr)
    else
      input = string.gsub(input, "\n", " ")
      self.binder:SetInputText(self.ui.InputField_Code, input)
    end
    local btnState = string.isempty(input) and CommonDefine.Z1ButtonState.Unclickable or CommonDefine.Z1ButtonState.High
    binder:SetButtonState(self.ui.Btn_Search, btnState)
  end)
end

function SocialPlayerBattleRecordComp:BindRecordDisplayToggle(binder)
  binder:BindToVisible(self.ui.Toggle_Display, function()
    return self.model and self.model.isMyInfo
  end)
  binder:SetZ1Toggle(self.ui.Toggle_Display, 0 == PlayerDataUtils.GetHideReview(), true)
  binder:BindToZ1Toggle(self.ui.Toggle_Display, nil, function(isOn)
    CopyRecordsController.Instance:ReqSetHideReview(isOn and 0 or 1)
  end)
end

function SocialPlayerBattleRecordComp:OnBtnRules()
  UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("RuleTipsTitle"), LT.Text("ReplayTabRule"))
end

function SocialPlayerBattleRecordComp:OnBtnCopy()
  local str = StrUtils.PasteFromClipboard()
  if str then
    self.binder:SetInputText(self.ui.InputField_Code, str)
  end
end

function SocialPlayerBattleRecordComp:OnBtnSearch()
  local str = self.binder:GetInputText(self.ui.InputField_Code)
  if string.isempty(str) then
    Alert.Show(LT.Text("ReplayNullTips"))
    return
  end
  local shareCode = str
  local replayInfo = PVEBattleReplayUtils.GetReplayInfoFromCode(shareCode)
  if replayInfo and replayInfo.battleUuid then
    if replayInfo.replayType == CommonDefine.ReplayType.PVP then
      ProtoManager.Instance:ReqServer("GameRequest", "GetReplayDetail", function(recordData)
        if not recordData.statsData or not table.next(recordData.statsData) then
          Alert.Show("PVEReplayErrorTips")
          return
        end
        UIManager.Instance:Reopen(Urls.PvpReplayAnglePanel, recordData)
      end, function()
      end, replayInfo.battleUuid, replayInfo.playerUid)
    else
      CopyRecordsController.Instance:ReqQueryReviewDetailByBattleUuid(replayInfo.battleUuid, function(data)
        local recordStageData = data.teamData.recordStageData
        recordStageData = CopyBattleStatisticsDataUtils.ApplyRecordOwnerSnapshot(recordStageData, data.playerId or replayInfo.playerUid)
        CopySettleModel.Instance:UpdateBySvrData({
          teamData = data.teamData,
          recordStageData = recordStageData
        })
        CopyController.Instance:OnOpenCopySettleBaseView()
      end)
    end
  else
    Alert.ShowStr(LT.Text("PvPReplayCode_ErrorPaste"))
  end
end

function SocialPlayerBattleRecordComp:IsPage(page)
  return self._page.value == page
end

function SocialPlayerBattleRecordComp:ShowPage(page)
  self._page.value = page
end

function SocialPlayerBattleRecordComp:BindPageComps(binder)
  binder:BindToRaw(function(cbinder, page)
    self:CreatePageComp(cbinder, page)
  end, function()
    return self._page.value
  end)
end

return SocialPlayerBattleRecordComp
