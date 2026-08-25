local AlchemyDecomposeItemExtModel = NewClass("AlchemyDecomposeItemExtModel", AlchemyDecomposeBaseExtModel)

function AlchemyDecomposeItemExtModel:OnInit()
  self:OnInitViewData()
  self:Init_decompositeItemList()
end

local decompositeCheckCfgGroup = AlchemyDataUtils.PreParseDecompositeConversion()

local function FilterBagItemDataNonGear()
  local rst = {}
  for _, item in pairs(DataCenter.itemData.BagItemData) do
    local tid = item.tid
    if tid and DT.Item[tid] then
      local itemType = DT.Item[tid].Type
      if itemType ~= CommonDefine.ItemType.Weapon and itemType ~= CommonDefine.ItemType.Trinket then
        table.insert(rst, item)
      end
    end
  end
  return rst
end

function AlchemyDecomposeItemExtModel:Init_decompositeItemList()
  if 0 ~= #self.decompositeItemList then
    return
  end
  local returnList = {}
  local bagItems = FilterBagItemDataNonGear()
  for _, cfgData in pairs(decompositeCheckCfgGroup) do
    local itemType = cfgData.itemType
    local itemTid = cfgData.itemTid
    if itemType ~= CommonDefine.ItemType.Weapon and itemType ~= CommonDefine.ItemType.Trinket then
      local foundInBag = false
      for _, v in pairs(bagItems) do
        if v.tid == itemTid then
          foundInBag = true
          local decompositeData = {
            itemTid = v.tid,
            itemNum = cfgData.itemNum,
            itemUid = v.uid,
            costItemTids = cfgData.consumeItemTids,
            costItemNum = cfgData.consumeItemNum,
            convertItemTids = cfgData.convertItemTids,
            convertItemNum = cfgData.convertItemNum,
            conversionId = cfgData.ID
          }
          table.insert(returnList, decompositeData)
        end
      end
      if not foundInBag then
        local decompositeData = {
          itemTid = itemTid,
          itemNum = cfgData.itemNum,
          itemUid = 0,
          costItemTids = cfgData.consumeItemTids,
          costItemNum = cfgData.consumeItemNum,
          convertItemTids = cfgData.convertItemTids,
          convertItemNum = cfgData.convertItemNum,
          conversionId = cfgData.ID
        }
        table.insert(returnList, decompositeData)
      end
    end
  end
  table.sort(returnList, function(a, b)
    local aCfg = DT.Item[a.itemTid]
    local bCfg = DT.Item[b.itemTid]
    local aQualityWeight = CommonDefine.QualitySortValueTable[aCfg.Quality]
    local bQualityWeight = CommonDefine.QualitySortValueTable[bCfg.Quality]
    local aBaseSortId = aCfg.BaseSortID
    local bBaseSortId = bCfg.BaseSortID
    if aQualityWeight ~= bQualityWeight then
      return aQualityWeight > bQualityWeight
    end
    return aBaseSortId < bBaseSortId
  end)
  self.decompositeItemList = returnList
end

function AlchemyDecomposeItemExtModel:GetSelectCountByUid(uid)
  local count = 0
  for _, selectedUid in pairs(self.curSelectItemUidGroup) do
    if selectedUid == uid then
      count = count + 1
    end
  end
  return count
end

function AlchemyDecomposeItemExtModel:AddItem(uid)
  if not uid then
    return
  end
  table.insert(self.curSelectItemUidGroup, uid)
end

function AlchemyDecomposeItemExtModel:UpdateCurSelectItemUidGroup(uid)
  if not uid then
    return
  end
  for i = #self.curSelectItemUidGroup, 1, -1 do
    if self.curSelectItemUidGroup[i] == uid and self:IsItemLocked(uid) then
      table.remove(self.curSelectItemUidGroup, i)
    end
  end
end

function AlchemyDecomposeItemExtModel:Update_curDecompositeList()
  local returnList = {}
  if 0 == #self.curSelectItemUidGroup then
    self:Set_curDecompositeList(returnList)
    return
  end
  local uidCountMap = {}
  for _, uid in pairs(self.curSelectItemUidGroup) do
    uidCountMap[uid] = (uidCountMap[uid] or 0) + 1
  end
  local tmpMap = {}
  
  local function AddToTempMap(alchemyItemData)
    local tid = alchemyItemData.tid
    local num = alchemyItemData.num
    if not tmpMap[tid] then
      tmpMap[tid] = alchemyItemData
    else
      tmpMap[tid].num = tmpMap[tid].num + num
    end
  end
  
  for uid, count in pairs(uidCountMap) do
    local decompositeItemData = self:GetDecompositeDataByUid(uid)
    if decompositeItemData and decompositeItemData.convertItemTids then
      for i = 1, #decompositeItemData.convertItemTids do
        local tid = decompositeItemData.convertItemTids[i]
        local num = decompositeItemData.convertItemNum[i] * count
        local alchemyItemData = {tid = tid, num = num}
        AddToTempMap(alchemyItemData)
      end
    end
  end
  for _, itemData in pairs(tmpMap) do
    table.insert(returnList, itemData)
  end
  table.sort(returnList, function(a, b)
    local aCfg = DT.Item[a.tid]
    local bCfg = DT.Item[b.tid]
    local aQualityWeight = CommonDefine.QualitySortValueTable[aCfg.Quality]
    local bQualityWeight = CommonDefine.QualitySortValueTable[bCfg.Quality]
    local aBaseSortId = aCfg.BaseSortID
    local bBaseSortId = bCfg.BaseSortID
    if aQualityWeight ~= bQualityWeight then
      return aQualityWeight > bQualityWeight
    end
    return aBaseSortId < bBaseSortId
  end)
  self:Set_curDecompositeList(returnList)
end

function AlchemyDecomposeItemExtModel:Update_oriLit()
  local tempList = {}
  if not self.decompositeItemList or not table.next(self.decompositeItemList) then
    self.oriLit = tempList
    return
  end
  for _, data in pairs(self.decompositeItemList) do
    if 0 == data.itemUid or not ItemDataUtils.GetItemByUid(data.itemUid) then
      local itemData = ItemDataUtils.GetItemByTid(data.itemTid)
      data.itemUid = itemData and itemData.uid or 0
    end
    table.insert(tempList, data)
  end
  self.oriLit = tempList
end

return AlchemyDecomposeItemExtModel
