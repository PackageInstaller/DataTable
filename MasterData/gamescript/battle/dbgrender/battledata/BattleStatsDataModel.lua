local function createBattleStatsDataModelState()
  local data = {}
  
  data.isInit = false
  return data
end

local function createBattleStatsDataModelViews(_)
  local views = {}
  return views
end

local function createBattleStatsDataModelActions(data)
  local actions = {}
  
  function actions:InitData(statsData)
    data.isInit = true
    for k, v in pairs(statsData) do
      data[k] = v
    end
  end
  
  return actions
end

local function onSetup(_, _)
end

local BattleStatsDataModel = Vue.model("BattleStatsDataModel", createBattleStatsDataModelState):views(createBattleStatsDataModelViews):actions(createBattleStatsDataModelActions):setup(onSetup)
return BattleStatsDataModel
