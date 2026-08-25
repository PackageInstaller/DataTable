local DungeonStatisticMO = NewClass("DungeonStatisticMO")

function DungeonStatisticMO:ctor()
  self._statisticDataList = {}
  self._viewData = nil
  self._settleAwakerDatas = {}
  self._recordStageData = nil
  self._teamAssistSlot = CommonDefine.TeamAssistPos
end

function DungeonStatisticMO:UpdateData(svrData)
  self._statisticDataList = svrData or {}
end

function DungeonStatisticMO:UpdateSourceData(settleAwakerDatas, recordStageData, teamAssistSlot)
  self._settleAwakerDatas = settleAwakerDatas or {}
  self._recordStageData = recordStageData
  self._teamAssistSlot = teamAssistSlot or CommonDefine.TeamAssistPos
  self._viewData = CopyBattleStatisticsDataUtils.BuildViewData(self._settleAwakerDatas, self._recordStageData, self._teamAssistSlot)
end

function DungeonStatisticMO:RebuildByScope(battleIndex, roundIndex)
  self._statisticDataList = CopyBattleStatisticsDataUtils.BuildOwnerRowsByScope(self._viewData, battleIndex, roundIndex)
end

function DungeonStatisticMO:BuildStatisticDataListByScope(battleIndex, roundIndex)
  do return CopyBattleStatisticsDataUtils.BuildOwnerRowsByScope, self._viewData, battleIndex end
  return CopyBattleStatisticsDataUtils.BuildOwnerRowsByScope, self._viewData, battleIndex, roundIndex
end

function DungeonStatisticMO:GetBattleCount()
  local battles = self._viewData and self._viewData.battles or {}
  return #battles
end

function DungeonStatisticMO:GetBattleRowByIndex(battleIndex)
  local battles = self._viewData and self._viewData.battles or {}
  local targetIndex = tonumber(battleIndex) or 0
  if targetIndex <= 0 then
    return nil, nil, battles
  end
  for pos, battleRow in ipairs(battles) do
    local idx = tonumber(battleRow.battleIndex) or pos
    if idx == targetIndex then
      return battleRow, pos, battles
    end
  end
  return nil, nil, battles
end

function DungeonStatisticMO:GetRoundCount(battleIndex)
  do return CopyBattleStatisticsDataUtils.GetMaxRoundIndex, self._viewData end
  return CopyBattleStatisticsDataUtils.GetMaxRoundIndex, self._viewData, battleIndex
end

function DungeonStatisticMO:GetRoundSummaryList(battleIndex, roundIndex)
  do return CopyBattleStatisticsDataUtils.BuildRoundRowsByScope, self._viewData, battleIndex end
  return CopyBattleStatisticsDataUtils.BuildRoundRowsByScope, self._viewData, battleIndex, roundIndex
end

function DungeonStatisticMO:GetSkillStatisticRowsByScope(awakerTid, battleIndex, roundIndex)
  local rows = CopyBattleStatisticsDataUtils.BuildOwnerSkillRowsByScope(self._viewData, awakerTid, battleIndex, roundIndex)
  return rows
end

function DungeonStatisticMO:GetSkillRowsByScope(ownerId, battleIndex, roundIndex, extraFields)
  do return CopyBattleStatisticsDataUtils.BuildOwnerSkillRowsByScope, self._viewData, ownerId, battleIndex, roundIndex end
  return CopyBattleStatisticsDataUtils.BuildOwnerSkillRowsByScope, self._viewData, ownerId, battleIndex, roundIndex, extraFields
end

function DungeonStatisticMO:GetLastBossBattleIndex()
  do return CopyBattleStatisticsDataUtils.GetLastBossBattleIndex end
  return CopyBattleStatisticsDataUtils.GetLastBossBattleIndex, self._viewData
end

function DungeonStatisticMO:GetBattleOptionList()
  do return CopyBattleStatisticsDataUtils.GetBattleOptionList end
  return CopyBattleStatisticsDataUtils.GetBattleOptionList, self._viewData
end

function DungeonStatisticMO:GetStatisticDataList()
  return self._statisticDataList
end

function DungeonStatisticMO:_Aggregate(field, mode)
  local rst = 0
  for _, statisticData in ipairs(self._statisticDataList) do
    local v = statisticData[field] or 0
    if "sum" == mode then
      rst = rst + v
    elseif v > rst then
      rst = v
    end
  end
  return rst
end

function DungeonStatisticMO:GetTotalDamage()
  do return self._Aggregate, self, "damage" end
  return self._Aggregate, self, "damage", "sum"
end

function DungeonStatisticMO:GetTotalHeal()
  do return self._Aggregate, self, "heal" end
  return self._Aggregate, self, "heal", "sum"
end

function DungeonStatisticMO:GetTotalShield()
  do return self._Aggregate, self, "shield" end
  return self._Aggregate, self, "shield", "sum"
end

function DungeonStatisticMO:GetMaxDamage()
  do return self._Aggregate, self, "damage" end
  return self._Aggregate, self, "damage", "max"
end

function DungeonStatisticMO:GetMaxHeal()
  do return self._Aggregate, self, "heal" end
  return self._Aggregate, self, "heal", "max"
end

function DungeonStatisticMO:GetMaxShield()
  do return self._Aggregate, self, "shield" end
  return self._Aggregate, self, "shield", "max"
end

function DungeonStatisticMO:GetBarNormalizedByPercentCeil(value, vmax)
  local p = CopyBattleStatisticsDataUtils.BarPercentCeil(value, vmax)
  return p > 0 and p / 100 or 0
end

return DungeonStatisticMO
