local PVPRankPanel, Super = System.NewClass("PVPRankPanel", RankBaseView)
PVPRankPanel.uiResCls = UI_Pvp_Popup_TipsResource
local RankType = RankDefine.RankType
local SeasonGameplayType = CommonDefine.SeasonGameplayType
local StrategyPreBuilt = SeasonRankStrategy.PvpPreBuilt
local StrategyDraft = SeasonRankStrategy.PvpDraft
local Vector3 = CS.UnityEngine.Vector3
local RankTabIndex = 1
local RewardTabIndex = 2

function PVPRankPanel:ctor()
  Super.ctor(self)
  self.toggleIndex = Vue.ref(nil)
  self._pvpGameType = nil
  self._curSeasonTid = 0
  self.histSeasonCfgListByPage = {
    [SeasonGameplayType.PvpPreBuilt] = {},
    [SeasonGameplayType.PvpDraft] = {}
  }
  self.histSeasonCfgList = {}
  SdkMgr.Instance:JfCommitEvent(CommonDefine.SdkJfEventNameType.RankBoard, {
    rankType = RankDefine.RankType.PVP
  })
end

function PVPRankPanel:_GetHistSeasonCfgList(gameplayType)
  local firstRotationCfg = SeasonRotationModel.Instance:GetFirstRotationCfg()
  local curSeasonTid = SeasonRotationModel.Instance:GetSeasonId(gameplayType)
  if (not curSeasonTid or 0 == curSeasonTid) and firstRotationCfg and firstRotationCfg.ID then
    curSeasonTid = firstRotationCfg.ID
  end
  if not curSeasonTid or 0 == curSeasonTid then
    return {}
  end
  local firstRotationStartTime = SeasonRotationModel.Instance:GetFirstRotationStartTime()
  local seasonCfgs = {}
  local curSeasonCfg = SeasonRotationCfgUtils.GetSeasonCfg(curSeasonTid)
  if not curSeasonCfg then
    return {}
  end
  for seasonId, seasonCfg in pairs(SeasonRotationCfgUtils.GetSeasonCfgList()) do
    if seasonCfg.BaseSortID <= curSeasonCfg.BaseSortID then
      table.insert(seasonCfgs, {
        ID = seasonId,
        Name = SeasonRotationCfgUtils.GetName(seasonId, gameplayType),
        IsSeasonRotation = true,
        gameplayType = gameplayType,
        BaseSortID = seasonCfg.BaseSortID
      })
    end
  end
  for _, cfg in pairs(DT.PVPSeason or {}) do
    if cfg.StartTime and firstRotationStartTime > cfg.StartTime then
      table.insert(seasonCfgs, {
        ID = cfg.ID,
        Name = cfg.Name,
        IsSeasonRotation = false,
        gameplayType = gameplayType,
        BaseSortID = cfg.BaseSortID
      })
    end
  end
  table.sort(seasonCfgs, function(a, b)
    if a.IsSeasonRotation ~= b.IsSeasonRotation then
      return a.IsSeasonRotation
    end
    local sa = a.BaseSortID or 0
    local sb = b.BaseSortID or 0
    return sa > sb
  end)
  return seasonCfgs
end

function PVPRankPanel:_InitSeasonState()
  self.histSeasonCfgListByPage[SeasonGameplayType.PvpPreBuilt] = self:_GetHistSeasonCfgList(SeasonGameplayType.PvpPreBuilt)
  self.histSeasonCfgListByPage[SeasonGameplayType.PvpDraft] = self:_GetHistSeasonCfgList(SeasonGameplayType.PvpDraft)
  self.histSeasonCfgList = self.histSeasonCfgListByPage[self._pvpGameType] or {}
end

function PVPRankPanel:RegisterEvents()
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_Rank_Pvp, System.fn(self, self._OnToggleRankPvp))
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_Rank_RotationMode, System.fn(self, self._OnToggleRankRotationMode))
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Season, System.fn(self, self._OnClickSeason))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Question, System.fn(self, self._OnClickQuestion))
  self:BindEvent(EventMgr.Instance.RankUpdate, System.fn(self, self.OnRankUpdate))
end

function PVPRankPanel:_OnClickSeason()
  self:_RefreshSeasonEntry(not self.ui.ScrollView_Seasons.activeSelf)
end

