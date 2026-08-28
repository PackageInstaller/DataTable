-------------------------------------------------------------------------------
-- 任务模块
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-02-20 03:13:06
-------------------------------------------------------------------------------

local DELAY_TIME = 2  -- 服务端给的倒计时加两秒延时，用于解决客户端服务端计时不一致的问题

local ECSComponent = import("Frame.ECS.ECSComponent")
---@class TaskComponent : ECSComponent
local TaskComponent = Class("TaskComponent", ECSComponent)


function TaskComponent:__init()
    self.name = "TaskComponent"

    ---@type table<string, table> @ 日常-任务数据记录（key：任务id，value：任务数据）
    self.dailyTaskDataMap = {}

    ---@type integer @ 日常-当前宝箱积分
    self.dailyTaskPointNow = 0

    ---@type integer @ 日常-宝箱积分上限
    self.dailyTaskPointMax = 0

    ---@type table<string, table> @ 日常-宝箱数据（key：宝箱id，value：宝箱数据）
    self.dailyTaskBoxDataMap = {}

    ---@type integer @ 日常-任务刷新剩余时间
    self.dailyTaskTimeLeft = 0

    ---@type table<string, table> @ 成就-任务数据（key：成就id，value：任务数据）
    self.achievementDataMap = {}

    ---@type integer @ 成就-获得的积分
    self.achievementPoint = 0

    ---@type integer @ 成就-当前宝厢id
    self.achievementBoxId = 0

    ---@type integer @ 成就-当前宝厢所需积分
    self.achievementBoxPoint = 0
end


function TaskComponent:__delete()
    self.dailyTaskDataMap    = nil
    self.dailyTaskTimeLeft   = nil
    self.dailyTaskPointNow   = nil
    self.dailyTaskPointMax   = nil
    self.dailyTaskBoxDataMap = nil
    self.achievementDataMap  = nil
    self.achievementPoint    = nil
    self.achievementBoxId    = nil
    self.achievementBoxPoint = nil
end


-------------------------------------------------
-- get / set

--- 是否解锁 日常任务
---@return boolean
function TaskComponent:IsUnlockedDailyTask()
    return GameUtils.IsUnlockedBySystemTogId(Constants.SystemToggleIds.Id205)
end


--- 是否解锁 成就任务
---@return boolean
function TaskComponent:IsUnlockedAchievementTask()
    return GameUtils.IsUnlockedBySystemTogId(Constants.SystemToggleIds.Id207)
end


--- 是否解锁 成长任务
---@return boolean
function TaskComponent:IsUnlockedGrowUpTask()
    return GameUtils.IsUnlockedBySystemTogId(Constants.SystemToggleIds.Id258) -- 目前为 true
end


--- 是否解锁 调查任务
---@return boolean
function TaskComponent:IsUnlockedInvestigationTask()
    return GameUtils.IsUnlockedBySystemTogId(Constants.SystemToggleIds.Id2009)
    --return true
end


--- 获取描述 日常任务
---@return string
function TaskComponent:GetUnlockDailyTaskDescr()
    return GameUtils.GetUnlockDescrBySystemTogId(Constants.SystemToggleIds.Id205)
end


--- 获取描述 成就任务
---@return string
function TaskComponent:GetUnlockAchievementTaskDescr()
    return GameUtils.GetUnlockDescrBySystemTogId(Constants.SystemToggleIds.Id207)
end


--- 获取描述 成长任务
---@return string
function TaskComponent:GetUnlockGrowUpTaskDescr()
    return GameUtils.GetUnlockDescrBySystemTogId(Constants.SystemToggleIds.Id258) -- "玩家等级达到1级时解锁"
end


--- 获取描述 调查任务
---@return string
function TaskComponent:GetUnlockInvestigationTaskDescr()
    return GameUtils.GetUnlockDescrBySystemTogId(Constants.SystemToggleIds.Id2009)
    --return "调查任务 临时文本 --1--"
end


---@param taskId integer
---@return table
function TaskComponent:GetAchievementTaskData(taskId)
    return self.achievementDataMap[tostring(taskId)] or {}
end


---@param taskId integer
---@return boolean
function TaskComponent:IsDrawnAchievementTask(taskId)
    return checkInt(self:GetAchievementTaskData(taskId).status) == -1
end
---@param taskId integer
function TaskComponent:SetDrawnAchievementTask(taskId)
    if self.achievementDataMap[tostring(taskId)] then
        self.achievementDataMap[tostring(taskId)].status = -1
    else
        self:AppendAchievementTaskData({
            currentTaskId = taskId, -- 任务id
            status        = -1,     -- 任务状态（1:可领取，0:进行中, -1:已完成）
            progress      = 0,      -- 进度
        })
    end
end


---@param taskId integer
---@return table
function TaskComponent:GetDailyTaskData(taskId)
    return self.dailyTaskDataMap[tostring(taskId)] or {}
end


---@param taskId integer
---@return boolean
function TaskComponent:IsDrawnDailyTask(taskId)
    return checkInt(self:GetDailyTaskData(taskId).status) == Constants.GetStatus.Has
end
---@param taskId integer
function TaskComponent:SetDrawnDailyTask(taskId)
    self:GetDailyTaskData(taskId).status = Constants.GetStatus.Has -- 0:进行中，1:可领取，2:已领取
end


---@param boxId integer
---@return boolean
function TaskComponent:IsDrawnDailyTaskBox(boxId)
    return checkInt(self.dailyTaskBoxDataMap[tostring(boxId)].status) == Constants.GetStatus.Has
