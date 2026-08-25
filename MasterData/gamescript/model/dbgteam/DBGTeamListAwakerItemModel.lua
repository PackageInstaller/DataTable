local function createDBGTeamListAwakerItemModel(tid, level)
  local state = {}
  
  state.level = level
  state.tid = tid
  state.config = DT.AwakerConfig[state.tid]
  state.quality = state.config and state.config.Quality or nil
  return state
end

local function createDBGTeamListAwakerItemModelViews(data)
  local views = {}
  return views
end

local function createDBGTeamListAwakerItemModelActions(data)
  local actions = {}
  return actions
end

local function onSetup(binder, model)
end

local DBGTeamListAwakerItemModel = Vue.model("DBGTeamListAwakerItemModel", createDBGTeamListAwakerItemModel):views(createDBGTeamListAwakerItemModelViews):actions(createDBGTeamListAwakerItemModelActions):setup(onSetup)
return DBGTeamListAwakerItemModel
