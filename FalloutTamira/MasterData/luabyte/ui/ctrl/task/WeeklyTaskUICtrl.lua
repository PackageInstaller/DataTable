local WeeklyTaskUICtrl = BaseClass("WeeklyTaskUICtrl")
local M = WeeklyTaskUICtrl

function M:__init(view)
    self._view = view

    local activityCtrl = require("UI.Ctrl.Task.WeeklyActivityItemCtrl")
    local activityView = require("UI.View.Task.WeeklyActivityItemView")
    self._view.activityScrollView:Init(activityCtrl, activityView)

    local taskCtrl = require("UI.Ctrl.Task.WeeklyListItemCtrl")
    local taskView = require("UI.View.Task.WeeklyListItemView")
    self._view.listScrollView:Init(taskCtrl, taskView)

    self._view.togReceiveAll:onClick(Bind(self, self.OnReceiveAll))
    self._taskRefreshCallback = EventMgr:AddListener(UIMessageNames.TASK_TYPE_REFRESH, 
        Bind(self, self.OnTaskRefresh))
    self._activityRefreshCallback = EventMgr:AddListener(UIMessageNames.TASK_AWARD_REFRESH, 
        Bind(self, self.OnActivityRefresh))

    local taskActiveCfgs = ConfigHelper.GetCfgsByLua("taskActive", {type = 2})
    self._maxValue = taskActiveCfgs[#taskActiveCfgs].activeValue

    self._increment = TaskDataMgr:GetWeeklyActivitiesUpperLimitMaxValue()
end

function M:Open()
    self:_SetMaxActivityValue()
    self:_RefreshTasks()
    self:_RefreshActivities()
    self:_UpdateActivityValue()
    self:_SetAllReceiveActive()
end

function M:OnReceiveAll()
    if self._view.togReceiveAll:GetInteractable() then
        local taskIds = TaskDataMgr:GetRewardTaskIdsByType(TaskConst.TaskType.Weekly)
        local hasActivityAward = TaskDataMgr:HasActivityAward(TaskConst.TaskType.Weekly)
        if taskIds then
            if hasActivityAward then
                TaskDataMgr:RequestActivityAwards(TaskConst.EACTType.EACT_Weekly)
            else
                TaskDataMgr:RequestCompleteTasks(taskIds, hasActivityAward)
            end
        else
            if hasActivityAward then
                TaskDataMgr:RequestActivityAwards(TaskConst.EACTType.EACT_Weekly)
            end
        end
    end
end

function M:OnTaskRefresh(type)
    if type == TaskConst.TaskType.Weekly and self._view.rectWeeklyPanel.gameObject.activeInHierarchy then
        self:_RefreshTasks()
        self:_RefreshActivities()
        self:_UpdateActivityValue()
        self:_SetAllReceiveActive()
    end
end

function M:OnActivityRefresh(type)
    if type == TaskConst.EACTType.EACT_Weekly and self._view.rectWeeklyPanel.gameObject.activeInHierarchy then
        self:_RefreshActivities()
        self:_SetAllReceiveActive()
    end
end

function M:_RefreshTasks()
    --设置下侧任务列表数据
    local listDatas = TaskDataMgr:GetUnLockTasksDataByType(TaskConst.TaskType.Weekly)
    self._view.listScrollView:SetDataList(listDatas)
end

function M:_SetAllReceiveActive()
    --是否有可领取奖励数据
    local hasTaskData = TaskDataMgr:HasRewardTaskDatasByType(TaskConst.TaskType.Weekly)
    local hasActivityData = TaskDataMgr:HasActivityAward(TaskConst.TaskType.Weekly)

    if hasTaskData or hasActivityData then
        self._view.togReceiveAllState:SetState(1)
    else
        self._view.togReceiveAllState:SetState(2)
    end
end

function M:_RefreshActivities()
    -- --设置上侧活动点数数据
    local activityDatas = TaskDataMgr:GetWeeklyActivitiesData()
    self._view.activityScrollView:SetDataList(activityDatas)
end

function M:_SetMaxActivityValue()
    self._increment = TaskDataMgr:GetWeeklyActivitiesUpperLimitMaxValue()
    self._view.txtMaxValue:SetText(tostring(self._maxValue+self._increment))
end

function M:_UpdateActivityValue()
    local cycleType = protocol.ECycleEvent.ECET_Weekly_Task
    local cycleData = CycleDataMgr:GetInstance():GetCycleDataByType(cycleType)
    local curValue = cycleData:GetField0()
    self._increment = TaskDataMgr:GetWeeklyActivitiesUpperLimitMaxValue()
    curValue = curValue > (self._maxValue+self._increment) and (self._maxValue+self._increment) or curValue 
    self._view.txtCurValue:SetText(curValue .. "/")
    
    self:_SetMaxActivityValue()

    local activityDatas = TaskDataMgr:GetWeeklyActivitiesData()
    local singleProcess = 1/#activityDatas
    local level =1

    for i=#activityDatas,1,-1 do
        if curValue<=(activityDatas[i].value + activityDatas[i].increment) then
            level = i
        end
    end

    local progress =singleProcess * (level-1) + 0.5 *singleProcess --curValue / (activityDatas[level].value+self._increment) * singleProcess * level
    self._view.imgFgProgress:SetFillAmount(progress)
    self._view.imgBgProgress:SetFillAmount(1 - progress)
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.TASK_TYPE_REFRESH, self._taskRefreshCallback)
    EventMgr:RemoveListener(UIMessageNames.TASK_AWARD_REFRESH, self._activityRefreshCallback)

    
    self._view.activityScrollView:Dispose()
    self._view.activityScrollView = nil

    self._view.listScrollView:Dispose()
    self._view.listScrollView = nil

    self._view.togReceiveAll:onClick(nil)
    self._maxValue = nil

    self._view:OnDispose()
    self._view = nil
end

return WeeklyTaskUICtrl
