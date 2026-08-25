local DailyChallengeBoardEntryPanelModel = NewClass("DailyChallengeBoardEntryPanelModel", BaseModel)
local DailyRankType = RankDefine.RankType.SeasonRoDailyChallenge
local Strategy = SeasonRankStrategy.DailyChallenge

function DailyChallengeBoardEntryPanelModel:OnInit()
  self:OnReset()
end

function DailyChallengeBoardEntryPanelModel:OnReset()
  self.seasonTid = 0
  self.showingBoard = nil
  self.currPlayerRank = 0
  self.currPlayerRewardRankIndex = 0
  self.totalRankingNum = 100
  self.rankRanges = {}
  self.rankId = 0
  self.scrollBarVal = {}
  self.maxRankingNum = 1
  self.showPlayerRankingGroup = {}
  self.rankViewData = nil
end

function DailyChallengeBoardEntryPanelModel:SetSeasonTid(id)
  self.seasonTid = id or 0
  self.currPlayerRank = 0
  self.currPlayerRewardRankIndex = 0
  self.totalRankingNum = 100
  self.rankRanges = {}
  self.rankId = 0
  self.maxRankingNum = 1
  self.showPlayerRankingGroup = {}
end

function DailyChallengeBoardEntryPanelModel:GetSeasonTid()
  return self.seasonTid
end

function DailyChallengeBoardEntryPanelModel:SetShowingBoard(index)
  if nil == index then
    Logger.Error("Error boolVal ", index)
    return
  end
  self.showingBoard = index
end

function DailyChallengeBoardEntryPanelModel:SetScrollBarVal(numVal, boardIndex)
  if nil == numVal then
    Logger.Error("Error numVal ", numVal)
    return
  end
  self.scrollBarVal[boardIndex] = MathUtils.Clamp(MathUtils.Round(numVal, 1), 0, 1)
end

function DailyChallengeBoardEntryPanelModel:GetScrollBarVal(boardIndex)
  return self.scrollBarVal[boardIndex] or 1
end

function DailyChallengeBoardEntryPanelModel:RequestRankRewardInfo(rankType, onUpdated)
  RankController.Instance:ReqRankPrizeData(rankType, self:_GetRankSubTid(), function()
    self:SetRankViewData(self:_BuildRankViewData())
    if onUpdated then
      onUpdated()
    end
  end)
end

function DailyChallengeBoardEntryPanelModel:_GetRankSubTid()
  local seasonTid = self:_GetSeasonId()
  return seasonTid > 0 and seasonTid or nil
end

function DailyChallengeBoardEntryPanelModel:_BuildRankViewData()
  local rankType = DailyRankType
  local subTid = self:_GetRankSubTid()
  local selfRank = RankModel.Instance:GetSelfRankData(rankType, subTid)
  local totalNum = RankModel.Instance:GetRankLengthData(rankType, subTid) or 0
  local personalIndex = selfRank and selfRank:GetRank() or 0
  local personalRewardIndex = selfRank and selfRank:GetRewardRankIndex() or personalIndex
  return {
    settling = RankModel.Instance:GetRankSettlingData(rankType, subTid),
    rankPercent = nil,
    totalNum = totalNum,
    personalIndex = personalIndex or 0,
    personalRewardIndex = personalRewardIndex or 0,
    personalScore = selfRank and selfRank:GetScore() or 0,
    dailyChallengeTeam = selfRank and selfRank:GetDailyChallengeTeam() or nil,
    school2MaxScoreTeam = selfRank and selfRank:GetSchool2MaxScoreTeam() or nil,
    dataList = RankModel.Instance:GetRankListData(rankType, subTid) or {}
  }
end

