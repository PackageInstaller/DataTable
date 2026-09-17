local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    dataDict = {},
    selectIndex = this.initIndex or 1,
    selectType = L_Const.quickRouletteType.normal,
    dataDic = {}
  }
end

function this:getDataList(type)
  type = type or self.data.selectType
  if not self.data.dataDict[type] then
    self.data.dataDict[type] = {}
  end
  return self.data.dataDict[type]
end

function this:getRouletteData(index, type)
  type = type or self.data.selectType
  local dataList = self:getDataList(type)
  return dataList[index]
end

function this:getGuidByIndex(index, type)
  type = type or self.data.selectType
  local data = self:getRouletteData(index, type)
  return data and data.guid
end

function this:getCurSelectGuid()
  return self:getGuidByIndex(self.data.selectIndex)
end

function this:getCurSelectIndex()
  return self.data.selectIndex
end

function this:getItemCfgList(rouletteType, rouletteTab)
  local _commonItemTpl = L_GameTpl:getCommonItemTpl()
  local tabDict = _commonItemTpl.rouletteTypeGroupData[rouletteType]
  return tabDict and tabDict[rouletteTab] or table.empty
end

function this:getRouletteInfoByType(type)
  if type == L_Const.quickRouletteType.petPuzzle then
    if not self.data.dataDic[type] then
      local guidList = {}
      for i = 1, 9 do
        table.insert(guidList, 0)
      end
      self:setRouletteInfoByType(type, guidList)
    end
    return self.data.dataDic[type]
  end
end

function this:setRouletteInfoByType(type, data)
  self.data.dataDic[type] = data
end

function this:checkInRoulette(type, id)
  if type == L_Const.quickRouletteType.petPuzzle then
    local data = self:getRouletteInfoByType(type)
    for i = 1, 9 do
      if data[i] == id then
        return i
      end
    end
    return -1
  end
  return -1
end

return this
