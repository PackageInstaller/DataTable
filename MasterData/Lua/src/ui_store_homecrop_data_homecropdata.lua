local this = class("homeCropData")
local _homeSeedTpl = L_GameTpl:getHomeSeedsTpl()

function this:ctor()
  self.guid = 0
  self.seed_id = 0
  self.status = L_Const.WorldMapCropStatusType.WMCST_GROW
  self.index = 0
  self.start_time = 0
  self.reward_count = 0
  self.block_id = 0
  self.field_ids = {}
  self.field_min = 0
  self.water_num = 0
  self.talent_id = {}
  self._readHarvest = false
end

function this:populate(sData)
  self.guid = sData.guid
  self.seed_id = sData.seed_id
  self.status = sData.status
  self.index = sData.index
  self.start_time = sData.start_time
  self.reward_count = sData.reward_count
  self.block_id = sData.block_id
  self.field_ids = sData.field_ids
  self.water_num = sData.water_num
  self.talent_id = sData.talent_id or {}
  local minId = math.huge
  for _, id in pairs(sData.field_ids) do
    minId = math.min(minId, id)
  end
  self.field_min = minId
  if self:getStatus() ~= L_Const.WorldMapCropStatusType.WMCST_HARVEST then
    self._readHarvest = false
  end
end

function this:getFieldData()
  return L_HomeCropStore:getFieldData(self.block_id, self.field_min)
end

function this:getCurrWater()
  local _, w = self:getFieldData():getCurrWaterInfo()
  return w
end

function this:getHarvestTime()
  local buffCondition = L_HomeBuffManager:getCropCondition(self.seed_id)
  local growTime, preHarTime = L_HomeBuffManager:getCropGrowParam(self.seed_id, buffCondition, {
    talentIds = self.talent_id
  })
  if self.status == L_Const.WorldMapCropStatusType.WMCST_PRE_HARVEST then
    return preHarTime + self.start_time
  end
  return growTime + preHarTime + self.start_time
end

function this:getStepEndTime()
  return self:getCurrStepInfo()
end

function this:getStatus()
  local _, s = self:getCurrStepInfo()
  return s
end

function this:getCurrStepInfo()
  local tpl = _homeSeedTpl:getTplById(self.seed_id)
  if self.status == L_Const.WorldMapCropStatusType.WMCST_SEED then
    errorf("植物没有种子阶段了 数据有问题" .. self.guid)
    return 0, L_Const.WorldMapCropStatusType.WMCST_SEED, 10000, 0
  end
  if self.status == L_Const.WorldMapCropStatusType.WMCST_HARVEST then
    return 0, L_Const.WorldMapCropStatusType.WMCST_HARVEST, _homeSeedTpl:getHarvestParam(tpl), 0
  end
  local growTime = L_TimeUtil.getServerTimeWithFloor() - self.start_time
  local buffCondition = L_HomeBuffManager:getCropCondition(self.seed_id)
  if self.status == L_Const.WorldMapCropStatusType.WMCST_GROW then
    for index, stepInfo in ipairs(growParams) do
      if growTime >= stepInfo[2] then
        growTime = growTime - stepInfo[2]
      else
        local nextInfo = growParams[index + 1] or preHarPara[1]
        local nextPhase = nextInfo and nextInfo[1] or _homeSeedTpl:getHarvestParam(tpl)
        return L_TimeUtil.getServerTimeWithFloor() + stepInfo[2] - growTime, L_Const.WorldMapCropStatusType.WMCST_GROW, stepInfo[1], stepInfo[2], nextPhase
      end
    end
  end
  for index, stepInfo in ipairs(preHarPara) do
    if growTime >= stepInfo[2] then
      growTime = growTime - stepInfo[2]
    else
      local nextPhase = preHarPara[index + 1] and preHarPara[index + 1][1] or _homeSeedTpl:getHarvestParam(tpl)
      return L_TimeUtil.getServerTimeWithFloor() + stepInfo[2] - growTime, L_Const.WorldMapCropStatusType.WMCST_PRE_HARVEST, stepInfo[1], stepInfo[2], nextPhase
    end
  end
  return 0, L_Const.WorldMapCropStatusType.WMCST_HARVEST, _homeSeedTpl:getHarvestParam(tpl), 0
end

function this:getCanBeWatered()
  if self.status == L_Const.WorldMapCropStatusType.WMCST_SEED then
    return true
  end
  return false
end

function this:setReadHarvest()
  self._readHarvest = true
end

function this:getReadHarvest()
  return self._readHarvest
end

return this