function DailyChallengeBoardEntryPanelModel:SetRankViewData(rankViewData)
  self.rankViewData = rankViewData or self:_BuildRankViewData()
  self.maxRankingNum = math.max(self.rankViewData.totalNum or 0, 1)
  local rewardShowData = SeasonRankStrategy.GetSortedRewardShowData(Strategy, self:_GetSeasonId())
  local totalNum = self.rankViewData.totalNum or 0
  local personalRewardIndex = self.rankViewData.personalRewardIndex or 0
  local rangesModel = SeasonRankStrategy.BuildRankRangesModel(rewardShowData, totalNum, personalRewardIndex)
  self.rankRanges = rangesModel.rankRanges or {}
  self.currPlayerRewardRankIndex = personalRewardIndex
  self.totalRankingNum = math.max(totalNum, 100)
  self.rankId = self:_CalcRankId()
  self.currPlayerRank = self.rankId
  self.showPlayerRankingGroup = self:_BuildShowPlayerRankingGroup()
end

function DailyChallengeBoardEntryPanelModel:GetRankViewData()
  return self.rankViewData or self:_BuildRankViewData()
end

function DailyChallengeBoardEntryPanelModel:_GetSeasonId()
  local seasonId = self.seasonTid
  if not seasonId or 0 == seasonId then
    seasonId = DailyChallengeDataUtils.GetNowSeasonTid()
  end
  return seasonId or 0
end

function DailyChallengeBoardEntryPanelModel:GetTotalRankingNum()
  return self.totalRankingNum or math.max(self:GetRankViewData().totalNum or 0, 100)
end

function DailyChallengeBoardEntryPanelModel:_CalcRankId()
  local rst = 0
  if self.rankRanges and #self.rankRanges > 0 then
    local rankIdx = self:GetRankViewData().personalRewardIndex or 0
    for _, range in ipairs(self.rankRanges) do
      if rankIdx >= range.from and rankIdx <= range.to then
        rst = range.rankID
        break
      end
    end
    local showRankId = DailyChallengeDataUtils.GetShowRankId(rst)
    if showRankId and showRankId > 0 then
      rst = showRankId
    end
  end
  return rst or 0
end

function DailyChallengeBoardEntryPanelModel:_BuildShowPlayerRankingGroup()
  local rst = {}
  local serverDataList = self:GetRankViewData().dataList or {}
  local seasonId = self:_GetSeasonId()
  if 0 == seasonId then
    return rst
  end
  local playersNum = self.totalRankingNum or 100
  for _, serverPageData in ipairs(serverDataList) do
    local genderVal = serverPageData:GetGender() or 0
    local gender = 0 == genderVal and CommonDefine.GenderID.Boy or genderVal
    local avatarItemTid = serverPageData:GetIcon() or 0
    local frameIcon = ItemDataUtils.GetItemIcon(serverPageData:GetAvatarFrame() or 0)
    local icon, title, titleBG
    title, titleBG = serverPageData:GetTitleAndIcon(playersNum)
    if gender then
      local cfg = GenderDataUtils.GetCfgByTid(gender)
      icon = cfg.MainCharacterAvatarRes
    end
    if avatarItemTid then
      icon = ItemDataUtils.GetAvatarIcon(avatarItemTid)
    end
    local dailyChallengeTeam = serverPageData:GetDailyChallengeTeam()
    local itemData = {
      icon = icon,
      frameIcon = frameIcon,
      name = serverPageData:GetName() or "",
      ranking = serverPageData:GetRank() or 0,
      score = serverPageData:GetScore() or 0,
      title = title,
      uid = serverPageData:GetUid() or 0,
      level = serverPageData:GetLevel(),
      gender = gender,
      titleBG = titleBG,
      dailyChallengeTeam = dailyChallengeTeam,
      school2MaxScoreTeam = serverPageData:GetSchool2MaxScoreTeam(),
      seasonTid = seasonId
    }
    table.insert(rst, itemData)
  end
  return rst
end

function DailyChallengeBoardEntryPanelModel:SetPlayerCntInfo(info)
  RankModel.Instance:ApplyOpenRankData(DailyRankType, self:_GetRankSubTid(), info or {})
  self:SetRankViewData(self:_BuildRankViewData())
end

return DailyChallengeBoardEntryPanelModel
