local RecommeFormationNewData = class("RecommeFormationNewData")
local RecommeFormationSingleData = require("Game.Formation.Data.RecommeFormationNewSingleData")

function RecommeFormationNewData:ctor()
  self.list = {}
  self.isDungeon = false
  self.__formationRuleCfg = ConfigData.formation_rule[0]
end

function RecommeFormationNewData.CreateRecommeData(stageId)
  local data = RecommeFormationNewData:New()
  data.stageId = stageId
  return data
end

function RecommeFormationNewData:GenRecommeSingleData(msg)
  self.refreshTime = msg.refreshTime or 0
  local data = msg.dataV2
  table.sort(data, function(a, b)
    if a.winCount ~= b.winCount then
      return a.winCount > b.winCount
    else
      return a.data.power < b.data.power
    end
  end)
  for i = 1, #data do
    local singleData = RecommeFormationSingleData.New()
    singleData:SetRecommeSinglePara(self.isDungeon, self.stageId)
    singleData:InitRecommeSingleData(data[i], i)
    table.insert(self.list, singleData)
  end
end

function RecommeFormationNewData:SetAsDungeonRecomme()
  self.isDungeon = true
end

function RecommeFormationNewData:SetFormationRuleId(ruleId)
  if ruleId <= 0 then
    return
  end
  local formationRuleCfg = ConfigData.formation_rule[ruleId]
  self.__formationRuleCfg = formationRuleCfg
end

function RecommeFormationNewData:GetRecommeMaxStageNum()
  return self.__formationRuleCfg.stage_num
end

return RecommeFormationNewData
