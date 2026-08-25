local AbyssRankView, Super = NewClass("AbyssRankView", RankBaseView)
AbyssRankView.uiResCls = UI_Dungeons_Popup_AbyssRankResource
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local TransformUtil = CS.Framework.TransformUtil
local _SetAnchoredPos = TransformUtil.SetAnchoredPos
local _GetAnchoredPos = TransformUtil.GetAnchoredPos

function AbyssRankView:ctor(curActivityTid)
  Super.ctor(self)
  self.model = AbyssExtModel.Instance
  self.controller = AbyssController.Instance
  self.selectActivityTid = curActivityTid
  self.curPeriodActivityTid = curActivityTid
end

function AbyssRankView:OnBuildView()
  self.rankScrollRect = self.ui.ScrollView_Rank:GetComponent(T_ScrollRect)
  self.dropdownContentTf = self.ui.Content.transform
  self:_CheckAndShowFirstLoadTip()
  self:_RequestRankPage()
end

function AbyssRankView:RegisterEvents()
  self:_InitDropdown()
  self:_CreateRankTableView()
end

function AbyssRankView:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnRankDataChanged, self._OnRankDataChanged, self)
end

function AbyssRankView:OnEnterView()
  Super.OnEnterView(self)
  local curActivityTid = self.model:GetCurrActivityTid()
  if curActivityTid and curActivityTid > 0 and curActivityTid ~= self.curPeriodActivityTid then
    self.curPeriodActivityTid = curActivityTid
    self.selectActivityTid = curActivityTid
    self.dropdownOptionList = self.model:GetSeasonOptionList(self.curPeriodActivityTid)
    self:_RefreshDropdown()
    self:_ResetRankPagination()
    self:_RequestRankPage()
  end
  self:_SetBgComp()
  self:_SetFirstSelectDropdownValue()
  self:_RefreshView(true)
end

function AbyssRankView:_CheckAndShowFirstLoadTip()
  local rankList = RankModel.Instance:GetRankListData(RankDefine.RankType.AbyssChallenge, self.selectActivityTid)
  if not rankList or 0 == #rankList then
    self.ui.Group_Null_Black:SetActive(true)
    if self.ui.Text_C_NoTask then
      self:SetText(self.ui.Text_C_NoTask, LT.Text("RankDataFirstLoadTip"))
    end
    self:SetActive(self.ui.Item_Rank_My, false)
  end
end

function AbyssRankView:OnExitView()
  Super.OnExitView(self)
end

function AbyssRankView:_SetBgComp()
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.PopupTipsType.L,
    clickFunc = System.fn(self, self._OnClickClose)
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Popup_Tips_L, CompPublicPopupTips, commonPopupConfirmTipsData)
end

function AbyssRankView:_InitDropdown()
  self.dropdownOptionList = self.model:GetSeasonOptionList(self.curPeriodActivityTid)
  self:AddZ1ToggleValueChangedListener(self.ui.Dropdown_Season, function(isOn)
    self:_SetDropdownShow(isOn)
  end)
  self:_RefreshDropdown()
  self:SetZ1Toggle(self.ui.Dropdown_Season, false)
  self:_SetDropdownShow(false)
end

function AbyssRankView:_SetFirstSelectDropdownValue()
  for _, optionData in ipairs(self.dropdownOptionList) do
    if optionData and optionData.key == self.curPeriodActivityTid then
      self:SetText(self.ui.Text_Cur, optionData.text)
      break
    end
  end
end

function AbyssRankView:_RefreshView(isReloadData)
  self:_RefreshRankList(isReloadData)
  self:_RefreshSelfRank()
  self:_RefreshEmptyState()
end

