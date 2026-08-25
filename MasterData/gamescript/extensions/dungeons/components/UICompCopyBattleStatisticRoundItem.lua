local UICompCopyBattleStatisticRoundItem, Super = NewViewComponent("UICompCopyBattleStatisticRoundItem")
local SortDim = {
  Damage = 1,
  Shield = 2,
  Heal = 3
}
local ROUND_PROGRESS_MAX_RATIO = 1
local RoundOwnerSlot = {
  Damage = 1,
  Shield = 2,
  Heal = 3,
  Other = 4,
  Player = 5
}
local RoundDisplaySlots = {
  RoundOwnerSlot.Player,
  RoundOwnerSlot.Other,
  RoundOwnerSlot.Heal,
  RoundOwnerSlot.Shield,
  RoundOwnerSlot.Damage
}

local function GetOwnerMapValue(ownerMap, ownerId)
  if type(ownerMap) ~= "table" or not ownerId then
    return 0
  end
  return tonumber(ownerMap[ownerId] or ownerMap[tostring(ownerId)]) or 0
end

function UICompCopyBattleStatisticRoundItem:ctor(uiNode, view, row, roundDataTypeDim, roundMetricMax, orderedOwnerIds, ownerColorMap, ownerSlotMap, segmentPrefabColors)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeous_Item_RoundStatisticsResource(uiNode)
  self._row = row
  self._roundDataTypeDim = roundDataTypeDim or SortDim.Damage
  self._roundMetricMax = roundMetricMax or 0
  self._orderedOwnerIds = orderedOwnerIds or {}
  self._ownerColorMap = ownerColorMap
  self._ownerSlotMap = ownerSlotMap
  self._segmentPrefabColors = segmentPrefabColors
end

function UICompCopyBattleStatisticRoundItem:OnEnterComponent()
  self:_Refresh()
end

function UICompCopyBattleStatisticRoundItem:Refresh(row, roundDataTypeDim, roundMetricMax, orderedOwnerIds, ownerColorMap, ownerSlotMap, segmentPrefabColors)
  self._row = row
  self._roundDataTypeDim = roundDataTypeDim or SortDim.Damage
  self._roundMetricMax = roundMetricMax or 0
  if nil ~= orderedOwnerIds then
    self._orderedOwnerIds = orderedOwnerIds
  end
  if nil ~= ownerColorMap then
    self._ownerColorMap = ownerColorMap
  end
  if nil ~= ownerSlotMap then
    self._ownerSlotMap = ownerSlotMap
  end
  if nil ~= segmentPrefabColors then
    self._segmentPrefabColors = segmentPrefabColors
  end
  self:_Refresh()
end

function UICompCopyBattleStatisticRoundItem:_ApplySegmentFillsAndColors(imgs, fills, colors, actives)
  local prefabCols = self._segmentPrefabColors
  for i = 1, 5 do
    local img = imgs[i]
    if img then
      if actives then
        self:SetActive(img, true == actives[i])
      else
        self:SetActive(img, true)
      end
      self:SetImageFillAmount(img, fills[i] or 0)
      local c = colors and colors[i]
      if not c and prefabCols then
        c = prefabCols[i]
      end
      if c then
        self:SetImageColor(img, c)
      end
    end
  end
end

function UICompCopyBattleStatisticRoundItem:_GetOtherSegmentPrefabColor()
  return self._segmentPrefabColors and self._segmentPrefabColors[4] or nil
end

function UICompCopyBattleStatisticRoundItem:_GetSlotPrefabColor(slot)
  return self._segmentPrefabColors and self._segmentPrefabColors[slot] or nil
end

