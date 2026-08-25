local TaskServerIndex = CommonDefine.TaskServerIndex
local ModuleType = GuideNoteDefine.ModuleType
local LevelType = GuideNoteDefine.LevelType
local ActivityItemConstKey = "GuideNoteWeeklyActivityItem"
local TierRewardConstKey = "GuideNoteWeeklyActivityTierRewards"
local GuideNoteWeeklyTaskView, Super = NewClass("GuideNoteWeeklyTaskView", GuideNoteTaskViewBase)
GuideNoteWeeklyTaskView.uiResCls = "UI/UI_GuideNote/UI_GuideNote_Prefab/UI_GuideNote_Panel_Task.prefab"

function GuideNoteWeeklyTaskView:ctor()
  Super.ctor(self)
end

function GuideNoteWeeklyTaskView:_GetTaskServerIndex()
  return TaskServerIndex.Weekly
end

function GuideNoteWeeklyTaskView:_GetRewardLevelType()
  return LevelType.Weekly
end

function GuideNoteWeeklyTaskView:_GetSidebarModuleType()
  return ModuleType.WeeklyActivity
end

function GuideNoteWeeklyTaskView:_GetActivityItemTid()
  do return DT.GetConstant end
  return DT.GetConstant, ActivityItemConstKey
end

function GuideNoteWeeklyTaskView:_BuildLivenessRewardCfg()
  local cfg = {}
  local raw = DT.GetOriginalConstant(TierRewardConstKey, {})
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

function GuideNoteWeeklyTaskView:_BuildSidebarTierRewardCfg()
  local cfg = {}
  local raw = DT.Constant[TierRewardConstKey] and DT.Constant[TierRewardConstKey].Data or {}
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

return GuideNoteWeeklyTaskView
