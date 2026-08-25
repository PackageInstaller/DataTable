local LIMIT_NUM = DT.GetConstant("MaximumQuantityLimitForDecomposition")
local AlchemyDecomposeBaseExtModel = NewClass("AlchemyDecomposeBaseExtModel", BagItemsFilterModel)

function AlchemyDecomposeBaseExtModel:OnInit()
end

function AlchemyDecomposeBaseExtModel:OnInitViewData()
  self:OnReset()
  self.curSelectUid = 0
  self.decompositeItemList = {}
  self.curSelectItemUidGroup = {}
  self.decomposedItemUidGroup = {}
  self.isSelectAll = false
  self.oriLit = {}
  self.curDecompositeList = {}
  self:UpdateData()
end

function AlchemyDecomposeBaseExtModel:UpdateData()
  self:Update_decompositeItemList()
  self:Update_oriLit()
  self:Update_curDecompositeList()
end

function AlchemyDecomposeBaseExtModel:Set_curSelectUid(numVal, withoutNotify)
  self.curSelectUid = numVal
  if not withoutNotify then
    self:LocalNotify(NotifyId.OnAlchemyDecomposeSelectChanged, numVal)
  end
end

function AlchemyDecomposeBaseExtModel:Get_curSelectUid()
  return self.curSelectUid
end

function AlchemyDecomposeBaseExtModel:Update_decompositeItemList()
  if not table.next(self.decompositeItemList) then
    self:Init_decompositeItemList()
    return
  end
  local removeNum = 0
  local returnList = self.decompositeItemList
  for i = #returnList, 1, -1 do
    if table.contains(self.decomposedItemUidGroup, returnList[i].itemUid) then
      removeNum = removeNum + 1
      table.remove(returnList, i)
    end
  end
  self:SetDecomposedItemUidGroup({})
  self.decompositeItemList = returnList
end

function AlchemyDecomposeBaseExtModel:Set_curDecompositeList(tbl)
  for i = #tbl, 1, -1 do
    local decompositeData = tbl[i]
    if 0 == decompositeData.num then
      table.remove(tbl, i)
    end
  end
  self.curDecompositeList = tbl
end

function AlchemyDecomposeBaseExtModel:GetSuits()
  local suits = {}
  local suitNumMap = ItemDataUtils.GetTrinketSuitNumMap()
  for suitId, _ in pairs(suitNumMap) do
    if 0 == suitId then
    elseif ItemDataUtils.TrinketShowTimeMatch(suitId) then
      table.insert(suits, suitId)
    end
  end
  table.sort(suits, function(a, b)
    return a < b
  end)
  return suits
end

function AlchemyDecomposeBaseExtModel:GetDecompositeDataByUid(uid)
  for _, data in pairs(self.decompositeItemList) do
    if uid == data.itemUid then
      return data
    end
  end
end

function AlchemyDecomposeBaseExtModel:IsItemLocked(uid)
  do return ItemDataUtils.GetItemLocked end
  return ItemDataUtils.GetItemLocked, uid
end

function AlchemyDecomposeBaseExtModel:IsTrinketUsing(uid)
  do return AwakerTrinketExtModel.Instance.IsTrinketUsing, AwakerTrinketExtModel.Instance end
  return AwakerTrinketExtModel.Instance.IsTrinketUsing, AwakerTrinketExtModel.Instance, uid
end

function AlchemyDecomposeBaseExtModel:SetIsSelectAll(boolVal)
  self.isSelectAll = boolVal
  self:LocalNotify(NotifyId.OnAlchemyDecomposeToggleAllChanged, boolVal)
end

function AlchemyDecomposeBaseExtModel:AddItem(uid)
  if not uid then
    return
  end
  if #self.curSelectItemUidGroup >= LIMIT_NUM then
    Alert.ShowStr(LT.Text("AlchemyDecomposeSelectLimitTips"))
    return
  end
  table.insert(self.curSelectItemUidGroup, uid)
  if #self.curSelectItemUidGroup >= LIMIT_NUM then
    self:SetIsSelectAll(true)
  end
end

function AlchemyDecomposeBaseExtModel:RemoveItem(uid)
  if not uid then
    return
  end
  for idx, val in pairs(self.curSelectItemUidGroup) do
    if val == uid then
      table.remove(self.curSelectItemUidGroup, idx)
      break
    end
  end
end

function AlchemyDecomposeBaseExtModel:UpdateCurSelectItemUidGroup(uid)
  for idx, val in pairs(self.curSelectItemUidGroup) do
    if val == uid and self:IsItemLocked(uid) then
      table.remove(self.curSelectItemUidGroup, idx)
      break
    end
  end
end

function AlchemyDecomposeBaseExtModel:SetCurSelectItemUidGroup(group)
  if not group then
    return
  end
  self.curSelectItemUidGroup = group
end

function AlchemyDecomposeBaseExtModel:SetDecomposedItemUidGroup(group)
  if not group then
    return
  end
  self.decomposedItemUidGroup = group
end

function AlchemyDecomposeBaseExtModel:FilterBagItemData(itemType)
  local rst = {}
  for _, item in pairs(DataCenter.itemData.BagItemData) do
    local tid = item.tid
    if DT.Item[tid].Type == itemType then
      table.insert(rst, item)
    end
  end
  return rst
end

return AlchemyDecomposeBaseExtModel