function PVPRankPanel:_OnClickQuestion()
  local strategy = self:_GetCurStrategy()
  if not strategy then
    return
  end
  UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text(strategy.ruleTitle), LT.Text(strategy.ruleDesc))
end

function PVPRankPanel:_GetCurStrategy()
  if self._pvpGameType == SeasonGameplayType.PvpDraft then
    return StrategyDraft
  end
  return StrategyPreBuilt
end

function PVPRankPanel:_OnToggleRankPvp(isOn)
  if isOn then
    self:_SetPvpGameType(SeasonGameplayType.PvpPreBuilt)
  end
end

function PVPRankPanel:_OnToggleRankRotationMode(isOn)
  if isOn then
    self:_SetPvpGameType(SeasonGameplayType.PvpDraft)
  end
end

function PVPRankPanel:OnBuildView()
  Super.OnBuildView(self)
  self:RegisterEvents()
  self:_InitSeasonState()
  self:CreateRankTableView()
  self:CreateRankRewardTableView()
  self:CreateHistoryTableView()
  self:_SetPvpGameType(SeasonGameplayType.PvpPreBuilt)
  self:_RefreshPvpPageEntry()
  self:_RefreshTopTabGroup()
  self:_CheckAndShowFirstLoadTip()
  self:_ReqRankData()
  self:_RefreshDualSeasonCountdown()
  self:_RefreshRankListSettlementNotice()
  self:BindTimer(1, -1, function()
    self:_RefreshDualSeasonCountdown()
    self:_RefreshRankListSettlementNotice()
  end)
  self.histTableView:ReloadData()
end

function PVPRankPanel:_CheckAndShowFirstLoadTip()
  local rankType = self:_GetCurRankType()
  local rankList = RankModel.Instance:GetRankListData(rankType, self._curSeasonTid)
  if not rankList or 0 == #rankList then
    self.ui.Group_Null_Black:SetActive(true)
    if self.ui.Text_C_NoTask then
      self:SetText(self.ui.Text_C_NoTask, LT.Text("RankDataFirstLoadTip"))
    end
    if self.ui.Text_Time then
      self.ui.Text_Time:SetActive(false)
    end
    self.ui.Image_Myself:SetActive(false)
  end
end

function PVPRankPanel:OnExitView()
  Super.OnExitView(self)
  RankModel.Instance:ResetRankType(RankDefine.RankType.PVP)
  RankModel.Instance:ResetRankType(RankDefine.RankType.DraftPVP)
end

function PVPRankPanel:_RefreshSeasonLabel(seasonData)
  local seasonName = seasonData and seasonData.Name or ""
  self:SetText(self.ui.Label_Season, LT.Text(seasonName))
end

function PVPRankPanel:_RefreshDualSeasonCountdown()
  local preBuiltSeasonId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.PvpPreBuilt)
  local draftSeasonId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.PvpDraft)
  if self.ui.Text_Time_Pvp then
    self:SetText(self.ui.Text_Time_Pvp, SeasonRotationCfgUtils.GetLeftTimeTextColored(preBuiltSeasonId, SeasonGameplayType.PvpPreBuilt))
  end
  if self.ui.Text_Time_RotationMode then
    self:SetText(self.ui.Text_Time_RotationMode, SeasonRotationCfgUtils.GetLeftTimeTextColored(draftSeasonId, SeasonGameplayType.PvpDraft))
  end
  if self.ui.Icon_CountDown_Pvp then
    self:SetActive(self.ui.Icon_CountDown_Pvp, true)
    self:SetImage(self.ui.Icon_CountDown_Pvp, SeasonRotationCfgUtils.GetLeftTimeHourglassIcon(preBuiltSeasonId, SeasonGameplayType.PvpPreBuilt))
  end
  if self.ui.Icon_CountDown_RotationMode then
    self:SetActive(self.ui.Icon_CountDown_RotationMode, true)
    self:SetImage(self.ui.Icon_CountDown_RotationMode, SeasonRotationCfgUtils.GetLeftTimeHourglassIcon(draftSeasonId, SeasonGameplayType.PvpDraft))
  end
end

function PVPRankPanel:_GetCurSeasonEndTime()
  local strategy = self:_GetCurStrategy()
  local endTime = SeasonRankStrategy.GetSeasonEndTime(strategy, self._curSeasonTid)
  if (not endTime or 0 == endTime) and DT.PVPSeason and DT.PVPSeason[self._curSeasonTid] then
    endTime = DT.PVPSeason[self._curSeasonTid].EndTime or 0
  end
  return endTime or 0
