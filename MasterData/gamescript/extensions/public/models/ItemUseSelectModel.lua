local ItemUseSelectModel = NewClass("ItemUseSelectModel", BaseModel)

function ItemUseSelectModel:OnInit()
  self:OnReset()
end

function ItemUseSelectModel:OnReset()
  self._itemId = 0
  self._useNum = 0
  self._curSelectTid = 0
  self._curSelectNum = 0
  self._dropList = nil
end

function ItemUseSelectModel:SetItemId(itemId)
  self._itemId = itemId
  self._dropList = nil
end

function ItemUseSelectModel:GetItemId()
  return self._itemId
end

function ItemUseSelectModel:SetUseNum(num)
  self._useNum = num
end

function ItemUseSelectModel:GetUseNum()
  return self._useNum
end

function ItemUseSelectModel:SetCurSelectTid(tid)
  if not tid then
    Logger.Error("ItemUseSelectModel: SetCurSelectTid parameter is nil")
    return
  end
  self._curSelectTid = tid
end

function ItemUseSelectModel:GetCurSelectTid()
  return self._curSelectTid
end

function ItemUseSelectModel:SetCurSelectNum(num)
  if not num then
    Logger.Error("ItemUseSelectModel: SetCurSelectNum parameter is nil")
    return
  end
  self._curSelectNum = num
end

function ItemUseSelectModel:GetCurSelectNum()
  return self._curSelectNum
end

function ItemUseSelectModel:IsNotSelect()
  return 0 == self._curSelectTid
end

function ItemUseSelectModel:GetDropList()
  if self._dropList then
    return self._dropList
  end
  local rst = {}
  local itemCfg = DT.Item[self._itemId]
  if not itemCfg then
    self._dropList = rst
    return rst
  end
  local dropCfg = DT.Drop[itemCfg.SpParam[1]]
  if not dropCfg then
    self._dropList = rst
    return rst
  end
  for _, data in pairs(dropCfg.data_list) do
    table.insert(rst, {
      tid = data.DropItem,
      num = data.DropNum or 0
    })
  end
  table.sort(rst, function(a, b)
    local aSort = DT.Item[a.tid].BaseSortID
    local bSort = DT.Item[b.tid].BaseSortID
    return aSort < bSort
  end)
  self._dropList = rst
  return rst
end

return ItemUseSelectModel
