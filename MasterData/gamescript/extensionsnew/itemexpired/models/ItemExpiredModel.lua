local ItemExpiredModel = NewClass("ItemExpiredModel", BaseModel)

function ItemExpiredModel:OnInit()
  self:OnReset()
end

function ItemExpiredModel:OnReset()
  self._itemList = nil
  self._convertItemList = nil
end

function ItemExpiredModel:SetItemList(itemList)
  local list = itemList
  if not list or 0 == #list then
    list = ItemDataUtils.GetExpiredItems()
  end
  self._itemList = list
  self._convertItemList = self:_GetConvertItemList(list)
end

function ItemExpiredModel:_GetConvertItemList(itemList)
  local convertItemList = {}
  for _, item in ipairs(itemList) do
    local itemCfg = ItemDataUtils.GetItemConfig(item.tid)
    if itemCfg and itemCfg.TransItem then
      for itemTid, itemCount in table.iteraDouble(itemCfg.TransItem) do
        table.insert(convertItemList, {
          tid = itemTid,
          num = itemCount * item.num
        })
      end
    end
  end
  return convertItemList
end

function ItemExpiredModel:GetItemList()
  return self._itemList
end

function ItemExpiredModel:GetConvertItemList()
  return self._convertItemList
end

function ItemExpiredModel:IsShowConvert()
  return self._convertItemList and #self._convertItemList > 0
end

return ItemExpiredModel
