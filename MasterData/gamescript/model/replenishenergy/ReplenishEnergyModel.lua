local function modelState()
  local state = {}
  
  state.itemId2ExchangeType = {}
  state.FrequencyDesc = ""
  state.PromptDesc = ""
  state.curSelectCfgId = 0
  return state
end

local function modelView(data)
  local views = {}
  
  function views:GetExchangeDescType(itemCfgID)
    return data.itemId2ExchangeType[itemCfgID]
  end
  
  function views:GetFrequencyDesc()
    return data.FrequencyDesc
  end
  
  function views:GetPromptDesc()
    return data.PromptDesc
  end
  
  function views:GetCurSelectCfgId()
    return data.curSelectCfgId
  end
  
  return views
end

local function modelAction(data)
  local actions = {}
  
  function actions:SetExchangeDescIndex(itemCfgID, exchangeType)
    data.itemId2ExchangeType[itemCfgID] = exchangeType
  end
  
  function actions:SetFrequencyDesc(desc)
    data.FrequencyDesc = desc
  end
  
  function actions:SetPromptDesc(desc)
    data.PromptDesc = desc
  end
  
  function actions:SetCurSelectCfgId(tid)
    data.curSelectCfgId = tid
  end
  
  return actions
end

local function onSetup(_, _)
end

do return Vue.model("ReplenishEnergyModel", modelState):views(modelView):actions(modelAction).setup, (Vue.model("ReplenishEnergyModel", modelState):views(modelView):actions(modelAction)) end
return Vue.model("ReplenishEnergyModel", modelState):views(modelView):actions(modelAction).setup, Vue.model("ReplenishEnergyModel", modelState):views(modelView):actions(modelAction), onSetup
