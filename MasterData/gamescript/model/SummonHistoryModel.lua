local function createSummonHistoryPanelState()
  local state = {}
  
  state.onePageShowNum = 5
  state.curPageNum = 1
  state.minPageNum = 1
  
  function state.maxPageNum()
    local rst = SummonDataUtils.GetSummonHistoryCount(state.curSummonType)
    if not rst or 0 == rst then
      rst = 1
      return rst
    end
    do return math.ceil end
    return math.ceil, rst / state.onePageShowNum
  end
  
  state.curSummonType = table.deepclone(SummonDataUtils.GetLastSummonType())
  state.curShowItemGroup = {}
  state.summonTypeList = DT.Constant.SummonRecordTypeSelectList.Data
  state.showTypeList = false
  return state
end

local function createSummonHistoryPanelViews(_)
  local views = {}
  return views
end

local function createSummonHistoryPanelActions(data)
  local actions = {}
  
  function actions.SetShowTypeList(boolVal)
    if nil == boolVal then
      Logger.Error("Error boolVal ", boolVal)
      return
    end
    data.showTypeList = boolVal
  end
  
  function actions.SetCurSummonType(numVal)
    if not numVal then
      Logger.Error("Error numVal ", numVal)
      return
    end
    data.curSummonType = numVal
    data.SetCurPageNum(1)
  end
  
  function actions.SetCurPageNum(numVal)
    if not numVal then
      Logger.Error("Error numVal ", numVal)
      return
    end
    numVal = math.min(numVal, data.maxPageNum)
    numVal = math.max(numVal, data.minPageNum)
    data.curPageNum = numVal
  end
  
  function actions.SetCurShowItemGroup(tblVal)
    if not tblVal then
      Logger.Error("Error numVal ", tblVal)
      return
    end
    data.curShowItemGroup = tblVal
  end
  
  return actions
end

local function onSetup(_, _)
end

local SummonHistoryModel = Vue.model("SummonHistoryModel", createSummonHistoryPanelState):views(createSummonHistoryPanelViews):actions(createSummonHistoryPanelActions):setup(onSetup)
return SummonHistoryModel
