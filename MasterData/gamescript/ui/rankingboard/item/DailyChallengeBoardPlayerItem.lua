local MAX_AWAKER_NUM = 4
local DailyChallengeBoardPlayerItem, Super = System.NewComponent("DailyChallengeBoardPlayerItem")

function DailyChallengeBoardPlayerItem:ctor(uiNode, data, rankType)
  Super.ctor(self)
  self.ui = UI_Dungeous_Item_RankingResource(uiNode)
  self.icon = data.icon
  self.frameIcon = data.frameIcon
  self.name = data.name
  self.uid = data.uid
  self.title = data.title
  self.score = data.score
  self.ranking = data.ranking
  self.titleBG = data.titleBG
  self.seasonTid = data.seasonTid
  self.rankType = rankType
  self.data = data
  local RankType = RankDefine.RankType
  if data.school2MaxScoreTeam then
    local teamDict = {
      [RankType.DailyChallengeChaos] = data.school2MaxScoreTeam.Chaos,
      [RankType.DailyChallengeOcean] = data.school2MaxScoreTeam.Ocean,
      [RankType.DailyChallengeBlood] = data.school2MaxScoreTeam.Blood,
      [RankType.DailyChallengeDimension] = data.school2MaxScoreTeam.Dimension,
      [RankType.DailyChallengeOceanBlood] = data.school2MaxScoreTeam.OceanBlood,
      [RankType.DailyChallengeOceanDimension] = data.school2MaxScoreTeam.OceanDimension,
      [RankType.DailyChallengeBloodDimension] = data.school2MaxScoreTeam.BloodDimension
    }
    self.team = teamDict[rankType] or data.dailyChallengeTeam
  else
    self.team = data.dailyChallengeTeam
  end
  self.awakerDatas = {}
  if self.team and self.team.awakers then
    for _, awakerData in ipairs(self.team.awakers) do
      table.insert(self.awakerDatas, awakerData)
    end
  end
end

function DailyChallengeBoardPlayerItem:OnBind(binder)
  self.binder = binder
  self:BindDivingTitle(binder)
  binder:LoadAllLangFont(self.ui.Text_Name)
  binder:BindToText(self.ui.Text_Ranking, function()
    return 0 == self.ranking and LT.Text("Unranked") or LT.Text(self.ranking)
  end)
  binder:BindToText(self.ui.Text_Highest, function()
    return 0 == self.score and "-" or LT.Text(self.score)
  end)
  binder:BindToText(self.ui.Text_Name, function()
    do return SocialDataUtils.GetPlayerNameByUid, self.uid, LT.Text(self.name) end
    return SocialDataUtils.GetPlayerNameByUid, self.uid, LT.Text(self.name)
  end)
  binder:BindToText(self.ui.Text_Uid, function()
    do return LT.Text end
    return LT.Text, self.uid
  end)
  binder:BindComponent((CommonHeadItem(self.ui.UI_Common_Head, {
    clickCb = System.fn(self, self._OnClickAvatar),
    headIcon = self.icon,
    frameIcon = self.frameIcon
  })))
  binder:BindToRaw(function(_, noAwakers)
    local itsMe = self.uid == PlayerDataUtils.GetPlayerUid()
    self.ui.Group_Null:SetActive(itsMe and noAwakers)
    self.ui.Group_Underway:SetActive(not itsMe and noAwakers)
  end, function()
    return not self:HaveAwakers()
  end)
  binder:BindToVisible(self.ui.Group_Layout, function()
    do return self.HaveAwakers end
    return self.HaveAwakers, self
  end)
  if self:HaveAwakers() then
    for idx = 1, MAX_AWAKER_NUM do
      local awakerData = self.awakerDatas[idx]
      local go = self.ui["UI_Common_Item_Role0" .. idx]
      local awakerItemData = {
        awakerId = awakerData.tid,
        curSkin = awakerData.curSkin or cd.DefaultSkinTid,
        itemCount = LT.Textf("Team_AwakerLevel", awakerData.level)
      }
      binder:BindComponent(CommonIconItemType2(go, awakerItemData))
    end
  end
  binder:BindButtonClick(self.ui.Btn_Awakers_Click, function()
    if not self:HaveAwakers() then
      return
    end
    
    local function _OnClickShowAwakerDetail(serverData)
      local previewData
      if serverData and serverData.school2MaxScoreTeam then
        local RankType = RankDefine.RankType
        local teamDict = {
          [RankType.DailyChallengeChaos] = serverData.school2MaxScoreTeam.Chaos,
          [RankType.DailyChallengeOcean] = serverData.school2MaxScoreTeam.Ocean,
          [RankType.DailyChallengeBlood] = serverData.school2MaxScoreTeam.Blood,
          [RankType.DailyChallengeDimension] = serverData.school2MaxScoreTeam.Dimension,
          [RankType.DailyChallengeBloodDimension] = serverData.school2MaxScoreTeam.BloodDimension,
          [RankType.DailyChallengeOceanDimension] = serverData.school2MaxScoreTeam.OceanDimension,
          [RankType.DailyChallengeOceanBlood] = serverData.school2MaxScoreTeam.OceanBlood
        }
        if teamDict[self.rankType] then
          previewData = teamDict[self.rankType]
        end
      end
      if not previewData then
        Logger.Info("服务器数据错误")
        return
      end
      local recordStageData = previewData.recordStageData
      if type(recordStageData) == "table" then
        recordStageData = CopyBattleStatisticsDataUtils.ApplyRecordOwnerSnapshot(recordStageData, self.uid)
        recordStageData.playerUid = tonumber(self.uid) or recordStageData.playerUid
        if self.name and self.name ~= "" then
          recordStageData.playerName = self.name
        end
        if self.data and self.data.level then
          recordStageData.playerLevel = self.data.level
        end
        if self.data and self.data.gender then
          recordStageData.playerGender = self.data.gender
        end
      end
      CopySettleModel.Instance:UpdateBySvrData({teamData = previewData, recordStageData = recordStageData})
      CopyController.Instance:OnOpenCopySettleBaseView()
    end
    
    SocialDataUtils.ReqQueryAwakerList(self.uid, _OnClickShowAwakerDetail)
  end)
  self:_BindReplayBtn(binder)
