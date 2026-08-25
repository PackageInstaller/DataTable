local UICompCopyBattleStatisticRoundList, Super = NewViewComponent("UICompCopyBattleStatisticRoundList")
local T_Image = typeof(CS.UnityEngine.UI.Image)
local TabIndex = {Battle = 1, Round = 2}
local RoundOwnerSlot = {
  Damage = 1,
  Shield = 2,
  Heal = 3,
  Other = 4,
  Player = 5
}
local ROUND_PROGRESS_MAX_RATIO = 1

local function _FormatRoundAxisValue(num)
  local n = math.floor((tonumber(num) or 0) + 0.5)
  if n <= 0 then
    return "0"
  end
  do return tostring end
  return tostring, bc.NumberToK(n) or n, n
end

function UICompCopyBattleStatisticRoundList:ctor(uiNode, view, viewModel)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Panel_CopyStatisticsResource(uiNode)
  self._viewModel = viewModel
  self._tableView = nil
  self._rowList = {}
  self._roundMetricMax = 0
  self._roundSegmentPrefabColors = nil
  self._roundIndicatorColorMap = nil
  self._roundIndicatorSlotMap = nil
end

function UICompCopyBattleStatisticRoundList:OnEnterComponent()
  self:_CreateTableView()
  self:Refresh()
end

function UICompCopyBattleStatisticRoundList:Refresh()
  if self._viewModel.tabIndex == TabIndex.Round then
    self:_EnsureRoundOwnerIndicatorColorMap()
    self._rowList = self._viewModel:GetRoundRows()
    self._roundMetricMax = 0
    for _, row in ipairs(self._rowList or {}) do
      local metricValue = tonumber(row and row.metricValue) or 0
      if metricValue > self._roundMetricMax then
        self._roundMetricMax = metricValue
      end
    end
  else
    self._roundIndicatorColorMap = nil
    self._roundIndicatorSlotMap = nil
    self._rowList = {}
    self._roundMetricMax = 0
  end
  if self._tableView then
    self._tableView:ReloadData()
  end
  self:_RefreshDataArean()
end

function UICompCopyBattleStatisticRoundList:GetRoundIndicatorColorMap()
  return self._roundIndicatorColorMap
end

function UICompCopyBattleStatisticRoundList:_EnsureRoundOwnerIndicatorColorMap()
  if self._roundIndicatorColorMap and self._roundIndicatorSlotMap then
    return
  end
  self._roundIndicatorColorMap, self._roundIndicatorSlotMap = self:BuildRoundOwnerIndicatorColorMap()
end

function UICompCopyBattleStatisticRoundList:_CreateTableView()
  local owner = self.ui.RoundStatisticsView
  if not owner then
    return
  end
  local templateGo = self.ui.UI_Dungeous_Item_RoundStatistics
  if not templateGo then
    return
  end
  local cellRT = templateGo.transform
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self._tableView = self:CreateTableview(owner, function()
    return self._rowList and #self._rowList or 0
  end, System.fn(self, self._CellAtIndex), function()
    return width, height
  end)
end

function UICompCopyBattleStatisticRoundList:_CellAtIndex(view, index)
  local templateGo = self.ui.UI_Dungeous_Item_RoundStatistics
  local cell = self.view:DequeueCell(view, templateGo)
  local comp = self:AddViewComponentOnce(cell.gameObject, UICompCopyBattleStatisticRoundItem, self._rowList[index], self._viewModel.roundDataTypeDim, self._roundMetricMax, self._viewModel.roundOwnerIdOrder, self._roundIndicatorColorMap or {}, self._roundIndicatorSlotMap or {}, self:GetRoundSegmentPrefabColors())
  comp:Refresh(self._rowList[index], self._viewModel.roundDataTypeDim, self._roundMetricMax, self._viewModel.roundOwnerIdOrder, self._roundIndicatorColorMap or {}, self._roundIndicatorSlotMap or {}, self:GetRoundSegmentPrefabColors())
  return cell
end

