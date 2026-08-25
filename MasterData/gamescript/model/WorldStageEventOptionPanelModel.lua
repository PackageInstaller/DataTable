local function createWorldStageEventOptionPanelState(optionDisplayList)
  local state = {}
  
  state.curShowIdx = 1
  state.optionDisplayList = optionDisplayList
  
  function state.curShowData()
    return state.optionDisplayList[state.curShowIdx]
  end
  
  function state.curShowType()
    local cfgName = state.GetCfgName()
    local argList = state.GetArgList()
    if cfgName == CommonDefine.DisplayType.Skill then
      return CommonDefine.WorldEventOptionType.DisplayCardList
    elseif 1 == #argList then
      return CommonDefine.WorldEventOptionType.DisplayPanel
    end
    return CommonDefine.WorldEventOptionType.DisplayListPanel
  end
  
  return state
end

local function createWorldStageEventOptionPanelViews(data)
  local views = {}
  
  function views.GetCfgName()
    return data.curShowData.cfgName
  end
  
  function views.GetArgList()
    return data.curShowData.content
  end
  
  return views
end

local function createWorldStageEventOptionPanelActions(data)
  local actions = {}
  
  function actions.SetCurShowIdx(numVal)
    if not numVal then
      return
    end
    if 0 == numVal then
      numVal = #data.optionDisplayList
    elseif numVal == #data.optionDisplayList + 1 then
      numVal = 1
    end
    data.curShowIdx = numVal
  end
  
  return actions
end

local function onSetup(binder, model)
end

local WorldStageEventOptionPanelModel = Vue.model("WorldStageEventOptionPanelModel", createWorldStageEventOptionPanelState):views(createWorldStageEventOptionPanelViews):actions(createWorldStageEventOptionPanelActions):setup(onSetup)
return WorldStageEventOptionPanelModel