end

function DailyChallengeBoardPlayerItem:_GetReplayBattleUuid()
  return self.team and self.team.battleUuid
end

function DailyChallengeBoardPlayerItem:_BindReplayBtn(binder)
  self.ui.Btn_Replay:SetActive(true)
  binder:BindButtonClick(self.ui.Btn_Replay, function()
    local team = self.team
    if not team then
      Alert.Show("PVEReplayNoDataTips")
      return
    end
    local recordData = team.recordStageData or team
    local battleUuid = recordData.battleUuid
    local stageId = recordData.stageId
    local wid = recordData.wid
    if not battleUuid or "" == battleUuid then
      Alert.Show("PVEReplayNoDataTips")
      return
    end
    CopyRecordsController.Instance:OpenRecordDetailPanel(stageId, wid, self.uid, {
      uid = self.uid,
      name = self.name,
      level = self.data and self.data.level,
      gender = self.data and self.data.gender
    })
  end)
end

function DailyChallengeBoardPlayerItem:_OnClickAvatar()
  SocialDataUtils.OpenPlayerInfoPanel(SocialDefine.PlayerInfoPage.Overview, self.uid)
end

function DailyChallengeBoardPlayerItem:HaveAwakers()
  return self.awakerDatas and #self.awakerDatas > 0
end

function DailyChallengeBoardPlayerItem:BindDivingTitle(binder)
  if not self.ui.UI_Dungeons_Item_DivingTitle then
    return
  end
  local titleText = self.title
  if not titleText or "" == titleText then
    binder:SetActive(self.ui.UI_Dungeons_Item_DivingTitle, false)
    return
  end
  binder:SetActive(self.ui.UI_Dungeons_Item_DivingTitle, true)
  UIComDungeonsDivingTitle.BindByTitleData(binder, self.ui.UI_Dungeons_Item_DivingTitle, {
    titleText = LT.Text(titleText),
    titleIcon = self.titleBG,
    width = 200
  })
end

return DailyChallengeBoardPlayerItem
