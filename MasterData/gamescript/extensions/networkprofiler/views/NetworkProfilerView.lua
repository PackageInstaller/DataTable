local NetworkProfiler = require("Foundation.Network.NetworkProfiler")
local NetworkProfilerView, Super = NewClass("NetworkProfilerView", BaseView)
NetworkProfilerView.uiResCls = "UI/UI_Gm/Popup_Gm_PerformanceTesting.prefab"
local SortType = {
  MaxTime = 1,
  MinTime = 2,
  AvgTime = 3,
  TotalTime = 4,
  FirstTime = 5
}
local SortFields = {
  {
    field = "maxTime",
    name = "最大耗时"
  },
  {
    field = "minTime",
    name = "最小耗时"
  },
  {
    field = "avgTime",
    name = "平均耗时"
  },
  {field = "totalTime", name = "总耗时"},
  {
    field = "firstTime",
    name = "首次耗时"
  }
}
local TypeList = {
  {
    type = NetworkProfiler.NetworkProfilerType.Request,
    name = "协议请求"
  },
  {
    type = NetworkProfiler.NetworkProfilerType.Notify,
    name = "本地处理服务器推送"
  },
  {
    type = NetworkProfiler.NetworkProfilerType.Unzip,
    name = "协议解压"
  },
  {
    type = NetworkProfiler.NetworkProfilerType.HandleRespond,
    name = "本地处理服务器响应"
  }
}

function NetworkProfilerView:ctor(args)
  Super.ctor(self)
  self._typeDataList = {}
  self._statsDataList = {}
  self._currentSortIndex = SortType.AvgTime
  self._ascending = false
  self._currentType = NetworkProfiler.NetworkProfilerType.Request
end

function NetworkProfilerView:OnBuildView()
  self:_InitTypeTableView()
  self:_InitStatsTableView()
  self._sortToggles = {
    self.ui.Toggle_MaxTime,
    self.ui.Toggle_MinTime,
    self.ui.Toggle_AvgTime,
    self.ui.Toggle_TotalTime,
    self.ui.Toggle_FirstTime
  }
end

function NetworkProfilerView:RegisterNotifications()
end

function NetworkProfilerView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self._OnClickClose))
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_Enable, System.fn(self, self._OnClickToggle))
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_SortType, System.fn(self, self._OnClickSortOrder))
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_FirstTime, function(isOn)
    if isOn then
      self:_UpdateSortType(SortType.FirstTime)
    end
  end)
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_AvgTime, function(isOn)
    if isOn then
      self:_UpdateSortType(SortType.AvgTime)
    end
  end)
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_MaxTime, function(isOn)
    if isOn then
      self:_UpdateSortType(SortType.MaxTime)
    end
  end)
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_MinTime, function(isOn)
    if isOn then
      self:_UpdateSortType(SortType.MinTime)
    end
  end)
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_TotalTime, function(isOn)
    if isOn then
      self:_UpdateSortType(SortType.TotalTime)
    end
  end)
  self:AddInputValueChangeListener(self.ui.InputField, System.fn(self, self._OnInputFieldValueChanged))
  self:AddButtonClickListener(self.ui.Btn_Clear, System.fn(self, self._OnClickClear))
end

function NetworkProfilerView:OnEnterView()
  Super.OnEnterView(self)
  self._currentType = NetworkProfiler.NetworkProfilerType.Request
  self._ascending = false
  self._filterText = nil
  self:_UpdateSortType(SortType.AvgTime)
  self:_RefreshToggleState()
  self:_RefreshTypeList()
  self:_RefreshSortToggles()
  self:_RefreshSortOrder()
end

function NetworkProfilerView:OnExitView()
  self:ClearTableviews()
  Super.OnExitView(self)
end

function NetworkProfilerView:_RefreshToggleState()
  local isEnabled = NetworkProfiler.IsEnabled()
  self:SetZ1Toggle(self.ui.Toggle_Enable, isEnabled, true)
end

