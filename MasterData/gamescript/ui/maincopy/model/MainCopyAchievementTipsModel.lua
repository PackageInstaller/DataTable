local function createMainCopyAchievementTipsState(stageGroupId)
  local state = {}
  
  function state.stageGroup()
    local rst = {}
    for _, stageData in ipairs(MainCopyDataUtils.GetStageList(stageGroupId)) do
      local stageCfg = DT.Stage[stageData.stageID]
      if stageCfg.LevelAchieve then
        table.insert(rst, stageData)
      end
    end
    return rst
  end
  
  return state
end

local function createMainCopyAchievementTipsViews(data)
  local views = {}
  return views
end

local function createMainCopyAchievementTipsActions(data)
  local actions = {}
  return actions
end

local function onSetup(binder, model)
end

local MainCopyAchievementTipsModel = Vue.model("MainCopyAchievementTipsModel", createMainCopyAchievementTipsState):views(createMainCopyAchievementTipsViews):actions(createMainCopyAchievementTipsActions):setup(onSetup)
return MainCopyAchievementTipsModel
