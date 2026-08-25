local function createComChanllengeResonanceItemModelState(resonanceTid)
  local state = {}
  
  state.resonanceTid = resonanceTid
  state.resonanceText = ""
  state.imageIcon = ""
  state.resonanceDesc = ""
  return state
end

local function createComChanllengeResonanceItemModelViews(data)
  local views = {}
  return views
end

local function createComChanllengeResonanceItemModelActions(data)
  local actions = {}
  
  function actions:SetResonanceTid(resonanceTid)
    data.resonanceTid = resonanceTid
    data.resonanceText = ""
    data.imageIcon = ""
    data.resonanceDesc = ""
  end
  
  return actions
end

local function onSetup(binder, model)
end

local ComChanllengeResonanceItemModel = Vue.model("ComChanllengeResonanceItemModel", createComChanllengeResonanceItemModelState):views(createComChanllengeResonanceItemModelViews):actions(createComChanllengeResonanceItemModelActions):setup(onSetup)
return ComChanllengeResonanceItemModel
