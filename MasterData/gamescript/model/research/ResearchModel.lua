local function modelState()
  local state = {}
  
  return state
end

local function modelView(_)
  local view = {}
  
  function view:GetFunctionList()
    local functionList = DT.GetOriginalConstant("HomeLand_FunList")
    return functionList
  end
  
  function view:GetFunctionCfgByIndex(index)
    local list = self:GetFunctionList()
    local funcId = list[index]
    local funcUnlockCfg = DT.FeatureUnlock[funcId]
    return funcUnlockCfg
  end
  
  function view:GetFunctionDataByFeature(feature, key)
    local tFunc = ResearchUtils.GetFeatureData(feature, key)
    return tFunc and tFunc or nil
  end
  
  return view
end

local function modelAction(data)
  local action = {}
  
  function action:SetContent(content)
    data.content = content
  end
  
  return action
end

local function onSetup(_, _)
end

do return Vue.model("ResearchModel", modelState):views(modelView):actions(modelAction).setup, (Vue.model("ResearchModel", modelState):views(modelView):actions(modelAction)) end
return Vue.model("ResearchModel", modelState):views(modelView):actions(modelAction).setup, Vue.model("ResearchModel", modelState):views(modelView):actions(modelAction), onSetup
