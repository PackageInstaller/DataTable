local RankingBoardDataUtils = {}

function RankingBoardDataUtils.OpenDailyChallengeBoardEntryPanel(dailyModel)
  UIManager.Instance:Reopen(Urls.DailyChallengeBoardEntryPanel, dailyModel)
end

function RankingBoardDataUtils.GetSeasonRankRowRewards(row)
  local rst = {}
  if not row or not row.NewRankReward then
    return rst
  end
  for tid, num in pairs(row.NewRankReward) do
    table.insert(rst, {tid = tid, num = num})
  end
  return rst
end

function RankingBoardDataUtils.GetRankCfg(rankId)
  if not rankId then
    Logger.Debug("Error Val rankId")
    return nil
  end
  return DT.Rank[rankId]
end

return RankingBoardDataUtils
