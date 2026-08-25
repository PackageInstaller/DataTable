local TrinketSortingModel = NewClass("TrinketSortingModel", BaseModel)
local ItemType = CommonDefine.ItemType

function TrinketSortingModel:OnInit()
  self:RegisterNotify(NotifyId.OnTrinketUpdategraded, self._OnTrinketUpdategraded, self)
  self:RegisterNotify(NotifyId.OnTrinketConversioned, self._OnTrinketConversioned, self)
end

function TrinketSortingModel:OnReset()
  self._trinketSortParams = nil
  self._showAttrIds = nil
  self._trinketsList = nil
  self._invalidItems = nil
  self._calTrinketIndex = 0
  self._isCalculating = false
  LateUpdateBeat.Instance:Remove(self._DoCalSortingParams, self)
end

function TrinketSortingModel:StartCalSortingParams()
  if self._isCalculating then
    return
  end
  if self._trinketsList and #self._trinketsList + 1 == self._calTrinketIndex then
    return
  end
  self._isCalculating = true
  self._showAttrIds = self._showAttrIds or AwakerDataUtils.GetSortedAttrIds(CommonDefine.AttrShowType.TrinketShow)
  LateUpdateBeat.Instance:Add(self._DoCalSortingParams, self)
  self._trinketSortParams = {}
  local list = {}
  local itemBagData = DataCenter.itemData.BagItemData
  for _, v in pairs(itemBagData) do
    local config = DT.Item[v.tid]
    if config.Type == ItemType.Trinket then
      table.insert(list, v)
    end
  end
  self._trinketsList = list
  self._calTrinketIndex = 1
end

function TrinketSortingModel:CalSortingParam(item)
  self._trinketSortParams = self._trinketSortParams or {}
  self._showAttrIds = self._showAttrIds or AwakerDataUtils.GetSortedAttrIds(CommonDefine.AttrShowType.TrinketShow)
  local suitId = item.suitId or 0
  local mainAttr = AwakerTrinketDataUtils.GetMainAttr(item.uid)
  local params = {}
  params.isTrinketUsing = AwakerTrinketExtModel.Instance:IsTrinketUsing(item.uid)
  params.level = item.level == nil and 999 or item.level
  params.suitOrder = DT.TrinketSuitEffect[suitId] and DT.TrinketSuitEffect[suitId].BaseSortID or 0
  params.part = ItemDataUtils.GetTrinketPosIndex(item) or 0
  params.mainAttrId = mainAttr and mainAttr.attrId or math.huge
  params.attrs = params.attrs or {}
  for _, attrId in ipairs(self._showAttrIds) do
    params.attrs[attrId] = AwakerTrinketDataUtils.GetTrinketAttrValue(item, attrId)
  end
  self._trinketSortParams[item] = params
  return params
end

function TrinketSortingModel:ResetSortingParam(item)
  if self._trinketSortParams and item then
    self._trinketSortParams[item] = nil
  end
end

function TrinketSortingModel:TryCalSortingParam(item)
  local params = self._trinketSortParams and self._trinketSortParams[item] or nil
  if params then
    return params
  end
  do return self.CalSortingParam, self end
  return self.CalSortingParam, self, item
end

function TrinketSortingModel:PushToCalSortingParam(item)
  if self._trinketSortParams and self._trinketSortParams[item] then
    return
  end
  self._trinketsList = self._trinketsList or {}
  table.insert(self._trinketsList, item)
  if not self._isCalculating then
    self._isCalculating = true
    if 0 == self._calTrinketIndex then
      self._calTrinketIndex = 1
    end
    LateUpdateBeat.Instance:Add(self._DoCalSortingParams, self)
  end
end

function TrinketSortingModel:_DoCalSortingParams()
  for i = 0, 9 do
    local item = self._trinketsList and self._trinketsList[self._calTrinketIndex] or nil
    if not item then
      self._isCalculating = false
      LateUpdateBeat.Instance:Remove(self._DoCalSortingParams, self)
      return
    end
    self._calTrinketIndex = self._calTrinketIndex + 1
    if not self._invalidItems or not self._invalidItems[item] then
      self:TryCalSortingParam(item)
    end
  end
end

function TrinketSortingModel:RemoveCalSortingParam(item)
  self._invalidItems = self._invalidItems or {}
  self._invalidItems[item] = true
end

function TrinketSortingModel:_OnTrinketUpdategraded(targetUid)
  local item = ItemDataUtils.GetItemByUid(targetUid)
  if item then
    self:CalSortingParam(item)
  end
end

function TrinketSortingModel:_OnTrinketConversioned(targetUid)
  local item = ItemDataUtils.GetItemByUid(targetUid)
  if item then
    self:CalSortingParam(item)
  end
end

return TrinketSortingModel