function NetworkProfilerView:_RefreshSortToggles()
  for i = 1, #self._sortToggles do
    self:SetZ1Toggle(self._sortToggles[i], i == self._currentSortIndex, true)
    self:SetZ1ToggleInteractable(self._sortToggles[i], i ~= self._currentSortIndex)
  end
end

function NetworkProfilerView:_InitTypeTableView()
  self._typeTableView = self:CreateTableview(self.ui.ScrollView_Option, function()
    return #self._typeDataList
  end, function(view, index)
    do return self._TypeCellAtIndex, self, view end
    return self._TypeCellAtIndex, self, view, index
  end, function()
    return 360, 96
  end)
end

function NetworkProfilerView:_TypeCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.Item_Gn_PerformanceTesting_Tab)
  local data = self._typeDataList[index]
  local ui = UIBaseResource(cell.gameObject)
  self:SetText(ui.Text_Option, data.name)
  self:SetZ1Toggle(ui.uiNode, data.type == self._currentType, true)
  self:SetZ1ToggleInteractable(ui.uiNode, data.type ~= self._currentType)
  self:AddZ1ToggleValueChangedListener(ui.uiNode, function(isOn)
    self:_SelectType(data.type)
  end)
  return cell
end

function NetworkProfilerView:_InitStatsTableView()
  self.ui.DetailsItem:SetActive(false)
  self._statsTableView = self:CreateTableview(self.ui.ScrollView_Detail, function()
    return #self._statsDataList
  end, function(view, index)
    do return self._StatsCellAtIndex, self, view end
    return self._StatsCellAtIndex, self, view, index
  end, function()
    return 800, 230
  end)
end

function NetworkProfilerView:_StatsCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.DetailsItem)
  local data = self._statsDataList[index]
  local ui = UIBaseResource(cell.gameObject)
  self:SetText(ui.Text_ProtoName, "协议名称：" .. data.func)
  self:SetText(ui.Text_ReqCount, "请求次数：" .. data.count)
  self._tempArray = self._tempArray or {}
  table.clear(self._tempArray)
  table.insert(self._tempArray, "最大耗时：" .. string.format("%.2f", data.maxTime * 1000))
  table.insert(self._tempArray, "最小耗时：" .. string.format("%.2f", data.minTime * 1000))
  table.insert(self._tempArray, "平均耗时：" .. string.format("%.2f", data.avgTime * 1000))
  table.insert(self._tempArray, "总耗时：" .. string.format("%.2f", data.totalTime * 1000))
  table.insert(self._tempArray, "首次耗时：" .. string.format("%.2f", data.firstTime * 1000))
  local firstTxt = table.remove(self._tempArray, self._currentSortIndex)
  table.insert(self._tempArray, 1, firstTxt)
  for i = 1, #self._tempArray do
    self:SetText(ui["Text_Time" .. i], self._tempArray[i])
  end
  return cell
end

function NetworkProfilerView:_RefreshTypeList()
  self._typeDataList = TypeList
  if self._typeTableView then
    self._typeTableView:ReloadData()
  end
end

function NetworkProfilerView:_RefreshStatsList()
  self._statsDataList = self:_GetSortedStatsList()
  if self._statsTableView then
    self._statsTableView:ReloadData()
  end
end

function NetworkProfilerView:_GetSortedStatsList()
  local allStats = NetworkProfiler.GetAllStats(self._currentType)
  if not allStats then
    return {}
  end
  local list = {}
  for func, entry in pairs(allStats) do
    if string.isempty(self._filterText) or string.find(string.lower(func), self._filterText) then
      local item = {
        func = func,
        count = entry.count,
        totalTime = entry.totalTime,
        firstTime = entry.firstTime,
        minTime = entry.minTime,
        maxTime = entry.maxTime,
        avgTime = entry.totalTime / entry.count
      }
      table.insert(list, item)
    end
  end
  local sortField = SortFields[self._currentSortIndex].field
  local ascending = self._ascending
  table.sort(list, function(a, b)
    if ascending then
      return (a[sortField] or 0) < (b[sortField] or 0)
    else
      return (a[sortField] or 0) > (b[sortField] or 0)
    end
  end)
  return list
end

