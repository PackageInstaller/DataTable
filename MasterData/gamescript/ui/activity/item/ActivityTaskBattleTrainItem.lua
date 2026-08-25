local ActivityTaskBattleTrainItem, Super = System.NewComponent("ActivityTaskBattleTrainItem", ActivityTaskBaseItem)

function ActivityTaskBattleTrainItem:ctor(res, taskData, activityData)
  Super.ctor(self, taskData, activityData)
  self.ui = UI_Events_Item_BattleTeachingResource(res)
end

function ActivityTaskBattleTrainItem:_OnClickJumpBtn()
end

function ActivityTaskBattleTrainItem:_GetTaskName()
  do return LT.Text end
  return LT.Text, self.taskConfig.Name
end

function ActivityTaskBattleTrainItem:_GetTaskDesc()
  do return LT.Text end
  return LT.Text, self.taskConfig.Desc
end

return ActivityTaskBattleTrainItem
