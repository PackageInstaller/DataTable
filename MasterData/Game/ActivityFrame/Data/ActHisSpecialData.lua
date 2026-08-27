local ActHisSpecialData = class("ActHisSpecialData")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")

function ActHisSpecialData:ctor()
  self.carnival24HisDataDic = {}
end

function ActHisSpecialData:AssignmentCarnival24Data(actId, data)
  self.carnival24HisDataDic[actId] = {}
  self.carnival24HisDataDic[actId].fragMentDemandTable = table.deepCopy(data)
end

function ActHisSpecialData:RefreshCarnival24HisData(msg)
  self.carnival24HisDataDic[msg.actId] = {}
  self.carnival24HisDataDic[msg.actId].actId = msg.actId
  self.carnival24HisDataDic[msg.actId].fragMentDemandTable = {}
  for stageId, stage in pairs(msg.stages) do
    local demandIdList = stage.demandId
    for index, demandId in pairs(demandIdList) do
      if self.carnival24HisDataDic[msg.actId].fragMentDemandTable[stageId] == nil then
        self.carnival24HisDataDic[msg.actId].fragMentDemandTable[stageId] = {}
      end
      self.carnival24HisDataDic[msg.actId].fragMentDemandTable[stageId][demandId] = true
    end
  end
end

function ActHisSpecialData:IsHaveCarnival24Data(actId)
  return self.carnival24HisDataDic[actId] ~= nil
end

function ActHisSpecialData:IsUnLockMemoryFragMent(actId, memoryStateId)
  local memoryStageCfg = ConfigData.activity_carnival24_memory_stage[memoryStateId]
  for checkStageId, keyDemandCount in pairs(memoryStageCfg.next_need) do
    local compeltedCount = 0
    local demandCfgList = ConfigData.activity_carnival24_memory_demand[checkStageId]
    if demandCfgList == nil then
      return false
    end
    for demandId, cfg in pairs(demandCfgList) do
      if cfg.type_id == 1 and self.carnival24HisDataDic[actId].fragMentDemandTable[checkStageId] ~= nil and self.carnival24HisDataDic[actId].fragMentDemandTable[checkStageId][demandId] == true then
        compeltedCount = compeltedCount + 1
      end
    end
    if keyDemandCount > compeltedCount then
      return false
    end
  end
  return true
end

return ActHisSpecialData
