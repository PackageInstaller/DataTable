local DailyChallengeBoardEntryPanel, Super = System.NewClass("DailyChallengeBoardEntryPanel", RankBaseView)
DailyChallengeBoardEntryPanel.uiResCls = UI_Dungeons_Popup_List_TipResource
local Vector3 = CS.UnityEngine.Vector3
local Strategy = SeasonRankStrategy.DailyChallenge
local RankAwardTab = "RankAward"
local TabKeys = {
  SurveyRanking = "SurveyRanking",
  RankAward = "RankAward"
}
local RankTypeMap = {
  [TabKeys.SurveyRanking] = RankDefine.RankType.SeasonRoDailyChallenge
}
local INITIAL_QUERY_NUM = 10
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)

function DailyChallengeBoardEntryPanel:ctor()
  Super.ctor(self)
  self._tabKey = TabKeys.SurveyRanking
  AwakerFilterListController.Instance:SetFilterType(CommonDefine.AwakerFilterType.DailyChallengeRank)
  for _, rankType in pairs(RankTypeMap) do
    SdkMgr.Instance:JfCommitEvent(CommonDefine.SdkJfEventNameType.RankBoard, {rankType = rankType})
  end
end

function DailyChallengeBoardEntryPanel:RegisterNotifications()
  GlobalDispatcher:AddListener(NotifyId.OnSaveAwakerFilter, self._OnSaveAwakerFilter, self)
end

function DailyChallengeBoardEntryPanel:OnBuildView()
  Super.OnBuildView(self)
  self.model = DailyChallengeBoardEntryPanelModel.Instance
  self.model:OnReset()
  self.model:SetSeasonTid(DailyChallengeDataUtils.GetNowSeasonTid() or 0)
  self._myInfoBinder = nil
  self._awardShowData = self:InitAwardShowData()
  self:_InitSeasonFilter()
  self:_CreateRankTableView()
  self:_CreateAwardRuleTableView()
  self:_RefreshRankListSettlementNotice()
  self:BindTimer(1, -1, function()
    self:_RefreshRankListSettlementNotice()
  end)
end

function DailyChallengeBoardEntryPanel:OnEnterView()
  Super.OnEnterView(self)
  self:_CheckAndShowFirstLoadTip()
  self:SetShowingBoard(TabKeys.SurveyRanking)
  self:_RequestCurrentBoardData()
  self:_RefreshFilterAwakerBtnState()
  self:_RefreshView()
  self:_RefreshRankListSettlementNotice()
  if self._awardRuleTableView then
    self._awardRuleTableView:ReloadData()
  end
end

function DailyChallengeBoardEntryPanel:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Game, function()
    self:SetShowingBoard(TabKeys.SurveyRanking)
  end)
  self:AddButtonClickListener(self.ui.Btn_Activity, function()
    self:SetShowingBoard(TabKeys.RankAward)
    self:_RequestRankRewardInfo(RankTypeMap[TabKeys.RankAward])
  end)
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Question, System.fn(self, self._OnClickRule))
  self:AddButtonClickListener(self.ui.Btn_FilterAwaker, System.fn(self, self._OnClickFilterAwaker))
  self:AddButtonClickListener(self.ui.Btn_Season, System.fn(self, self._OnClickSeason))
end

function DailyChallengeBoardEntryPanel:OnExitView()
  Super.OnExitView(self)
  GlobalDispatcher:RemoveListener(NotifyId.OnSaveAwakerFilter, self._OnSaveAwakerFilter, self)
  NetBlockMgr.Instance:CancelBlocked(true)
  AwakerFilterListController.Instance:ClearFilterData(CommonDefine.AwakerFilterType.DailyChallengeRank)
  self:_ReqDailyChallengeData()
end

