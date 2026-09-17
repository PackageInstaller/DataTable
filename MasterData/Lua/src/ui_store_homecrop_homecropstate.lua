local this = {}
local _homeSeedTpl = L_GameTpl:getHomeSeedsTpl()

function this:init()
  this.super.init(self)
  self.data = {
    fieldDataDic = {},
    cropDatas = {},
    blockCropAutoDatas = {}
  }
end

function this:getBlockAutoCropData(blockId)
  return self.data.blockCropAutoDatas[blockId] or require(L_R.store .. "homeCrop.data.homeBlockCropAutoData").new(blockId)
end

function this:getAllAutoData()
  return self.data.blockCropAutoDatas
end

function this:getFieldData(blockId, id)
  local blockData = self.data.fieldDataDic[blockId]
  return blockData and blockData[id]
end

function this:getCropData(guid)
  return self.data.cropDatas[guid]
end

function this:getAllFieldData()
  return self.data.fieldDataDic
end

return this
