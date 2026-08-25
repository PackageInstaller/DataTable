local function modelState()
  local state = {}
  
  function state.skillList()
    local list = {}
    return list
  end
  
  return state
end

local function modelView(data)
  local view = {}
  
  function view:GetCurSchoolId()
    return data.curSchoolId
  end
  
  return view
end

local function modelAction(data)
  local action = {}
  
  function action:SetCurSchoolId()
  end
  
  return action
end

local function onSetup(_, _)
end

do return Vue.model("AssistAwakerModel", modelState):views(modelView):actions(modelAction).setup, (Vue.model("AssistAwakerModel", modelState):views(modelView):actions(modelAction)) end
return Vue.model("AssistAwakerModel", modelState):views(modelView):actions(modelAction).setup, Vue.model("AssistAwakerModel", modelState):views(modelView):actions(modelAction), onSetup