function DailyChallengeBoardEntryPanel:_RefreshRankListSettlementNotice()
  if not self.ui.Text_C_Prompt then
    return
  end
  local currentSeasonTid = DailyChallengeDataUtils.GetNowSeasonTid() or 0
  local isAwardTab = self._tabKey == TabKeys.RankAward
  local noticeText
  if isAwardTab then
    local endTime = SeasonRankStrategy.GetSeasonEndTime(Strategy, currentSeasonTid)
    noticeText = SeasonRankStrategy.FormatSettlementNotice(endTime)
  else
    local seasonTid = self.model and self.model:GetSeasonTid() or 0
    if 0 == seasonTid then
      seasonTid = currentSeasonTid
    end
    if seasonTid == currentSeasonTid then
      local endTime = SeasonRankStrategy.GetSeasonEndTime(Strategy, seasonTid)
      noticeText = SeasonRankStrategy.FormatSettlementNotice(endTime)
    end
  end
  if not noticeText then
    self.ui.Text_C_Prompt:SetActive(false)
    return
  end
  self.ui.Text_C_Prompt:SetActive(true)
  self:SetText(self.ui.Text_C_Prompt, noticeText)
end

function DailyChallengeBoardEntryPanel:_OnClickRule()
  UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text(Strategy.ruleTitle), LT.Text(Strategy.ruleDesc))
end

function DailyChallengeBoardEntryPanel:_RefreshSeasonScrollHeight()
  if not self.ui.ScrollView_Seasons or not self.ui.UI_Pvp_Item_Season then
    return
  end
  local itemCount = #self._histSeasonCfgList
  local itemHeight = self.ui.UI_Pvp_Item_Season.transform.sizeDelta.y
  local sizeDelta = self.ui.ScrollView_Seasons.transform.sizeDelta
  local itemMaxCount = math.min(itemCount, 2)
  self.ui.ScrollView_Seasons.transform.sizeDelta = CS.UnityEngine.Vector2(sizeDelta.x, itemMaxCount * itemHeight)
end

function DailyChallengeBoardEntryPanel:_InitSeasonFilter()
  self._histSeasonCfgList = SeasonRankStrategy.GetHistSeasonCfgList(Strategy, self.model:GetSeasonTid())
  self:_RefreshSeasonLabelBySeasonId(self.model:GetSeasonTid() or 0)
  self:_RefreshSeasonEntry(false)
  self:_RefreshSeasonScrollHeight()
  if self.ui.ScrollView_Seasons and self.ui.UI_Pvp_Item_Season then
    self:_CreateSeasonHistoryTableView()
  end
end

function DailyChallengeBoardEntryPanel:_RefreshSeasonLabelBySeasonId(seasonTid)
  if not self.ui.Label_Season then
    return
  end
  if not seasonTid or 0 == seasonTid then
    self:SetText(self.ui.Label_Season, "")
    return
  end
  local curSeasonTid = DailyChallengeDataUtils.GetNowSeasonTid() or 0
  local showLabel = curSeasonTid == seasonTid and LT.Text("AbyssChallengeRankThisPeriod") or LT.Text("AbyssChallengeRankPreviousPeriod")
  self:SetText(self.ui.Label_Season, showLabel)
end

function DailyChallengeBoardEntryPanel:_OnClickSeason()
  if not self.ui.ScrollView_Seasons then
    return
  end
  self:_RefreshSeasonEntry(not self.ui.ScrollView_Seasons.activeSelf)
  if self.ui.ScrollView_Seasons.activeSelf and self._histSeasonTableView then
    self._histSeasonTableView:ReloadData()
  end
end

function DailyChallengeBoardEntryPanel:_RefreshSeasonEntry(isShow)
  if self.ui.ScrollView_Seasons then
    self:SetActive(self.ui.ScrollView_Seasons, isShow)
  end
  if self.ui.Image_Arrow then
    local normalDirection = Vector3(1, 1, 1)
    local oppositeDirection = Vector3(-1, 1, 1)
    self.ui.Image_Arrow.transform.localScale = isShow and oppositeDirection or normalDirection
  end
