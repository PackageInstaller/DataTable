local DailyTaskUICtrl = BaseClass("DailyTaskUICtrl")

local M = DailyTaskUICtrl

function M:__init(view)
    self._view = view

    local activityCtrl = require("UI.Ctrl.Task.DailyActivityItemCtrl")
    local activityView = require("UI.View.Task.DailyActivityItemView")
    self._view.activityScrollView:Init(activityCtrl, activityView)

    local tasksCtrl = require("UI.Ctrl.Task.DailyListItemCtrl")
    local tasksView = require("UI.View.Task.DailyListItemView")
    self._view.listScrollView:Init(tasksCtrl, tasksView)

    self._view.togReceiveAll:onClick(Bind(self, self.OnReceiveAll))
    
    self._taskRefreshCallback = EventMgr:AddListener(UIMessageNames.TASK_TYPE_REFRESH, 
        Bind(self, self.OnTaskRefresh))
    self._activityRefreshCallback = EventMgr:AddListener(UIMessageNames.TASK_AWARD_REFRESH, 
        Bind(self, self.OnActivityRefresh))

    local taskActiveCfgs = ConfigHelper.GetCfgsByLua("taskActive", {type = 1})
    self._maxValue = taskActiveCfgs[#taskActiveCfgs].activeValue

    self._increment = TaskDataMgr:GetDailyActivitiesUpperLimitMaxValue()
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
        local taskIds = TaskDataMgr:GetRewardTaskIdsByType(TaskConst.TaskType.Daily)
        local hasActivityAward = TaskDataMgr:HasActivityAward(TaskConst.TaskType.Daily)
        if taskIds then
            if hasActivityAward then
                TaskDataMgr:RequestActivityAwards(TaskConst.EACTType.EACT_Daily)
            else
                TaskDataMgr:RequestCompleteTasks(taskIds)
            end
        else
            if hasActivityAward then
                TaskDataMgr:RequestActivityAwards(TaskConst.EACTType.EACT_Daily)
            end
        end
    end
end

function M:OnTaskRefresh(type)
    if type == TaskConst.TaskType.Daily and self._view.rectDailyPanel.gameObject.activeInHierarchy then
        self:_RefreshActivities()
        self:_RefreshTasks()
        self:_UpdateActivityValue()
        self:_SetAllReceiveActive()
    end
end

function M:OnActivityRefresh(type)
    if type == TaskConst.EACTType.EACT_Daily and self._view.rectDailyPanel.gameObject.activeInHierarchy then
        self:_RefreshActivities()
        self:_SetAllReceiveActive()
    end
end

function M:_RefreshTasks()
    --设置下侧任务列表数据
    local listDatas = TaskDataMgr:GetUnLockTasksDataByType(TaskConst.TaskType.Daily)
    self._view.listScrollView:SetDataList(listDatas)
end

function M:_SetAllReceiveActive()
    --是否有可领取奖励数据
    local hasTaskAward = TaskDataMgr:HasRewardTaskDatasByType(TaskConst.TaskType.Daily)
    local hasActivityAward = TaskDataMgr:HasActivityAward(TaskConst.TaskType.Daily)
    if hasTaskAward or hasActivityAward then
        self._view.togReceiveAllState:SetState(1)
    else
        self._view.togReceiveAllState:SetState(2)
    end
end

function M:_RefreshActivities()
    --设置上侧活动点数数据
    local activityDatas = TaskDataMgr:GetDailyActivitiesData()
    self._view.activityScrollView:SetDataList(activityDatas)
end

function M:_SetMaxActivityValue()
    self._increment = TaskDataMgr:GetDailyActivitiesUpperLimitMaxValue()
    self._view.txtMaxValue:SetText(tostring(self._maxValue+self._increment))
end

function M:_UpdateActivityValue()
    local cycleType = protocol.ECycleEvent.ECET_Daily_Task
    local cycleData = CycleDataMgr:GetInstance():GetCycleDataByType(cycleType)
    local curValue = cycleData:GetField0()
    self._increment = TaskDataMgr:GetDailyActivitiesUpperLimitMaxValue()
    curValue = curValue > (self._maxValue+self._increment) and (self._maxValue+self._increment) or curValue 
    self._view.txtCurValue:SetText(curValue .. "/")
    
    self:_SetMaxActivityValue()

    local activityDatas = TaskDataMgr:GetDailyActivitiesData()
    local singleProcess = 1/#activityDatas
    local level =1

    for i=#activityDatas,1,-1 do
        if curValue<=(activityDatas[i].value + activityDatas[i].increment) then
            level = i
        end
    end

    local progress = singleProcess * (level-1) + 0.5 *singleProcess--curValue / (activityDatas[level].value+self._increment) * singleProcess * level
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

return DailyTaskUICtrl
