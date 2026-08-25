local AlchemyDecomposeWeaponExtModel = NewClass("AlchemyDecomposeWeaponExtModel", AlchemyDecomposeBaseExtModel)

function AlchemyDecomposeWeaponExtModel:OnInit()
  self:OnInitViewData()
  self:Init_decompositeItemList()
end

local decompositeCheckCfgGroup = AlchemyDataUtils.PreParseDecompositeConversion()

function AlchemyDecomposeWeaponExtModel:Init_decompositeItemList()
  if 0 ~= #self.decompositeItemList then
    return
  end
  local returnList = {}
  local trinketBagItems = ItemDataUtils.GetRedundantWeaponList()
  for _, cfgData in pairs(decompositeCheckCfgGroup) do
    local itemType = cfgData.itemType
    local itemTid = cfgData.itemTid
    if itemType == CommonDefine.ItemType.Weapon then
      for _, v in pairs(trinketBagItems) do
        if v.awaker and v.awaker > 0 then
        elseif v.tid == itemTid then
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
    end
  end
  local isWeaponUsingMap = {}
  table.sort(returnList, function(a, b)
    local aItemUid = a.itemUid
    local bItemUid = b.itemUid
    local isWeaponUsingA = isWeaponUsingMap[aItemUid]
    local isWeaponUsingB = isWeaponUsingMap[bItemUid]
    if nil == isWeaponUsingA then
      isWeaponUsingA = AwakerWeaponExtModel.Instance:IsWeaponUsing(aItemUid)
      isWeaponUsingMap[aItemUid] = isWeaponUsingA or false
    end
    if nil == isWeaponUsingB then
      isWeaponUsingB = AwakerWeaponExtModel.Instance:IsWeaponUsing(bItemUid)
      isWeaponUsingMap[bItemUid] = isWeaponUsingB or false
    end
    if isWeaponUsingA ~= isWeaponUsingB then
      return not isWeaponUsingA
    end
    local aItemData = ItemDataUtils.GetItemByUid(aItemUid)
    local bItemData = ItemDataUtils.GetItemByUid(bItemUid)
    local aLocked = aItemUid and (aItemData.locked and 1 or 0) or 0
    local bLocked = bItemUid and (bItemData.locked and 1 or 0) or 0
    if aLocked ~= bLocked then
      return aLocked < bLocked
    end
    local aSortId = DT.ItemConversion[a.conversionId].Sort
    local bSortId = DT.ItemConversion[b.conversionId].Sort
    if aSortId == bSortId then
      local aLevel = ItemDataUtils.GetWeaponLevel(aItemUid)
      local bLevel = ItemDataUtils.GetWeaponLevel(bItemUid)
      return aLevel < bLevel
    end
    return aSortId < bSortId
  end)
  self.decompositeItemList = returnList
end

function AlchemyDecomposeWeaponExtModel:Update_curDecompositeList()
  local returnList = {}
  if 0 == #self.curSelectItemUidGroup then
    self:Set_curDecompositeList(returnList)
    return
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
  
  for _, uid in pairs(self.curSelectItemUidGroup) do
    local decompositeItemData = self:GetDecompositeDataByUid(uid)
    local itemTid = decompositeItemData.itemTid
    local itemCfg = DT.Item[itemTid]
    if itemCfg.Type == CommonDefine.ItemType.Weapon and decompositeItemData and decompositeItemData.convertItemTids then
      for i = 1, #decompositeItemData.convertItemTids do
        local tid = decompositeItemData.convertItemTids[i]
        local num = decompositeItemData.convertItemNum[i]
        local tmpUid = uid
        if tmpUid and 0 ~= tmpUid then
          local level = ItemDataUtils.GetWeaponLevel(tmpUid)
          level = level + 1
          num = num * level
        end
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

function AlchemyDecomposeWeaponExtModel:Update_oriLit()
  local tempList = {}
  if not self.decompositeItemList or not table.next(self.decompositeItemList) then
    self.oriLit = tempList
    return
  end
  for _, data in pairs(self.decompositeItemList) do
    table.insert(tempList, data)
  end
  self.oriLit = tempList
end

return AlchemyDecomposeWeaponExtModel
