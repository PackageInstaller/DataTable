local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    itemDic = {}
  }
end

function this:getAllItem()
  return self.data.itemDic
end

function this:getAllCollectedItemIdByGroup(id)
  local res = {}
  local libraryBranchTpl = L_GameTpl:getLibraryBranchTpl()
  local tempBranchTpl = libraryBranchTpl.getTplById(id)
  for k, v in pairs(self.data.itemDic) do
    local isContain = false
    for k2, v2 in pairs(tempBranchTpl.seriesId) do
      if v2 == v.itemId then
        isContain = true
        break
      end
    end
    if isContain then
      table.insert(res, v.itemId)
    end
  end
end

function this:isLibraryBookCollect(id)
  for k, v in pairs(self.data.itemDic) do
    if v.itemId == id then
      return true
    end
  end
  return false
end

function this:isLbiraryBookUnReaded(id)
  for k, v in pairs(self.data.itemDic) do
    if v.itemId == id then
      return v.isNew == nil or v.isNew == 0
    end
  end
  return false
end

function this:getDataById(id)
  for k, v in pairs(self.data.itemDic) do
    if v.itemId == id then
      return v
    end
  end
  return nil
end

function this:getCollectProcess(id)
  local _librarySeriesTpl = L_GameTpl:getLibrarySeriesTpl()
  local curLibrarySeriesTpl = _librarySeriesTpl:getTplById(id)
  local totalNum = #curLibrarySeriesTpl.subId
  local collectedNum = 0
  for k2, v2 in pairs(curLibrarySeriesTpl.subId) do
    for k3, v3 in pairs(self.data.itemDic) do
      if v2 == v3.itemId then
        collectedNum = collectedNum + 1
        break
      end
    end
  end
  if totalNum == collectedNum then
    return L_SortFilterConst.FilterId.collected
  elseif collectedNum ~= nil and collectedNum ~= 0 then
    return L_SortFilterConst.FilterId.collecting
  end
  return L_SortFilterConst.FilterId.unCollect
end

function this:getTotalCollectProcess()
  local collectedNum = 0
  local tempCollectedBooks = {}
  for _, bookItem in pairs(L_LibraryBookStore.data.itemDic) do
    tempCollectedBooks[bookItem.itemId] = true
  end
  local libraryBranchTpl = L_GameTpl:getLibraryBranchTpl()
  local subTypeList = libraryBranchTpl:getBranchIdList()
  local totalNum = 0
  local librarySeriesTpl = L_GameTpl:getLibrarySeriesTpl()
  for _, subTypeId in ipairs(subTypeList) do
    local subTypeTpl = libraryBranchTpl:getTplById(subTypeId)
    local subTypeSeriesId = libraryBranchTpl:getSeriesId(subTypeTpl)
    for _, seriesId in ipairs(subTypeSeriesId) do
      local subIds = librarySeriesTpl:getSubId(seriesId)
      totalNum = totalNum + #subIds
      for _, subId in ipairs(subIds) do
        if tempCollectedBooks[subId] then
          collectedNum = collectedNum + 1
        end
      end
    end
  end
  return collectedNum, totalNum
end

return this
