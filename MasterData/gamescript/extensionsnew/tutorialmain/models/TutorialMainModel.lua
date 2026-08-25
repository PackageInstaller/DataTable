local TutorialTabType = CommonDefine.TutorialTabType
local TutorialMainModel = NewClass("TutorialMainModel", BaseModel)

function TutorialMainModel:OnInit()
  self:OnReset()
end

function TutorialMainModel:OnReset()
  self._curSelectTutorialItemTid = nil
  self._inSearchingState = false
  self._curSelectTutorialTab = nil
  self._curPage = 1
  self._minPage = 1
  self._searchKeyStr = ""
  self._curShowItemGroup = {}
  self._jumpTidGroup = nil
end

function TutorialMainModel:SetJumpTidGroup(tidGroup)
  self._jumpTidGroup = tidGroup
end

function TutorialMainModel:GetJumpTidGroup()
  return self._jumpTidGroup
end

function TutorialMainModel:GetCurSelectTutorialItemTid()
  return self._curSelectTutorialItemTid
end

function TutorialMainModel:SetCurSelectTutorialItemTid(tid)
  if not tid then
    return
  end
  self._curSelectTutorialItemTid = tid
  self:SetCurPage(1)
end

function TutorialMainModel:IsInSearchingState()
  return self._inSearchingState
end

function TutorialMainModel:SetInSearchingState(value)
  if nil == value then
    return
  end
  self._inSearchingState = value
end

function TutorialMainModel:GetCurSelectTutorialTab()
  return self._curSelectTutorialTab
end

function TutorialMainModel:SetCurSelectTutorialTab(tabType)
  if not tabType then
    return
  end
  self._curSelectTutorialTab = tabType
  if self._curSelectTutorialItemTid and 1 == TutorialDataUtils.GetTutorialMaxPageByTid(self._curSelectTutorialItemTid) then
    TutorialDataUtils.ReqTutorialFinishRead(self._curSelectTutorialItemTid)
  end
  self:UpdateCurShowItemGroup()
  local firstItem = self._curShowItemGroup[1]
  self:SetCurSelectTutorialItemTid(firstItem and firstItem.tid or 0)
end

function TutorialMainModel:GetCurPage()
  return self._curPage
end

function TutorialMainModel:GetMinPage()
  return self._minPage
end

function TutorialMainModel:GetMaxPage()
  do return TutorialDataUtils.GetTutorialMaxPageByTid end
  return TutorialDataUtils.GetTutorialMaxPageByTid, self._curSelectTutorialItemTid
end

function TutorialMainModel:SetCurPage(page)
  if not page then
    return
  end
  page = math.min(page, self:GetMaxPage())
  page = math.max(page, self._minPage)
  self._curPage = page
end

function TutorialMainModel:GetSearchKeyStr()
  return self._searchKeyStr
end

function TutorialMainModel:SetSearchKeyStr(str)
  if not str then
    return
  end
  self._searchKeyStr = str
end

function TutorialMainModel:GetCurShowItemGroup()
  return self._curShowItemGroup
end

function TutorialMainModel:GetCurSelectTutorialItemShowIndex()
  local rst = 1
  if not self._curSelectTutorialItemTid then
    return rst
  end
  for idx, item in pairs(self._curShowItemGroup) do
    if item.tid == self._curSelectTutorialItemTid then
      return idx
    end
  end
  return rst
end

function TutorialMainModel:GetCurShowDesc()
  local tutorialCfg = TutorialDataUtils.GetConfigByTid(self._curSelectTutorialItemTid)
  if not tutorialCfg then
    return ""
  end
  local pageData = tutorialCfg.data_list[self._curPage]
  if not pageData then
    return ""
  end
  return pageData.Desc or ""
end

function TutorialMainModel:GetCurShowImage()
  local tutorialCfg = TutorialDataUtils.GetConfigByTid(self._curSelectTutorialItemTid)
  if not tutorialCfg then
    return ""
  end
  local pageData = tutorialCfg.data_list[self._curPage]
  if not pageData then
    return ""
  end
  return pageData.Picture or ""
end

function TutorialMainModel:GetShowTutorialTidGroups()
  local rst = {
    [TutorialTabType.All] = {}
  }
  for _, tutorialItemData in pairs(TutorialDataUtils.GetTutorialItemMap()) do
    local cfg = TutorialDataUtils.GetConfigByTid(tutorialItemData.tid)
    if cfg then
      table.insert(rst[TutorialTabType.All], tutorialItemData.tid)
      if not rst[cfg.Type] then
        rst[cfg.Type] = {}
      end
      table.insert(rst[cfg.Type], tutorialItemData.tid)
    end
  end
  return rst
