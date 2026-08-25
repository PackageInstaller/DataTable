local function createModelState()
  local state = {}
  
  function state.stageGroupList()
  end
  
  return state
end

local function createModelView(data)
  local views = {}
  
  function views:GetStageList(copyId)
    do return CopyDataUtils.GetStageList end
    return CopyDataUtils.GetStageList, copyId
  end
  
  function views:GetStageGroupList()
    return data.stageGroupList
  end
end

local function createModelAction()
end

local function onSetup(binder, model)
end

do return Vue.model("WeekChallengeModel", createModelState):views(createModelView):actions(createModelAction).setup, (Vue.model("WeekChallengeModel", createModelState):views(createModelView):actions(createModelAction)) end
return Vue.model("WeekChallengeModel", createModelState):views(createModelView):actions(createModelAction).setup, Vue.model("WeekChallengeModel", createModelState):views(createModelView):actions(createModelAction), onSetup
