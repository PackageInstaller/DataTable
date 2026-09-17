local this = class("homeCropFieldData")
local FieldType = 1
local _homeFieldTpl = L_GameTpl:getHomeFieldtypeTpl()
local _homeSeedTpl = L_GameTpl:getHomeSeedsTpl()
local _homeBlockTpl = L_GameTpl:getHomeBlockTpl()

function this:ctor()
  self.field_id = 0
  self.block_id = 0
  self.status = L_Const.WorldMapFieldStatusType.WMFST_CLOSE
  self.water_num = 100
  self.change_time = 0
  self.max_water_num = 100
  self.crop_id = 0
end

function this:populate(data)
  self.field_id = data.field_id
  self.block_id = data.block_id
  self.status = data.status
  self.water_num = data.water_num
  self.change_time = data.change_time
  self.max_water_num = data.max_water_num
end

function this:getFieldType()
  local blockTpl = _homeBlockTpl:getTplById(self.block_id)
  return blockTpl and _homeBlockTpl:getFieldType(blockTpl) or FieldType
end

function this:setCropId(id)
  self.crop_id = id
end

function this:getCropData()
  return L_HomeCropStore:getCropData(self.crop_id)
end

function this:getBlockAutoData()
  return L_HomeCropStore:getBlockAutoCropData(self.block_id)
end

function this:getCurrWaterInfo()
  local fieldTpl = _homeFieldTpl:getTplById(self:getFieldType())
  local fieldWaterTime = _homeFieldTpl:getWaterTime(fieldTpl)
  local passTime = math.max(L_TimeUtil.getServerTimeWithFloor() - self.change_time, 0)
  local crop = self:getCropData()
  local fieldWaterMax = self.max_water_num
  if not crop then
    return math.max(self.water_num - math.floor(passTime / fieldWaterTime), 0), 0, self.water_num * fieldWaterTime - passTime, fieldWaterMax, 0
  end
  local cropTpl = _homeSeedTpl:getTplById(crop.seed_id)
  local cropNeedWater, cropNeedWaterMulti = _homeSeedTpl:getNeedWater(cropTpl)
  local needWater = crop.status == L_Const.WorldMapCropStatusType.WMCST_PRE_HARVEST and cropNeedWaterMulti or cropNeedWater
  local restGrowTime = math.max(crop:getHarvestTime() - self.change_time, 0)
  local cropWaterTime = _homeSeedTpl:getWaterTime(cropTpl)
  local restNeedWaterCount = math.min(needWater - crop.water_num, math.floor(restGrowTime / cropWaterTime))
  local restWaterTime, cropWaterMaxCount
  if math.floor((restNeedWaterCount * cropWaterTime - 1) / fieldWaterTime) + restNeedWaterCount <= self.water_num then
    restWaterTime = (self.water_num - restNeedWaterCount) * fieldWaterTime - passTime
    cropWaterMaxCount = restNeedWaterCount
  else
    local canCount = math.floor(math.max(self.water_num, 0) / (1 + cropWaterTime / fieldWaterTime))
    local canCountPlus1 = canCount + 1
    if math.floor((canCountPlus1 * cropWaterTime - 1) / fieldWaterTime) + canCountPlus1 <= self.water_num then
      canCount = canCountPlus1
    end
    restWaterTime = math.max(math.max(canCount * cropWaterTime, (self.water_num - canCount) * fieldWaterTime) - passTime, 0)
    cropWaterMaxCount = canCount
  end
  local cropWaterCount = math.min(math.floor(passTime / cropWaterTime), cropWaterMaxCount)
  local fieldWaterCount = math.floor(passTime / fieldWaterTime)
  local fieldCurrWater = math.max(self.water_num - fieldWaterCount - cropWaterCount, 0)
  local cropCurrWater = crop.water_num + cropWaterCount
  return fieldCurrWater, cropCurrWater, restWaterTime, fieldWaterMax, needWater
end

return this
