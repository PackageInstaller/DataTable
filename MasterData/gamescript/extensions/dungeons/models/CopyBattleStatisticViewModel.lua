local CopyBattleStatisticViewModel = NewClass("CopyBattleStatisticViewModel")
local TabIndex = {Battle = 1, Round = 2}
local SortDim = {
  None = 0,
  Damage = 1,
  Shield = 2,
  Heal = 3
}
local SortDir = {
  None = 0,
  Desc = 1,
  Asc = 2
}
local PLAYER_OWNER_TID = 1
local AwakerSkillSlot = CommonDefine.AwakerSkillSlot
local SINGLE_DEFAULT_ORDER = {
  [AwakerSkillSlot.Slot_Strike] = 1,
  [AwakerSkillSlot.Slot_Defend] = 2,
  [AwakerSkillSlot.Slot_Super] = 3,
  [AwakerSkillSlot.Slot_Awake] = 4,
  [AwakerSkillSlot.Slot_Skill1] = 5,
  [AwakerSkillSlot.Slot_Skill2] = 6,
  OtherCard = 7,
  state = 8
}
CopyBattleStatisticViewModel.TabIndex = TabIndex
CopyBattleStatisticViewModel.SortDim = SortDim
CopyBattleStatisticViewModel.SortDir = SortDir

local function _StableSort(list, lessFn)
  if type(list) ~= "table" or #list <= 1 then
    return
  end
  for i, v in ipairs(list) do
    v.__si = i
  end
  table.sort(list, function(a, b)
    if lessFn(a, b) then
      return true
    end
    if lessFn(b, a) then
      return false
    end
    return a.__si < b.__si
  end)
  for _, v in ipairs(list) do
    v.__si = nil
  end
end

local function _GetOwnerKeyFromStatisticRow(row)
  if not row then
    return nil
  end
  if row.awakerData and row.awakerData.tid then
    do return tonumber end
    return tonumber, row.awakerData.tid
  end
  if row.playerUid then
    return 1
  end
  return nil
end

