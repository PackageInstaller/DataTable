--[[ 
-----------------------------------------------------
@filename       : ReturnedManager
@Description    : 常驻回归活动数据管理器
@date           : 2023-10-31 17:26:04
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.returned.manager.ReturnedManager', Class.impl(Manager))

-- 回归活动状态变更
EVENT_RETURNED_STATE_CHANGE = "EVENT_RETURNED_STATE_CHANGE"
-- 签到更新
EVENT_RETURNED_SIGN_UPDATE = "EVENT_RETURNED_SIGN_UPDATE"
-- 任务更新
EVENT_RETURNED_TASK_UPDATE = "EVENT_RETURNED_TASK_UPDATE"

--构造
function ctor(self)
    super.ctor(self)
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:init()
end

--初始化
function init(self)
    self.isOpen = false
    self.loginDay = 0
    self.signReceiveDay = {}
end

-- 解析基础数据
function parseConfigData(self)
    self.mReturnedSignList = {}
    self.mReturnedTaskTypeData = {}
    self.mReturnedTaskData = {}
    local baseData = RefMgr:getData("returned_sign_data")
    for key, v in pairs(baseData) do
        local reward = v.reward[1]
        local vo = { id = key, tid = reward[1], num = reward[2] }
        table.insert(self.mReturnedSignList, vo)
    end
    table.sort(self.mReturnedSignList, function(a, b)
        return a.id < b.id
    end)

    local baseData = RefMgr:getData("returned_task_data")
    for key, v in pairs(baseData) do
        local vo = returned.ReturnedTaskVo.new()
        vo:parseConfigData(key, v)
        if not self.mReturnedTaskTypeData[vo.type] then
            self.mReturnedTaskTypeData[vo.type] = {}
        end
        table.insert(self.mReturnedTaskTypeData[vo.type], vo)

        self.mReturnedTaskData[key] = vo
    end
end

--- *s2c* 回归活动开启信息 24320
function parseReturnedInfoHandler(self, msg)
    self.isOpen = msg.is_open == 1
    self.endTime = msg.end_time
    GameDispatcher:dispatchEvent(EventName.RETURNED_STATE_CHANGE)
end
--- *s2c* 签到信息 24322
function parseReturnedSignInfoHandler(self, msg)
    self.loginDay = msg.login_day
    self.signReceiveDay = msg.sign_day_reward_list
    self:dispatchEvent(self.EVENT_RETURNED_SIGN_UPDATE)

    self:updateMainuiRed()
end

--- *s2c* 任务面板 24323
function parseReturnedTaskInfoHandler(self, msg)
    for i, pt_task_info_base in ipairs(msg.task_list) do
        local vo = self:getReturnedTaskData(pt_task_info_base.id)
        if vo then
            vo:parseMsg(pt_task_info_base)
        else
            logError("配置不一致，请策划检查配置：returned_task_data.lua")
        end
    end
    self:dispatchEvent(self.EVENT_RETURNED_TASK_UPDATE)
    self:updateMainuiRed()
end
--- *s2c* 任务领取奖励 24325
function parseReturnedTaskReceiveHandler(self, msg)
    for i, id in ipairs(msg.task_id_list) do
        local vo = self:getReturnedTaskData(id)
        if vo then
            vo.state = 2
        else
            logError("配置不一致，请策划检查配置：returned_task_data.lua")
        end
    end

    self:dispatchEvent(self.EVENT_RETURNED_TASK_UPDATE)
    self:updateMainuiRed()
end

--- *s2c* 更新任务进度 24326
function parseReturnedTaskUpdateHandler(self, msg)
    local vo = self:getReturnedTaskData(msg.task_info.id)
    if vo then
        vo:parseMsg(msg.task_info)
    else
        logError("配置不一致，请策划检查配置：returned_task_data.lua")
    end
    self:dispatchEvent(self.EVENT_RETURNED_TASK_UPDATE)
    self:updateMainuiRed()
end

function updateMainuiRed(self)
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_RETURNED, self:getHasRedAll())

end


-- 取签到奖励数据
function getReturnedSignList(self)
    if not self.mReturnedSignList then
        self:parseConfigData()
    end
    return self.mReturnedSignList
end

-- 通过类型取任务列表
function getReturnedTaskList(self, type)
    if not self.mReturnedTaskTypeData then
        self:parseConfigData()
    end
    return self.mReturnedTaskTypeData[type]
end

-- 通过id取一个任务数据
function getReturnedTaskData(self, id)
    if not self.mReturnedTaskData then
        self:parseConfigData()
    end
    return self.mReturnedTaskData[id]
end

-- 获取某日签到是否已领取
function getReturnedSignIsReceive(self, day)
    local index = table.indexof(self.signReceiveDay, day)
    if index ~= false then
        return true
    end
    return false
end

-- 检查签到是否有奖励可以领取
function checkReturnedSignHasAward(self)
    for i = 1, self.loginDay do
        if not self:getReturnedSignIsReceive(i) then
            return true
        end
    end
    return false
end

-- 检测任务是否有可以领取
function checkReturnedTaskHasAward(self, type)
    local list = self:getReturnedTaskList(type)
    for i, v in ipairs(list) do
        if v:getState() == ReturnedTaskState.CAN_REC then
            return true
        end
    end
    return false
end

-- 获取是否需要红点提示（page 页签， 不传则有就返回）
function getHasRedAll(self, page)
    if not self:checkIsOpen() then
        return false
    end
    if not page then
        return self:checkReturnedSignHasAward() or self:checkReturnedTaskHasAward(ReturnedTaskType.TASK_DAILY) or self:checkReturnedTaskHasAward(ReturnedTaskType.TASK_CHALLENGE)
    end
    if page == ReturnedTabPage.RETURNEN_PAGE_SIGN then
        return self:checkReturnedSignHasAward()
    end
    if page == ReturnedTabPage.RETURNEN_PAGE_TASK_DAILY then
        return self:checkReturnedTaskHasAward(ReturnedTaskType.TASK_DAILY)
    end
    if page == ReturnedTabPage.RETURNEN_PAGE_TASK_CHALLENGE then
        return self:checkReturnedTaskHasAward(ReturnedTaskType.TASK_CHALLENGE)
    end
    return false
end

function checkIsOpen(self)
    if not funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_RETURNED, false) or not self.isOpen then
        return false
    end
    return true
end


return _M