local TrinketSortType = CommonDefine.AwakerTrinketSortType
local TrinketFilterState = CommonDefine.TrinketFilterState
local TeamTrinketModel = NewClass("TeamTrinketModel", BaseModel)

local function _filterSuits()
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

function TeamTrinketModel:OnInit()
  self.curPage = nil
  self.selectTrinketUid = 0
  self.selectAwaker = 0
  self.selectTrinketDatas = {}
  self.selectPos = 0
  self.sortType = TrinketSortType.Level
  self.sortOrder = CommonDefine.SortOrder.Descend
  self.trinketShowList = {}
  local suits = _filterSuits()
  local suitsMap = {}
  for i = 1, #suits do
    suitsMap[suits[i]] = TrinketFilterState.FilterDefault
  end
  self.filterSuitsMap = suitsMap
  self.filterParts = {}
  self.filterMainAttrs = {}
  self.filterSubAttrs = {}
  self.selectTeamInfo = {}
end

function TeamTrinketModel:OnReset()
end

function TeamTrinketModel:UpdateTrinketShowList()
  local trinketData = self:GetCurPosEquipTrinket()
  local equipUid = trinketData and trinketData.uid or 0
  self.trinketShowList = self:GetPosList(self.selectPos, equipUid)
end

function TeamTrinketModel:SetSelectTeamInfo(teamInfo)
  if self.selectTeamInfo ~= teamInfo then
    self.selectTeamInfo = teamInfo
  end
end

function TeamTrinketModel:SetCurPage(page)
  if self.curPage ~= page then
    self.curPage = page
    self:LocalNotify(NotifyId.OnTeamTrinketPageChanged, page)
  end
end

function TeamTrinketModel:GetTrinketWeaponedAwakerTid(uid)
  return nil
end

function TeamTrinketModel:SetSelectAwaker(awakerTid)
  if self.selectAwaker ~= awakerTid then
    self.selectAwaker = awakerTid
  end
end

function TeamTrinketModel:SetSelectTrinketDatas(trinketUids)
  if self.selectTrinketDatas ~= trinketUids then
    self.selectTrinketDatas = trinketUids
  end
end

function TeamTrinketModel:SetSelectTrinketDataByPos(pos, itemData)
  self.selectTrinketDatas[pos] = itemData
  self:LocalNotify(NotifyId.OnTeamTrinketEquiped)
end

function TeamTrinketModel:SetSelectTrinketUid(uid)
  if self.selectTrinketUid ~= uid then
    self.selectTrinketUid = uid
    self:LocalNotify(NotifyId.OnTeamTrinketSelectUidChange, uid)
  end
end

function TeamTrinketModel:SetSelectPos(pos)
  if self.selectPos ~= pos then
    self.selectPos = pos
    self:OnTeamTrinketListChanged()
  end
end

function TeamTrinketModel:SetSortType(newType)
  if self.sortType ~= newType then
    self.sortType = newType
    self:OnTeamTrinketListChanged()
  end
end

function TeamTrinketModel:SetSortOrder(newOrder)
  if self.sortOrder ~= newOrder then
    self.sortOrder = newOrder
    self:OnTeamTrinketListChanged()
  end
end

function TeamTrinketModel:OnTeamTrinketListChanged()
  self:UpdateTrinketShowList()
  self:LocalNotify(NotifyId.OnTeamTrinketListChanged, self.page)
end

function TeamTrinketModel:GetCurPosEquipTrinket()
  return self.selectTrinketDatas[self.selectPos]
end

function TeamTrinketModel:_GetBoundExemptUid(pos)
  if table.next(AwakerDataUtils.GetMockAwakerMap()) then
    return 0
  end
  local awakerTid = self.selectAwaker
  if not (awakerTid and 0 ~= awakerTid and pos) or 0 == pos then
    return 0
  end
  local boundUid = AwakerDataUtils.GetBoundTrinketUid(awakerTid, pos)
  if 0 == boundUid or not ItemDataUtils.GetItemByUid(boundUid) then
    return 0
  end
  return boundUid
end

function TeamTrinketModel:GetPosList(pos, equipUid, withoutFilter)
  local trinketMap = ItemDataUtils.GetTrinketMapByPos(pos)
  local boundUid = self:_GetBoundExemptUid(pos)
  local tmp = {}
  for _, trinket in pairs(trinketMap) do
    if not AwakerTrinketDataUtils.IsTrinketVisibleInList(trinket.uid, equipUid) and trinket.uid ~= boundUid then
    elseif not withoutFilter then
      if 0 ~= equipUid and equipUid == trinket.uid or trinket.uid == boundUid then
        table.insert(tmp, trinket.uid)
      else
        local posIndex = ItemDataUtils.GetTrinketPosIndex(trinket)
        local mainAttr = AwakerTrinketDataUtils.GetMainAttr(trinket.uid)
        local subAttrs = AwakerTrinketDataUtils.GetSubAttrs(trinket.uid)
        local isSuitFilter = self:IsSuitFilter(trinket.suitId)
        local isPartFilter = self:IsPartFilter(posIndex)
        local isMainAttrFilter = self:IsMainAttrFilter(mainAttr.attrId)
        local isSubAttrFilter = self:IsSubAttrsFilter(subAttrs)
        if not (isSubAttrFilter and isSuitFilter and isPartFilter) or not isMainAttrFilter then
        else
          table.insert(tmp, trinket.uid)
        end
      end
    end
  end
  local sortType = self.sortType
  local sortOrder = self.sortOrder
  tmp = AwakerTrinketDataUtils.Sort(tmp, sortType, sortOrder)
  local list = tmp
  if 0 ~= equipUid then
    local index = -1
    for i = 1, #list do
      if list[i] == equipUid then
        index = i
        break
      end
    end
    if -1 ~= index then
      table.remove(list, index)
      table.insert(list, 1, equipUid)
    end
  end
  if 0 ~= boundUid and boundUid ~= equipUid then
    local boundIndex = -1
    for i = 1, #list do
      if list[i] == boundUid then
        boundIndex = i
        break
      end
    end
    if -1 ~= boundIndex then
      table.remove(list, boundIndex)
      table.insert(list, 1, boundUid)
    end
  end
  return list
end

function TeamTrinketModel:IsSuitFilter(suitId)
  return self.filterSuitsMap[suitId] ~= TrinketFilterState.FilterExclude
end

function TeamTrinketModel:IsPartFilter(part)
  return self.filterParts[part] ~= TrinketFilterState.FilterExclude
end

function TeamTrinketModel:IsMainAttrFilter(attrId)
  return self.filterMainAttrs[attrId] ~= TrinketFilterState.FilterExclude
end

function TeamTrinketModel:IsSubAttrsFilter(subAttrs)
  local isAllDefault = true
  for k, v in pairs(self.filterSubAttrs) do
    if v ~= TrinketFilterState.FilterDefault then
      isAllDefault = false
    end
  end
  if isAllDefault then
    return true
  end
  for k, v in pairs(self.filterSubAttrs) do
    if v == TrinketFilterState.FilterExclude then
      for i = 1, #subAttrs do
        if subAttrs[i].attrId == k then
          return false
        end
      end
    end
  end
  local hitedFilterInclude = false
  for k, v in pairs(self.filterSubAttrs) do
    if v == TrinketFilterState.FilterInclude then
      hitedFilterInclude = true
      if 0 == #subAttrs then
        return false
      end
      for i = 1, #subAttrs do
        if subAttrs[i].attrId == k then
          return true
        end
      end
    end
  end
  if hitedFilterInclude then
    return false
  end
  return true
end

return TeamTrinketModel
