local this = class("quickRouletteStore", G_BaseStore)
this:importPartialClass(require(L_R.store .. "quickRoulette.quickRouletteState"))
this:importPartialClass(require(L_R.store .. "quickRoulette.quickRouletteAction"))
this.event = {
  curSelectChange = "curSelectChange",
  rouletteDataUpdate = "rouletteDataUpdate",
  refreshPetPuzzleRouletteInfo = "refreshPetPuzzleRouletteInfo"
}
this.maxCount = 8
this.initIndex = 1

function this:ctor()
  this.super.ctor(self)
end

function this:setCurSelectType(type)
  self.data.selectType = type
end

function this:changeSelect(type, index)
  local isChange = index and self.data.selectIndex ~= index
  self.data.selectType = type or self.data.selectType
  self.data.selectIndex = index or self.data.selectIndex
  if isChange then
    self:call(self.event.curSelectChange)
    self:reqSaveRouletteInfo(self.data.selectType)
  end
end

function this:checkIsEmpty(index, type)
  index = index or self.data.selectIndex
  local guid = self:getGuidByIndex(index, type)
  return not guid or guid <= 0
end

function this:getIndexByGuid(guid, type)
  type = type or self.data.selectType
  local dataList = self:getDataList(type)
  for _, data in pairs(dataList or table.empty) do
    if data.guid == guid then
      return data.index
    end
  end
end

function this:setRouletteData(index, guid, type)
  type = type or self.data.selectType
  local data = self:getRouletteData(index, type)
  if guid and data and C_BagMgr:getItemNumByItemId(guid) <= 0 then
    data.guid = nil
    self:call(self.event.rouletteDataUpdate)
    if self.data.selectType == type and self.data.selectIndex == index then
      self:call(self.event.curSelectChange)
    end
    return
  end
  local isChange
  local oldIndex = self:getIndexByGuid(guid, type)
  local isSwitch = oldIndex and 0 < oldIndex and oldIndex ~= index
  if table.isEmpty(data) then
    data = {
      guid = guid,
      index = index,
      type = type
    }
    local dataList = self:getDataList(type)
    dataList[index] = data
    isChange = true
  elseif data.guid ~= guid then
    data.guid = guid
    isChange = true
  end
  if isSwitch then
    local list = self:getDataList(type)
    list[oldIndex] = nil
  end
  if isChange then
    if self.data.selectType == type and (self.data.selectIndex == index or oldIndex and self.data.selectIndex == oldIndex) then
      self:call(self.event.curSelectChange)
    end
    self:call(self.event.rouletteDataUpdate)
  end
end

function this:refreshRouletteData()
  local isChange
  local dataList = self:getDataList(self.data.selectType)
  for i = 1, self.maxCount do
    local data = dataList[i]
    if data and not self:checkIsEmpty(data.index, data.type) then
      local num = C_BagMgr:getItemNumByItemId(data.guid)
      if num <= 0 then
        if self.data.selectIndex == data.index then
          self.data.selectIndex = this.initIndex
        end
        data.guid = nil
        isChange = true
      end
    end
  end
  if isChange then
    self:reqSaveRouletteInfo(self.data.selectType)
  end
end

return this
