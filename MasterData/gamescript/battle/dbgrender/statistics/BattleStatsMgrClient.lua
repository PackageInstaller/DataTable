local BattleStatsMgrClient, Super = System.NewClass("BattleStatsMgrClient")

function BattleStatsMgrClient:ctor()
  Super.ctor(self)
  self.typeToStatsKey = {
    BattleStats = "battleStats",
    CurBoutStats = "curBoutStats",
    LastBoutStats = "lastBoutStats",
    GlobalStats = "globalStats"
  }
  self:RegisterEvents()
end

function BattleStatsMgrClient:Dispose()
  bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
end

function BattleStatsMgrClient:RegisterEvents()
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.UpdateStats, self.OnUpdateStats, self)
end

function BattleStatsMgrClient:OnUpdateStats(data)
  bg.battleDataCenter.statsDataModelMap[data.camp] = data.statsData
end

function BattleStatsMgrClient:__GetStatsData(statsType)
  local myCamp = bg.battleDataCenter:GetMyCamp()
  local statsModel = bg.battleDataCenter.statsDataModelMap[myCamp]
  if not statsModel then
    return
  end
  local statsKey = self.typeToStatsKey[statsType]
  local statsData = statsModel[statsKey]
  return statsData
end

function BattleStatsMgrClient:GetStats(statsType, attr)
  local statsData = self:__GetStatsData(statsType)
  if not statsData then
    return 0
  end
  return statsData[attr] or 0
end

function BattleStatsMgrClient:GetUsedCountOfCardByConfigId(statsType, cardConfigId)
  local statsData = self:__GetStatsData(statsType)
  local usedCardStats = statsData[bc.StatsKey.UsedCardCountByConfigId]
  if nil == usedCardStats then
    return 0
  end
  return usedCardStats[cardConfigId] or 0
end

return BattleStatsMgrClient