function CopyBattleStatisticViewModel:_FilterRoundRowsPositiveMetric(rows)
  local out = {}
  for _, row in ipairs(rows or {}) do
    if (tonumber(row and row.metricValue) or 0) > 0 then
      out[#out + 1] = row
    end
  end
  return out
end

function CopyBattleStatisticViewModel:ctor(mo)
  self._mo = mo or DungeonStatisticMO()
  self.tabIndex = TabIndex.Battle
  self.selectedOwnerId = 0
  self.sortDim = SortDim.None
  self.sortDir = SortDir.None
  self.battleFilterIndex = 0
  self.roundFilterIndex = 0
  self.roundDataTypeDim = SortDim.Damage
  self.roundDefaultBattleIndex = 0
  self.focusOwnerList = {}
  self.roundOwnerIdOrder = {}
  self._roundGlobalOwnerRows = nil
  self._skillDefaultOrderCache = nil
end

function CopyBattleStatisticViewModel:ResetEnterState()
  self.selectedOwnerId = 0
  self:SetTab(TabIndex.Battle)
end

function CopyBattleStatisticViewModel:SetTab(idx)
  self.tabIndex = idx or TabIndex.Battle
  if self.tabIndex ~= TabIndex.Round then
    self.roundFilterIndex = 0
  end
  self:RebuildByCurrentFilter()
end

function CopyBattleStatisticViewModel:SetSelectedOwnerId(ownerId)
  self.selectedOwnerId = tonumber(ownerId) or 0
  self:RebuildFocusOwnerList()
end

function CopyBattleStatisticViewModel:ToggleSort(dim)
  if self.sortDim ~= dim then
    self.sortDim = dim
    self.sortDir = SortDir.Desc
  elseif self.sortDir == SortDir.Desc then
    self.sortDir = SortDir.Asc
  elseif self.sortDir == SortDir.Asc then
    self.sortDim = SortDim.None
    self.sortDir = SortDir.None
  else
    self.sortDir = SortDir.Desc
  end
end

function CopyBattleStatisticViewModel:SetBattleFilterIndex(battleIndex)
  self.battleFilterIndex = tonumber(battleIndex) or 0
  self:NormalizeBattleFilterForCurrentTab()
  self.roundFilterIndex = 0
  self:RebuildByCurrentFilter()
end

function CopyBattleStatisticViewModel:SetRoundFilterIndex(roundIndex)
  self.roundFilterIndex = tonumber(roundIndex) or 0
  self:RebuildByCurrentFilter()
end

function CopyBattleStatisticViewModel:SetRoundDataTypeDim(dataTypeDim)
  local dim = tonumber(dataTypeDim) or SortDim.Damage
  if dim ~= SortDim.Damage and dim ~= SortDim.Shield and dim ~= SortDim.Heal then
    dim = SortDim.Damage
  end
  self.roundDataTypeDim = dim
end

function CopyBattleStatisticViewModel:RebuildByCurrentFilter()
  self._skillDefaultOrderCache = nil
  self:NormalizeBattleFilterForCurrentTab()
  self._mo:RebuildByScope(self.battleFilterIndex, self.roundFilterIndex)
  self:RebuildFocusOwnerList()
end

function CopyBattleStatisticViewModel:CanUseAllBattleFilter()
  return self.tabIndex ~= TabIndex.Round
end

function CopyBattleStatisticViewModel:GetDefaultRoundBattleIndex()
  if self.roundDefaultBattleIndex and self.roundDefaultBattleIndex > 0 then
    return self.roundDefaultBattleIndex
  end
  self.roundDefaultBattleIndex = self._mo:GetLastBossBattleIndex()
  return self.roundDefaultBattleIndex
end

function CopyBattleStatisticViewModel:NormalizeBattleFilterForCurrentTab()
  if self:CanUseAllBattleFilter() then
    return
  end
  if self.battleFilterIndex and self.battleFilterIndex > 0 then
    return
  end
  self.battleFilterIndex = self:GetDefaultRoundBattleIndex()
  self.roundFilterIndex = 0
end

function CopyBattleStatisticViewModel:RebuildFocusOwnerList()
  self.focusOwnerList = {}
  for _, row in ipairs(self._mo:GetStatisticDataList() or {}) do
    if row.awakerData or row.playerUid then
      self.focusOwnerList[#self.focusOwnerList + 1] = row
    end
  end
  if 0 ~= self.selectedOwnerId and not self:GetSelectedOwnerRow() then
    self.selectedOwnerId = 0
  end
  self:SyncRoundOwnerIdOrder()
end

function CopyBattleStatisticViewModel:SyncRoundOwnerIdOrder()
  self.roundOwnerIdOrder = {}
  local addedMap = {}
  for _, row in ipairs(self.focusOwnerList or {}) do
    local ownerId = _GetOwnerKeyFromStatisticRow(row)
    if ownerId and not addedMap[ownerId] then
      self.roundOwnerIdOrder[#self.roundOwnerIdOrder + 1] = ownerId
      addedMap[ownerId] = true
    end
  end
end

function CopyBattleStatisticViewModel:GetSelectedOwnerRow()
  if 0 == self.selectedOwnerId then
    return nil
  end
  for _, row in ipairs(self.focusOwnerList or {}) do
    if 1 == self.selectedOwnerId then
      if row.playerUid then
        return row
      end
    else
      local ownerId = tonumber(row.awakerData and row.awakerData.tid)
      if ownerId == self.selectedOwnerId then
        return row
      end
    end
  end
  return nil
end

function CopyBattleStatisticViewModel:GetBattleRows()
  if 0 ~= self.selectedOwnerId then
    do return self.GetSingleAwakerSkillList end
    return self.GetSingleAwakerSkillList, self
  end
  do return self.GetCurrentSortedDataList end
  return self.GetCurrentSortedDataList, self
end

function CopyBattleStatisticViewModel:GetCurrentSortedDataList()
  local list = self._mo:GetStatisticDataList() or {}
  if self.sortDim == SortDim.None or self.sortDir == SortDir.None then
    return list
  end
  local key = self:GetSortMetricKey(self.sortDim)
  local sorted = {}
  for i, v in ipairs(list) do
    sorted[i] = v
  end
  local desc = self.sortDir == SortDir.Desc
  _StableSort(sorted, function(a, b)
    local va = a and a[key] or 0
    local vb = b and b[key] or 0
    if desc then
      return va > vb
    end
    return va < vb
  end)
  return sorted
end

function CopyBattleStatisticViewModel:GetSortMetricKey(dim)
  if dim == SortDim.Shield then
    return "shield"
  end
  if dim == SortDim.Heal then
    return "heal"
  end
  return "damage"
end

function CopyBattleStatisticViewModel:GetSingleRowLabel(row)
  do return CopyBattleStatisticsDataUtils.ResolveSkillRowDisplayLabel end
  return CopyBattleStatisticsDataUtils.ResolveSkillRowDisplayLabel, row
end

function CopyBattleStatisticViewModel:GetSkillRowCategoryOrderBySlot(row)
  local typ = string.lower(tostring(row and row.statisticType or ""))
  typ = string.gsub(typ, "%s+", "")
  if "utilskill" == typ then
    return SINGLE_DEFAULT_ORDER[AwakerSkillSlot.Slot_Awake]
  end
  if "skill" ~= typ then
    return nil
  end
  local focusRow = self:GetSelectedOwnerRow()
  local awakerTid = focusRow and focusRow.awakerData and tonumber(focusRow.awakerData.tid)
  local skillTid = tonumber(row and row.defaultOrder)
  if (not skillTid or skillTid <= 0) and row and row.skillNameRaw then
    skillTid = tonumber(string.match(tostring(row.skillNameRaw), ":(%-?%d+)$"))
  end
  if not (awakerTid and not (awakerTid <= 0) and skillTid) or skillTid <= 0 then
    return nil
  end
  local slot = CopyBattleStatisticsDataUtils.ResolveSkillSlotIndex(awakerTid, skillTid)
  if not slot or slot <= 0 then
    return nil
  end
  return SINGLE_DEFAULT_ORDER[slot]
end

function CopyBattleStatisticViewModel:GetSingleRowDefaultOrder(row)
  if not row or type(row) ~= "table" then
    return 9999
  end
  local typ = string.lower(tostring(row.statisticType or ""))
  typ = string.gsub(typ, "%s+", "")
  local ownerKey = tonumber(row.ownerAwakerTid) or 0
  local cache = self._skillDefaultOrderCache
  if not cache then
    cache = {}
    self._skillDefaultOrderCache = cache
  end
  local ck = string.format("%d|%d|%d|%d|%s|%s|%s", tonumber(self.battleFilterIndex) or 0, tonumber(self.roundFilterIndex) or 0, tonumber(self.selectedOwnerId) or 0, ownerKey, typ, tostring(row.defaultOrder), tostring(row.skillNameRaw or ""))
  local cached = cache[ck]
  if nil ~= cached then
    return cached
  end
  local categoryOrder = self:GetSkillRowCategoryOrderBySlot(row)
  if not categoryOrder and ("status" == typ or "state" == typ) then
    categoryOrder = SINGLE_DEFAULT_ORDER.state
  end
  if not categoryOrder then
    local label = self:GetSingleRowLabel(row)
    categoryOrder = SINGLE_DEFAULT_ORDER[label]
  end
  local result
  if categoryOrder then
    if 5 == categoryOrder or 6 == categoryOrder then
      local skillSlotOrder = self:GetSingleSkillSlotOrder(row)
      if skillSlotOrder then
        result = categoryOrder * 100 + skillSlotOrder
      end
    end
    if not result then
      result = categoryOrder * 100
    end
  else
    local fallback = tonumber(row.defaultOrder) or 999
    result = 9000 + fallback
  end
  cache[ck] = result
  return result
end

function CopyBattleStatisticViewModel:GetSingleSkillSlotOrder(row)
  local focusRow = self:GetSelectedOwnerRow()
  local awakerTid = focusRow and focusRow.awakerData and tonumber(focusRow.awakerData.tid)
  if not awakerTid or awakerTid <= 0 then
    return nil
  end
  local typ = tostring(row and row.statisticType or ""):lower()
  if "skill" ~= typ then
    return nil
  end
  local skillTid = tonumber(row and row.defaultOrder)
  if (not skillTid or skillTid <= 0) and row and row.skillNameRaw then
    skillTid = tonumber(string.match(tostring(row.skillNameRaw), ":(%-?%d+)$"))
  end
  if not skillTid or skillTid <= 0 then
    return nil
  end
  local slot = CopyBattleStatisticsDataUtils.ResolveSkillSlotIndex(awakerTid, skillTid)
  if not slot or slot <= 0 then
    return nil
  end
  return slot
end

function CopyBattleStatisticViewModel:GetSingleAwakerSkillList()
  local focusRow = self:GetSelectedOwnerRow()
  if not focusRow then
    return {}
  end
  local ownerId = _GetOwnerKeyFromStatisticRow(focusRow)
  if not ownerId then
    return {}
  end
  local rst, barMax = self._mo:GetSkillRowsByScope(ownerId, self.battleFilterIndex, self.roundFilterIndex)
  if #rst > 0 then
    focusRow._skillBarsMaxFromDisplayList = barMax
  else
    focusRow._skillBarsMaxFromDisplayList = nil
  end
  for _, one in ipairs(rst) do
    one._defaultOrder = self:GetSingleRowDefaultOrder(one)
  end
  local useSort = self.sortDim ~= SortDim.None and self.sortDir ~= SortDir.None
  local sortKey = useSort and self:GetSortMetricKey(self.sortDim) or nil
  local desc = useSort and self.sortDir == SortDir.Desc
  if #rst > 1 then
    _StableSort(rst, function(a, b)
      if sortKey then
        local va, vb = tonumber(a[sortKey] or 0) or 0, tonumber(b[sortKey] or 0) or 0
        if va ~= vb then
          if desc then
            return va > vb
          end
          return va < vb
        end
      end
      local ao, bo = a._defaultOrder or 999, b._defaultOrder or 999
      if ao ~= bo then
        return ao < bo
      end
      return (a._originIndex or 0) < (b._originIndex or 0)
    end)
  end
  return rst
end

function CopyBattleStatisticViewModel:GetRoundRows()
  self:SyncRoundOwnerIdOrder()
  self:NormalizeBattleFilterForCurrentTab()
  local hasSingleOwner = 0 ~= (self.selectedOwnerId or 0)
  local hasSpecificRound = (self.roundFilterIndex or 0) > 0
  if hasSpecificRound then
    if hasSingleOwner then
      do return self._FilterRoundRowsPositiveMetric, self, self:GetSelectedOwnerRoundStatisticRows() end
      return self._FilterRoundRowsPositiveMetric, self, self:GetSelectedOwnerRoundStatisticRows()
    end
    do return self._FilterRoundRowsPositiveMetric, self, self:GetAllOwnerRoundSkillStatisticRows() end
    return self._FilterRoundRowsPositiveMetric, self, self:GetAllOwnerRoundSkillStatisticRows()
  end
  local roundRows = self._mo:GetRoundSummaryList(self.battleFilterIndex, self.roundFilterIndex)
  if self.tabIndex == TabIndex.Round and (not roundRows or 0 == #roundRows) and self.battleFilterIndex > 0 then
    roundRows = self._mo:GetRoundSummaryList(0, self.roundFilterIndex)
  end
  local focusOwner = self:GetSelectedOwnerRow()
  local focusKey = _GetOwnerKeyFromStatisticRow(focusOwner)
  local mapKey = "damageMap"
  if self.roundDataTypeDim == SortDim.Shield then
    mapKey = "shieldMap"
  elseif self.roundDataTypeDim == SortDim.Heal then
    mapKey = "healMap"
  end
  for _, row in ipairs(roundRows or {}) do
    local ownerMap = row[mapKey] or {}
    local metricValue = 0
    if hasSingleOwner and nil ~= focusKey then
      metricValue = self:GetRoundOwnerMapValue(ownerMap, focusKey)
      row._selectedOwnerKey = focusKey
    else
      metricValue = self:GetAllOwnerRoundMetricValue(ownerMap)
      row._selectedOwnerKey = nil
    end
    row.metricValue = metricValue
  end
  if roundRows and #roundRows > 1 then
    table.sort(roundRows, function(a, b)
      local aBattle = a and a.battleIndex or 0
      local bBattle = b and b.battleIndex or 0
      if aBattle ~= bBattle then
        return aBattle < bBattle
      end
      local aRound = a and a.roundIndex or 0
      local bRound = b and b.roundIndex or 0
      return aRound < bRound
    end)
  end
  return roundRows or {}
end

function CopyBattleStatisticViewModel:GetAllOwnerRoundSkillStatisticRows()
  local result = {}
  local ownerRankMap = {}
  for i, ownerId in ipairs(self.roundOwnerIdOrder or {}) do
    ownerRankMap[ownerId] = i
  end
  for _, ownerId in ipairs(self.roundOwnerIdOrder or {}) do
    if ownerId and 0 ~= ownerId then
      local rst = self._mo:GetSkillRowsByScope(ownerId, self.battleFilterIndex, self.roundFilterIndex, {_isSingleOwnerStatisticRow = true, _selectedOwnerKey = ownerId})
      for _, row in ipairs(rst or {}) do
        row.metricValue = self:GetRoundSingleRowMetricValue(row)
        row._ownerRank = ownerRankMap[ownerId] or 999
        result[#result + 1] = row
      end
    end
  end
  if #result > 1 then
    _StableSort(result, function(a, b)
      local ar, br = a._ownerRank or 999, b._ownerRank or 999
      if ar ~= br then
        return ar < br
      end
      return (a._originIndex or 0) < (b._originIndex or 0)
    end)
  end
  return result
end

function CopyBattleStatisticViewModel:GetSelectedOwnerRoundStatisticRows()
  local focusRow = self:GetSelectedOwnerRow()
  if not focusRow then
    return {}
  end
  local focusKey = _GetOwnerKeyFromStatisticRow(focusRow)
  local ownerAwakerTid = tonumber(focusRow.awakerData and focusRow.awakerData.tid)
  local ownerId = ownerAwakerTid or PLAYER_OWNER_TID
  local rst = self._mo:GetSkillRowsByScope(ownerId, self.battleFilterIndex, self.roundFilterIndex, {_isSingleOwnerStatisticRow = true, _selectedOwnerKey = focusKey})
  for _, one in ipairs(rst) do
    one._defaultOrder = self:GetSingleRowDefaultOrder(one)
    one.metricValue = self:GetRoundSingleRowMetricValue(one)
  end
  if #rst > 1 then
    _StableSort(rst, function(a, b)
      local ao, bo = a._defaultOrder or 999, b._defaultOrder or 999
      if ao ~= bo then
        return ao < bo
      end
      return (a._originIndex or 0) < (b._originIndex or 0)
    end)
  end
  do return self._FilterRoundRowsPositiveMetric, self end
  return self._FilterRoundRowsPositiveMetric, self, rst, ipairs(rst)
end

function CopyBattleStatisticViewModel:GetGlobalRoundOwnerRows()
  if not self._roundGlobalOwnerRows then
    self._roundGlobalOwnerRows = self._mo:BuildStatisticDataListByScope(0, 0)
  end
  return self._roundGlobalOwnerRows
end

function CopyBattleStatisticViewModel:GetRoundSingleRowMetricValue(row)
  local key = self:GetSortMetricKey(self.roundDataTypeDim)
  return tonumber(row and row[key]) or 0
end

function CopyBattleStatisticViewModel:GetRoundOwnerMapValue(ownerMap, ownerId)
  if type(ownerMap) ~= "table" or not ownerId then
    return 0
  end
  return tonumber(ownerMap[ownerId] or ownerMap[tostring(ownerId)] or 0) or 0
end

function CopyBattleStatisticViewModel:GetAllOwnerRoundMetricValue(ownerMap)
  local total = 0
  for _, ownerId in ipairs(self.roundOwnerIdOrder or {}) do
    if ownerId and 0 ~= ownerId then
      total = total + self:GetRoundOwnerMapValue(ownerMap, ownerId)
    end
  end
  return total
end

function CopyBattleStatisticViewModel:GetBattleTypeOptions()
  local ordered = {}
  if self:CanUseAllBattleFilter() then
    ordered[#ordered + 1] = {
      battleIndex = 0,
      label = self:GetBattleFilterText(0)
    }
  end
  local optionList = self._mo:GetBattleOptionList()
  for _, option in ipairs(optionList or {}) do
    local battleIndex = tonumber(option and option.battleIndex) or 0
    if battleIndex > 0 then
      ordered[#ordered + 1] = {
        battleIndex = battleIndex,
        label = self:GetBattleFilterText(battleIndex)
      }
    end
  end
  return ordered
end

function CopyBattleStatisticViewModel:GetDataTypeOptions()
  return {
    {
      dataTypeDim = SortDim.Damage,
      label = LT.Text("statistic_type_filter_damage")
    },
    {
      dataTypeDim = SortDim.Shield,
      label = LT.Text("statistic_type_filter_block")
    },
    {
      dataTypeDim = SortDim.Heal,
      label = LT.Text("statistic_type_filter_heal")
    }
  }
end

function CopyBattleStatisticViewModel:GetRoundFilterOptions()
  local list = {
    {
      roundIndex = 0,
      label = LT.Text("statistic_bout_filter_all")
    }
  }
  local count = self._mo:GetRoundCount(self.battleFilterIndex)
  for i = 1, count do
    list[#list + 1] = {
      roundIndex = i,
      label = LT.Textf("statistic_bout_filter_turn", i)
    }
  end
  return list
end

function CopyBattleStatisticViewModel:GetBattleFilterText(battleIndex)
  if not battleIndex or battleIndex <= 0 then
    do return LT.Text end
    return LT.Text, "statistic_battle_filter_all", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  local battleRow, battlePos, battles = self._mo:GetBattleRowByIndex(battleIndex)
  if not battleRow or not battlePos then
    do return string.format, "%s%d", (LT.Text("statistic_battle_filter_common")) end
    return string.format, "%s%d", LT.Text("statistic_battle_filter_common"), battleIndex, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  local gearType = tonumber(battleRow.gearType) or 0
  local battleTypeText = LT.Text("statistic_battle_filter_common")
  if gearType == CommonDefine.GearItemType.EliteMonster then
    battleTypeText = LT.Text("statistic_battle_filter_elite")
  elseif gearType == CommonDefine.GearItemType.Boss then
    battleTypeText = LT.Text("statistic_battle_filter_boss")
  end
  local typeOrder = 0
  for i = 1, battlePos do
    local row = battles[i]
    if row then
      local rowGearType = tonumber(row.gearType) or 0
      if rowGearType == gearType then
        typeOrder = typeOrder + 1
      end
    end
  end
  if typeOrder <= 0 then
    typeOrder = 1
  end
  local sameCategoryCount = 0
  for _, row in ipairs(battles) do
    local gt = tonumber(row and row.gearType) or 0
    local inCategory = false
    if gearType == CommonDefine.GearItemType.Boss then
      inCategory = gt == CommonDefine.GearItemType.Boss
    elseif gearType == CommonDefine.GearItemType.EliteMonster then
      inCategory = gt == CommonDefine.GearItemType.EliteMonster
    else
      inCategory = gt ~= CommonDefine.GearItemType.Boss and gt ~= CommonDefine.GearItemType.EliteMonster
    end
    if inCategory then
      sameCategoryCount = sameCategoryCount + 1
    end
  end
  if sameCategoryCount <= 1 then
    return battleTypeText
  end
  do return string.format, "%s%d", battleTypeText end
  return string.format, "%s%d", battleTypeText, typeOrder, 0, row.gearType, 0, true, CommonDefine.GearItemType.EliteMonster
end

function CopyBattleStatisticViewModel:GetRoundFilterText()
  if self.roundFilterIndex > 0 then
    do return LT.Textf, "statistic_bout_filter_turn" end
    return LT.Textf, "statistic_bout_filter_turn", self.roundFilterIndex
  end
  do return LT.Text end
  return LT.Text, "statistic_bout_filter_all", self.roundFilterIndex
end

function CopyBattleStatisticViewModel:GetDataTypeText()
  local dimTextKey = self.roundDataTypeDim == SortDim.Shield and "statistic_type_filter_block" or self.roundDataTypeDim == SortDim.Heal and "statistic_type_filter_heal" or "statistic_type_filter_damage"
  do return LT.Text end
  return LT.Text, dimTextKey
end

return CopyBattleStatisticViewModel
