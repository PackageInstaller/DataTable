local ActivityBattleTeachingTaskListComp, Super = System.NewClass("ActivityBattleTeachingTaskListComp", ActivityTaskListComp)

function ActivityBattleTeachingTaskListComp:_OnBindActivityPlot()
end

function ActivityBattleTeachingTaskListComp:_InitUIResource(res)
  self.ui = UI_Events_BattleTeachingResource(res)
end

function ActivityBattleTeachingTaskListComp:_OnBindEvent(binder)
  binder:BindEvent(EventMgr.Instance.OnActivityTaskComplete, System.fn(self, self._RefreshTaskTableView))
end

function ActivityBattleTeachingTaskListComp:_OnBindTaskListView()
  local baseGameObj = self.ui.UI_Events_Item_CombatTraining
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.taskTableView = self:CreateTableview(self.ui.TaskView, function()
    return #(self:_GetTaskList() or {})
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local taskData = self:_GetTaskList()[idx]
    itemComps[gameObj] = self.binder:BindComponent(ActivityTaskBattleTeachingItem(gameObj, taskData, self.activityData))
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
  self:_RefreshTaskTableView()
end

function ActivityBattleTeachingTaskListComp:_RefreshTaskTableView()
  self.taskTableView:ReloadData()
end

function ActivityBattleTeachingTaskListComp:OnOpenAnim(callback)
  self:PlayTableViewFadeInAnim(self.ui.TaskView)
  self.uiAnimController:PlayState("UI_Events_Panel_SurveyDiary_Open", callback)
end

function ActivityBattleTeachingTaskListComp:OnCloseAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_SurveyDiary_Close", callback)
end

return ActivityBattleTeachingTaskListComp