end

function PVPRankPanel:_GetCurrentSeasonTid()
  local strategy = self:_GetCurStrategy()
  local currentSeasonTid = SeasonRankStrategy.GetCurrentSeasonTid(strategy)
  currentSeasonTid = currentSeasonTid or SeasonRotationModel.Instance:GetFirstRotationId()
  return currentSeasonTid
end

function PVPRankPanel:_RefreshRankListSettlementNotice()
  local isRewardTab = self.toggleIndex.value == RewardTabIndex
  if self.ui.Text_RankTip then
    local showRankTip = false
    if not isRewardTab then
      local currentSeasonTid = self:_GetCurrentSeasonTid()
      showRankTip = self._curSeasonTid == currentSeasonTid
    end
    self.ui.Text_RankTip:SetActive(showRankTip)
  end
  if self.ui.Text_C_Hint then
    self.ui.Text_C_Hint:SetActive(isRewardTab)
  end
end

local targetRankTypes = {
  RankDefine.RankType.PVP,
  RankDefine.RankType.DraftPVP,
  RankDefine.RankType.SeasonRoPvpPrebuilt,
  RankDefine.RankType.SeasonRoPvpDraft
}

function PVPRankPanel:OnRankUpdate(targetType, subTid)
  if not table.contains(targetRankTypes, targetType) then
    return
  end
  if targetType ~= self:_GetCurRankType() or subTid ~= self._curSeasonTid then
    return
  end
  local rankList = RankModel.Instance:GetRankListData(targetType, subTid)
  if not rankList then
    return
  end
  self.rankTableView:ReloadData()
  self:_ScheduleInvalidRankRefresh()
  if self.ui.Text_C_NoTask then
    self:SetText(self.ui.Text_C_NoTask, "")
  end
  if self.ui.Text_Time then
    self.ui.Text_Time:SetActive(true)
  end
  self:UpdateSelfRank()
  self:CheckIsShowNull()
end

function PVPRankPanel:_RefreshTopTabGroup()
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_History, function(isOn)
    if isOn then
      self:ShowToggleIndex(RankTabIndex)
    end
  end)
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Ranking, function(isOn)
    if isOn then
      self:ShowToggleIndex(RewardTabIndex)
    end
  end)
  self:ShowToggleIndex(1)
end

function PVPRankPanel:ShowToggleIndex(index)
  if self.toggleIndex.value == index then
    return
  end
  self.cachedRankTableOffset = self.cachedRankTableOffset or {}
  if self.toggleIndex.value then
    self.cachedRankTableOffset[self.toggleIndex.value] = self.rankTableView:GetOffset()
  end
  self.toggleIndex.value = index
  self.ui.Group_Rank:SetActive(index ~= RewardTabIndex)
  self:UpdateSelfRank()
  self.ui.Group_RankReward:SetActive(index == RewardTabIndex)
  self.ui.Image_Season:SetActive(index ~= RewardTabIndex)
  self.ui.ScrollView_Seasons:SetActive(false)
  if index == RankTabIndex then
    self.rankTableView:ReloadData()
    local offset = self.cachedRankTableOffset[index]
    if offset then
      self.rankTableView:SetOffset(offset, false)
    end
  end
  self:CheckIsShowNull()
  if index == RewardTabIndex then
    self.rankRewardTableView:ReloadData()
    self.ui.ScrollView_RankReward:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect)).content.transform.anchoredPosition = CS.UnityEngine.Vector2(0, 0)
  end
  self:_RefreshRankListSettlementNotice()
end

function PVPRankPanel:CheckIsShowNull()
  local index = self.toggleIndex.value
  if index == RankTabIndex then
    local rankList = self:GetRankList() or {}
    local isEmpty = 0 == #rankList
    self.ui.Group_Null_Black:SetActive(isEmpty)
    if isEmpty and self.ui.Text_C_NoTask then
      self:SetText(self.ui.Text_C_NoTask, LT.Text("RankDataNull"))
    end
  else
    self.ui.Group_Null_Black:SetActive(false)
  end
end

