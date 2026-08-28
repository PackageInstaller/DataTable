local DataModel = {}

function DataModel.init(itemId)
  local data = PlayerData:GetFactoryData(itemId) or {}
  local exchangeList = data.exchangeList or {}
  DataModel.itemPosList = {}
  DataModel.height = 0
  DataModel.itemList = {}
  DataModel.allWeight = 0
  for i, v in ipairs(exchangeList) do
    local data = v
    data.quality = PlayerData:GetFactoryData(v.itemId).qualityInt or 1
    data.idx = i
    table.insert(DataModel.itemList, v)
    DataModel.allWeight = DataModel.allWeight + data.weight
  end
  if not next(DataModel.itemList) then
    return
  end
  table.sort(DataModel.itemList, function(t1, t2)
    if t1.quality == t2.quality then
      if t1.weight == t2.weight then
        return t1.idx < t2.idx
      else
        return t1.weight < t2.weight
      end
    end
    return t1.quality > t2.quality
  end)
  DataModel.CreateItemPosData()
end

local function CalculatePercentage(weight)
  if DataModel.allWeight == 0 then
    return "0.0000%"
  end
  local percentage = weight / DataModel.allWeight * 100
  local value = tonumber(string.format("%.4f", percentage))
  return value .. "%"
end

function DataModel.CreateItemPosData()
  local itemHeight1 = 250
  local itemHeight2 = 170
  local staticCount = 8
  local nowQuality = -1
  local staticListIdx = 1
  local ItemPosIdx = 0
  for i, v in ipairs(DataModel.itemList) do
    if nowQuality == v.quality then
      staticListIdx = (staticListIdx + 1) % staticCount
      staticListIdx = staticListIdx == 0 and staticCount or staticListIdx
      if staticListIdx == 1 then
        ItemPosIdx = ItemPosIdx + 1
        local data = {
          pos = itemHeight2,
          isFirst = false,
          id = ItemPosIdx
        }
        data.pos = DataModel.itemPosList[ItemPosIdx - 1].pos - itemHeight2
        data.list = {}
        local probability = CalculatePercentage(v.weight)
        data.list[staticListIdx] = {
          itemId = v.itemId,
          probability = probability,
          num = v.num
        }
        table.insert(DataModel.itemPosList, data)
        DataModel.height = DataModel.height + itemHeight2
      else
        local probability = CalculatePercentage(v.weight)
        DataModel.itemPosList[ItemPosIdx].list[staticListIdx] = {
          itemId = v.itemId,
          probability = probability,
          num = v.num
        }
      end
    else
      staticListIdx = 1
      ItemPosIdx = ItemPosIdx + 1
      local data = {
        pos = 0,
        isFirst = true,
        quality = v.quality,
        id = ItemPosIdx
      }
      data.list = {}
      local probability = CalculatePercentage(v.weight)
      data.list[staticListIdx] = {
        itemId = v.itemId,
        probability = probability,
        num = v.num
      }
      data.pos = ItemPosIdx == 1 and 0 or DataModel.itemPosList[ItemPosIdx - 1].pos - itemHeight1
      table.insert(DataModel.itemPosList, data)
      DataModel.height = DataModel.height + itemHeight1
    end
    nowQuality = v.quality
  end
  if 0 < ItemPosIdx then
    DataModel.height = -DataModel.itemPosList[ItemPosIdx].pos + itemHeight1
  end
end

return DataModel
