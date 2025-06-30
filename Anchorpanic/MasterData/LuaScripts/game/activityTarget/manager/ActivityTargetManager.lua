module("activityTarget.ActivityTargetManager", Class.impl(Manager))

function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    --本地任务字典 索引-数据
    self.mLocalTaskDic = nil

    --当前任务第几天
    self.currentDay = 0

    self.isFinish = false

    --服务器下发的任务字典
    self.mServerTaskDic = {}
end

--获取结束的时间戳
function getEndTime(self)
    return self.mEndTime
end

-- 解析服务器任务列表
function parseTaskListMsg(self, msg)
    self.currentDay = msg.day
    self.isFinish = msg.is_finish == 1 and true or false
    self.mServerTaskDic = {}
    for i = 1, #msg.task_info do
        local vo = activityTarget.ActivityTargetTaskInfoVo.new()
        vo:parseData(msg.task_info[i])
        self.mServerTaskDic[vo.id] = vo
    end
    if (not self.isFinish) then
        GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_TARGET_PANEL)
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_WELFAREOPT_FLAG, { tabType = welfareOpt.WelfareOptConst.WELFAREOPT_SEVENTDAY_TARGET })
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
    if activityTarget.ActivityTargetManager:getIsFinish() then
        GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_HIDE)
    end
end

function getIsFinish(self, msg)
    return self.isFinish
end

--更新新手任务数据
function updateActivityTargetTask(self, msg)
    local vo = activityTarget.ActivityTargetTaskInfoVo.new()
    vo:parseData(msg.task_info)
    if not self.mServerTaskDic then
        self.mServerTaskDic = {}
    end
    self.mServerTaskDic[vo.id] = vo
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_TARGET_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_WELFAREOPT_FLAG, { tabType = welfareOpt.WelfareOptConst.WELFAREOPT_SEVENTDAY_TARGET })
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
    if activityTarget.ActivityTargetManager:getIsFinish() then
        GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_HIDE)
    end
end

--修改任务状态  按之前逻辑为本地修改 TODO 优化
function setTaskState(self, msg)
    if (msg.result == 1) then
        if (not msg.task_list) then
            return
        end
        local rewardList = msg.task_list
        self.isFinish = msg.is_finish == 1 and true or false
        for i = 1, #rewardList do
            for n, taskVo in pairs(self.mServerTaskDic) do
                if taskVo.id == rewardList[i] then
                    self.mServerTaskDic[n].state = 2
                end
            end
        end
        GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_TARGET_PANEL)
        GameDispatcher:dispatchEvent(EventName.UPDATE_WELFAREOPT_FLAG, { tabType = welfareOpt.WelfareOptConst.WELFAREOPT_SEVENTDAY_TARGET })
        GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
        if activityTarget.ActivityTargetManager:getIsFinish() then
            GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_HIDE, activity.ActivityConst.ACTIVITY_SEVENTDAY_TARGET)
        end
    end
end

--获取当前任务天数
function getActivityTargetDay(self)
    return self.currentDay
end

--通过任务id获取服务器任务数据
function getTaskVo(self, id)
    return self.mServerTaskDic[id]
end

function parseActivityTargetData(self)
    self.mLocalTaskDic = {}
    local baseData = RefMgr:getData("novice_target_data")
    for id, data in pairs(baseData) do
        local vo = activityTarget.ActivityTargetVo.new()
        vo:parseActivityTargetVo(data, id)
        self.mLocalTaskDic[id] = vo
    end
end

function getActivityTargetData(self, day)
    if self.mLocalTaskDic == nil then
        self:parseActivityTargetData()
    end

    local retList = {}
    for id, data in pairs(self.mLocalTaskDic) do
        if data.day == day then
            table.insert(retList, { localData = data, serverData = self:getTaskVo(data.id) })
        end
    end

    table.sort(retList, function(a, b)
        if (not a.serverData or not b.serverData) then
            return false
        end
        if (a.serverData.state ~= b.serverData.state) then
            return a.serverData.state < b.serverData.state
        else
            return a.serverData.id < b.serverData.id
        end
    end)
    return retList
end

function getActivityTargetRed(self, day)
    if self.mLocalTaskDic == nil then
        self:parseActivityTargetData()
    end

    if not self:canOpen() then
        return false
    end

    if day > self.currentDay then
        return false
    end

    local dayList = self:getActivityTargetData(day)

    for i = 1, #dayList do
        local vo = self:getTaskVo(dayList[i].id)
        if vo.m_state == 0 then
            return true
        end
    end
    return false
end
--当前天数下任务是否已全部完成
function getActivityTargetIsAllOver(self, day)
    for i, vo in ipairs(self:getActivityTargetData(day)) do
        if not self:getTaskVo(vo.localData.id) or self:getTaskVo(vo.localData.id).state ~= 2 then
            return false
        end
    end
    return true
end

function getActivityTargetVo(self, id)
    if self.mLocalTaskDic == nil then
        self:parseActivityTargetData()
    end
    return self.mLocalTaskDic[id]
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]