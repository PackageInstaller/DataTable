local RankRailWayView, Super = NewClass("RankRailWayView", RankBaseView)
RankRailWayView.uiResCls = UI_Dungeons_Popup_RailWayRankResource
local Vector3 = CS.UnityEngine.Vector3
local SeasonGameplayType = CommonDefine.SeasonGameplayType
local Strategy = SeasonRankStrategy.RailWay
local TabKey = {Rank = "Rank", RankAward = "RankAward"}

function RankRailWayView:ctor(viewData)
  Super.ctor(self)
  self:_InitViewData(viewData)
  RankModel.Instance:ResetRankType(self._rankType)
end

function RankRailWayView:OnBuildView()
  self:_CreateTableView()
  self:_CreateHistoryTableView()
  self:_CreateRankAwardTableView()
  self:_RefreshRankListSettlementNotice()
  self:BindTimer(1, -1, function()
    self:_RefreshRankListSettlementNotice()
  end)
end

function RankRailWayView:OnEnterView()
  self:_InitSeasonState()
  self:_CheckAndShowFirstLoadTip()
  self:_RequestRankPage()
  self:_SwitchTab(TabKey.Rank)
  self:_RefreshRankListSettlementNotice()
end

function RankRailWayView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  if self.ui.Btn_Season then
    self:AddButtonClickListener(self.ui.Btn_Season, System.fn(self, self._OnClickSeason))
  end
  if self.ui.Btn_Rank then
    self:AddButtonClickListener(self.ui.Btn_Rank, function()
      self:_SwitchTab(TabKey.Rank)
    end)
  end
  if self.ui.Btn_RankAward then
    self:AddButtonClickListener(self.ui.Btn_RankAward, function()
      self:_SwitchTab(TabKey.RankAward)
    end)
  end
  self:BindEvent(EventMgr.Instance.RankUpdate, System.fn(self, self._OnRankUpdate))
end

function RankRailWayView:_RefreshTabButtonState()
  local rankBtnState = self._curTab == TabKey.Rank
  local awardBtnState = self._curTab == TabKey.RankAward
  if self.ui.Btn_Rank then
    self:SetButtonChosen(self.ui.Btn_Rank, rankBtnState)
  end
  if self.ui.Btn_RankAward then
    self:SetButtonChosen(self.ui.Btn_RankAward, awardBtnState)
  end
end

function RankRailWayView:_InitViewData(viewData)
  self._rankType = RankDefine.RankType.SeasonRoRailWay
  self._curSeasonTid = 0
  self._histSeasonCfgList = {}
  self._selectRankType = viewData and viewData.selectRankType or nil
  self._rankUidList = {}
  self._curTab = TabKey.Rank
end

function RankRailWayView:_GetRailWayRankSubTid()
  local tid = self._curSeasonTid or 0
  if tid > 0 then
    return tid
  end
  return SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.ConsciousnessRailway) or nil
end

function RankRailWayView:_UpdateRankUidList()
  self._rankUidList = RankModel.Instance:GetRankListData(self._rankType, self:_GetRailWayRankSubTid()) or {}
end

function RankRailWayView:_DoRequestRankData(startIndex, count, onSuccess, onFail)
  local rankType = self._rankType
  local subTid = self:_GetRailWayRankSubTid()
  local targetTotalLength = RankModel.Instance:GetRankLengthData(rankType, subTid)
  if targetTotalLength then
    local endIdx = math.min(startIndex + count - 1, targetTotalLength)
    count = math.max(0, endIdx - startIndex + 1)
  end
  if count <= 0 then
    onFail()
    return
  end
  RankController.Instance:QueryRankData(rankType, subTid, startIndex, count, onSuccess, nil, onFail)
end

function RankRailWayView:_GetRankListCount()
  return #self._rankUidList
end

function RankRailWayView:_GetRankTableView()
  return self._rankListView
end

function RankRailWayView:_GetRankRefreshContext()
  return self._rankType, self:_GetRailWayRankSubTid()
end

function RankRailWayView:_OnRankPageSuccess()
  self:_UpdateRankUidList()
  self:_RefreshView()
end

