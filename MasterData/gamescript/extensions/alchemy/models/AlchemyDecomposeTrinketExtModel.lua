local Trinket_Decompose_Params = DT.Constant.TrinketDecomposeParams.Data[1]
local AlchemyDecomposeTrinketExtModel = NewClass("AlchemyDecomposeTrinketExtModel", AlchemyDecomposeBaseExtModel)

function AlchemyDecomposeTrinketExtModel:OnInit()
  self:OnInitViewData()
  self:Init_decompositeItemList()
end

local decompositeCheckCfgGroup = AlchemyDataUtils.PreParseDecompositeConversion()

function AlchemyDecomposeTrinketExtModel:Init_decompositeItemList()
  if 0 ~= #self.decompositeItemList then
    return
  end
  local returnList = {}
  local trinketBagItems = self:FilterBagItemData(CommonDefine.ItemType.Trinket)
  for _, cfgData in pairs(decompositeCheckCfgGroup) do
    local itemTid = cfgData.itemTid
    if cfgData.itemType == CommonDefine.ItemType.Trinket then
      for _, v in pairs(trinketBagItems) do
        if not ItemDataUtils.GetItemByUid(v.uid) then
        elseif not AwakerTrinketDataUtils.IsTrinketVisibleInList(v.uid) then
        elseif v.tid == itemTid then
          local decompositeData = {
            itemTid = v.tid,
            itemNum = cfgData.itemNum,
            itemUid = v.uid,
            uid = v.uid,
            costItemTids = cfgData.consumeItemTids,
            costItemNum = cfgData.consumeItemNum,
            convertItemTids = cfgData.convertItemTids,
            convertItemNum = cfgData.convertItemNum,
            conversionId = cfgData.ID,
            locked = v.locked,
            level = v.level,
            sort = cfgData.Sort
          }
          table.insert(returnList, decompositeData)
        end
      end
    end
  end
  self.decompositeItemList = returnList
end

function AlchemyDecomposeTrinketExtModel:Update_curDecompositeList()
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
    if not decompositeItemData then
    else
      local itemTid = decompositeItemData.itemTid
      local itemCfg = DT.Item[itemTid]
      if itemCfg and itemCfg.Type == CommonDefine.ItemType.Trinket and decompositeItemData and decompositeItemData.convertItemTids then
        for i = 1, #decompositeItemData.convertItemTids do
          local tid = decompositeItemData.convertItemTids[i]
          local num = decompositeItemData.convertItemNum[i]
          local tmpUid = uid
          if tmpUid and 0 ~= tmpUid then
            local level = ItemDataUtils.GetTrinketLevel(tmpUid) or 0
            local costMat = AwakerTrinketDataUtils.GetTrinketUpgradeItemCost(0, level)
            local extraNum = math.floor(costMat.num * Trinket_Decompose_Params)
            if costMat.tid == tid then
              num = num + extraNum
            else
              local alchemyItemData = {
                tid = costMat.tid,
                num = extraNum
              }
              AddToTempMap(alchemyItemData)
            end
          end
          local alchemyItemData = {tid = tid, num = num}
          AddToTempMap(alchemyItemData)
        end
      end
    end
  end
  for _, itemData in pairs(tmpMap) do
    table.insert(returnList, itemData)
  end
  self:Set_curDecompositeList(returnList)
end

function AlchemyDecomposeTrinketExtModel:SetTrinketSortOrder(order)
  if not order or self.trinketSortOrder == order then
    return
  end
  self.trinketSortOrder = order
end

function AlchemyDecomposeTrinketExtModel:Update_oriLit()
  local tempList = {}
  if not self.decompositeItemList or not table.next(self.decompositeItemList) then
    self.oriLit = tempList
    return
  end
  for _, data in pairs(self.decompositeItemList) do
    local itemCfg = DT.Item[data.itemTid]
    if itemCfg.Type == CommonDefine.ItemType.Trinket then
      local trinketItem = ItemDataUtils.GetItemByUid(data.itemUid)
      local pos = ItemDataUtils.GetTrinketPosIndex(trinketItem)
      local mainAttr = AwakerTrinketDataUtils.GetMainAttr(trinketItem.uid)
      local subAttrs = AwakerTrinketDataUtils.GetSubAttrs(trinketItem.uid)
      local isSuitFilter = self:IsSuitFilter(trinketItem.suitId)
      local isPartFilter = self:IsPartFilter(pos)
      local isMainAttrFilter = self:IsMainAttrFilter(mainAttr.attrId)
      local isSubAttrFilter = self:IsSubAttrsFilter(subAttrs)
      if not (isSubAttrFilter and isSuitFilter and isPartFilter) or not isMainAttrFilter then
      else
        table.insert(tempList, data)
      end
    end
  end
  AwakerTrinketDataUtils.Sort(tempList, self.trinketSortType, self.trinketSortOrder)
  self:LocalNotify(NotifyId.OnTrinketSortOrderChanged)
  self.oriLit = tempList
end

return AlchemyDecomposeTrinketExtModel
