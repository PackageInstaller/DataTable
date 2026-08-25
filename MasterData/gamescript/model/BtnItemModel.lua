local function createBtnItemModelState(btnItemData)
  local state = {}
  
  state.btnItemData = btnItemData
  return state
end

local function createBtnItemModelViews(data)
  local views = {}
  return views
end

local function createBtnItemModelActions(data)
  local actions = {}
  return actions
end

local function onSetup(binder, model)
end

local BtnItemModel = Vue.model("BtnItemModel", createBtnItemModelState):views(createBtnItemModelViews):actions(createBtnItemModelActions):setup(onSetup)
return BtnItemModel
