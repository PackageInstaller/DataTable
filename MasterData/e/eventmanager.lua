require "class"
---@class EventManager
local EventManager = class("EventManager")
local BattleCore = require "BattleCore"


function EventManager:ctor()

    --本次战斗需要的事件列表
    ---@type table<BattleTiming, table>
    self.battleEventList = {}
    self._sortedBattleEventIds = {}
    self._battleEventOrderDirty = {}

    --待演出事件列表
    ---@type table<BattleTiming, table>
    self.eventPlayList = {}

    --已经演出的事件列表
    self.isShowEventPlayList = {}

    --战斗事件额外保存数据
    self.eventSaveData = {}

    --当前执行的事件表数据
    self.nowEventConfig = nil

    --事件系统触发战斗结束
    self.haveEventLevelTarget = {
        isWin = false,
        isLose = false,
    }

    --当前表现的事件表数据
    self.nowPreEventfConfig = nil

    --需要移除的表现效果
    self.removePrefIdList = {}

-----------------------------------------

    --事件触发条件方法列表
    self.conditionFunc = {}

    --事件触发结果方法列表
    self.resultFunc = {}

    --事件表现方法列表
    self.performanceFunc = {}

    --将事件核心方法分类于不同脚本
    self:extendFunc()

    --初始化事件核心方法
    self:setEventFunc()
end

function EventManager:_markBattleEventDirty(timingPoint)
    if timingPoint ~= nil then
        self._battleEventOrderDirty[timingPoint] = true
    end
end

---@param timingPoint BattleTiming
---@param eventId integer
---@param eventData EventData
function EventManager:_setBattleEvent(timingPoint, eventId, eventData)
    local timingEventList = self.battleEventList[timingPoint]
    if not timingEventList then
        timingEventList = {}
        self.battleEventList[timingPoint] = timingEventList
    end
    timingEventList[eventId] = eventData
    self:_markBattleEventDirty(timingPoint)
end

---@param timingPoint BattleTiming
---@param eventId integer
function EventManager:_removeBattleEvent(timingPoint, eventId)
    local timingEventList = self.battleEventList[timingPoint]
    if timingEventList and timingEventList[eventId] ~= nil then
        timingEventList[eventId] = nil
        self:_markBattleEventDirty(timingPoint)
    end
end

---@param timingPoint BattleTiming
---@return integer[]
function EventManager:_getSortedBattleEventIds(timingPoint)
    local eventIdList = self._sortedBattleEventIds[timingPoint]
    if eventIdList and not self._battleEventOrderDirty[timingPoint] then
        return eventIdList
    end

    eventIdList = {}
    local curPlayEventList = self.battleEventList[timingPoint]
    if curPlayEventList then
        local listIndex = 1
        for eventId, _ in pairs(curPlayEventList) do
            eventIdList[listIndex] = eventId
            listIndex = listIndex + 1
        end
        table.sort(eventIdList, function(a, b)
            return a < b
        end)
    end

    self._sortedBattleEventIds[timingPoint] = eventIdList
    self._battleEventOrderDirty[timingPoint] = false
    return eventIdList
end

---实例化
---@return EventManager EventManager
function EventManager.instance()
	if (EventManager._instance == nil) then
		EventManager._instance = EventManager:new()
	end
	return EventManager._instance
end

--初始化本次战斗需要的事件
function EventManager:setBattleEventList(levelId)
    --通过当前关卡id获取关卡所需事件列表
    local levelConfig = Config.GetPveLevelInfo(levelId)
    local levelData = BattleCore:getBattleMgr():getLevelInfo()
    local eventConfigList = Config.GetPveLevelTriggerInfoByBaseId(levelConfig.triggerGroup) or {}
    local needCloseEventId = {}
    for _, achieveId in pairs(levelData and levelData.achieveList or {}) do
        local achConfig = Config.GetPveLevelAchieveInfo(achieveId)
        needCloseEventId = tablex.combine(needCloseEventId, achConfig.triggerClose)
    end
    for id, eventConfig in pairs(eventConfigList) do
        --TODO断线重连事件判断

        --如果是已完成的成就类型事件不加载
        local isNewAchieve = true
        for _, eventId in pairs(needCloseEventId) do
            if eventId == eventConfig.id then
                isNewAchieve = false
            end
        end
        --根据事件初始化类型添加事件
        local eventTiming = eventConfig.timingPoint
        local eventId = eventConfig.id
        if eventConfig.createBaseinfo.initcr == GE.EventInitType.Immediately and isNewAchieve then
            self:_setBattleEvent(eventTiming, eventId, {
                count = eventConfig.createBaseinfo.cnt
            })
            --有初始化表现效果的事件
            if eventConfig.preEffect then
                self.eventPlayList[eventId] = eventConfig.preEffect
            end
        end
    end

    --设置关卡初始星级
    self.eventSaveData.star = levelConfig.baseStar
    if LuaLogger.Enabled then
        BattleCore.ds("battleEventList：", tablex.dump(self.battleEventList))
    end
