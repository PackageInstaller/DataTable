local SocialExtModel, Super = NewClass("SocialExtModel", BaseModel)

function SocialExtModel:OnInit()
  self:OnReset()
  self:GetRankTypeList()
  self.rankType2ScoreGetFuncMap = {
    [RankDefine.RankType.Level] = System.fn(self, self.GetRankTypeLevelScore),
    [SocialDefine.FriendRankTypePrefix .. RankDefine.RankType.Level] = System.fn(self, self.GetRankTypeLevelScore)
  }
end

function SocialExtModel:OnReset()
  self.rankTypeList = nil
  self.awakerLikeRankList = nil
  self.Rank_Req_Interval = 10
  self.selectAwakerLikeRankTid = 0
  self.rankTypeTextDict = nil
  self.rankTypeTitleTextDict = nil
end

function SocialExtModel:GetRankTypeLevelScore(data)
  do return string.format, "%s / %s", (LT.Textf("Team_AwakerLevel", data.level or "")) end
  return string.format, "%s / %s", LT.Textf("Team_AwakerLevel", data.level or ""), data.exp or "", data.level or ""
end

function SocialExtModel:GetAwakerLikeRankTid()
  if 0 == self.selectAwakerLikeRankTid and self.awakerLikeRankList and #self.awakerLikeRankList > 0 then
    self.selectAwakerLikeRankTid = self.awakerLikeRankList[1] or 0
  end
  return self.selectAwakerLikeRankTid
end

function SocialExtModel:GetRankReqInterval()
  return self.Rank_Req_Interval
end

function SocialExtModel:GetRankList(rankType, isFriendRank)
  local serverRankType = self:GetReqRankType(rankType, isFriendRank)
  do return RankModel.Instance.GetRankListData, RankModel.Instance end
  return RankModel.Instance.GetRankListData, RankModel.Instance, serverRankType
end

function SocialExtModel:GetRankTypeList()
  if self.rankTypeList then
    return self.rankTypeList
  end
  self.rankTypeList = {
    RankDefine.RankType.Level,
    RankDefine.RankType.AwakerLike,
    RankDefine.RankType.LoginDays,
    RankDefine.RankType.AchieveNum,
    RankDefine.RankType.GoodNum,
    RankDefine.RankType.BeGoodNum,
    RankDefine.RankType.AssistNum,
    RankDefine.RankType.FollowerNum,
    RankDefine.RankType.Collection
  }
  return self.rankTypeList
end

function SocialExtModel:GetAwakerLikeRankList()
  if self.awakerLikeRankList then
    return self.awakerLikeRankList
  end
  self.awakerLikeRankList = {}
  local now = TimeUtils.GetServerTime()
  for tid, cfg in pairs(DT.AwakerConfig) do
    local notOriginAwaker = not AwakerDataUtils.IsOriginType(tid)
    local isReachShowTime = not cfg.AwakeDisplayDate or now >= cfg.AwakeDisplayDate
    if notOriginAwaker and isReachShowTime then
      table.insert(self.awakerLikeRankList, tid)
    end
  end
  
  local function _SortAwaker(a, b)
    local likeValueA = AwakerDataUtils.GetAwakerLike(a)
    local likeValueB = AwakerDataUtils.GetAwakerLike(b)
    if likeValueA ~= likeValueB then
      return likeValueA > likeValueB
    end
    local cfgA = AwakerDataUtils.GetAwakerConfig(a)
    local cfgB = AwakerDataUtils.GetAwakerConfig(b)
    local cfgSortA = cfgA and cfgA.SortID or 999
    local cfgSortB = cfgB and cfgB.SortID or 999
    return cfgSortA < cfgSortB
  end
  
  table.sort(self.awakerLikeRankList, _SortAwaker)
  return self.awakerLikeRankList
end

function SocialExtModel:GetOwnedAwakerLikeRankList()
  local allAwakerList = self:GetAwakerLikeRankList()
  local list = {}
  for _, awakerTid in ipairs(allAwakerList) do
    if AwakerDataUtils.HasOwnedAwaker(awakerTid) then
      table.insert(list, awakerTid)
    end
  end
  return list
end

function SocialExtModel:GetReqRankType(rankType, isFriendRank)
  if not rankType then
    return
  end
  if isFriendRank then
    rankType = SocialDefine.FriendRankTypePrefix .. rankType
  end
  Logger.Debug("[sr] try get req rankType, rankType=%s, isFriendRank=%s", rankType, isFriendRank)
  if string.contains(rankType, RankDefine.RankType.AwakerLike) then
  end
  return rankType
end

function SocialExtModel:GetRankTypeText(rankType)
  if self.rankTypeTextDict then
    return self.rankTypeTextDict[rankType]
  end
  self.rankTypeTextDict = {
    [RankDefine.RankType.Level] = LT.Text("Option_RankListPlayerLevel"),
    [RankDefine.RankType.AwakerLike] = LT.Text("Option_RankListHomologyRate"),
    [RankDefine.RankType.LoginDays] = LT.Text("Option_RankListLoginDays"),
    [RankDefine.RankType.AchieveNum] = LT.Text("Option_RankListAchievementCount"),
    [RankDefine.RankType.GoodNum] = LT.Text("Option_RankListLikeCount"),
    [RankDefine.RankType.BeGoodNum] = LT.Text("Option_RankListGetlikeCount"),
    [RankDefine.RankType.AssistNum] = LT.Text("Option_RankListAssistanceCount"),
    [RankDefine.RankType.FollowerNum] = LT.Text("Option_RankListFollowerNum"),
    [RankDefine.RankType.Collection] = LT.Text("Option_RankListCollectionNum")
  }
  return self.rankTypeTextDict[rankType]
end

function SocialExtModel:GetRankTypeTitleText(rankType)
  if self.rankTypeTitleTextDict then
    return self.rankTypeTitleTextDict[rankType]
  end
  self.rankTypeTitleTextDict = {
    [RankDefine.RankType.Level] = LT.Text("RankListPlayerLevel"),
    [RankDefine.RankType.AwakerLike] = LT.Text("RankListHomologyRate"),
    [RankDefine.RankType.LoginDays] = LT.Text("RankListLoginDays"),
    [RankDefine.RankType.AchieveNum] = LT.Text("RankListAchievementCount"),
    [RankDefine.RankType.GoodNum] = LT.Text("RankListLikeCount"),
    [RankDefine.RankType.BeGoodNum] = LT.Text("RankListGetlikeCount"),
    [RankDefine.RankType.AssistNum] = LT.Text("RankListAssistanceCount"),
    [RankDefine.RankType.FollowerNum] = LT.Text("RankListFollowerNum"),
    [RankDefine.RankType.Collection] = LT.Text("RankListCollectionNum")
  }
  return self.rankTypeTitleTextDict[rankType]
end

function SocialExtModel:GetScoreShowText(rankData, rankType)
  local score = rankData.score and rankData.score >= 0 and rankData.score or "-"
  if rankData and rankData.level and self.rankType2ScoreGetFuncMap[rankType] then
    score = self.rankType2ScoreGetFuncMap[rankType](rankData)
  end
  return score
end

function SocialExtModel:SetAwakerLikeRankTid(awakerTid)
  self.selectAwakerLikeRankTid = awakerTid
  self:LocalNotify(NotifyId.OnSelectAwakerLikeRank, self.selectAwakerLikeRankTid)
end

return SocialExtModel