function PVPRankPanel:CreateRankRewardTableView()
  local baseGameObj = self.ui.UI_Pvp_Item_Ranking
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  local rewardList = self:GetSortedRankRewardList()
  self.rankRewardTableView = self:CreateTableview(self.ui.ScrollView_RankReward, function()
    return #rewardList
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local rankType = self:_GetCurRankType()
    local seasonTid = self._curSeasonTid
    local selfRank = RankModel.Instance:GetSelfRankData(rankType, seasonTid)
    selfRank = selfRank or RankModel.Instance:GetSelfRankData(rankType)
    local selfRewardRankIndex = selfRank and selfRank:GetRewardRankIndex() or 0
    if selfRewardRankIndex <= 0 then
      selfRewardRankIndex = selfRank and selfRank:GetRank() or 0
    end
    local playersNum = RankModel.Instance:GetRankLengthData(rankType, seasonTid) or RankModel.Instance:GetRankLengthData(rankType) or 0
    itemComps[gameObj] = self.binder:BindComponent(PVPRankCfgItem(gameObj, rewardList[idx], selfRewardRankIndex, rankType, seasonTid, playersNum))
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

function PVPRankPanel:_RefreshSeasonEntry(isShow)
  local normalDirection = Vector3(1, 1, 1)
  local oppositeDiretion = Vector3(-1, 1, 1)
  self:SetActive(self.ui.ScrollView_Seasons, isShow)
  if isShow and self.histTableView then
    self.histTableView:ReloadData()
  end
  self.ui.Image_Arrow.transform.localScale = isShow and oppositeDiretion or normalDirection
end

function PVPRankPanel:_SetPvpGameType(gamePlayType)
  if self._pvpGameType == gamePlayType then
    return
  end
  self._pvpGameType = gamePlayType
  self:_ResetRankPagination()
  self._curSeasonTid = SeasonRotationModel.Instance:GetSeasonId(gamePlayType)
  if not self._curSeasonTid then
    self._curSeasonTid = SeasonRotationModel.Instance:GetFirstRotationId()
  end
  self:_ReqRankData()
  self.rankTableView:ReloadData()
  self:_ResetRankScroll(self.rankTableView)
  self.histSeasonCfgList = self.histSeasonCfgListByPage[gamePlayType] or {}
  if table.next(self.histSeasonCfgList) then
    local lastSeasonData = self.histSeasonCfgList[1]
    self:_RefreshSeasonLabel(lastSeasonData)
    self:_RefreshSeasonEntry(false)
  end
  if self.toggleIndex.value == RewardTabIndex then
    self.rankRewardTableView:ReloadData()
    self.ui.ScrollView_RankReward:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect)).content.transform.anchoredPosition = CS.UnityEngine.Vector2(0, 0)
  end
  self:_RefreshRankListSettlementNotice()
end

function PVPRankPanel:GetSortedRankRewardList()
  local strategy = self:_GetCurStrategy()
  local rowList = SeasonRankStrategy.GetRankRewardRowList(strategy, self._curSeasonTid)
  if rowList and #rowList > 0 then
    local list = {}
    for i = 1, #rowList do
      list[i] = rowList[i]
    end
    table.sort(list, function(a, b)
      return (a.RankLowerInterval or 0) < (b.RankLowerInterval or 0)
    end)
    return list
  end
  local list = {}
  for _, cfg in pairs(DT.PVPNewRank or {}) do
    local row = {
      ID = cfg.ID,
      BaseSortID = cfg.ID,
      Name = cfg.Name,
      RankIcon = cfg.RankIcon,
      RankLowerInterval = cfg.RankLowerInterval,
      RankUpperInterval = cfg.RankUpperInterval,
      NewRankReward = {}
    }
    for tid, count in pairs(cfg.CoinReward or {}) do
      row.NewRankReward[tid] = count
    end
    for tid, count in pairs(cfg.GoldReward or {}) do
      row.NewRankReward[tid] = count
    end
    table.insert(list, row)
  end
  table.sort(list, function(a, b)
    return (a.RankLowerInterval or 0) < (b.RankLowerInterval or 0)
  end)
  return list
end

function PVPRankPanel:GetRankList()
  local rankType = self:_GetCurRankType()
  do return RankModel.Instance.GetRankListData, RankModel.Instance, rankType end
  return RankModel.Instance.GetRankListData, RankModel.Instance, rankType, self._curSeasonTid
end

