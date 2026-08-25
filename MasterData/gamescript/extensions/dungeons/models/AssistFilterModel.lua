local AssistFilterModel, Super = NewClass("AssistFilterModel", BaseModel)
local AwakerMapFilterParam = {select = 1, diselect = 2}

function AssistFilterModel:OnInit()
  self:OnReset()
end

function AssistFilterModel:OnReset()
  self.school = 0
  self.filter = AwakerMapFilterParam.diselect
  self.wholeList = {}
  self.allAssistAwakerList = {}
  self.selectList = nil
  self:_RebuildWholeList()
  for _, awakerTidList in pairs(self.wholeList) do
    for _, awakerTid in ipairs(awakerTidList) do
      self.allAssistAwakerList[awakerTid] = false
    end
  end
end

function AssistFilterModel:_RebuildWholeList()
  self.wholeList = {}
  for awakerTid, awakerCfg in pairs(DT.AwakerConfig) do
    if not awakerCfg.OpenDate or TimeUtils.GetServerTime() >= awakerCfg.OpenDate then
      if not self.wholeList[awakerCfg.School] then
        self.wholeList[awakerCfg.School] = {}
      end
      table.insert(self.wholeList[awakerCfg.School], awakerTid)
    end
  end
end

function AssistFilterModel:RefreshOnPanelOpen()
  self:ResetWholeList(true)
end

function AssistFilterModel:ResetWholeList(silent)
  self.showList = nil
  self:_RebuildWholeList()
  for _, awakerTidList in pairs(self.wholeList) do
    for _, awakerTid in ipairs(awakerTidList) do
      if nil == self.allAssistAwakerList[awakerTid] then
        self.allAssistAwakerList[awakerTid] = false
        if self.selectList then
          self.selectList[awakerTid] = DT.AwakerConfig[awakerTid].School
        end
      end
    end
  end
  if not silent then
    self:LocalNotify(NotifyId.OnAssistFilterListChange)
  end
end

function AssistFilterModel:ReqFilter(stateList)
  local ret = {}
  if stateList then
    for _, awakerTidList in pairs(self.wholeList) do
      for _, awakerTid in ipairs(awakerTidList) do
        if not stateList[awakerTid] then
          ret[awakerTid] = DT.AwakerConfig[awakerTid].School
          self.allAssistAwakerList[awakerTid] = false
        else
          self.allAssistAwakerList[awakerTid] = true
        end
      end
    end
    self.selectList = ret
  else
    self:ResetSelect()
  end
  if not self.selectList then
    self:ResetSelect()
  end
  return self.selectList
end

function AssistFilterModel:GetAwakerMapFilter()
  return self.filter
end

function AssistFilterModel:GetAwakerFilterMap(filter)
  local ret = {}
  if not self.selectList then
    self:ResetSelect()
  end
  for _, awakerTidList in pairs(self.wholeList) do
    for _, awakerTid in ipairs(awakerTidList) do
      if self.selectList[awakerTid] and filter == AwakerMapFilterParam.select or not self.selectList[awakerTid] and filter == AwakerMapFilterParam.diselect then
        ret[awakerTid] = 1
      end
    end
  end
  return ret
end

function AssistFilterModel:GetSelectedAwakerCount()
  local ret = 0
  for _, selectSchool in pairs(self.selectList) do
    if 0 == self.school or selectSchool == self.school then
      ret = ret + 1
    end
  end
  return ret
end

function AssistFilterModel:GetAllSelectAssistAwakerCount()
  local allAssistAwakerCount = table.length(self.allAssistAwakerList)
  local selectedAwakerCount = 0
  for _, AwakerSelectState in pairs(self.allAssistAwakerList) do
    if not AwakerSelectState then
      selectedAwakerCount = selectedAwakerCount + 1
    end
  end
  return allAssistAwakerCount, selectedAwakerCount
end

function AssistFilterModel:IsFliterAssistAwaker()
  local allAssistAwakerCount, selectedAwakerCount = self:GetAllSelectAssistAwakerCount()
  return allAssistAwakerCount ~= selectedAwakerCount
end

function AssistFilterModel:GetSelectList()
  if 0 == self.school then
    return self.selectList
  end
  local ret = {}
  for selectAwakerTid, selectSchool in pairs(self.selectList) do
    if selectSchool == self.school then
      ret[selectAwakerTid] = selectSchool
    end
  end
  return ret
end

local qualitySortFeq = {
  UR = 1,
  Orange = 2,
  Purple = 3
}
local SchoolSortFeq = {
  1,
  3,
  4,
  2
}

