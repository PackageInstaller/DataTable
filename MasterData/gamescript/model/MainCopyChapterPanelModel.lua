local function createMainCopyChapterPanelState()
  local state = {}
  
  return state
end

local function createMainCopyChapterPanelViews(data)
  local views = {}
  return views
end

local function createMainCopyChapterPanelActions(data)
  local actions = {}
  return actions
end

local function onSetup(binder, model)
end

local MainCopyChapterPanelModel = Vue.model("MainCopyChapterPanelModel", createMainCopyChapterPanelState):views(createMainCopyChapterPanelViews):actions(createMainCopyChapterPanelActions):setup(onSetup)
return MainCopyChapterPanelModel
