local UICompRankRailWayItem, Super = NewViewComponent("UICompRankRailWayItem", UICompRankBaseItem)

function UICompRankRailWayItem:ctor(uiNode, view, rankMO)
  Super.ctor(self, uiNode, view, rankMO)
  self.ui = UI_Dungeons_Item_RailWayRankResource(uiNode)
end

function UICompRankRailWayItem:_GetNameTextNode()
  return self.ui.Text_Name
end

function UICompRankRailWayItem:_GetUidTextNode()
  return self.ui.Text_Uid
end

function UICompRankRailWayItem:_GetScoreTextNode()
  return self.ui.Text_Exp
end

function UICompRankRailWayItem:_GetRankIdxTextNode()
  return self.ui.Text_Rank
end

function UICompRankRailWayItem:RegisterEvents()
  Super.RegisterEvents(self)
  self:AddButtonClickListener(self.ui.Btn_Replay, System.fn(self, self._OnClickBtnReplay))
end

function UICompRankRailWayItem:_OnClickBtnReplay()
  if self:_IsTeamEmpty() then
    Alert.Show("PVEReplayNoDataTips")
    return
  end
  local playerUid = self._rankMO:GetUid()
  local rankPlayerName = self._rankMO:GetName()
  local rankPlayerLevel = self._rankMO:GetLevel()
  local rankPlayerGender = self._rankMO:GetGender()
  local stageTid = self._rankMO:GetStageTid()
  local seasonTid = self._rankMO:GetSeasonTid()
  if not seasonTid or 0 == seasonTid then
    Alert.Show("PVEReplayNoDataTips")
    return
  end
  CopyRecordsController.Instance:ReqQueryFacadeFields(playerUid, {
    Type = "railWaySeasonMaxTeamMap",
    seasonTid = seasonTid
  }, function(data)
    local map = data and data.railWaySeasonMaxTeamMap
    local teamData = map and map[seasonTid]
    local recordStageData = teamData and teamData.recordStageData
    if recordStageData then
      recordStageData = CopyBattleStatisticsDataUtils.ApplyRecordOwnerSnapshot(recordStageData, playerUid)
      recordStageData.playerUid = tonumber(playerUid) or recordStageData.playerUid
      if rankPlayerName and "" ~= rankPlayerName then
        recordStageData.playerName = rankPlayerName
      end
      if rankPlayerLevel and rankPlayerLevel > 0 then
        recordStageData.playerLevel = rankPlayerLevel
      end
      if rankPlayerGender then
        recordStageData.playerGender = rankPlayerGender
      end
      CopySettleModel.Instance:UpdateBySvrData({teamData = teamData, recordStageData = recordStageData})
      CopySettleModel.Instance:Set_stageTid(stageTid)
      CopySettleModel.Instance:SetBanRecordBtn(true)
      CopyController.Instance:OnOpenCopySettleBaseView()
    else
      Alert.Show("PVEReplayNoDataTips")
    end
  end)
end

function UICompRankRailWayItem:_RefreshView()
  Super._RefreshView(self)
  self:_RefreshTitle()
  self:_RefreshTeam()
  self:_RefreshRoundNum()
end

function UICompRankRailWayItem:_GetTitleData()
  if not self._rankMO then
    return nil, nil
  end
  do return self._rankMO.GetTitleAndIcon end
  return self._rankMO.GetTitleAndIcon, self._rankMO
end

function UICompRankRailWayItem:_RefreshTitle()
  if not self.ui.UI_Dungeons_Item_DivingTitle then
    return
  end
  local titleText, titleIcon = self:_GetTitleData()
  if not titleText or "" == titleText then
    self:SetActive(self.ui.UI_Dungeons_Item_DivingTitle, false)
    return
  end
  self:SetActive(self.ui.UI_Dungeons_Item_DivingTitle, true)
  UIComDungeonsDivingTitle.BindByTitleData(self.binder, self.ui.UI_Dungeons_Item_DivingTitle, {
    titleText = LT.Text(titleText),
    titleIcon = titleIcon,
    width = 200
  })
end

function UICompRankRailWayItem:_GetRailWayTeam()
  if not self._rankMO then
    return nil
  end
  if type(self._rankMO.GetTeamAwakers) == "function" then
    do return self._rankMO.GetTeam end
    return self._rankMO.GetTeam, self._rankMO
  end
  if "function" == type(self._rankMO.GetRailWayTeam) then
    do return self._rankMO.GetRailWayTeam end
    return self._rankMO.GetRailWayTeam, self._rankMO
  end
  return self._rankMO.railWayTeam
end

function UICompRankRailWayItem:_GetTeamAwakers()
  local team = self:_GetRailWayTeam()
  return team and team.awakers or {}
end

function UICompRankRailWayItem:_RefreshTeam()
  local teamAwakers = self:_GetTeamAwakers()
  local isEmptyTeam = self:_IsTeamEmpty()
  self:SetActive(self.ui.Group_Team_Null, isEmptyTeam)
  self:SetActive(self.ui.Group_Team, not isEmptyTeam)
  if isEmptyTeam then
    return
  end
  for i = 1, #teamAwakers do
    local itemObj = self.ui["UI_Common_Item_Role0" .. i]
    if not itemObj then
    else
      local teamAwakerData = teamAwakers[i]
      self:SetActive(itemObj, true)
      local viewData = {
        awakerId = teamAwakerData.tid,
        itemCount = string.format("LV.%s", teamAwakerData.level),
        curSkin = teamAwakerData.curSkin or cd.DefaultSkinTid
      }
      self:AddViewComponentOnce(itemObj, CompPublicIconItemType2, viewData)
    end
  end
  for i = #teamAwakers + 1, 4 do
    local itemObj = self.ui["UI_Common_Item_Role0" .. i]
    if not itemObj then
    else
      self:SetActive(itemObj, false)
    end
  end
end

function UICompRankRailWayItem:_RefreshRoundNum()
  local rankRoundNum = 0
  if self._rankMO then
    if type(self._rankMO.GetRoundNum) == "function" then
      rankRoundNum = self._rankMO:GetRoundNum() or 0
    elseif "function" == type(self._rankMO.GetScore2) then
      rankRoundNum = self._rankMO:GetScore2() or 0
    end
  end
  self:SetText(self.ui.Text_Round, rankRoundNum)
end

function UICompRankRailWayItem:_IsTeamEmpty()
  local teamAwakers = self:_GetTeamAwakers()
  return 0 == #teamAwakers
end

return UICompRankRailWayItem