function AssistFilterModel:GetWholeList()
  if self.showList and self.showList[self.school] then
    return self.showList[self.school]
  end
  local ret = {}
  for school, awakerTidList in pairs(self.wholeList) do
    if 0 == self.school or self.school == school then
      for _, awakerTid in ipairs(awakerTidList) do
        table.insert(ret, awakerTid)
      end
    end
  end
  table.sort(ret, function(a, b)
    local aCfg = DT.AwakerConfig[a]
    local bCfg = DT.AwakerConfig[b]
    local aQual = qualitySortFeq[aCfg.Quality]
    local bQual = qualitySortFeq[bCfg.Quality]
    if aQual ~= bQual then
      return aQual < bQual
    end
    local aSch = SchoolSortFeq[aCfg.School]
    local bSch = SchoolSortFeq[bCfg.School]
    if aSch ~= bSch then
      return aSch < bSch
    end
    local aOpenT = aCfg.OpenDate or 0
    local bOpenT = bCfg.OpenDate or 0
    if aOpenT ~= bOpenT then
      return aOpenT > bOpenT
    end
    return DT.AwakerConfig[a].BaseSortID > DT.AwakerConfig[b].BaseSortID
  end)
  if not self.showList then
    self.showList = {}
  end
  self.showList[self.school] = ret
  return ret
end

function AssistFilterModel:GetIcon(awakerTid)
  local cfg = DT.AwakerConfig[awakerTid]
  local headIcon = cfg.Item_LittleIcon
  local qualityIcon = DT.ItemQuality[cfg.Quality].ItemQualityColor
  return headIcon, qualityIcon
end

function AssistFilterModel:ResetSelect()
  self.school = 0
  self.selectList = {}
  for _, awakerTidList in pairs(self.wholeList) do
    for _, awakerTid in ipairs(awakerTidList) do
      if self.allAssistAwakerList[awakerTid] then
        self.allAssistAwakerList[awakerTid] = false
      end
      self.selectList[awakerTid] = DT.AwakerConfig[awakerTid].School
    end
  end
  self:LocalNotify(NotifyId.OnAssistFilterListChange)
  return self.selectList
end

function AssistFilterModel:SetSchool(school)
  self.school = school
  self:LocalNotify(NotifyId.OnAssistFilterListChange)
end

function AssistFilterModel:ToggleSingleAwaker(awakerTid)
  if not awakerTid then
    return
  end
  if not self.selectList[awakerTid] then
    self.selectList[awakerTid] = DT.AwakerConfig[awakerTid].School
    self.allAssistAwakerList[awakerTid] = false
    return true
  else
    self.selectList[awakerTid] = nil
    self.allAssistAwakerList[awakerTid] = true
    return false
  end
end

function AssistFilterModel:_SetSingleAwaker(awakerTid, isOn)
  if not awakerTid then
    return
  end
  if isOn and not self.selectList[awakerTid] then
    self.selectList[awakerTid] = DT.AwakerConfig[awakerTid].School
    self.allAssistAwakerList[awakerTid] = false
  elseif not isOn and self.selectList[awakerTid] then
    self.selectList[awakerTid] = nil
    self.allAssistAwakerList[awakerTid] = true
  end
end

function AssistFilterModel:ToggleSelectAll()
  self:GetWholeList()
  local isOn = 0 == self:GetSelectedAwakerCount(self.school)
  for _, awakerTid in pairs(self.showList[self.school]) do
    self:_SetSingleAwaker(awakerTid, isOn)
  end
  self:LocalNotify(NotifyId.OnAssistFilterListChange)
end

function AssistFilterModel:SaveFilter()
  local ret = {}
  local diselCount = 0
  local selCount = 0
  for _, awakerTidList in pairs(self.wholeList) do
    for _, awakerTid in ipairs(awakerTidList) do
      if self.selectList[awakerTid] then
        ret[awakerTid] = false
        selCount = selCount + 1
      else
        ret[awakerTid] = true
        diselCount = diselCount + 1
      end
    end
  end
  self.filter = selCount > diselCount and AwakerMapFilterParam.diselect or AwakerMapFilterParam.select
  ProtoManager.Instance:ReqServer("GameRequest", "OnAssistFilter", function(data)
    Logger.Info("========== 上传助战筛选列表成功 ==========\n", table.tostring(data))
  end, function(data)
    Logger.Info("========== 上传助战筛选列表失败 ==========\n", table.tostring(data))
  end, ret)
end

return AssistFilterModel