function RankRailWayView:_OnInvalidRankRefreshDone()
  self:_UpdateRankUidList()
  self:_RefreshView()
end

function RankRailWayView:_OnRankUpdate(rankType, subTid)
  if rankType ~= self._rankType then
    return
  end
  if subTid ~= self:_GetRailWayRankSubTid() then
    return
  end
  if self.ui.Text_C_NoTask then
    self:SetText(self.ui.Text_C_NoTask, "")
  end
  self:_UpdateRankUidList()
  self:_RefreshView()
  self:_ScheduleInvalidRankRefresh()
end

function RankRailWayView:_RefreshView()
  self:_RefreshEmptyState()
  self:_RefreshRankList()
  self:_RefreshMyRank()
  self:_RefreshRankListSettlementNotice()
end

function RankRailWayView:_RefreshSeasonScrollHeight()
  if not self.ui.ScrollView_Seasons or not self.ui.UI_Pvp_Item_Season then
    return
  end
  local itemCount = #self._histSeasonCfgList
  local itemHeight = self.ui.UI_Pvp_Item_Season.transform.sizeDelta.y
  local sizeDelta = self.ui.ScrollView_Seasons.transform.sizeDelta
  local itemMaxCount = math.min(itemCount, 2)
  self.ui.ScrollView_Seasons.transform.sizeDelta = CS.UnityEngine.Vector2(sizeDelta.x, itemMaxCount * itemHeight)
end

function RankRailWayView:_InitSeasonState()
  self._curSeasonTid = SeasonRankStrategy.GetCurrentSeasonTid(Strategy)
  self:_ResetRankPagination()
  self:_RefreshSeasonLabelBySeasonId(self._curSeasonTid)
  self._histSeasonCfgList = SeasonRankStrategy.GetHistSeasonCfgList(Strategy, self._curSeasonTid)
  self:_RefreshSeasonScrollHeight()
  self:_RefreshSeasonEntry(false)
  if self.histTableView then
    self.histTableView:ReloadData()
  end
end

function RankRailWayView:_RefreshSeasonLabelBySeasonId(seasonId)
  if not self.ui.Label_Season then
    return
  end
  if not seasonId or 0 == seasonId then
    self:SetText(self.ui.Label_Season, "")
    return
  end
  local curSeasonTid = SeasonRankStrategy.GetCurrentSeasonTid(Strategy)
  local showLabel = curSeasonTid == seasonId and LT.Text("AbyssChallengeRankThisPeriod") or LT.Text("AbyssChallengeRankPreviousPeriod")
  self:SetText(self.ui.Label_Season, showLabel)
end

function RankRailWayView:_OnClickSeason()
  if not self.ui.ScrollView_Seasons then
    return
  end
  self:_RefreshSeasonEntry(not self.ui.ScrollView_Seasons.activeSelf)
end

function RankRailWayView:_RefreshSeasonEntry(isShow)
  if not self.ui.ScrollView_Seasons then
    return
  end
  self:SetActive(self.ui.ScrollView_Seasons, isShow)
  if self.ui.Image_Arrow then
    local normalDirection = Vector3(1, 1, 1)
    local oppositeDirection = Vector3(-1, 1, 1)
    self.ui.Image_Arrow.transform.localScale = isShow and oppositeDirection or normalDirection
  end
end

function RankRailWayView:_SwitchTab(tabKey)
  self._curTab = tabKey
  local isRank = tabKey == TabKey.Rank
  local isAward = tabKey == TabKey.RankAward
  self:SetActive(self.ui.Group_Rank, isRank)
  self:SetActive(self.ui.Group_RankAward, isAward)
  self:_RefreshTabButtonState()
  self:_RefreshEmptyState()
  if isRank then
    self:_RefreshView()
  elseif isAward then
    self:_RefreshRankAwardList()
  end
  self:_RefreshRankListSettlementNotice()
end