end
---@param boxId integer
function TaskComponent:SetDrawnDailyTaskBox(boxId)
    self.dailyTaskBoxDataMap[tostring(boxId)].status = Constants.GetStatus.Has
end


-------------------------------------------------
-- public

---@param callback fun():void
function TaskComponent:SyncDailyTaskData(callback)
    GameUtils.Request(Interfaces.OverseaDailyTask, {}, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData       = checkTable(response.data)
            self.dailyTaskDataMap    = {}
            self.dailyTaskTimeLeft   = checkInt(responseData.dailyTaskTimeLeft) + DELAY_TIME
            self.dailyTaskPointNow   = 0
            self.dailyTaskPointMax   = 0
            self.dailyTaskBoxDataMap = {}
            -- parse taskData
            for _, dailyData in pairs(checkTable(responseData.task)) do
                self.dailyTaskDataMap[tostring(dailyData.id)] = dailyData
            end
            -- parse drawData
            for _, boxId in ipairs(self:GetRewardBoxIdList(1)) do
                local rewardBoxVo = self:GetRewardBoxData(boxId)
                self.dailyTaskBoxDataMap[tostring(boxId)] = {
                    boxId  = boxId,
                    boxVo  = rewardBoxVo,
                    status = Constants.GetStatus.Not,
                }
                self.dailyTaskPointMax = math.max(self.dailyTaskPointMax, rewardBoxVo.unlockPoint)
            end
            for _, boxId in ipairs(checkTable(responseData.dailyTaskBoxDraw)) do
                self:SetDrawnDailyTaskBox(boxId)
            end
            self:UpdateDailyTaskBoxProgress(responseData.dailyTaskPoint)
            -- done callback
            if callback then
                callback()
            end
        end
    end)
end


---@param dailyTaskBoxPoint integer
function TaskComponent:UpdateDailyTaskBoxProgress(dailyTaskBoxPoint)
    self.dailyTaskPointNow = checkInt(dailyTaskBoxPoint)
    for taskBoxId, taskBoxData in pairs(self.dailyTaskBoxDataMap) do
        ---@type TaskRewardBoxVo
        local rewardBoxVo = taskBoxData.boxVo
        if self.dailyTaskPointNow >= rewardBoxVo.unlockPoint and self:IsDrawnDailyTaskBox(taskBoxId) == false then
            taskBoxData.status = Constants.GetStatus.Can
        end
    end
end


---@param callback fun():void
function TaskComponent:SyncAchievementTaskData(callback)
    GameUtils.Request(Interfaces.AchievementTask, {}, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData       = checkTable(response.data)
            self.achievementPoint    = checkInt(responseData.point)
            self.achievementBoxId    = checkInt(responseData.boxId)
            self.achievementBoxPoint = checkInt(responseData.boxPoint)
            self.achievementDataMap  = {}
            -- parse taskData
            for _, taskDataDojo in ipairs(checkTable(responseData.task)) do
                self:AppendAchievementTaskData(taskDataDojo)
            end
            -- parse drawData
            for _, taskId in ipairs(checkTable(responseData.drawTaskInfo)) do
                self:SetDrawnAchievementTask(taskId)
            end
            -- done callback
            if callback then
                callback()
            end
        end
    end)
end


---@param taskDataDojo table
function TaskComponent:AppendAchievementTaskData(taskDataDojo)
    local taskId = taskDataDojo.currentTaskId
    if taskId then
        self.achievementDataMap[tostring(taskId)] = taskDataDojo
    end
end


---@class TaskRewardBoxVo
---@field id integer @ 奖励宝箱id
---@field type integer @ 奖励类型（1-日常 2-周常 3-成就）
---@field unlockPoint integer @ 解锁点数
---@field rewards table[] @ 奖励数据

--- 获取奖励宝箱配表的数据
---@param refId integer
---@return TaskRewardBoxVo
function TaskComponent:GetRewardBoxData(refId)
    ---@type TableML.TableFileRow
    local boxConfRow      = CfUtils.GetCfLine(AutoIds.IdSetting256, refId)
    local rewardBoxExp    = checkInt(boxConfRow:Get("exp"))
    local rewardBoxType   = checkInt(boxConfRow:Get("type"))
    local unlockPoint     = checkInt(boxConfRow:Get("unlockPoint"))
    local rewardData      = parse_rewardData(boxConfRow, "rewardId", "rewardNum")
    local playerExpGoodId = CfUtils.GetCfVo(AutoIds.IdSetting10, "BaseArgVo", 15).num
    if rewardBoxExp > 0 then
        table.insert(rewardData, {goodsId = playerExpGoodId, num = rewardBoxExp})
    end
    return {
        id          = refId,
        type        = rewardBoxType,
        unlockPoint = unlockPoint,
        rewards     = rewardData,
    }
end


--- 获取指定类型的全部奖励宝箱id
---@param type integer @ 类型（1-日常 2-周常 3-成就）
---@return integer[]
function TaskComponent:GetRewardBoxIdList(boxType)
    local rewardBoxType   = checkInt(boxType)
    local rewardBoxIdList = {}
    local allConfTable = CfUtils.GetCfTable(AutoIds.IdSetting256)
    for _, confRow in pairs(allConfTable:GetAll()) do
        local isOpened = checkInt(confRow:Get("status")) == 1
        if isOpened and rewardBoxType == checkInt(confRow:Get("type")) then
            table.insert(rewardBoxIdList, checkInt(confRow:Get("id")))
        end
    end
    table.sort(rewardBoxIdList, function(aBoxId, bBoxId)
        return aBoxId < bBoxId
    end)
    return rewardBoxIdList
end


return TaskComponent
