local TrinketListBaseModel, Super = NewClass("TrinketListBaseModel", BagItemsFilterModel)

function TrinketListBaseModel:OnInit()
  self:OnReset()
end

function TrinketListBaseModel:OnReset()
  Super.OnReset(self)
  self.partType = 1
  self.allTrinketsList = nil
  self.curFilterTrinkets = nil
  self.curChoosenTrinketUid = 0
end

function TrinketListBaseModel:ResetByPartType(partType)
  self.allTrinketsList = BagExtModel.Instance:GetAllTrinketDataList()
  self.partType = partType or 1
  self:CalFilterTrinketsList()
end

function TrinketListBaseModel:ReloadAllTrinketsList()
  self.allTrinketsList = BagExtModel.Instance:GetAllTrinketDataList()
end

function TrinketListBaseModel:DeleteTrinketFromTrinketsList(trinketUids)
  if not trinketUids then
    return
  end
  if not self.allTrinketsList and not self.curFilterTrinkets then
    return
  end
  local uidsMap = {}
  local reCalChoosedId = false
  for _, uid in pairs(trinketUids) do
    uidsMap[uid] = true
    if uid == self.curChoosenTrinketUid then
      reCalChoosedId = true
    end
  end
  if self.allTrinketsList then
    for i = #self.allTrinketsList, 1, -1 do
      local uid = self.allTrinketsList[i].uid
      if uidsMap[uid] then
        table.remove(self.allTrinketsList, i)
      end
    end
  end
  if self.curFilterTrinkets then
    for i = #self.curFilterTrinkets, 1, -1 do
      local uid = self.curFilterTrinkets[i].uid
      if uidsMap[uid] then
        table.remove(self.curFilterTrinkets, i)
      end
    end
  end
  if reCalChoosedId then
    self.curChoosenTrinketUid = 0
    self:_PlaceAwakerEquipTrinketToFirstPos()
    self:_CalCurChoosenTrinketUid()
  end
end

function TrinketListBaseModel:GetFilterTrinksList()
  return self.curFilterTrinkets
end

function TrinketListBaseModel:CalFilterTrinketsList()
  self:_CalCurFilterTrinketsList()
  self:_SortCurFilterTrinkets()
  self:_PlaceAwakerEquipTrinketToFirstPos()
  self:_CalCurChoosenTrinketUid()
end

function TrinketListBaseModel:_CalCurFilterTrinketsList()
  self.curFilterTrinkets = {}
  local trinkets = self.allTrinketsList
  if not trinkets then
    return
  end
  local curEquipTrinketUid = self:GetCurEquipTrinketUid()
  local exemptUid = self:_GetListExemptUid()
  for i = 1, #trinkets do
    local trinket = trinkets[i]
    local pos = ItemDataUtils.GetTrinketPosIndex(trinket)
    if pos ~= self.partType then
    elseif curEquipTrinketUid ~= trinket.uid then
      if not AwakerTrinketDataUtils.IsTrinketVisibleInList(trinket.uid, exemptUid) then
      elseif not self:IsFilter(trinket) then
      else
        local itemData = {
          tid = trinket.tid,
          uid = trinket.uid,
          trinketData = trinket
        }
        table.insert(self.curFilterTrinkets, itemData)
      end
    end
  end
end

function TrinketListBaseModel:_SortCurFilterTrinkets()
  self.curFilterTrinkets = self:_SortTrinkets(self.curFilterTrinkets)
end

function TrinketListBaseModel:_SortTrinkets(trinkets)
  do return AwakerTrinketDataUtils.Sort, trinkets, self.trinketSortType, self.trinketSortOrder, false end
  return AwakerTrinketDataUtils.Sort, trinkets, self.trinketSortType, self.trinketSortOrder, false, true
end

function TrinketListBaseModel:_CalCurChoosenTrinketUid()
  local trinkets = self.curFilterTrinkets
  if 0 ~= self.curChoosenTrinketUid then
    for i = 1, #trinkets do
      if trinkets[i].uid == self.curChoosenTrinketUid then
        return
      end
    end
  end
  local curChoosenTrinketUid = self:GetCurEquipTrinketUid()
  local equipInList = false
  if 0 ~= curChoosenTrinketUid then
    for i = 1, #trinkets do
      if trinkets[i].uid == curChoosenTrinketUid then
        equipInList = true
        break
      end
    end
  end
  if 0 == curChoosenTrinketUid or not equipInList then
    curChoosenTrinketUid = trinkets and trinkets[1] and trinkets[1].uid or 0
  end
  self.curChoosenTrinketUid = curChoosenTrinketUid
end

function TrinketListBaseModel:_PlaceAwakerEquipTrinketToFirstPos()
  local list = self.curFilterTrinkets
  local curEquipUid = self:GetCurEquipTrinketUid()
  if 0 ~= curEquipUid then
    local index = -1
    for i = 1, #list do
      if list[i].uid == curEquipUid then
        index = i
        break
      end
    end
    if -1 ~= index then
      local trinket = table.remove(list, index)
      table.insert(list, 1, trinket)
    end
  end
end

function TrinketListBaseModel:GetCurEquipTrinketUid()
  return 0
end

function TrinketListBaseModel:_GetListExemptUid()
  return nil
end

return TrinketListBaseModel