end

function TutorialMainModel:GetShowTutorialTidGroup(tabType)
  local groups = self:GetShowTutorialTidGroups()
  return groups[tabType] or {}
end

function TutorialMainModel:GetShowTutorialTabGroup()
  local tabGroupData = {}
  local showTutorialTidGroups = self:GetShowTutorialTidGroups()
  local tabDataList = DT.Constant.TutorialTabType.Data
  for _, tabData in ipairs(tabDataList) do
    for groupType, _ in pairs(showTutorialTidGroups) do
      if groupType == tabData[1] then
        table.insert(tabGroupData, tabData)
      end
    end
  end
  return tabGroupData
end

function TutorialMainModel:UpdateCurShowItemGroup()
  local rst = {}
  local tmpGroup = self:GetShowTutorialTidGroups()[self._curSelectTutorialTab]
  if not tmpGroup then
    self._curShowItemGroup = rst
    return
  end
  local showTutorialTidGroup = {}
  if self._searchKeyStr == "" then
    showTutorialTidGroup = tmpGroup
  else
    local searchKey = string.lower(self._searchKeyStr)
    for _, tid in pairs(tmpGroup) do
      local cfg = TutorialDataUtils.GetConfigByTid(tid)
      local title = LT.Text(cfg.Title)
      local matched = false
      if StrUtils.SearchByKeyStr(searchKey, string.lower(title)) then
        matched = true
      else
        for _, subCfg in pairs(cfg.data_list) do
          if subCfg.Desc and StrUtils.SearchByKeyStr(self._searchKeyStr, string.lower(LT.Text(subCfg.Desc))) then
            matched = true
            break
          end
        end
      end
      if matched then
        table.insert(showTutorialTidGroup, tid)
      end
    end
  end
  local haveReadedGroup = {}
  local notReadedGroup = {}
  for _, tid in pairs(showTutorialTidGroup) do
    local tutorialItemData = TutorialDataUtils.GetTutorialItemDataByTid(tid)
    if tutorialItemData.state == CommonDefine.TutorialItemState.Done then
      table.insert(haveReadedGroup, tutorialItemData)
    elseif tutorialItemData.state == CommonDefine.TutorialItemState.Receive then
      table.insert(notReadedGroup, tutorialItemData)
    end
  end
  table.sort(notReadedGroup, function(a, b)
    if a.sortWeight and b.sortWeight then
      return a.sortWeight > b.sortWeight
    end
    return true
  end)
  table.sort(haveReadedGroup, function(a, b)
    local aCfg = TutorialDataUtils.GetConfigByTid(a.tid)
    local bCfg = TutorialDataUtils.GetConfigByTid(b.tid)
    local aSort = aCfg and aCfg.BaseSortID or 0
    local bSort = bCfg and bCfg.BaseSortID or 0
    return aSort < bSort
  end)
  table.move(notReadedGroup, 1, #notReadedGroup, #rst + 1, rst)
  table.move(haveReadedGroup, 1, #haveReadedGroup, #rst + 1, rst)
  self._curShowItemGroup = rst
end

function TutorialMainModel:GetToggleActiveState(tabType)
  local showTutorialTidGroup = self:GetShowTutorialTidGroup(tabType)
  for _, tid in pairs(showTutorialTidGroup) do
    local tutorialItemData = TutorialDataUtils.GetTutorialItemDataByTid(tid)
    if tutorialItemData.state == CommonDefine.TutorialItemState.Receive or tutorialItemData.state == CommonDefine.TutorialItemState.Done then
      return true
    end
  end
  return false
end

function TutorialMainModel:HasTabReceiveRed(tabType)
  local tutorialGroup = self:GetShowTutorialTidGroup(tabType)
  for _, tid in pairs(tutorialGroup) do
    local tutorialData = TutorialDataUtils.GetTutorialItemDataByTid(tid)
    if tutorialData.state == CommonDefine.TutorialItemState.Receive then
      return true
    end
  end
  return false
end

function TutorialMainModel:HasItemReceiveRed(tid)
  local tutorialData = TutorialDataUtils.GetTutorialItemDataByTid(tid)
  return tutorialData and tutorialData.state == CommonDefine.TutorialItemState.Receive or false
end

return TutorialMainModel