function AbyssRankView:_RefreshDropdown()
  local cnt = #self.dropdownOptionList
  local childCount = self.dropdownContentTf.childCount
  while cnt > childCount do
    Instantiate(self.ui.Item_Season, self.dropdownContentTf)
    childCount = childCount + 1
  end
  local objHeight = self.ui.Item_Season.transform.sizeDelta.y
  for idx = 1, cnt do
    local go = self.dropdownContentTf:GetChild(idx - 1).gameObject
    go:SetActive(true)
    local optionData = self.dropdownOptionList[idx]
    local uiRes = UI_Dungeons_Item_RankSeasonResource(go)
    self:AddButtonClickListener(uiRes.Btn_Click, function()
      if optionData.key == self.selectActivityTid then
        self:SetZ1Toggle(self.ui.Dropdown_Season, false)
        return
      end
      self:SetText(self.ui.Text_Cur, optionData.text)
      self:_OnSeasonChanged(idx)
      self:SetZ1Toggle(self.ui.Dropdown_Season, false)
      self:SetZ1Toggle(uiRes.uiNode, true)
      self:_RefreshDropdown()
    end)
    local isSelected = self.selectActivityTid == optionData.key
    local textColorType = CommonDefine.ColorType.Dark
    local btnState = CommonDefine.Z1ButtonState.Normal
    if isSelected then
      textColorType = CommonDefine.ColorType.Light
      btnState = CommonDefine.Z1ButtonState.High
    end
    local pos_x, _ = _GetAnchoredPos(go.transform)
    local pos_y = (cnt - idx + 1) * objHeight
    _SetAnchoredPos(go.transform, pos_x, pos_y)
    self:SetText(uiRes.Text_Drop_Item_Tips, optionData.text)
    self:SetTextColorType(uiRes.Text_Drop_Item_Tips, textColorType)
    self:SetButtonState(uiRes.Btn_Click, btnState)
    self:SetZ1Toggle(uiRes.uiNode, isSelected)
  end
  for i = cnt + 1, childCount do
    local go = self.dropdownContentTf:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
end

function AbyssRankView:_SetDropdownShow(show)
  self.ui.ScrollView_Season:SetActive(show)
end

function AbyssRankView:_CreateRankTableView()
  self.rankTableView = self:CreateTableview(self.ui.ScrollView_Rank, function()
    if not self.rankList then
      return 0
    end
    return #self.rankList
  end, function(view, index)
    do return self._RankCellAtIndex, self, view end
    return self._RankCellAtIndex, self, view, index
  end)
  self:_SetupRankScroll(self.rankTableView)
end

function AbyssRankView:_RankCellAtIndex(view, index)
  local rankData = self.rankList[index]
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Dungeons_Item_AbyssRank)
  
  local function _OnClickAvatar()
    SocialDataUtils.OpenPlayerInfoPanel(SocialDefine.PlayerInfoPage.Overview, rankData.uid)
  end
  
  local function _OnClickMore()
    self:_OpenCopySettleView(rankData.uid, rankData.abyssChallenge, rankData)
  end
  
  local function _OnClickReplay()
    local positionNode = cell.transform:Find("NodeReplayStages")
    self:_ReplayAbyssBattle(rankData.abyssChallenge, true, positionNode.gameObject)
  end
  
  self:AddViewComponentOnce(cell.gameObject, UICompAbyssRankItem, rankData, _OnClickAvatar, _OnClickMore, _OnClickReplay)
  return cell
end

function AbyssRankView:_OpenCopySettleView(playerUid, abyssChallenge, rankData)
  local seasonData
  if abyssChallenge and abyssChallenge.activityId2Data then
    seasonData = abyssChallenge.activityId2Data[self.selectActivityTid]
  end
  local recordList = AbyssExtModel.Instance:CalcRecordDataListByServer(self.selectActivityTid, seasonData and seasonData.stageGroups)
  local viewData = {
    recordList = recordList,
    playerUid = playerUid,
    playerName = rankData and rankData.name,
    playerLevel = rankData and rankData.level,
    playerGender = rankData and rankData.gender,
    activityTid = self.selectActivityTid,
    fromRank = true
  }
  CopyController.Instance:OnOpenCopyAbyssSettleView(viewData)
