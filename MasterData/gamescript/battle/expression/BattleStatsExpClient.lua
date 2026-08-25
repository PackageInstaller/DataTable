local BattleStatsExpClient, Super = System.NewClass("BattleStatsExpClient", BaseExpression)

function BattleStatsExpClient:ctor(cmdParser, statsType)
  Super.ctor(self)
  self.statsType = statsType
  self.cmdParser = cmdParser
  self.memberValues = {}
  self.cmdFuncs = {}
  Super.InitGetter(self)
end

function BattleStatsExpClient:GetStatsType()
  do return rawget, self end
  return rawget, self, "statsType"
end

function BattleStatsExpClient:GetAttr(attrName)
  local statsType = self:GetStatsType()
  if not bg.battleScene then
    if "GlobalStats" ~= statsType then
      return 0
    end
    local stageData = WorldStageManager.Instance:GetCurStageData()
    if not stageData or not stageData.stats then
      return 0
    end
    return stageData.stats[attrName]
  end
  if "CurCmdStats" == statsType then
    return 0
  end
  do return bg.battleRender.statsMgr.GetStats, bg.battleRender.statsMgr, self.statsType end
  return bg.battleRender.statsMgr.GetStats, bg.battleRender.statsMgr, self.statsType, attrName
end

function BattleStatsExpClient:GetUsedCountOfCardByConfigId(cardConfigId)
  local statsType = self:GetStatsType()
  if not bg.battleScene then
    if "GlobalStats" ~= statsType then
      return 0
    end
    local stageData = WorldStageManager.Instance:GetCurStageData()
    if not stageData or not stageData.stats then
      return
    end
    local usedCardStats = stageData.stats[bc.StatsKey.UsedCardCountByConfigId]
    if not usedCardStats then
      return 0
    end
    return usedCardStats[cardConfigId] or 0
  end
  if "CurCmdStats" == statsType then
    return 0
  end
  do return bg.battleRender.statsMgr.GetUsedCountOfCardByConfigId, bg.battleRender.statsMgr, self.type end
  return bg.battleRender.statsMgr.GetUsedCountOfCardByConfigId, bg.battleRender.statsMgr, self.type, cardConfigId
end

return BattleStatsExpClient
