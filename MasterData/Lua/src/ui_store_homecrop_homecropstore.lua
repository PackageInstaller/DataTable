local this = class("homeCropStore", G_BaseStore)
this.event = {
  refreshField = "refreshField",
  refreshLookingCropId = "refreshLookingCropId",
  refreshEntruest = "refreshEntruest",
  onFieldOpen = "onFieldOpen",
  onFieldWater = "onFieldWater",
  onAutoWorkDataChange = "onAutoWorkDataChange"
}
this:importPartialClass(require(L_R.store .. "homeCrop.homeCropState"))
this:importPartialClass(require(L_R.store .. "homeCrop.homeCropAction"))

function this:ctor()
  this.super.ctor(self)
end

function this:rsp_CSProtoFieldOpen(data)
  for k, v in pairs(data) do
    self:call(self.event.onFieldOpen, v.block_id, v.field_id)
  end
end

function this:rsp_CSProtoFieldWater(data)
  for k, v in pairs(data) do
    self:call(self.event.onFieldWater, v.block_id, v.field_id)
  end
end

function this:syncDatas(data)
  local mapInfo = data.map_info
  if table.isEmpty(mapInfo) or table.isEmpty(mapInfo.home) then
    return
  end
  local homeData = mapInfo.home
  local updateMaps = {}
  self:syncFieldData(homeData.fields or {}, updateMaps)
  self:syncCropData(homeData.crops or {}, updateMaps)
  self:syncDelField(homeData.del_fields or {}, updateMaps)
  self:syncDelCrop(homeData.del_crops or {}, updateMaps)
  self:call(self.event.refreshField, updateMaps)
end

function this:syncAutoWorkDatas(datas)
  for _, data in ipairs(datas) do
    local blockId = data.block_id
    self.data.blockCropAutoDatas[blockId] = self.data.blockCropAutoDatas[blockId] or require(L_R.store .. "homeCrop.data.homeBlockCropAutoData").new(blockId)
    self.data.blockCropAutoDatas[blockId]:populate(data)
  end
  self:call(self.event.onAutoWorkDataChange)
end

function this:syncDelField(fieldKeys, updateMaps)
  for k, v in pairs(fieldKeys) do
    if self.data.fieldDataDic[v.block_id] then
      self.data.fieldDataDic[v.block_id][v.field_id] = nil
      updateMaps[v.field_id] = true
      self:doUpdateRange(v.field_id, updateMaps)
    end
  end
end

function this:doUpdateRange(id, maps)
  for x = -1, 1 do
    for y = -1, 1 do
      maps[id + x + y * L_Const.homeGridDataYOffset] = true
    end
  end
end

function this:syncDelCrop(cropGuids, updateMaps)
  for k, v in pairs(cropGuids) do
    local crop = self.data.cropDatas[v]
    if crop then
      updateMaps[crop:getFieldData().field_id] = true
    end
    self:clearCropData(v)
  end
end

function this:syncFieldData(data, updateMaps)
  for k, v in pairs(data) do
    local blockId = v.block_id
    self.data.fieldDataDic[blockId] = self.data.fieldDataDic[blockId] or {}
    local blockData = self.data.fieldDataDic[blockId]
    local id = v.field_id
    updateMaps[id] = true
    self:doUpdateRange(id, updateMaps)
    local fieldData = blockData[id]
    if not fieldData then
      blockData[id] = require(L_R.store .. "homeCrop.data.homeCropFieldData").new()
      fieldData = blockData[id]
    end
    fieldData:populate(v)
    if v.status ~= L_Const.WorldMapFieldStatusType.WMFST_CROP then
      fieldData:setCropId(0)
    end
  end
end

function this:syncCropData(data, updateMaps)
  for k, v in pairs(data) do
    local guid = v.guid
    self.data.cropDatas[guid] = self.data.cropDatas[guid] or require(L_R.store .. "homeCrop.data.homeCropData").new()
    self.data.cropDatas[guid]:populate(v)
    local blockData = self.data.fieldDataDic[v.block_id] or {}
    local ids = v.field_ids
    for _, fieldId in pairs(ids) do
      updateMaps[fieldId] = true
      local fieldData = blockData[fieldId]
      if not fieldData then
        errorf("未找到对应的field数据！blockId为" .. v.block_id .. "，fieldId为" .. fieldId)
        return
      end
      fieldData:setCropId(guid)
    end
  end
end

function this:clearCropData(guid)
  local crop = self.data.cropDatas[guid]
  if not crop then
    error("后端要求删除作物" .. guid .. "不存在")
    return
  end
  local blockId = crop.block_id
  local fieldIds = crop.field_ids
  for k, v in pairs(fieldIds) do
    local fieldData = self:getFieldData(blockId, v)
    fieldData:setCropId(0)
  end
  self.data.cropDatas[guid] = nil
end

return this