function RankRailWayView:_RefreshRankListSettlementNotice()
  if not self.ui.Text_Tip then
    return
  end
  local isAwardTab = self._curTab == TabKey.RankAward
  if isAwardTab then
    local currentSeasonTid = SeasonRankStrategy.GetCurrentSeasonTid(Strategy)
    local endTime = SeasonRankStrategy.GetSeasonEndTime(Strategy, currentSeasonTid)
    local noticeText = SeasonRankStrategy.FormatSettlementNotice(endTime)
    if not noticeText then
      self.ui.Text_Tip:SetActive(false)
      return
    end
    self.ui.Text_Tip:SetActive(true)
    self:SetText(self.ui.Text_Tip, noticeText)
  else
    local currentSeasonTid = SeasonRankStrategy.GetCurrentSeasonTid(Strategy)
    local isCurrentSeason = self._curSeasonTid == currentSeasonTid
    if not isCurrentSeason then
      self.ui.Text_Tip:SetActive(false)
      return
    end
    local endTime = SeasonRankStrategy.GetSeasonEndTime(Strategy, self._curSeasonTid)
    local noticeText = SeasonRankStrategy.FormatSettlementNotice(endTime)
    if not noticeText then
      self.ui.Text_Tip:SetActive(false)
      return
    end
    self.ui.Text_Tip:SetActive(true)
    self:SetText(self.ui.Text_Tip, noticeText)
  end
end

function RankRailWayView:_GetRankAwardShowData()
  local seasonGroupId = self._curSeasonTid
  if not seasonGroupId or 0 == seasonGroupId then
    seasonGroupId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.ConsciousnessRailway)
  end
  if not seasonGroupId or 0 == seasonGroupId then
    return {}
  end
  local rowList = SeasonRotationModel.Instance:GetSeasonRankRewardRowList(seasonGroupId, SeasonGameplayType.ConsciousnessRailway)
  if not rowList or 0 == #rowList then
    return {}
  end
  local baseSortID, baseIdx
  for idx, row in ipairs(rowList) do
    if row and row.BaseSortID and row.BaseSortID > 0 then
      baseSortID = row.BaseSortID
      baseIdx = idx
      break
    end
  end
  local result = {}
  for idx, row in ipairs(rowList) do
    local rewardGroup = RankingBoardDataUtils.GetSeasonRankRowRewards(row)
    local rankID
    if row and row.BaseSortID and row.BaseSortID > 0 then
      rankID = row.BaseSortID
    elseif baseSortID and baseIdx then
      rankID = baseSortID + (idx - baseIdx)
    else
      rankID = idx
    end
    table.insert(result, {
      rankID = rankID,
      title = row and row.Name or "",
      titleBG = row and row.RankIcon or "",
      lowerLimit = row and row.RankLowerInterval or 0,
      higherLimit = row and row.RankUpperInterval or 0,
      rewardGroup = rewardGroup
    })
  end
  table.sort(result, function(a, b)
    return (a.lowerLimit or 0) < (b.lowerLimit or 0)
  end)
  return result
end

function RankRailWayView:_RefreshRankAwardList()
  self._rankAwardShowData = SeasonRankStrategy.GetSortedRewardShowData(Strategy, self._curSeasonTid)
  self._rankAwardRuleModel = self:_BuildRankAwardRuleModel()
  self._rankAwardListView:ReloadData()
end

function RankRailWayView:_BuildRankAwardRuleModel()
  local currentSeasonTid = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.ConsciousnessRailway)
  local totalNum = RankModel.Instance:GetRankLengthData(self._rankType, currentSeasonTid) or #self._rankUidList or 0
  local rankMO = RankModel.Instance:GetSelfRankData(self._rankType, currentSeasonTid)
  local rewardRankIndex = 0
  if rankMO then
    rewardRankIndex = rankMO:GetRewardRankIndex() or 0
  end
  if rewardRankIndex <= 0 then
    rewardRankIndex = rankMO and (rankMO:GetRank() or 0) or 0
  end
  do return SeasonRankStrategy.BuildRankRangesModel, self._rankAwardShowData, totalNum end
  return SeasonRankStrategy.BuildRankRangesModel, self._rankAwardShowData, totalNum, rewardRankIndex
end

function RankRailWayView:_RefreshEmptyState()
  if self._rankIsRequesting then
    return
  end
  local isShowNull = self._curTab == TabKey.Rank and 0 == table.length(self._rankUidList)
  self:SetActive(self.ui.Group_Null_Black, isShowNull)
  if isShowNull and self.ui.Text_C_NoTask then
    self:SetText(self.ui.Text_C_NoTask, LT.Text("RankDataNull"))
  end
