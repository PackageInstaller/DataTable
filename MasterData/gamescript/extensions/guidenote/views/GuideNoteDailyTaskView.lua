local TaskServerIndex = CommonDefine.TaskServerIndex
local ModuleType = GuideNoteDefine.ModuleType
local LevelType = GuideNoteDefine.LevelType
local ActivityItemConstKey = "GuideNoteDailyActivityItem"
local GuideNoteDailyTaskView, Super = NewClass("GuideNoteDailyTaskView", GuideNoteTaskViewBase)
GuideNoteDailyTaskView.uiResCls = "UI/UI_GuideNote/UI_GuideNote_Prefab/UI_GuideNote_Panel_Task.prefab"

function GuideNoteDailyTaskView:ctor()
  Super.ctor(self)
end

function GuideNoteDailyTaskView:_GetTaskServerIndex()
  return TaskServerIndex.Daily
end

function GuideNoteDailyTaskView:_GetRewardLevelType()
  return LevelType.Daily
end

function GuideNoteDailyTaskView:_GetSidebarModuleType()
  return ModuleType.DailyActivity
end

function GuideNoteDailyTaskView:_GetActivityItemTid()
  do return DT.GetConstant end
  return DT.GetConstant, ActivityItemConstKey
end

function GuideNoteDailyTaskView:_BuildLivenessRewardCfg()
  local cfg = {}
  local raw = DT.GetOriginalConstant("GuideNoteDailyActivityTierRewards", {})
  for i = 1, #raw, 2 do
    local need = raw[i]
    local rewards = raw[i + 1]
    if need then
      table.insert(cfg, {
        need = need,
        rewards = rewards or {}
      })
    end
  end
  return cfg
end

function GuideNoteDailyTaskView:_GetActivityItemTipExtraParam()
  return {posY = -400}
end

return GuideNoteDailyTaskView
