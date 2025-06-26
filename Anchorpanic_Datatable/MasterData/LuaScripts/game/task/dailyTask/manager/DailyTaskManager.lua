module("task.DailyTaskManager", Class.impl(Manager))

--构造函数
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
    -- 任务配置字典
    self.m_taskConfigDic = nil

    -- 日常任务积分
    self.dailyTaskScore = 0
    -- 日常任务最大积分
    self.maxDailyTaskScore = 0
    -- 服务器任务列表
    self.m_taskList = {}
    -- 服务器每日任务积分奖励列表
    self.m_dailyTaskScoreAwardList = {}
end

-- 解析任务配置表
function parseTaskConfig(self)
    self.m_taskConfigDic = {}
    local baseData = RefMgr:getData("daily_task_data")
    for taskId, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(task.DailyTaskConfigVo)
        ro:parseData(taskId, data)
        self.m_taskConfigDic[taskId] = ro
    end
end

-- 根据任务id获取任务配置
function getTaskConfigVo(self, taskId)
    if (not self.m_taskConfigDic) then
        self:parseTaskConfig()
    end
    return self.m_taskConfigDic[taskId]
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 解析服务器任务列表
function parseTaskListMsg(self, msg)
    self.dailyTaskScore = msg.total_score
    self.m_taskList = {}
    for i = 1, #msg.task_info do
        local vo = task.DailyTaskVo.new()
        vo:parseData(msg.task_info[i])
        table.insert(self.m_taskList, vo)
    end

    self.m_dailyTaskScoreAwardList = {}
    for i = 1, #msg.score_info do
        local vo = task.DailyTaskScoreAwardVo.new()
        vo:parseData(msg.score_info[i])
        table.insert(self.m_dailyTaskScoreAwardList, vo)

        if (vo.score >= self.maxDailyTaskScore) then
            self.maxDailyTaskScore = vo.score
        end
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_TASK_DATA)

    self:setRedFlag()
end

-- 更新单个任务数据
function updateTaskListMsg(self, msg)
    if (self.m_taskList) then
        local taskVo = nil
        local isHas = false
        for i = 1, #self.m_taskList do
            taskVo = self.m_taskList[i]
            if (taskVo.id == msg.id) then
                taskVo:parseData(msg)
                isHas = true
                break
            end
        end

        if (not isHas) then
            taskVo = task.DailyTaskVo.new()
            taskVo:parseData(msg)
            table.insert(self.m_taskList, taskVo)
        end

        GameDispatcher:dispatchEvent(EventName.UPDATE_TASK_LIST, { type = taskVo.type })
        self:setRedFlag()

    end
end

-- 领取单个任务奖励
function updateTaskAward(self, msg)
    if (msg.result == 1) then
        local taskVo = self:getTaskVo(msg.task_id)
        if (taskVo) then
            taskVo:setState(task.AwardRecState.HAS_REC)
            local configVo = self:getTaskConfigVo(taskVo.id)
            if (configVo) then
                for i = 1, #self.m_dailyTaskScoreAwardList do
                    local taskScoreAwardVo = self.m_dailyTaskScoreAwardList[i]
                    if (taskScoreAwardVo:getState() == task.AwardRecState.UN_REC and self.dailyTaskScore >= taskScoreAwardVo.score) then
                        taskScoreAwardVo:setState(task.AwardRecState.CAN_REC)
                    end
                end
            end
            GameDispatcher:dispatchEvent(EventName.UPDATE_TASK_AWARD, { type = taskVo.type })
            local list = {}
            for i = #taskVo.propsList, 1, -1 do
                table.insert(list, taskVo.propsList[i])
            end
            ShowAwardPanel:showPropsList(list)
            self:setRedFlag()
        end
    else
        gs.Message.Show("领取失败")
    end
end

-- 领取单个任务积分奖励
function updateTaskScoreAward(self, msg)
    if (msg.result == 1) then
        local taskScoreAwardVo = task.DailyTaskManager:getDailyTaskScoreAwardVo(msg.score_award_id)
        if (taskScoreAwardVo) then
            taskScoreAwardVo:setState(task.AwardRecState.HAS_REC)
            GameDispatcher:dispatchEvent(EventName.UPDATE_TASK_SCORE_AWARD, { type = task.TYPE_DAILY_TASK })
            -- ShowAwardPanel:showPropsList(taskScoreAwardVo.propsList)
        end
        self:setRedFlag()
    else
        gs.Message.Show("领取失败")
    end
end