function NetworkProfilerView:_SelectType(profilerType)
  self._currentType = profilerType
  self:_RefreshTypeList()
  self:_RefreshStatsList()
end

function NetworkProfilerView:_OnClickToggle(isOn)
  NetworkProfiler.SetEnabled(isOn)
  self:_RefreshSortToggles()
end

function NetworkProfilerView:_OnClickExport()
  local mdContent = self:_ExportToMarkdown()
  local path = CS.UnityEngine.Application.persistentDataPath .. "/NetworkProfiler_" .. os.date("%Y%m%d_%H%M%S") .. ".md"
  local file = io.open(path, "w")
  if file then
    file:write(mdContent)
    file:close()
    Logger.Info("NetworkProfiler data exported to: %s", path)
  else
    Logger.Error("NetworkProfiler export failed, cannot open file: %s", path)
  end
end

function NetworkProfilerView:_OnClickSortOrder(isOn)
  self._ascending = isOn
  self:_RefreshStatsList()
  self:_RefreshSortOrder()
end

function NetworkProfilerView:_OnClickRefresh()
end

function NetworkProfilerView:_OnClickClose()
  self:Close()
end

function NetworkProfilerView:_ExportToMarkdown()
  local lines = {}
  table.insert(lines, "# NetworkProfiler Report\n")
  table.insert(lines, string.format("Generated: %s\n", os.date("%Y-%m-%d %H:%M:%S")))
  local typeNames = {
    [NetworkProfiler.NetworkProfilerType.Request] = "Request (客户端请求往返)",
    [NetworkProfiler.NetworkProfilerType.Notify] = "Notify (服务器推送处理)",
    [NetworkProfiler.NetworkProfilerType.Unzip] = "Unzip (解压耗时)",
    [NetworkProfiler.NetworkProfilerType.HandleRespond] = "HandleRespond (本地处理耗时)"
  }
  for typeId, typeName in pairs(typeNames) do
    table.insert(lines, string.format([[

## %s
]], typeName))
    table.insert(lines, "| Func | Count | AvgTime(ms) | MinTime(ms) | MaxTime(ms) | TotalTime(ms) | FirstTime(ms) |")
    table.insert(lines, "|------|-------|-------------|-------------|-------------|---------------|---------------|")
    local allStats = NetworkProfiler.GetAllStats(typeId)
    if allStats then
      local sortedList = {}
      for func, entry in pairs(allStats) do
        table.insert(sortedList, {
          func = func,
          count = entry.count,
          totalTime = entry.totalTime,
          firstTime = entry.firstTime,
          minTime = entry.minTime,
          maxTime = entry.maxTime,
          avgTime = entry.totalTime / entry.count
        })
      end
      table.sort(sortedList, function(a, b)
        return a.avgTime > b.avgTime
      end)
      for _, item in ipairs(sortedList) do
        table.insert(lines, string.format("| %s | %d | %.2f | %.2f | %.2f | %.2f | %.2f |", item.func, item.count, item.avgTime * 1000, item.minTime * 1000, item.maxTime * 1000, item.totalTime * 1000, item.firstTime * 1000))
      end
    else
      table.insert(lines, "| - | - | - | - | - | - | - |")
    end
  end
  do return table.concat, lines end
  return table.concat, lines, "\n", pairs(typeNames)
end

function NetworkProfilerView:_UpdateSortType(sortType)
  self._currentSortIndex = sortType
  self:_RefreshStatsList()
  self:_RefreshSortToggles()
end

function NetworkProfilerView:_RefreshSortOrder()
  self:SetZ1Toggle(self.ui.Toggle_SortType, self._ascending, true)
  self:SetZ1ToggleText(self.ui.Toggle_SortType, self._ascending and "升序" or "降序")
end

function NetworkProfilerView:_OnInputFieldValueChanged(value)
  self._filterText = value and string.lower(value) or nil
  self:_RefreshStatsList()
end

function NetworkProfilerView:_OnClickClear()
  NetworkProfiler.ClearAll()
  self:_RefreshStatsList()
end

return NetworkProfilerView