function UICompCopyBattleStatisticRoundList:_RefreshDataArean()
  if not self.ui.Text_DataArean_1 then
    return
  end
  local scaleMax = (tonumber(self._roundMetricMax) or 0) * ROUND_PROGRESS_MAX_RATIO
  local textList = {
    self.ui.Text_DataArean_1,
    self.ui.Text_DataArean_2,
    self.ui.Text_DataArean_3,
    self.ui.Text_DataArean_4,
    self.ui.Text_DataArean_5
  }
  local count = #textList
  local duration = scaleMax / count
  for i, node in ipairs(textList) do
    if node and not IsNil(node) then
      local num = duration * i
      if 0 == num then
        self:SetRawText(node, "")
      else
        self:SetRawText(node, _FormatRoundAxisValue(num))
      end
    end
  end
end

function UICompCopyBattleStatisticRoundList:_GetImageColorFromGo(go)
  if not go or IsNil(go) then
    return nil
  end
  local img = go:GetComponent(T_Image)
  if not img then
    return nil
  end
  return img.color
end

function UICompCopyBattleStatisticRoundList:GetRoundSegmentPrefabColors()
  if self._roundSegmentPrefabColors then
    return self._roundSegmentPrefabColors
  end
  local templateGo = self.ui.UI_Dungeous_Item_RoundStatistics
  if not templateGo or IsNil(templateGo) then
    return nil
  end
  local res = UI_Dungeous_Item_RoundStatisticsResource(templateGo)
  local gos = {
    res.Image_Damage,
    res.Image_Shield,
    res.Image_Heal,
    res.Image_Other,
    res.Image_Player
  }
  local list = {}
  for i = 1, 5 do
    list[i] = self:_GetImageColorFromGo(gos[i])
  end
  self._roundSegmentPrefabColors = list
  return self._roundSegmentPrefabColors
end

function UICompCopyBattleStatisticRoundList:_PickBestAwakerTidForMetric(rows, metricKey, usedTids)
  local bestTid, bestVal
  for _, row in ipairs(rows or {}) do
    if row.awakerData and row.awakerData.tid then
      local tid = tonumber(row.awakerData.tid)
      if tid and not usedTids[tid] then
        local value = tonumber(row[metricKey]) or 0
        if nil == bestVal or bestVal < value then
          bestVal = value
          bestTid = tid
        end
      end
    end
  end
  return bestTid
end

function UICompCopyBattleStatisticRoundList:BuildRoundOwnerIndicatorColorMap()
  local colorMap = {}
  local slotMap = {}
  if self._viewModel.tabIndex ~= TabIndex.Round then
    return colorMap, slotMap
  end
  local segmentColors = self:GetRoundSegmentPrefabColors() or {}
  colorMap[1] = segmentColors[5]
  slotMap[1] = RoundOwnerSlot.Player
  local rows = {}
  for _, row in ipairs(self._viewModel:GetGlobalRoundOwnerRows() or {}) do
    if row.awakerData and row.awakerData.tid then
      rows[#rows + 1] = row
    end
  end
  local used = {}
  local tidRed = self:_PickBestAwakerTidForMetric(rows, "damage", used)
  if tidRed then
    colorMap[tidRed] = segmentColors[1]
    slotMap[tidRed] = RoundOwnerSlot.Damage
    used[tidRed] = true
  end
  local tidBlue = self:_PickBestAwakerTidForMetric(rows, "shield", used)
  if tidBlue then
    colorMap[tidBlue] = segmentColors[2]
    slotMap[tidBlue] = RoundOwnerSlot.Shield
    used[tidBlue] = true
  end
  local tidGreen = self:_PickBestAwakerTidForMetric(rows, "heal", used)
  if tidGreen then
    colorMap[tidGreen] = segmentColors[3]
    slotMap[tidGreen] = RoundOwnerSlot.Heal
    used[tidGreen] = true
  end
  for _, row in ipairs(rows) do
    local tid = tonumber(row.awakerData.tid)
    if tid and not used[tid] then
      colorMap[tid] = segmentColors[4]
      slotMap[tid] = RoundOwnerSlot.Other
      used[tid] = true
    end
  end
  return colorMap, slotMap
end

return UICompCopyBattleStatisticRoundList