end

function DailyChallengeBoardEntryPanel:_CreateSeasonHistoryTableView()
  if not self.ui.ScrollView_Seasons or not self.ui.UI_Pvp_Item_Season then
    return
  end
  local baseGameObj = self.ui.UI_Pvp_Item_Season
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self._histSeasonTableView = self:CreateTableview(self.ui.ScrollView_Seasons, function()
    return #self._histSeasonCfgList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local seasonData = self._histSeasonCfgList[index]
    
    local function clickFunc()
      if not seasonData or not seasonData.ID then
        return
      end
      self.model:SetSeasonTid(seasonData.ID)
      self:_RefreshSeasonLabelBySeasonId(seasonData.ID)
      self:_RefreshSeasonEntry(false)
      self:SetShowingBoard(self.model.showingBoard or TabKeys.SurveyRanking)
      self:_ResetRankScrollPos()
      self:_CheckAndShowFirstLoadTip()
      self:_RequestCurrentBoardData()
    end
    
    itemComps[gameObj] = self.binder:BindComponent(PVPHistSeasonItem(gameObj, seasonData, clickFunc))
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

function DailyChallengeBoardEntryPanel:_CreateRankTableView()
  local owner = self.ui.ScrollView_Role_SurveyRanking
  self._rankScrollRect = owner:GetComponent(T_ScrollRect)
  local itemPrefabGo = self.ui.UI_Dungeous_Item_Ranking
  local sizeDelta = itemPrefabGo.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local cellComps = {}
  self._roleTableView = self:CreateTableview(owner, function()
    local list = self.model and self.model.showPlayerRankingGroup
    return list and #list or 0
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(itemPrefabGo)
    if not cell then
      return nil
    end
    local gameObj = cell.gameObject
    local oldComp = cellComps[gameObj]
    if oldComp then
      oldComp.binder:teardown()
      cellComps[gameObj] = nil
    end
    local list = self.model and self.model.showPlayerRankingGroup
    local playerData = list and list[index]
    if playerData then
      local component = DailyChallengeBoardPlayerItem(gameObj, playerData, RankTypeMap[TabKeys.SurveyRanking])
      cellComps[gameObj] = self.binder:BindComponent(component)
    end
    return cell
  end, function()
    return itemW, itemH
  end)
  
  function self._roleTableView.onScrollValueChanged(_, vector2)
    if vector2.y < 0.05 then
      self:_RequestMoreRankData()
    end
  end
end

function DailyChallengeBoardEntryPanel:_CreateAwardRuleTableView()
  local owner = self.ui.ScrollView_RankAward
  local itemW, itemH = 0, 0
  local templateGo
  do
    local contentTf = owner.transform and owner.transform:Find("Content") or owner.transform
    if contentTf and contentTf.childCount > 0 then
      templateGo = contentTf:GetChild(0).gameObject
      if templateGo and templateGo.transform and templateGo.transform.sizeDelta then
        itemW, itemH = templateGo.transform.sizeDelta.x, templateGo.transform.sizeDelta.y
      end
    end
  end
  local cellComps = {}
  self._awardRuleTableView = self:CreateTableview(owner, function()
    return self._awardShowData and #self._awardShowData or 0
  end, function(view, index)
    local cell = view:DequeueCell()
    if not cell and templateGo then
      cell = view:AddChild(templateGo)
    end
    if not cell then
      return nil
    end
    local gameObj = cell.gameObject
    local oldComp = cellComps[gameObj]
    if oldComp then
      oldComp.binder:teardown()
      cellComps[gameObj] = nil
    end
    local data = self._awardShowData and self._awardShowData[index]
    if data then
      local component = DailyChallengeRewardRuleItem(gameObj, data, self.model)
      cellComps[gameObj] = self.binder:BindComponent(component)
    end
    return cell
  end, function()
    return itemW, itemH
  end)
end

function DailyChallengeBoardEntryPanel:_RequestMoreRankData()
  if not self:_TryThrottleRankRequest() then
    return
  end
  if not self.model or not self.model.showPlayerRankingGroup then
    return
  end
  local list = self.model.showPlayerRankingGroup
  local rankViewData = self.model:GetRankViewData() or {}
  local isSettling = rankViewData.settling
  if 0 == #list or isSettling then
    return
  end
  if self.model.maxRankingNum and #list >= self.model.maxRankingNum then
    return
  end
  local curListNum = #list
  local perQueryNum = self.model.perQueryNum or 10
  local isInitialPageFilled = curListNum == INITIAL_QUERY_NUM
  local isFollowPageFilled = curListNum > INITIAL_QUERY_NUM and 0 == (curListNum - INITIAL_QUERY_NUM) % perQueryNum
  if not isInitialPageFilled and not isFollowPageFilled then
    return
  end
  self._rankIsRequesting = true
  local rankType = RankTypeMap[TabKeys.SurveyRanking]
  local subTid = self:_GetRankSubTid()
  local awakerMap = {
    dailyTeamAwaker = AwakerFilterListController.Instance:GetDailyChallengeRankFilterAwakerMap()
  }
  RankController.Instance:QueryRankData(rankType, subTid, curListNum + 1, perQueryNum, function()
    self._rankIsRequesting = false
    if self.ui then
      self.model:SetRankViewData()
      self:_RefreshRoleBoardIfActive()
    end
  end, {awakerMap = awakerMap, extraId = subTid}, function()
    self._rankIsRequesting = false
  end)
end

function DailyChallengeBoardEntryPanel:_RequestCurrentBoardData()
  if self.model.showingBoard == TabKeys.SurveyRanking then
    self:_RequestRankData()
  elseif self.model.showingBoard == TabKeys.RankAward then
    self:_RequestRankRewardInfo(RankTypeMap[TabKeys.RankAward])
  end
end

function DailyChallengeBoardEntryPanel:_RefreshRoleBoardIfActive()
  if not self.model or not self.ui then
    return
  end
  if self.model.showingBoard ~= self._tabKey then
    return
  end
  if self._isRequesting then
    return
  end
  local boardIndex = self._tabKey
  local list = self.model.showPlayerRankingGroup or {}
  local rankViewData = self.model:GetRankViewData() or {}
  local isSettling = rankViewData.settling
  local groupNull = self.ui["Group_Null_" .. boardIndex]
  if groupNull then
    self:SetActive(groupNull, 0 == #list or isSettling)
    self:SetText(groupNull, isSettling and LT.Text("DailyChallengeLiquidation") or LT.Text("DailyChallengeEmptyTips"))
  end
  if self.ui.Text_C_NoTask then
    if isSettling then
      self:SetText(self.ui.Text_C_NoTask, LT.Text("DailyChallengeLiquidation"))
    elseif 0 == #list then
      self:SetText(self.ui.Text_C_NoTask, LT.Text("RankDataNull"))
    else
      self:SetText(self.ui.Text_C_NoTask, "")
    end
  end
  local scrollViewRole = self.ui["ScrollView_Role_" .. boardIndex]
  if scrollViewRole then
    self:SetActive(scrollViewRole, not isSettling)
  end
  if self._roleTableView then
    self._roleTableView:ReloadData()
  end
  self:RefreshMeInfo()
end

function DailyChallengeBoardEntryPanel:_RefreshAwardRuleBoardIfActive()
  if self.model.showingBoard ~= RankAwardTab then
    return
  end
end

function DailyChallengeBoardEntryPanel:SetShowingBoard(boardIndex)
  self._tabKey = boardIndex
  self.model:SetShowingBoard(boardIndex)
  self:_RefreshView()
  self:_RefreshRankListSettlementNotice()
end

function DailyChallengeBoardEntryPanel:_RefreshView()
  local isSurvey = self._tabKey == TabKeys.SurveyRanking
  local isAward = self._tabKey == TabKeys.RankAward
  self:SetActive(self.ui.Group_SurveyRanking, isSurvey)
  self:SetActive(self.ui.Group_RankAward, isAward)
  self:SetButtonChosen(self.ui.Btn_Game, isSurvey)
  self:SetButtonChosen(self.ui.Btn_Activity, isAward)
  if isSurvey then
    self._roleTableView:ReloadData()
  end
end

function DailyChallengeBoardEntryPanel:_OnClickFilterAwaker()
  UIManager.Instance:Reopen(Urls.AwakerFilterListView, CommonDefine.AwakerFilterType.DailyChallengeRank)
end

function DailyChallengeBoardEntryPanel:_RefreshFilterAwakerBtnState()
  local isFiltering = AwakerFilterListController.Instance:GetDailyChallengeRankFilterAwakerMap() ~= nil
  local btnState = isFiltering and CommonDefine.BtnType.High or CommonDefine.BtnType.Normal
  self:SetButtonState(self.ui.Btn_FilterAwaker, btnState)
  local btnText = isFiltering and LT.Text("AwakerHasColletion") or LT.Text("AwakerColletion")
  self:SetButtonText(self.ui.Btn_FilterAwaker, btnText)
end

function DailyChallengeBoardEntryPanel:_OnSaveAwakerFilter(filterType)
  if filterType ~= CommonDefine.AwakerFilterType.DailyChallengeRank then
    return
  end
  self:_RefreshFilterAwakerBtnState()
  self:SetShowingBoard(self._tabKey)
  self:_ResetRankScrollPos()
  self:_RequestRankData()
end

function DailyChallengeBoardEntryPanel:RefreshMeInfo()
  if self._hideMeInfoForLoading then
    return
  end
  local boardIndex = self.model.showingBoard
  local UI_MeInfo
  if boardIndex == TabKeys.SurveyRanking then
    UI_MeInfo = self.ui.UI_MeInfo_SurveyRanking
  elseif boardIndex == TabKeys.RankAward then
    UI_MeInfo = self.ui.UI_MeInfo_RankAward
  end
  if not UI_MeInfo then
    return
  end
  local rankType = self._surveyRankType
  local rankCfg
  local rankViewData = self.model:GetRankViewData() or {}
  local rankIdx = rankViewData.personalIndex or 0
  local rewardRankIdx = rankViewData.personalRewardIndex or 0
  if rewardRankIdx > 0 then
    local seasonId = self.model:GetSeasonTid()
    if not seasonId or 0 == seasonId then
      seasonId = DailyChallengeDataUtils.GetNowSeasonTid()
    end
    if seasonId and seasonId > 0 then
      local playersNum = rankViewData.totalNum or 0
      rankCfg = SeasonRotationModel.Instance:GetSeasonRankRewardRowByRewardIndex(seasonId, CommonDefine.SeasonGameplayType.ConsciousnessDiving, rewardRankIdx, playersNum)
    end
  end
  self:SetActive(UI_MeInfo, true)
  local icon = PlayerDataUtils.GetAvatarIcon()
  local dailyChallengeTeam = rankViewData.dailyChallengeTeam
  local school2MaxScoreTeam = rankViewData.school2MaxScoreTeam
  local meSeasonTid = self.model:GetSeasonTid()
  if not meSeasonTid or 0 == meSeasonTid then
    meSeasonTid = DailyChallengeDataUtils.GetNowSeasonTid()
  end
  local playerItemData = {
    icon = icon,
    name = PlayerDataUtils.GetName() or "",
    ranking = rankIdx,
    score = rankViewData.personalScore or 0,
    title = rankCfg and rankCfg.Name or nil,
    titleBG = rankCfg and rankCfg.RankIcon or nil,
    seasonTid = meSeasonTid,
    uid = PlayerDataUtils.GetPlayerUid(),
    level = PlayerDataUtils.GetLevel(),
    gender = PlayerDataUtils.GetGender(),
    dailyChallengeTeam = dailyChallengeTeam,
    school2MaxScoreTeam = school2MaxScoreTeam
  }
  local component = DailyChallengeBoardPlayerItem(UI_MeInfo, playerItemData, rankType)
  self._myInfoBinder = self.binder:BindComponent(component).bind
end

function DailyChallengeBoardEntryPanel:InitAwardShowData()
  if self._awardShowData and #self._awardShowData > 0 then
    return self._awardShowData
  end
  local currentSeasonId = DailyChallengeDataUtils.GetNowSeasonTid() or 0
  do return SeasonRankStrategy.GetSortedRewardShowData, Strategy end
  return SeasonRankStrategy.GetSortedRewardShowData, Strategy, currentSeasonId
end

function DailyChallengeBoardEntryPanel:OnClose()
  self:Close()
end

function DailyChallengeBoardEntryPanel:_ReqDailyChallengeData()
  EventMgr.Instance.ReqDailyChallengeDataEvt:Dispatch()
end

function DailyChallengeBoardEntryPanel:_CheckAndShowFirstLoadTip()
  local rankType = RankTypeMap[TabKeys.SurveyRanking]
  local subTid = self:_GetRankSubTid()
  local rankList = RankModel.Instance:GetRankListData(rankType, subTid)
  self._isRequesting = true
  if not rankList or 0 == #rankList then
    local groupNull = self.ui["Group_Null_" .. TabKeys.SurveyRanking]
    if groupNull then
      self:SetActive(groupNull, true)
    end
    if self.ui.Text_C_NoTask then
      self:SetText(self.ui.Text_C_NoTask, LT.Text("RankDataFirstLoadTip"))
    end
  end
  self._hideMeInfoForLoading = true
  if self.ui.UI_MeInfo_SurveyRanking then
    self:SetActive(self.ui.UI_MeInfo_SurveyRanking, false)
  end
end

function DailyChallengeBoardEntryPanel:_RequestRankData(dontReset)
  if TabKeys.SurveyRanking ~= self._tabKey then
    return
  end
  self._rankIsRequesting = false
  self._isRequesting = true
  if not dontReset then
    RankModel.Instance:ResetRankType(RankTypeMap[TabKeys.SurveyRanking], self:_GetRankSubTid())
  end
  local rankType = RankTypeMap[TabKeys.SurveyRanking]
  local subTid = self:_GetRankSubTid()
  local awakerMap = {
    dailyTeamAwaker = AwakerFilterListController.Instance:GetDailyChallengeRankFilterAwakerMap()
  }
  NetBlockMgr.Instance:CancelBlocked(true)
  RankController.Instance:QueryRankData(rankType, subTid, 1, INITIAL_QUERY_NUM, function()
    self._isRequesting = false
    self._hideMeInfoForLoading = false
    if self.ui then
      self.model:SetRankViewData()
      self:_RefreshRoleBoardIfActive()
    end
  end, {awakerMap = awakerMap, extraId = subTid}, function()
    self._isRequesting = false
    self._hideMeInfoForLoading = false
  end)
  NetBlockMgr.Instance:CancelBlocked(false)
end

function DailyChallengeBoardEntryPanel:_ResetRankScrollPos()
  if self._roleTableView then
    self._roleTableView:SetOffset(0, false)
  end
end

function DailyChallengeBoardEntryPanel:_GetRankSubTid()
  local seasonTid = self.model and self.model:GetSeasonTid() or 0
  return seasonTid > 0 and seasonTid or nil
end

function DailyChallengeBoardEntryPanel:_RequestRankRewardInfo(rankType)
  if not rankType then
    return
  end
  self.model:RequestRankRewardInfo(rankType, function()
    self:_RefreshAwardRuleBoardIfActive()
  end)
end

return DailyChallengeBoardEntryPanel
