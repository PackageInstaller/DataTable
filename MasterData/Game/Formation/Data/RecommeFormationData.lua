local RecommeFormationData = class("RecommeFormationData")
local RecommeFormationSingleData = require("Game.Formation.Data.RecommeFormationSingleData")

function RecommeFormationData:ctor()
  self.list = {}
  self.isDungeon = false
  self.recommeSupoortChip = true
  self.__formationRuleCfg = ConfigData.formation_rule[0]
end

function RecommeFormationData.CreateRecommeData(stageId)
  local data = RecommeFormationData:New()
  data.stageId = stageId
  return data
end

function RecommeFormationData:GenRecommeSingleData(msg)
  self.refreshTime = msg.refreshTime or 0
  for i = 1, #msg.data do
    local singleData = RecommeFormationSingleData.New()
    singleData:SetRecommeSinglePara(self.isDungeon, self.stageId)
    singleData:InitRecommeSingleData(msg.data[i], self.__formationRuleCfg)
    table.insert(self.list, singleData)
  end
end

function RecommeFormationData:SetAsDungeonRecomme()
  self.isDungeon = true
end

function RecommeFormationData:SetRecommeSupportChip(active)
  self.recommeSupoortChip = active
end

function RecommeFormationData:SetFormationRuleId(ruleId)
  if ruleId <= 0 then
    return
  end
  local formationRuleCfg = ConfigData.formation_rule[ruleId]
  self.__formationRuleCfg = formationRuleCfg
end

function RecommeFormationData:GetRecommeMaxStageNum()
  return self.__formationRuleCfg.stage_num
end

function RecommeFormationData:GetRecommeMaxBenchNum()
  return self.__formationRuleCfg.bench_num
end

function RecommeFormationData:SortByPower()
  table.sort(self.list, RecommeFormationData.__DefaultSort)
end

function RecommeFormationData:SortByHeroCount()
  for key, value in pairs(self.list) do
    value.haveCount = value:GetHaveCount()
  end
  table.sort(self.list, RecommeFormationData.__CountSort)
end

function RecommeFormationData.__CountSort(a, b)
  local aHasAll = a.haveCount == a.heroCount
  local bHasAll = b.haveCount == b.heroCount
  if aHasAll ~= bHasAll then
    return aHasAll
  end
  if aHasAll then
    if a.heroCount ~= b.heroCount then
      return a.heroCount < b.heroCount
    end
    return RecommeFormationData.__DefaultSort(a, b)
  end
  if a.haveCount ~= b.haveCount then
    return a.haveCount > b.haveCount
  end
  return RecommeFormationData.__DefaultSort(a, b)
end

function RecommeFormationData.__DefaultSort(a, b)
  if a.power ~= b.power then
    return a.power < b.power
  end
  if a.heroCount ~= b.heroCount then
    return a.heroCount < b.heroCount
  end
  if a.starMax ~= b.starMax then
    return a.starMax < b.starMax
  end
  if a.levelMax ~= b.levelMax then
    return a.levelMax < b.levelMax
  end
  return a.idAddtion < b.idAddtion
end

return RecommeFormationData
