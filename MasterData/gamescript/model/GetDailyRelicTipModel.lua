local tableInsert = table.insert
local tableSort = table.sort

local function createGetDailyRelicTipModelState(relicList, title)
  local state = {}
  state.relicList = relicList
  state.titleStr = title
  return state
end

local function createGetDailyRelicTipModelViews(data)
  local views = {}
  
  function views:GetTextDesc()
    return data.titleStr or LT.Text("DailyChallengeTodayRelicGetTitle")
  end
  
  function views:GetChanllengeBtnText()
    local chanllengeBtnText = LT.Text("DailyChallengeTodayRelicGetConfirmButton")
    chanllengeBtnText = chanllengeBtnText or ""
    return chanllengeBtnText
  end
  
  function views:GetRelicList()
    return data.relicList
  end
  
  return views
end

local function createGetDailyRelicTipModelActions(data)
  local actions = {}
  return actions
end

local function onSetup(binder, model)
end

local GetDailyRelicTipModel = Vue.model("GetDailyRelicTipModel", createGetDailyRelicTipModelState):views(createGetDailyRelicTipModelViews):actions(createGetDailyRelicTipModelActions):setup(onSetup)
return GetDailyRelicTipModel
