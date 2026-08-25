local function createPublicKeyWordTipItemModelState(desc)
  local state = {}
  
  state.desc = desc
  return state
end

local function createPublicKeyWordTipItemModelViews(data)
  local views = {}
  return views
end

local function createPublicKeyWordTipItemModelActions(data)
  local actions = {}
  return actions
end

local function onSetup(binder, model)
end

local PublicKeyWordTipItemModel = Vue.model("PublicKeyWordTipItemModel", createPublicKeyWordTipItemModelState):views(createPublicKeyWordTipItemModelViews):actions(createPublicKeyWordTipItemModelActions):setup(onSetup)
return PublicKeyWordTipItemModel