-- 领取所有任务奖励更新，包括积分奖励
function updateAllTaskAward(self, msg)
    if (msg.result == 1) then
        local showAwardList = {}

        -- 修改任务数据的领取状态
        for i = 1, #msg.task_id do
            local taskVo = self:getTaskVo(msg.task_id[i])
            if (taskVo) then
                taskVo:setState(task.AwardRecState.HAS_REC)
                local configVo = self:getTaskConfigVo(taskVo.id)

                for j = 1, #taskVo.propsList do
                    table.insert(showAwardList, taskVo.propsList[j])
                end
            end
        end
        -- 修改积分奖励数据的领取状态
        for i = 1, #msg.score_award_id do
            local taskScoreAwardVo = self:getDailyTaskScoreAwardVo(msg.score_award_id[i])
            if (taskScoreAwardVo) then
                taskScoreAwardVo:setState(task.AwardRecState.HAS_REC)

                for j = 1, #taskScoreAwardVo.propsList do
                    table.insert(showAwardList, taskScoreAwardVo.propsList[j])
                end
            end
        end

        GameDispatcher:dispatchEvent(EventName.UPDATE_ALL_TASK_AWARD, { type = msg.type })
        self:setRedFlag()

        if (#showAwardList > 0) then
            ShowAwardPanel:showPropsList(showAwardList, nil, false, true)
        else
            gs.Message.Show("没有可以领取的奖励")
        end
    else
        gs.Message.Show("领取失败")
    end
end

-- 更新日常任务积分
function updateDailyTaskScore(self, msg)
    self.dailyTaskScore = msg.total_score
    GameDispatcher:dispatchEvent(EventName.UPDATE_DAILY_TASK_SCORE, { type = task.TYPE_DAILY_TASK })
    self:setRedFlag()
end

-- 获取日常积分奖励vo
function getDailyTaskScoreAwardVo(self, taskScoreAwardId)
    for i = 1, #self.m_dailyTaskScoreAwardList do
        if (self.m_dailyTaskScoreAwardList[i].id == taskScoreAwardId) then
            return self.m_dailyTaskScoreAwardList[i]
        end
    end
end

function getTaskVo(self, taskId)
    for i = 1, #self.m_taskList do
        if (self.m_taskList[i].id == taskId) then
            return self.m_taskList[i]
        end
    end
end

function getTaskList(self, taskType)
    local list = {}
    for i = 1, #self.m_taskList do
        if (self.m_taskList[i].type == taskType) then
            table.insert(list, self.m_taskList[i])
        end
    end
    table.sort(list, self.__sortTaskList)
    return list
end
--获取当前任务列表的可领取奖励数量
function getTaskCanRecList(self, taskType)
    local list = {}
    local canNum = 0
    for i = 1, #self.m_taskList do
        if (self.m_taskList[i].type == taskType) then
            table.insert(list, self.m_taskList[i])
        end
    end
    table.sort(list, self.__sortTaskList)
    for i, Vo in ipairs(list) do
        if Vo:getState() == task.AwardRecState.CAN_REC then
            canNum = canNum + 1
        end
    end
    return canNum
end

function __sortTaskList(taskVo_1, taskVo_2)
    if (taskVo_1:getState() > taskVo_2:getState()) then
        return false
    elseif (taskVo_1:getState() < taskVo_2:getState()) then
        return true
    else
        if (taskVo_1.id < taskVo_2.id) then
            return true
        elseif (taskVo_1.id > taskVo_2.id) then
            return false
        end
    end
    return false
end

-- 获取日常任务积分奖励列表
function getTaskScoreAwardList(self)
    return self.m_dailyTaskScoreAwardList
end

function setRedFlag(self)
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_TASK, self:judgeIsCanRec())
end

function judgeIsCanRec(self, type)
    local isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_TASK)
    if not isOpen then
        return false
    end

    local isCanRec = false

    for i = 1, #self.m_taskList do
        local taskVo = self.m_taskList[i]
        if ((not type or taskVo.type == type) and taskVo:getState() == task.AwardRecState.CAN_REC) then
            isCanRec = true
            break
        end
    end

    if (not isCanRec and (not type or type == task.TYPE_DAILY_TASK)) then
        for i = 1, #self.m_dailyTaskScoreAwardList do
            local scoreAwardVo = self.m_dailyTaskScoreAwardList[i]
            if (scoreAwardVo:getState() == task.AwardRecState.CAN_REC) then
                isCanRec = true
                break
            end
        end
    end

    return isCanRec
end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]