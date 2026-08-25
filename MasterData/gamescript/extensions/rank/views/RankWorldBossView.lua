local RankWorldBossView, Super = NewClass("RankWorldBossView", RankBaseView)
RankWorldBossView.uiResCls = UI_Events_Popup_WorldBossRankResource

function RankWorldBossView:ctor(viewData)
  Super.ctor(self)
  self:_InitViewData(viewData)
end

function RankWorldBossView:OnBuildView()
  self:_CreateTableView()
  RankModel.Instance:ClearRank(self._killRankType)
  RankModel.Instance:ClearRank(self._assistRankType)
  self:_CheckAndShowFirstLoadTip()
end

function RankWorldBossView:OnEnterView()
  self:_InitToggleState()
  self._killRankPage = 1
  self._assistRankPage = 1
  self:_RequestRankPage(self._killRankType, self._killRankPage)
  self:_RequestRankPage(self._assistRankType, self._assistRankPage)
end

function RankWorldBossView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_KillRank, System.fn(self, self._OnClickToggleSkillRank))
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_AssistRank, System.fn(self, self._OnClickToggleAssistRank))
end

function RankWorldBossView:_OnClickToggleSkillRank(isOn)
  if isOn then
    self:_SetSelectRankType(self._killRankType)
    self:_RefreshView()
  end
end

function RankWorldBossView:_OnClickToggleAssistRank(isOn)
  if isOn then
    self:_SetSelectRankType(self._assistRankType)
    self:_RefreshView()
  end
end

function RankWorldBossView:_InitViewData(viewData)
  self._killRankType = viewData and viewData.killRankType or RankDefine.RankType.WorldBossKill
  self._assistRankType = viewData and viewData.assistRankType or RankDefine.RankType.WorldBossAssist
  self._selectRankType = viewData and viewData.selectRankType or self._killRankType
  if self._selectRankType ~= self._killRankType and self._selectRankType ~= self._assistRankType then
    self._selectRankType = self._killRankType
  end
  self._killRankUidList = {}
  self._assistRankUidList = {}
  self._killRankPage = 1
  self._assistRankPage = 1
end

function RankWorldBossView:_UpdateKillRankUidList()
  self._killRankUidList = RankModel.Instance:GetRankSequence(self._killRankType)
end

function RankWorldBossView:_UpdateAssistRankUidList()
  self._assistRankUidList = RankModel.Instance:GetRankSequence(self._assistRankType)
end

function RankWorldBossView:_SetSelectRankType(rankType)
  self._selectRankType = rankType
end

function RankWorldBossView:_RequestKillRankPage()
  if self._rankIsRequesting then
    return
  end
  local targetTotalLength = RankModel.Instance:GetRankLength(self._killRankType)
  if targetTotalLength and targetTotalLength <= #self._killRankUidList then
    return
  end
  self._killRankPage = self._killRankPage + 1
  self:_RequestRankPage(self._killRankType, self._killRankPage)
end

function RankWorldBossView:_RequestAssistRankPage()
  if self._rankIsRequesting then
    return
  end
  local targetTotalLength = RankModel.Instance:GetRankLength(self._assistRankType)
  if targetTotalLength and targetTotalLength <= #self._assistRankUidList then
    return
  end
  self._assistRankPage = self._assistRankPage + 1
  self:_RequestRankPage(self._assistRankType, self._assistRankPage)
end

function RankWorldBossView:_CheckAndShowFirstLoadTip()
  if self.ui.Group_Null_KillRank then
    self:SetActive(self.ui.Group_Null_KillRank, true)
  end
  if self.ui.Text_C_Empty_Kill then
    self:SetText(self.ui.Text_C_Empty_Kill, LT.Text("RankDataFirstLoadTip"))
  end
  if self.ui.Group_Null_AssistRank then
    self:SetActive(self.ui.Group_Null_AssistRank, true)
  end
  if self.ui.Text_C_Empty_Assist then
    self:SetText(self.ui.Text_C_Empty_Assist, LT.Text("RankDataFirstLoadTip"))
  end
end

function RankWorldBossView:_ClearLoadingText()
  if self.ui.Text_C_Empty_Kill then
    self:SetText(self.ui.Text_C_Empty_Kill, "")
  end
  if self.ui.Text_C_Empty_Assist then
    self:SetText(self.ui.Text_C_Empty_Assist, "")
  end
end

function RankWorldBossView:_RequestRankPage(rankType, rankPage)
  local targetTotalLength = RankModel.Instance:GetRankLength(rankType)
  self._rankIsRequesting = true
  local startIdx = (rankPage - 1) * self._rankPageSize + 1
  local endIdx = startIdx + self._rankPageSize - 1
  if targetTotalLength then
    endIdx = math.min(endIdx, targetTotalLength)
  end
  local count = endIdx - startIdx + 1
  RankController.Instance:QueryRankData(rankType, nil, startIdx, count, function()
    self._rankIsRequesting = false
    self:_ClearLoadingText()
    self:_UpdateKillRankUidList()
    self:_UpdateAssistRankUidList()
    self:_RefreshView()
  end, nil, function()
    self._rankIsRequesting = false
  end)
end