function PVPRankPanel:_GetCurRankType()
  local isPreBuilt = self._pvpGameType == SeasonGameplayType.PvpPreBuilt
  if SeasonRotationModel.Instance:IsOldPVPSeason(self._curSeasonTid) then
    return isPreBuilt and RankType.PVP or RankType.DraftPVP
  else
    return isPreBuilt and RankType.SeasonRoPvpPrebuilt or RankType.SeasonRoPvpDraft
  end
end

function PVPRankPanel:_GetRankTableView()
  return self.rankTableView
end

function PVPRankPanel:_GetRankRefreshContext()
  return self:_GetCurRankType(), self._curSeasonTid
end

function PVPRankPanel:_OnInvalidRankRefreshDone()
  if self.rankTableView then
    self.rankTableView:ReloadData()
  end
  self:UpdateSelfRank()
  self:CheckIsShowNull()
end

function PVPRankPanel:_ReqRankData()
  if self.toggleIndex.value == RankTabIndex then
    self:_RequestRankPage()
  end
end

function PVPRankPanel:_DoRequestRankData(startIndex, count, onSuccess, onFail)
  local rankType = self:_GetCurRankType()
  RankController.Instance:QueryRankData(rankType, self._curSeasonTid, startIndex, count, onSuccess, nil, onFail)
end

function PVPRankPanel:_GetRankListCount()
  return #(self:GetRankList() or {})
end

function PVPRankPanel:_OnRankPageSuccess()
  if self.rankTableView then
    self.rankTableView:ReloadData()
  end
  if self.ui.Text_C_NoTask then
    self:SetText(self.ui.Text_C_NoTask, "")
  end
  if self.ui.Text_Time then
    self.ui.Text_Time:SetActive(true)
  end
  self:UpdateSelfRank()
  self:CheckIsShowNull()
end

function PVPRankPanel:_RefreshPvpPageEntry()
  if self._pvpGameType == SeasonGameplayType.PvpPreBuilt then
    self:SetZ1Toggle(self.ui.Toggle_Rank_Pvp, true, true)
  else
    self:SetZ1Toggle(self.ui.Toggle_Rank_RotationMode, true, true)
  end
end

function PVPRankPanel:CreateRankTableView()
  local baseGameObj = self.ui.UI_Pvp_Item_Chess_Game
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.rankTableView = self:CreateTableview(self.ui.ScrollView_Rank, function()
    return #(self:GetRankList() or {})
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local rankList = self:GetRankList() or {}
    local rankData = rankList[idx]
    local rankType = self:_GetCurRankType()
    itemComps[gameObj] = self.binder:BindComponent(PVPRankItem(gameObj, rankData, self._curSeasonTid, rankType, self._pvpGameType))
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
  self:_SetupRankScroll(self.rankTableView)
end

function PVPRankPanel:CreateHistoryTableView()
  local baseGameObj = self.ui.UI_Pvp_Item_Season
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.histTableView = self:CreateTableview(self.ui.ScrollView_Seasons, function()
    return #self.histSeasonCfgList
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    
    local function clickFunc()
      local seasonData = self.histSeasonCfgList[idx]
      self:_RefreshSeasonLabel(seasonData)
      self._curSeasonTid = seasonData.ID
      self:_ResetRankPagination()
      self:_ReqRankData()
      self.rankTableView:ReloadData()
      self:_ResetRankScroll(self.rankTableView)
      self.ui.ScrollView_Seasons:SetActive(false)
      self:_RefreshRankListSettlementNotice()
    end
    
    itemComps[gameObj] = self.binder:BindComponent(PVPHistSeasonItem(gameObj, self.histSeasonCfgList[idx], clickFunc))
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

function PVPRankPanel:UpdateSelfRank()
  local toggleIndex = self.toggleIndex.value
  local rankType = self:_GetCurRankType()
  local selfRank = RankModel.Instance:GetSelfRankData(rankType, self._curSeasonTid)
  if self.selfRankItem then
    self.selfRankItem.binder:teardown()
    self.selfRankItem = nil
  end
  self.ui.Image_Myself:SetActive(toggleIndex ~= RewardTabIndex and nil ~= selfRank)
  if selfRank then
    self.selfRankItem = self.binder:BindComponent(PVPRankItem(self.ui.Rank_Item_My, selfRank, self._curSeasonTid, rankType, self._pvpGameType))
  end
end

return PVPRankPanel