function UICompCopyBattleStatisticRoundItem:_Refresh()
  local row = self._row
  local ui = self.ui
  if not row or not ui then
    return
  end
  if self:_IsSingleOwnerStatisticRow(row) then
    self:_RefreshSingleOwnerStatisticRow(row, ui)
    return
  end
  if ui.Text_Round then
    local rIdx = tonumber(row.roundIndex) or 0
    if rIdx > 0 then
      self:SetText(ui.Text_Round, LT.Textf("statistic_bout_filter_turn", rIdx))
    else
      self:SetText(ui.Text_Round, "")
    end
  end
  if ui.Text_Value then
    self:SetText(ui.Text_Value, string.format("%d", math.floor(row.metricValue or 0)))
  end
  local mapKey = "damageMap"
  if self._roundDataTypeDim == SortDim.Shield then
    mapKey = "shieldMap"
  elseif self._roundDataTypeDim == SortDim.Heal then
    mapKey = "healMap"
  end
  local ownerMap = row[mapKey] or {}
  local selectedOwnerKey = tonumber(row._selectedOwnerKey)
  local order = self._orderedOwnerIds or {}
  local cmap = self._ownerColorMap or {}
  local slotMap = self._ownerSlotMap or {}
  local imgs = {
    ui.Image_Damage,
    ui.Image_Shield,
    ui.Image_Heal,
    ui.Image_Other,
    ui.Image_Player
  }
  local metricValue = tonumber(row.metricValue) or 0
  local maxMetric = tonumber(self._roundMetricMax) or 0
  local baseProgress = 0
  if metricValue > 0 and maxMetric > 0 then
    baseProgress = math.min(1, metricValue / maxMetric) * ROUND_PROGRESS_MAX_RATIO
  end
  if selectedOwnerKey then
    local slot = slotMap[selectedOwnerKey] or RoundOwnerSlot.Other
    local fills = {
      0,
      0,
      0,
      0,
      0
    }
    local colors = {}
    local actives = {
      false,
      false,
      false,
      false,
      false
    }
    fills[slot] = baseProgress
    colors[slot] = cmap[selectedOwnerKey] or self:_GetSlotPrefabColor(slot) or self:_GetOtherSegmentPrefabColor()
    actives[slot] = true
    self:_ApplySegmentFillsAndColors(imgs, fills, colors, actives)
    return
  end
  local displayOwnerIds = {}
  local displayValues = {}
  local total = 0
  for _, ownerId in ipairs(order) do
    if ownerId and 0 ~= ownerId then
      local v = GetOwnerMapValue(ownerMap, ownerId)
      displayOwnerIds[#displayOwnerIds + 1] = ownerId
      displayValues[#displayValues + 1] = v
      total = total + v
    end
  end
  local valuesBySlot = {
    0,
    0,
    0,
    0,
    0
  }
  local colorsBySlot = {}
  local actives = {
    false,
    false,
    false,
    false,
    false
  }
  local count = math.min(#displayOwnerIds, #RoundDisplaySlots)
  local slotOffset = #RoundDisplaySlots - count
  for i = 1, count do
    local ownerId = displayOwnerIds[i]
    local slot = RoundDisplaySlots[slotOffset + i]
    valuesBySlot[slot] = valuesBySlot[slot] + (displayValues[i] or 0)
    colorsBySlot[slot] = cmap[ownerId] or self:_GetSlotPrefabColor(slotMap[ownerId] or slot)
    actives[slot] = true
  end
  local cumulative = 0
  local fills = {
    0,
    0,
    0,
    0,
    0
  }
  if total > 0 then
    for i = 1, count do
      local slot = RoundDisplaySlots[slotOffset + i]
      cumulative = cumulative + (valuesBySlot[slot] or 0)
      fills[slot] = cumulative / total * baseProgress
    end
  end
  local segColors = {
    colorsBySlot[RoundOwnerSlot.Damage] or self:_GetSlotPrefabColor(RoundOwnerSlot.Damage),
    colorsBySlot[RoundOwnerSlot.Shield] or self:_GetSlotPrefabColor(RoundOwnerSlot.Shield),
    colorsBySlot[RoundOwnerSlot.Heal] or self:_GetSlotPrefabColor(RoundOwnerSlot.Heal),
    colorsBySlot[RoundOwnerSlot.Other] or self:_GetSlotPrefabColor(RoundOwnerSlot.Other),
    colorsBySlot[RoundOwnerSlot.Player] or self:_GetSlotPrefabColor(RoundOwnerSlot.Player)
  }
  self:_ApplySegmentFillsAndColors(imgs, fills, segColors, actives)
end

function UICompCopyBattleStatisticRoundItem:_IsSingleOwnerStatisticRow(row)
  return row and row._isSingleOwnerStatisticRow == true
end

function UICompCopyBattleStatisticRoundItem:_GetSingleOwnerStatisticLabel(row)
  do return CopyBattleStatisticsDataUtils.ResolveSkillRowDisplayLabel end
  return CopyBattleStatisticsDataUtils.ResolveSkillRowDisplayLabel, row
end

function UICompCopyBattleStatisticRoundItem:_RefreshSingleOwnerStatisticRow(row, ui)
  if ui.Text_Round then
    self:SetText(ui.Text_Round, self:_GetSingleOwnerStatisticLabel(row))
  end
  if ui.Text_Value then
    self:SetText(ui.Text_Value, string.format("%d", math.floor(row.metricValue or 0)))
  end
  local imgs = {
    ui.Image_Damage,
    ui.Image_Shield,
    ui.Image_Heal,
    ui.Image_Other,
    ui.Image_Player
  }
  local selectedOwnerKey = tonumber(row._selectedOwnerKey)
  local cmap = self._ownerColorMap or {}
  local slotMap = self._ownerSlotMap or {}
  local metricValue = tonumber(row.metricValue) or 0
  local maxMetric = tonumber(self._roundMetricMax) or 0
  local baseProgress = 0
  if metricValue > 0 and maxMetric > 0 then
    baseProgress = math.min(1, metricValue / maxMetric) * ROUND_PROGRESS_MAX_RATIO
  end
  local slot = selectedOwnerKey and slotMap[selectedOwnerKey] or RoundOwnerSlot.Other
  local fills = {
    0,
    0,
    0,
    0,
    0
  }
  local colors = {}
  local actives = {
    false,
    false,
    false,
    false,
    false
  }
  fills[slot] = baseProgress
  colors[slot] = selectedOwnerKey and cmap[selectedOwnerKey] or self:_GetSlotPrefabColor(slot) or self:_GetOtherSegmentPrefabColor()
  actives[slot] = true
  self:_ApplySegmentFillsAndColors(imgs, fills, colors, actives)
end

return UICompCopyBattleStatisticRoundItem
