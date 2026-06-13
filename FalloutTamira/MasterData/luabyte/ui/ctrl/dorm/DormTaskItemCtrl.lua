local DormTaskItemCtrl = BaseClass("DormTaskItemCtrl")
local M = DormTaskItemCtrl

function M:__init(view)
    self._view = view
    self._view.GoBtn.transform:onClick(Bind(self, self._OnClickTask))
end

--点击任务跳转
function M:_OnClickTask(go)
    GameHelper.Jump(self.data.jumpId)
    EventMgr:Broadcast(UIMessageNames.DORM_TASK_JUMP)
end

function M:UpdataData(taskId)
    self.taskId = taskId
    self.data = TaskDataMgr:GetTaskData(TaskConst.TaskType.Dormitory, self.taskId)
    if self.data then
        self._view.ContentText:SetText(self.data.des)
        local value1 = self.data.value0 > self.data.limitValue1 and self.data.limitValue1 or self.data.value0
        self._view.Number:SetText(value1 .. "/" .. self.data.limitValue1)
        self._view.ExpSlider:SetFillAmount(TaskHelper.GetProgress(self.data))
        self:Enable(true)
        if self.data.state == TaskConst.TaskState.Doing then
            self._view.Finished.gameObject:SetActive(false)
            self._view.GoBtn.gameObject:SetActive(true)
        else
            self._view.Finished.gameObject:SetActive(true)
            self._view.GoBtn.gameObject:SetActive(false)
        end
    else
        self:Enable(false)
    end
end

function M:Enable(v)
    self._view:SetActive(v)
end

function M:OnDispose()
    self.taskId = 0
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return DormTaskItemCtrl
