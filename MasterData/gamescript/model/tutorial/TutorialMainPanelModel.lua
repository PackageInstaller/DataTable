local TutorialItemState = CommonDefine.TutorialItemState
local TutorialTabType = CommonDefine.TutorialTabType

local function createTutorialMainPanelState(jumpTab)
  local state = {}
  state.curSelectTutorialItemTid = nil
  state.inSearchingState = false
  
  function state.curSelectTutorialItemShowIndex()
    local rst = 1
    if not state.curSelectTutorialItemTid then
      return rst
    end
    for idx, item in pairs(state.curShowItemGroup) do
      if item.tid == state.curSelectTutorialItemTid then
        rst = idx
        break
      end
    end
    return rst
  end
  
  state.curSelectTutorialTab = nil
  state.curPage = 1
  state.minPage = 1
  
  function state.maxPage()
    do return TutorialDataUtils.GetTutorialMaxPageByTid end
    return TutorialDataUtils.GetTutorialMaxPageByTid, state.curSelectTutorialItemTid
  end
  
  state.searchKeyStr = ""
  
  function state.curShowDesc()
    local rst = ""
    local tutorialCfg = TutorialDataUtils.GetConfigByTid(state.curSelectTutorialItemTid)
    if not tutorialCfg then
      return rst
    end
    rst = tutorialCfg.data_list[state.curPage].Desc or nil
    return rst
  end
  
  function state.curShowImage()
    local rst = ""
    local tutorialCfg = TutorialDataUtils.GetConfigByTid(state.curSelectTutorialItemTid)
    if not tutorialCfg then
      return rst
    end
    rst = tutorialCfg.data_list[state.curPage].Picture or nil
    return rst
  end
  
  function state.showTutorialTidGroups()
    local rst = {
      [TutorialTabType.All] = {}
    }
    for tid, tutorialItemData in pairs(TutorialDataUtils.GetTutorialItemMap()) do
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
  
  function state.showTutorialTabGroup()
    local tabGroupData = {}
    local showTutorialTidGroups = state.showTutorialTidGroups
    local tabDataList = DT.Constant.TutorialTabType.Data
    for _, tabData in ipairs(tabDataList) do
      for groupType, group in pairs(showTutorialTidGroups) do
        if groupType == tabData[1] then
          table.insert(tabGroupData, tabData)
        end
      end
    end
    return tabGroupData
  end
  
  state.curShowItemGroup = {}
  return state
end

local function createTutorialMainPanelViews(data)
  local views = {}
  return views
end

local function createTutorialMainPanelActions(data)
  local actions = {}
  
  function actions:SwitchNextItem()
    if data.curSelectTutorialItemShowIndex == #data.curShowItemGroup then
      return
    end
    local nextItem = data.curShowItemGroup[data.curSelectTutorialItemShowIndex + 1]
    self:SetCurSelectTutorialItemTid(nextItem.tid)
  end
  
  function actions:SwitchLastItem()
    if 1 == data.curSelectTutorialItemShowIndex then
      return
    end
    local nextItem = data.curShowItemGroup[data.curSelectTutorialItemShowIndex - 1]
    self:SetCurSelectTutorialItemTid(nextItem.tid)
  end
  
  function actions:SetCurSelectTutorialItemTid(numVal)
    if not numVal then
      return
    end
    data.curSelectTutorialItemTid = numVal
    self:SetCurPage(1)
  end
  
  function actions:SetCurSelectTutorialTab(val)
    if not val then
      return
    end
    data.curSelectTutorialTab = val
    if data.curSelectTutorialItemTid and 1 == TutorialDataUtils.GetTutorialMaxPageByTid(data.curSelectTutorialItemTid) then
      TutorialDataUtils.ReqTutorialFinishRead(data.curSelectTutorialItemTid)
    end
    data:UpdateCurShowItemGroup()
    self:SetCurSelectTutorialItemTid(data.curShowItemGroup[1] and data.curShowItemGroup[1].tid or 0)
  end
  
  function actions:SetSearchKeyStr(strVal)
    if not strVal then
      return
    end
    data.searchKeyStr = strVal
  end
  
  function actions:SetCurPage(numVal)
    if not numVal then
      return
    end
    numVal = math.min(numVal, data.maxPage)
    numVal = math.max(numVal, data.minPage)
    data.curPage = numVal
  end
  
  function actions:SetInSearchingState(boolVal)
    if nil == boolVal then
      return
    end
    data.inSearchingState = boolVal
  end
  
  function actions:UpdateCurShowItemGroup()
    local rst = {}
    local tmpGroup = data.showTutorialTidGroups[data.curSelectTutorialTab]
    if not tmpGroup then
      return rst
    end
    local showTutorialTidGroup = {}
    if data.searchKeyStr == "" then
      showTutorialTidGroup = tmpGroup
    else
      local searchKey = string.lower(data.searchKeyStr)
      for _, tid in pairs(tmpGroup) do
        local cfg = TutorialDataUtils.GetConfigByTid(tid)
        local title = LT.Text(cfg.Title)
        if StrUtils.SearchByKeyStr(searchKey, string.lower(title)) then
          table.insert(showTutorialTidGroup, tid)
        else
          for _, subCfg in pairs(cfg.data_list) do
            if subCfg.Desc and StrUtils.SearchByKeyStr(data.searchKeyStr, string.lower(LT.Text(subCfg.Desc))) then
              table.insert(showTutorialTidGroup, tid)
              goto lbl_77
            end
          end
        end
        ::lbl_77::
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
      local aTid, bTid = a.tid, b.tid
      local aCfg, bCfg = TutorialDataUtils.GetConfigByTid(aTid), TutorialDataUtils.GetConfigByTid(bTid)
      local aSort = aCfg and aCfg.BaseSortID or 0
      local bSort = bCfg and bCfg.BaseSortID or 0
      return aSort < bSort
    end)
    table.move(notReadedGroup, 1, #notReadedGroup, #rst + 1, rst)
    table.move(haveReadedGroup, 1, #haveReadedGroup, #rst + 1, rst)
    data.curShowItemGroup = rst
  end
  
  return actions
end

local function onSetup(_, _)
end

local TutorialMainPanelModel = Vue.model("TutorialMainPanelModel", createTutorialMainPanelState):views(createTutorialMainPanelViews):actions(createTutorialMainPanelActions):setup(onSetup)
return TutorialMainPanelModel
