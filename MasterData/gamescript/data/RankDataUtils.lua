local RankDataUtils = {}

function RankDataUtils.GetRankKey(rankType, subTid)
  if nil == subTid then
    return rankType
  end
  do return string.format, "%s_%s", rankType end
  return string.format, "%s_%s", rankType, subTid or 0
end

local levelRankTypeGroup = {
  RankDefine.RankType.Level,
  SocialDefine.FriendRankTypePrefix .. RankDefine.RankType.Level
}

function RankDataUtils.GetRankText(rankInfo)
  local rankText = LT.Text("AbyssChallengeRankNotOnTheList")
  if rankInfo.rewardRankIndex and rankInfo.rewardRankIndex > 0 then
    rankText = rankInfo.rewardRankIndex
  end
  if rankInfo.type and table.contains(levelRankTypeGroup, rankInfo.type) then
    rankText = rankInfo.rank
  end
  return rankText
end

function RankDataUtils.ResetAll()
  RankModel.Instance:ResetAllRankData()
end

function RankDataUtils.ResetRankType(rankType, subTid)
  RankModel.Instance:ResetRankType(rankType, subTid)
end

function RankDataUtils.GetRankList(rankType, subTid)
  do return RankModel.Instance.GetRankListData, RankModel.Instance, rankType end
  return RankModel.Instance.GetRankListData, RankModel.Instance, rankType, subTid
end

function RankDataUtils.GetSelfRank(rankType, subTid)
  do return RankModel.Instance.GetSelfRankData, RankModel.Instance, rankType end
  return RankModel.Instance.GetSelfRankData, RankModel.Instance, rankType, subTid
end

function RankDataUtils.GetSelfRankTid(rankType, subTid)
  do return RankModel.Instance.GetSelfRankTid, RankModel.Instance, rankType end
  return RankModel.Instance.GetSelfRankTid, RankModel.Instance, rankType, subTid
end

function RankDataUtils.GetRankLength(rankType, subTid)
  do return RankModel.Instance.GetRankLengthData, RankModel.Instance, rankType end
  return RankModel.Instance.GetRankLengthData, RankModel.Instance, rankType, subTid
end

function RankDataUtils.GetRankCountInterval(rankType, subTid, rankTid)
  do return RankModel.Instance.GetRankCountIntervalData, RankModel.Instance, rankType, subTid end
  return RankModel.Instance.GetRankCountIntervalData, RankModel.Instance, rankType, subTid, rankTid
end

function RankDataUtils.GetRankCfgByRewardIndex(rankType, subTid, rewardIndex)
  do return RankModel.Instance.GetRankCfgByRewardIndex, RankModel.Instance, rankType, subTid end
  return RankModel.Instance.GetRankCfgByRewardIndex, RankModel.Instance, rankType, subTid, rewardIndex
end

function RankDataUtils.GetPlayerCntInfo(rankType, subTid)
  do return RankModel.Instance.GetPlayerCntInfoData, RankModel.Instance, rankType end
  return RankModel.Instance.GetPlayerCntInfoData, RankModel.Instance, rankType, subTid
end

function RankDataUtils.GetRankSettling(rankType, subTid)
  do return RankModel.Instance.GetRankSettlingData, RankModel.Instance, rankType end
  return RankModel.Instance.GetRankSettlingData, RankModel.Instance, rankType, subTid
end

function RankDataUtils.GetIsWinByRankType(rankType, subTid)
  do return RankModel.Instance.GetIsWinByRankType, RankModel.Instance, rankType end
  return RankModel.Instance.GetIsWinByRankType, RankModel.Instance, rankType, subTid
end

function RankDataUtils.GetSortedCfg(rankCfg)
  do return RankModel.Instance.GetSortedCfg, RankModel.Instance end
  return RankModel.Instance.GetSortedCfg, RankModel.Instance, rankCfg
end

function RankDataUtils.ApplyQueryRankResult(rankType, subTid, startIndex, svrData, count)
  RankModel.Instance:ApplyQueryRankResult(rankType, subTid, startIndex, svrData, count)
end

function RankDataUtils.ApplyOpenRankData(rankType, subTid, data)
  RankModel.Instance:ApplyOpenRankData(rankType, subTid, data)
end

function RankDataUtils.ReqRankingData(rankType, callback)
  RankController.Instance:ReqRankingData(rankType, callback)
end

return RankDataUtils
