local RpgArenaDataUtils = {}

function RpgArenaDataUtils.ResetAll()
  DataCenter.rpgArenaData.myRole = {}
  DataCenter.rpgArenaData.ranks = {}
  DataCenter.rpgArenaData.opponents = {}
  DataCenter.rpgArenaData.historyCombat = {}
  DataCenter.rpgArenaData.defendTeam = {
    0,
    0,
    0,
    0,
    0,
    0
  }
  DataCenter.rpgArenaData.combatTeam = {
    0,
    0,
    0,
    0,
    0,
    0
  }
  DataCenter.rpgArenaData.rankUpData = nil
  DataCenter.rpgArenaData.inited = false
end

function RpgArenaDataUtils.isInited()
  return DataCenter.rpgArenaData.inited
end

function RpgArenaDataUtils.GetTimeAwardPerHour(rank)
  local count = 0
  for _, v in ipairs(DT.SettingRewardConfig) do
    if rank >= v.UpperLimit and rank <= v.LowerLimit then
      count = count + (v.LowerLimit - rank + 1) * v.ItemNum
    elseif rank < v.UpperLimit then
      count = count + (v.LowerLimit - v.UpperLimit + 1) * v.ItemNum
    end
  end
  return count
end

function RpgArenaDataUtils.GetCoinId()
  return 1
end

function RpgArenaDataUtils.SetArenaData(data)
  RpgArenaDataUtils.SetMyRole(data.myData)
  RpgArenaDataUtils.SetOpponents(data.opponentData)
  RpgArenaDataUtils.SetDefendTeam(data.defTeam)
  RpgArenaDataUtils.SetAckTeam(data.ackTeam)
  DataCenter.rpgArenaData.inited = true
end

function RpgArenaDataUtils.SetMyRole(data)
  DataCenter.rpgArenaData.myRole = data
end

function RpgArenaDataUtils.SetOpponents(opponent)
  DataCenter.rpgArenaData.opponents = opponent
end

function RpgArenaDataUtils.SetDefendTeam(team)
  if next(team) ~= nil then
    DataCenter.rpgArenaData.defendTeam = team
  end
end

function RpgArenaDataUtils.SetAckTeam(team)
  if next(team) == nil then
    DataCenter.rpgArenaData.myRole.zl = 0
    return
  end
  DataCenter.rpgArenaData.combatTeam = team
  RpgArenaDataUtils.UpdateFight(team)
end

function RpgArenaDataUtils.UpdateFight(team)
  local awakerMap = DataCenter.awakerData.awakerMap
  local totalFighting = 0
  for _, tid in ipairs(team) do
    local awakerData = awakerMap[tid]
    if awakerData and awakerData.fighting then
      totalFighting = totalFighting + awakerData.fighting
    end
  end
  DataCenter.rpgArenaData.myRole.zl = totalFighting
end

function RpgArenaDataUtils.SetHistoryCombat(data)
  DataCenter.rpgArenaData.historyCombat = data
end

function RpgArenaDataUtils.SetRank(data)
  DataCenter.rpgArenaData.ranks = data
end

function RpgArenaDataUtils.OpenArenaBattleStatisPanel(data, detail)
  UIManager.Instance:Reopen(Urls.RpgArenaBattleStatsPanel, data, detail)
end

function RpgArenaDataUtils.SetRankUpData(data)
  DataCenter.rpgArenaData.rankUpData = data
end

function RpgArenaDataUtils.ShowRewards()
  local data = DataCenter.rpgArenaData.rankUpData
  if nil ~= data then
    UIManager.Instance:Reopen(Urls.RpgArenaRankUpPanel, data)
  end
  RpgArenaDataUtils.SetRankUpData(nil)
end

function RpgArenaDataUtils.HasOpenRpgArenaPanel()
  return UIManager.Instance:GetWindow(Urls.RpgArenaPanel) ~= nil
end

return RpgArenaDataUtils