end

--事件触发外部调用方法
function EventManager:battleEventTrigger(timingPoint)
    local curPlayEventList = self.battleEventList[timingPoint]
    --TODO判断对应事件条件是否满足
    if not curPlayEventList then
        return
    end
    local eventIdList = self:_getSortedBattleEventIds(timingPoint)

    for _, eventId in ipairs(eventIdList) do
        if curPlayEventList[eventId] then
            self.nowEventConfig = Config.GetPveLevelTriggerInfo(eventId)
            local conditionType = self.nowEventConfig.condition
            if self:checkEventCondition(conditionType, self.nowEventConfig.conditionValue) then
                self:doEventCompleted(timingPoint, eventId)
                self:doEventResult(self.nowEventConfig.result)
            end
        end
    end
    if LuaLogger.Enabled and not GV.IsServer then
        BattleCore.ds("事件数据：", tablex.dump(self.battleEventList))
        BattleCore.ds("表演数据：", tablex.dump(self.eventPlayList))
        BattleCore.ds("额外保存数据：", tablex.dump(self.eventSaveData))
    end
end

--判断事件是否触发
function EventManager:checkEventCondition(type, conditionData)
    if self.conditionFunc[type] then
        return self.conditionFunc[type](conditionData)
    end
    return false
end

--事件结果触发
function EventManager:doEventResult(resultList)
    for _, resultData in pairs(resultList) do
        self.resultFunc[resultData.type](resultData)
    end
end

--事件触发后处理事件列表数据
function EventManager:doEventCompleted(timingPoint, eventId)
    local timingEventList = self.battleEventList[timingPoint]
    local eventData = timingEventList[eventId]
    if not eventData then
        return
    end
    local eventConfig = Config.GetPveLevelTriggerInfo(eventId)
    eventData.count = eventData.count - 1
    if eventData.count <= 0 then
        self:_removeBattleEvent(timingPoint, eventId)
        --需要移除的事件表现
        if eventConfig.preEffect then
            table.insert(self.removePrefIdList, eventId)
            self.isShowEventPlayList[eventId] = nil
        end
        self:addPreEffectRemoveReport(eventId)
    end
    --添加事件触发后表现
    if eventConfig.finishEffect then
        self.eventPlayList[eventConfig.id] = eventConfig.finishEffect
    end
end

--添加前端表现效果移除报告
---@param effectId integer
function EventManager:addPreEffectRemoveReport(effectId)
    local battleMgr = BattleCore:getBattleMgr()
    ---@type RemoveEventObjReportData
    local reportData = {
        eventId = effectId,
    }
    battleMgr:getReporter():addReport(GE.BattleReportType.RemoveEventObjReport, reportData)
end

--前端展示事件表现外部调用方法
function EventManager:playEventPerformance()
    for eventId, perfConfigList in pairs(self.eventPlayList) do
        for _, perfConfig in pairs(perfConfigList) do --同事件中多表现处理
            self.nowPreEventfConfig = Config.GetPveLevelTriggerInfo(eventId)
            self.performanceFunc[perfConfig.type](perfConfig)
        end
        self.isShowEventPlayList[eventId] = perfConfigList
    end
    self.eventPlayList = {}
end

--前端删除事件表现效果调用方法
function EventManager:removeEventPerformance()
    if not next(self.removePrefIdList) then
        return
    end
    -- local BattleCore = require "BattleCore"
    local battleManager = BattleCore:getBattleMgr()
    local showManager = battleManager:getShowManager()
    for _, eventId in pairs(self.removePrefIdList) do
        showManager:removeEventObj(eventId)
        self.isShowEventPlayList[eventId] = nil
    end
    self.removePrefIdList = {}
end

---从事件表现列表中移除表现效果ID
function EventManager:removeRemovePrefIdList(eventId)
    for k, v in pairs(self.removePrefIdList) do
        if v == eventId then
            self.removePrefIdList[k] = nil
            break
        end
    end
end

--完成关卡成就外部调用方法
function EventManager:doCompletedAchievements()
    for k,v in pairs(self.eventSaveData.achievementIdList) do
        --TODO 关卡成就接口
    end