function RankWorldBossView:_RefreshView()
  self:_RefreshEmptyState()
  self:_RefreshRankList()
  self:_RefreshMyRank()
end

function RankWorldBossView:_InitToggleState()
  local targetToggleUi
  if self._selectRankType == self._killRankType then
    targetToggleUi = self.ui.Toggle_KillRank
  elseif self._selectRankType == self._assistRankType then
    targetToggleUi = self.ui.Toggle_AssistRank
  end
  if targetToggleUi then
    self:SetZ1Toggle(targetToggleUi, true)
  end
end

function RankWorldBossView:_RefreshEmptyState()
  if self._rankIsRequesting then
    return
  end
  local killEmpty = 0 == table.length(self._killRankUidList)
  local assistEmpty = 0 == table.length(self._assistRankUidList)
  self:SetActive(self.ui.Group_Null_KillRank, killEmpty)
  self:SetActive(self.ui.Group_Null_AssistRank, assistEmpty)
  if self.ui.Text_C_Empty_Kill then
    self:SetText(self.ui.Text_C_Empty_Kill, killEmpty and LT.Text("RankDataNull") or "")
  end
  if self.ui.Text_C_Empty_Assist then
    self:SetText(self.ui.Text_C_Empty_Assist, assistEmpty and LT.Text("RankDataNull") or "")
  end
end

function RankWorldBossView:_RefreshRankList()
  local isShowKillRank = self._selectRankType == self._killRankType
  local isShowAssistRank = self._selectRankType == self._assistRankType
  self:SetActive(self.ui.Group_KillRank, isShowKillRank)
  self:SetActive(self.ui.Group_AssistRank, isShowAssistRank)
  if isShowKillRank then
    self._killRankListView:ReloadData()
  end
  if isShowAssistRank then
    self._assistRankListView:ReloadData()
  end
end

function RankWorldBossView:_NextKillRankPage()
  if not self:_TryThrottleRankRequest() then
    return
  end
  self:_RequestKillRankPage()
end

function RankWorldBossView:_NextAssistRankPage()
  if not self:_TryThrottleRankRequest() then
    return
  end
  self:_RequestAssistRankPage()
end

function RankWorldBossView:_RefreshMyRank()
  local playerUid = PlayerDataUtils.GetPlayerUid()
  local isShowKillRank = self._selectRankType == self._killRankType
  local isShowAssistRank = self._selectRankType == self._assistRankType
  self:SetActive(self.ui.My_KillRank, false)
  self:SetActive(self.ui.My_AssistRank, false)
  if isShowKillRank then
    local rankMO = RankModel.Instance:GetRankMO(self._killRankType, nil, playerUid)
    rankMO = rankMO or RankModel.Instance:GetSelfRankData(self._killRankType, nil)
    if rankMO then
      self:SetActive(self.ui.My_KillRank, true)
      self:AddViewComponentOnce(self.ui.My_KillRank, UICompRankWorldBossKillItem, rankMO)
    end
  end
  if isShowAssistRank then
    local rankMO = RankModel.Instance:GetRankMO(self._assistRankType, nil, playerUid)
    rankMO = rankMO or RankModel.Instance:GetSelfRankData(self._assistRankType, nil)
    if rankMO then
      self:SetActive(self.ui.My_AssistRank, true)
      self:AddViewComponentOnce(self.ui.My_AssistRank, UICompRankWorldBossAssistItem, rankMO)
    end
  end
end

function RankWorldBossView:_CreateTableView()
  local killRankItemSizeDelta = self.ui.UI_Events_Item_KillRank.transform.sizeDelta
  self._killRankListView = self:CreateTableview(self.ui.ScrollView_KillRank, function()
    return #self._killRankUidList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Events_Item_KillRank)
    self:_FillKillRankCell(cell, index)
    return cell
  end, function()
    return killRankItemSizeDelta.x, killRankItemSizeDelta.y
  end)
  self:_SetupRankScroll(self._killRankListView, 0, function()
    self:_NextKillRankPage()
  end)
  local assistRankItemSizeDelta = self.ui.UI_Events_Item_AssistRank.transform.sizeDelta
  self._assistRankListView = self:CreateTableview(self.ui.ScrollView_AssistRank, function()
    return #self._assistRankUidList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Events_Item_AssistRank)
    self:_FillAssistRankCell(cell, index)
    return cell
  end, function()
    return assistRankItemSizeDelta.x, assistRankItemSizeDelta.y
  end)
  self:_SetupRankScroll(self._assistRankListView, 0, function()
    self:_NextAssistRankPage()
  end)
end

function RankWorldBossView:_FillKillRankCell(cell, index)
  local rankUid = self._killRankUidList[index]
  local rankMO = RankModel.Instance:GetRankMO(self._killRankType, nil, rankUid)
  self:AddViewComponentOnce(cell.gameObject, UICompRankWorldBossKillItem, rankMO)
end

function RankWorldBossView:_FillAssistRankCell(cell, index)
  local rankUid = self._assistRankUidList[index]
  local rankMO = RankModel.Instance:GetRankMO(self._assistRankType, nil, rankUid)
  self:AddViewComponentOnce(cell.gameObject, UICompRankWorldBossAssistItem, rankMO)
end

return RankWorldBossView