end

function RankRailWayView:_RefreshRankList()
  self._rankListView:ReloadData()
end

function RankRailWayView:_RefreshMyRank()
  local rankMO = RankModel.Instance:GetSelfRankData(self._rankType, self:_GetRailWayRankSubTid())
  if not rankMO then
    self:SetActive(self.ui.Item_Rank_My, false)
    return
  end
  self:SetActive(self.ui.Item_Rank_My, true)
  self:AddViewComponentOnce(self.ui.Item_Rank_My, UICompRankRailWayItem, rankMO)
end

function RankRailWayView:_CreateTableView()
  local assistRankItemSizeDelta = self.ui.UI_Dungeons_Item_RailWayRank.transform.sizeDelta
  self._rankListView = self:CreateTableview(self.ui.ScrollView_Rank, function()
    return #self._rankUidList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Dungeons_Item_RailWayRank)
    self:_FillRankCell(cell, index)
    return cell
  end, function()
    return assistRankItemSizeDelta.x, assistRankItemSizeDelta.y
  end)
  self:_SetupRankScroll(self._rankListView)
end

function RankRailWayView:_CheckAndShowFirstLoadTip()
  local rankList = RankModel.Instance:GetRankListData(self._rankType, self:_GetRailWayRankSubTid())
  if not rankList or 0 == #rankList then
    self:SetActive(self.ui.Group_Null_Black, true)
    if self.ui.Text_C_NoTask then
      self:SetText(self.ui.Text_C_NoTask, LT.Text("RankDataFirstLoadTip"))
    end
    self:SetActive(self.ui.Item_Rank_My, false)
  end
end

function RankRailWayView:_CreateHistoryTableView()
  if not self.ui.ScrollView_Seasons or not self.ui.UI_Pvp_Item_Season then
    return
  end
  local baseGameObj = self.ui.UI_Pvp_Item_Season
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.histTableView = self:CreateTableview(self.ui.ScrollView_Seasons, function()
    return #self._histSeasonCfgList
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Pvp_Item_Season)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local seasonData = self._histSeasonCfgList[idx]
    
    local function clickFunc()
      if not seasonData or not seasonData.ID then
        return
      end
      self._curSeasonTid = seasonData.ID
      self:_ResetRankPagination()
      RankModel.Instance:ResetRankType(self._rankType, self:_GetRailWayRankSubTid())
      self:_RefreshSeasonLabelBySeasonId(self._curSeasonTid)
      self.ui.ScrollView_Seasons:SetActive(false)
      self:_CheckAndShowFirstLoadTip()
      self:_RequestRankPage()
      self:_ResetRankScroll(self._rankListView)
    end
    
    itemComps[gameObj] = self.binder:BindComponent(PVPHistSeasonItem(gameObj, seasonData, clickFunc))
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

function RankRailWayView:_FillRankCell(cell, index)
  local rankMO = self._rankUidList[index]
  if not rankMO or type(rankMO) ~= "table" or type(rankMO.GetUid) ~= "function" then
    self:SetActive(cell.gameObject, false)
    return
  end
  self:SetActive(cell.gameObject, true)
  self:AddViewComponentOnce(cell.gameObject, UICompRankRailWayItem, rankMO)
end

function RankRailWayView:_CreateRankAwardTableView()
  if not self.ui.ScrollView_RankAward or not self.ui.UI_Dungeous_Item_Reward then
    return
  end
  local baseGameObj = self.ui.UI_Dungeous_Item_Reward
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self._rankAwardShowData = {}
  self._rankAwardListView = self:CreateTableview(self.ui.ScrollView_RankAward, function()
    return #self._rankAwardShowData
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
      itemComps[gameObj] = nil
    end
    local data = self._rankAwardShowData[idx]
    if data then
      local ruleModel = self._rankAwardRuleModel or {
        rankRanges = {},
        currPlayerRank = 0
      }
      itemComps[gameObj] = self.binder:BindComponent(DailyChallengeRewardRuleItem(gameObj, data, ruleModel))
    end
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

return RankRailWayView