end

---@class EventData
---@field count integer 事件触发次数

---@class EventSaveData
---@field star integer 星级
---@field achievementIdList table<integer, integer> 达成的成就ID列表
---@field deductStarIdList table<integer, integer> 扣除星级事件ID列表

---@class BattleHistoryEventData
---@field battleEventList table<integer, table<integer, EventData>> 本次战斗需要的事件列表
---@field eventPlayList table<integer, table<integer, table<integer, table>>> 待演出事件列表
---@field eventSaveData EventSaveData 战斗事件额外保存数据

--获取战斗事件系统数据(保存战斗数据外部调用)
---@return BattleHistoryEventData
function EventManager:getBattleEventData()
    local eventData = {
        battleEventList = tablex.copy(self.battleEventList),
        isShowEventPlayList = tablex.copy(self.isShowEventPlayList),
        eventSaveData = tablex.copy(self.eventSaveData),
    }
    return eventData
end

--设置战斗事件系统数据(重设战斗数据外部调用)
---@param eventData BattleHistoryEventData
function EventManager:setBattleEventData(eventData)
    for k,v in pairs(eventData) do
        self[k] = tablex.copy(v)
    end
    self._sortedBattleEventIds = {}
    self._battleEventOrderDirty = {}
    for timingPoint, _ in pairs(self.battleEventList) do
        self._battleEventOrderDirty[timingPoint] = true
    end
end

---清理事件演出物体(回退中使用)
function EventManager:ClearBattleEventShowObj()
    local battleMgr = BattleCore:getBattleMgr()
    local showManager = battleMgr:getShowManager()
    for eventId, _ in pairs(self.isShowEventPlayList) do
        showManager:removeEventObj(eventId)
    end
end

---刷新当前事件演出物体(回退中使用)
function EventManager:RefreshBattleEventShowObj()
    for eventId, perfConfigList in pairs(self.isShowEventPlayList) do
        for _, perfConfig in pairs(perfConfigList) do --同事件中多表现处理
            self.nowPreEventfConfig = Config.GetPveLevelTriggerInfo(eventId)
            self.performanceFunc[perfConfig.type](perfConfig)
        end
    end
end

--获取事件系统保存的需要后端记录的数据(结算时外部调用)
function EventManager:getToServerEventSaveData()
    local battleMgr = BattleCore:getBattleMgr()
    ---@type BattleResultData
    local resultData = {
        star = self.eventSaveData.star,
        achieveList = self.eventSaveData.achievementIdList or {},
        rounds = battleMgr:getCurrentRound(),
        backtraceTimes = 99 - battleMgr:getBacktraceTimes(),
        friendCampDamage = battleMgr:getFriendCampAllDamageValue(),
    }
    return resultData
end

--获取事件系统保存的扣除星级事件id(结算界面使用)
function EventManager:getDeductStarIdList()
    return self.eventSaveData.deductStarIdList or {}
end

---获取当前战斗星级
---@return integer
function EventManager:getBattleStar()
    return self.eventSaveData.star or 0
end

--获取事件系统控制的战斗结束结果
function EventManager:getEventLevelTarget()
    return self.haveEventLevelTarget
end

function EventManager:getCloneEventLevelTarget()
    return tablex.clone(self.haveEventLevelTarget)
end

function EventManager:resetEventLevelTarget(haveEventLevelTarget)
    self.haveEventLevelTarget = haveEventLevelTarget
end

function EventManager:clear()
    self.battleEventList = {}
    self._sortedBattleEventIds = {}
    self._battleEventOrderDirty = {}

    self.eventPlayList = {}

    self.eventSaveData = {}

    self.nowEventConfig = nil

    self.haveEventLevelTarget = {
        isWin = false,
        isLose = false,
    }

    self.nowPreEventfConfig = nil

    self.removePrefIdList = {}
    self.isShowEventPlayList = {}
end

--拓展方法
function EventManager:extendFunc()
    --扩展列表
    local extend_list = 
    {
        "EventCondition",--事件触发条件脚本
        "EventResult",--事件触发结果脚本
        "EventPerformance",--事件表现效果脚本
    }

    for _, name in pairs(extend_list) do
        ReloadModule(name)
    end
end

--初始化事件核心方法
function EventManager:setEventFunc()
    --事件触发条件初始化
    self:registerBattleEventCondition()
    --事件触发结果初始化
    self:registerBattleEventResult()
    --事件表现效果
    self:registerBattleEventPerformance()
end

return EventManager