end

function AbyssRankView:_ReplayAbyssBattle(abyssChallenge, isTop, posNode)
  local seasonData
  if abyssChallenge and abyssChallenge.activityId2Data then
    seasonData = abyssChallenge.activityId2Data[self.selectActivityTid]
  end
  local recordList = AbyssExtModel.Instance:CalcRecordDataListByServer(self.selectActivityTid, seasonData and seasonData.stageGroups)
  local stagesList = {}
  for i = 1, #recordList do
    local stageInfo = recordList[i]
    if recordList[i].battleUuid and recordList[i].stageId then
      table.insert(stagesList, stageInfo)
    end
  end
  if #stagesList > 0 then
    UIManager.Instance:Show(Urls.CopyReplayStagesView, stagesList, isTop, posNode)
  else
    Alert.Show("PVEReplayNoDataTips")
  end
end

function AbyssRankView:_RefreshRankList(isReloadData)
  if not self.rankTableView then
    return
  end
  if isReloadData then
    self.rankList = self.model:GetRankList(self.selectActivityTid)
    self.rankTableView:ReloadData()
  else
    self.rankTableView:Refresh()
  end
end

function AbyssRankView:_RefreshSelfRank()
  local rankData = RankModel.Instance:GetSelfRankData(RankDefine.RankType.AbyssChallenge, self.selectActivityTid)
  local selfUid = PlayerDataUtils.GetPlayerUid()
  
  local function _OnClickAvatar()
    SocialDataUtils.OpenPlayerInfoPanel(SocialDefine.PlayerInfoPage.Overview, selfUid)
  end
  
  local function _OnClickMore()
    if not rankData.abyssChallenge then
      Alert.ShowStr(LT.Text("PvEReplayTabNullDesc"))
      return
    end
    self:_OpenCopySettleView(selfUid, rankData.abyssChallenge)
  end
  
  local function _OnClickReplay()
    self:_ReplayAbyssBattle(rankData.abyssChallenge, false, self.ui.NodeReplayList)
  end
  
  local isCurrentPeriod = self.selectActivityTid == self.curPeriodActivityTid
  if not rankData then
    rankData = {
      name = PlayerDataUtils.GetName(),
      uid = selfUid,
      icon = DataCenter.playerData.DRole.icon
    }
    if isCurrentPeriod and (not self.rankList or 0 == #self.rankList) and AbyssExtModel.Instance:GetScore() > 0 then
      rankData.rank = 1
    end
  end
  rankData.isSelfRank = true
  local validScore = rankData.score or 0
  local rankScore = validScore
  if isCurrentPeriod and rankScore <= 0 then
    rankScore = AbyssExtModel.Instance:GetMaxScore()
  end
  rankData.score = rankScore
  local isV260 = self.model:IsUseV260RewardConfigForActivity(self.selectActivityTid)
  if isV260 and AbyssExtModel.Instance:IsAbyssRevivalFeatureEnabled() then
    local normalScore = rankData.normalScore
    local revivalScore = rankData.revivalScore
    if nil == normalScore and nil == revivalScore then
      if self.selectActivityTid == self.curPeriodActivityTid then
        local maxScore = AbyssExtModel.Instance:GetMaxScore()
        local totalScore = math.max(maxScore, validScore)
        normalScore = validScore
        revivalScore = math.max(totalScore - validScore, 0)
        Logger.Info("[AbyssRankView] calc current by maxScore=%s validScore=%s normalScore=%s revivalScore=%s", tostring(maxScore), tostring(validScore), tostring(normalScore), tostring(revivalScore))
      else
        normalScore, revivalScore = self:_CalcHistoryScoreFromStageGroups(rankData.abyssChallenge)
        Logger.Info("[AbyssRankView] calc history by validScore=%s normalScore=%s revivalScore=%s", tostring(validScore), tostring(normalScore), tostring(revivalScore))
      end
    end
    rankData.normalScore = normalScore
    rankData.revivalScore = revivalScore or 0
  else
    rankData.normalScore = nil
    rankData.revivalScore = nil
  end
  self:SetActive(self.ui.Item_Rank_My, true)
  self:AddViewComponentOnce(self.ui.Item_Rank_My, UICompAbyssRankItem, rankData, _OnClickAvatar, _OnClickMore, _OnClickReplay)
  local myRankRes = UIBaseResource(self.ui.Item_Rank_My)
  myRankRes.Btn_Replay:SetActive(nil ~= rankData)
end

function AbyssRankView:_CalcHistoryScoreFromStageGroups(abyssChallenge)
  local normalScore = 0
  local revivalScore = 0
  if not abyssChallenge or not abyssChallenge.activityId2Data then
    return normalScore, revivalScore
  end
  local seasonData = abyssChallenge.activityId2Data[self.selectActivityTid]
  local stageGroups = seasonData and seasonData.stageGroups
  if not stageGroups then
    return normalScore, revivalScore
  end
  for _, groupData in pairs(stageGroups) do
    if not groupData.stageTid or groupData.stageTid <= 0 then
    else
      local stageConfig = DT.Stage[groupData.stageTid]
      local scoreArr = stageConfig and stageConfig.AbyssChallengeScore
      local normalScoreCfg = 0
      local extraScoreCfg = 0
      if scoreArr then
        if tonumber(scoreArr) then
          normalScoreCfg = tonumber(scoreArr)
        else
          normalScoreCfg, extraScoreCfg = table.unpack(scoreArr)
          normalScoreCfg = normalScoreCfg or 0
          extraScoreCfg = extraScoreCfg or 0
        end
      end
      local team = groupData.team
      if normalScoreCfg > 0 then
        if team and team.isScoreValid == false or false == groupData.isValid or groupData.useRevivalNormal or false then
          revivalScore = revivalScore + normalScoreCfg
        else
          normalScore = normalScore + normalScoreCfg
        end
      end
      local teamExtra = groupData.teamExtra
      if groupData.extraPass and extraScoreCfg > 0 then
        if teamExtra and teamExtra.isScoreValid == false or false == groupData.isValidExtra or groupData.useRevivalExtra or false then
          revivalScore = revivalScore + extraScoreCfg
        else
          normalScore = normalScore + extraScoreCfg
        end
      end
    end
  end
  return normalScore, revivalScore
end

function AbyssRankView:_RefreshEmptyState()
  local isEmptyShow = not self.rankList or #self.rankList <= 0
  self.ui.Group_Null_Black:SetActive(isEmptyShow)
  if isEmptyShow and self.ui.Text_C_NoTask then
    self:SetText(self.ui.Text_C_NoTask, LT.Text("RankDataNull"))
  end
end

function AbyssRankView:_OnRankDataChanged(rankType)
  if rankType ~= RankDefine.RankType.AbyssChallenge then
    return
  end
  if self.ui.Text_C_NoTask then
    self:SetText(self.ui.Text_C_NoTask, "")
  end
  self:_RefreshView(true)
end

function AbyssRankView:_DoRequestRankData(startIndex, count, onSuccess, onFail)
  self.controller:ReqAbyssRankData(self.selectActivityTid, startIndex, count, onSuccess, onFail)
end

function AbyssRankView:_GetRankListCount()
  return self.rankList and #self.rankList or 0
end

function AbyssRankView:_OnRankPageSuccess()
  self:_RefreshView(true)
end

function AbyssRankView:_OnSeasonChanged(index)
  if not index then
    return
  end
  local optionData = self.dropdownOptionList[index]
  if optionData.key == self.selectActivityTid then
    return
  end
  self.selectActivityTid = optionData.key
  self:_ResetRankPagination()
  self:_RequestRankPage()
  self:_ResetRankScroll(self.rankTableView)
end

function AbyssRankView:_OnClickClose()
  self:Close()
end

return AbyssRankView
