local ChallengeTaskUICtrl = BaseClass("ChallengeTaskUICtrl")

local M = ChallengeTaskUICtrl

function M:__init(view)
    self._view = view
    self._view.challengeScrollView:Init(require("UI.Ctrl.Task.ChallengeListItemCtrl"), require("UI.View.Task.ChallengeListItemView"))
    self._taskRefreshCallback = EventMgr:AddListener(UIMessageNames.TASK_TYPE_REFRESH, Bind(self, self.OnTaskRefresh))
    self._view.togReceiveAll:onClick(Bind(self,self.OnReceiveAll))
end

function M:Open()
    self:OnResponseLoadTask()
    self:_SetAllReceiveActive()
end

function M:OnResponseLoadTask()
    local data = TaskDataMgr:GetTasksDataByType(TaskConst.TaskType.Challenge)
    self._view.challengeScrollView:SetDataList(data)
end

function M:OnTaskRefresh(type)
    if type == TaskConst.TaskType.Challenge and self._view.rectChallengePanel.gameObject.activeInHierarchy then
        self:OnResponseLoadTask()
        self:_SetAllReceiveActive()
    end
end

function M:OnReceiveAll()
    local taskIds = TaskDataMgr:GetRewardTaskIdsByType(TaskConst.TaskType.Challenge)
    if taskIds then
        TaskDataMgr:RequestCompleteTasks(taskIds)
    end
end

function M:_SetAllReceiveActive()
    --是否有可领取奖励数据
    local hasData = TaskDataMgr:HasRewardTaskDatasByType(TaskConst.TaskType.Challenge)
    if hasData then
        self._view.togReceiveAll:SetActive(true)
    else
        self._view.togReceiveAll:SetActive(false)
    end
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.TASK_TYPE_REFRESH, self._taskRefreshCallback)
    self._view.challengeScrollView:Dispose()
    self._view.challengeScrollView = nil

    self._view.togReceiveAll:onClick(nil)
    self._view:OnDispose()
    self._view = nil
end

return ChallengeTaskUICtrl
