-- baoruichang
-- 2022/11/17 13:55:49
local UIMasqueradeTaskContext = BaseClass("UIMasqueradeTaskContext", BaseContext)
local M = UIMasqueradeTaskContext
local tInsert = table.insert
local EActivityState = EnumConst.EActivityState

function M:Init()
end

function M:Open(activityId)
    -- 主活动id
    self.mainActivityId = activityId
    local relationIds = ConfigHelper.GetCfgPropByLua("activity", self.mainActivityId, "relationId")
    -- 任务活动id
    self._activityId = relationIds[1]
    -- 任务活动详细信息
    ActivityDataMgr:GetInstance():GetActivityRoleDatasAsyn(self._activityId, Bind(self, self._OnLoadTaskCallBack))
    -- 成就详细信息
    local activityCopys = ConfigHelper.GetCfgsByLua("activityCopy", {activityId=self.mainActivityId})
    if #activityCopys <= 0 then
        Logger.LogError("配置错误")
        return
    end
    self.achievementGroupId = activityCopys[1].achievementGroupId
    if self.achievementGroupId and self.achievementGroupId > 0 then
        AchievementDataMgr:GetInstance():SendRequestAchievementGroupDetail(self.achievementGroupId, Bind(self, self._OnLoadAcheveCallBack))
    end
end

function M:_OnLoadTaskCallBack(cRoleActivitys)
    self.task = {}
    -- 任务
    local activityCopyTasks = ConfigHelper.GetCfgsByLua("activityCopyTask", {activityId=self._activityId})
    for _, activityCopyTask in pairs(activityCopyTasks) do
        local CRoleActivity = self:_GetCRoleActivity(cRoleActivitys, activityCopyTask.id)
        local data = {}
        data.activityCopyTask = activityCopyTask
        if CRoleActivity then
            data.state = CRoleActivity.State
            data.value = CRoleActivity.Value0
            if data.state == EActivityState.Doing then
                data.sortIndex = 2
            elseif data.state == EActivityState.Finished then
                data.sortIndex = 3
            else
                data.sortIndex = 1
            end
        else
            data.state = 0
            data.value = 0
            data.sortIndex = 2
        end
        tInsert(self.task, data)
    end
    self:_Show(self.mainActivityId, self._activityId)
end

function M:_OnLoadAcheveCallBack(data)
    self.achieve = data
end

function M:_GetCRoleActivity(CRoleActivitys, subActivityId)
    for _, CRoleActivity in pairs(CRoleActivitys) do
        if CRoleActivity.SubActivityId == subActivityId then
            return CRoleActivity
        end
    end
end

function M:GetTaskData()
    return self.task or {}
end

function M:GetAcheveData()
    return self.achieve or {}
end
-- 请求新的任务信息
function M:GetNewTaskData()
    self.task = {}
    local data = ActivityDataMgr:GetInstance():GetActivityData(self._activityId)
    local cRoleActivitys = data:RoleActivity()
    local activityCopyTasks = ConfigHelper.GetCfgsByLua("activityCopyTask", {activityId=self._activityId})
    for _, activityCopyTask in pairs(activityCopyTasks) do
        local CRoleActivity = self:_GetCRoleActivity(cRoleActivitys, activityCopyTask.id)
        local data = {}
        data.activityCopyTask = activityCopyTask
        if CRoleActivity then
            data.state = CRoleActivity.State
            data.value = CRoleActivity.Value0
            if data.state == EActivityState.Doing then
                data.sortIndex = 2
            elseif data.state == EActivityState.Finished then
                data.sortIndex = 3
            else
                data.sortIndex = 1
            end
        else
            data.state = 0
            data.value = 0
            data.sortIndex = 2
        end
        tInsert(self.task, data)
    end
    self:GetCtrl():RefTaskList()
end

function M:GetActivityId()
    return self._activityId or 0
end

function M:GetAchievementGroupId()
    return self.achievementGroupId or 0
end

function M:OnClose()
    M.super.OnClose(self)
end

return UIMasqueradeTaskContext
