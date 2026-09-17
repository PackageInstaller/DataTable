local this = class("homeSeedsTpl")
local _commonItemTpl = L_GameTpl:getCommonItemTpl()

function this:init(config)
  self.data = config
  self.seedsIdDic = {}
  self.totalTime = {}
  self.harvestTime = {}
  self.growTime = {}
  for _, tpl in pairs(config) do
    local totalTime = 0
    totalTime = totalTime + tpl.preHarvestParam[2]
    self.harvestTime[tpl.id] = totalTime
    for _, para in pairs(tpl.growParam) do
      totalTime = totalTime + para[2]
    end
    self.totalTime[tpl.id] = totalTime
    self.growTime[tpl.id] = totalTime - tpl.preHarvestParam[2]
  end
  local seedGroup = _commonItemTpl:getTypeGroup(L_BagConst.bagItemType.seed)
  for k, v in pairs(seedGroup or {}) do
    self.seedsIdDic[v.id] = _commonItemTpl:getSubId(v)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTotalTime(tpl)
  return self.totalTime[tpl.id]
end

function this:getHarvestTime(tpl)
  return self.harvestTime[tpl.id]
end

function this:getGrowTime(tpl)
  return self.growTime[tpl.id]
end

function this:getTplBySeedItemId(id)
  local tplId = self.seedsIdDic[id]
  local result = self:getTplById(tplId)
  if result == nil then
    errorf("种子道具: " .. tostring(id) .. "  没有配置种植Id：" .. tostring(tplId))
  end
  return result
end

function this:getHarvestRound(tpl)
  return tpl.harvestRound
end

function this:getCropType(tpl)
  return tpl.cropType
end

function this:getPreHarvestParam(tpl)
  return tpl.preHarvestParam
end

function this:getHarvestParam(tpl)
  return tpl.harvestParam
end

function this:getGrowParam(tpl)
  return tpl.growParam
end

function this:getSeedParam(tpl)
  return tpl.seedParam
end

function this:getId(tpl)
  return tpl.id
end

function this:getHomeDropId(tpl)
  return tpl.homeDropId
end

function this:getDropPath(tpl)
  return tpl.dropPath
end

function this:getExp(tpl)
  return tpl.exp
end

function this:getFieldType(tpl)
  return tpl.fieldType
end

function this:getTimeNote(tpl)
  return tpl.time_note
end

function this:getBlockLength(tpl)
  return tpl.blockLength
end

function this:getIsSeed(id)
  return self.seedsIdDic[id] ~= nil
end

function this:getSeedTplByItem(id)
  return self.data[self.seedsIdDic[id]]
end

function this:getCropName(tpl)
  return L_Config:provider(tpl.cropName)
end

function this:getNumShow(tpl)
  return L_Config:provider(tpl.numShow)
end

function this:getWaterTime(tpl)
  return tpl.waterTime
end

function this:getNeedWater(tpl)
  return tpl.needWater, tpl.needWaterMulti
end

function this:getCondition(tpl)
  return tpl.cropUnlockCondition
end

function this:getHomeItemSize(tpl)
  return tpl.homeItemSize
end

return this
