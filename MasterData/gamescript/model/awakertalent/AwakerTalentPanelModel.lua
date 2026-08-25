local table_insert = table.insert

local function createAwakerTalentPanelState()
  local state = {}
  state.curTabType = nil
  state.curList = {}
  
  function state.allTalentList()
    do return end
    return TalentDataUtils.GetALLTalents, nil
  end
  
  return state
end

local function createAwakerTalentPanelViews(data)
  local views = {}
  
  function views:GetCurTabType()
    return data.curTabType
  end
  
  function views:GetCurList()
    return data.curList
  end
  
  function views:GetActiveNumStr()
    do return string.format, "%s/%s", TalentDataUtils.GetActiveNum(), tostring(#data.allTalentList) end
    return string.format, "%s/%s", TalentDataUtils.GetActiveNum(), tostring(#data.allTalentList)
  end
  
  return views
end

local function createAwakerTalentPanelActions(data)
  local actions = {}
  
  function actions:SetCurTabType(val)
    data.curTabType = val
    self:_UpdateCurList()
  end
  
  function actions:_UpdateCurList()
    local tempList = {}
    local curTabType = self:GetCurTabType()
    for _, talent in pairs(data.allTalentList) do
      if 0 == curTabType or talent.schoolId == curTabType then
        table_insert(tempList, talent)
      end
    end
    data.curList = tempList
  end
  
  return actions
end

local function onSetup(binder, model)
end

local AwakerTalentPanelModel = Vue.model("AwakerTalentPanelModel", createAwakerTalentPanelState):views(createAwakerTalentPanelViews):actions(createAwakerTalentPanelActions):setup(onSetup)
return AwakerTalentPanelModel
