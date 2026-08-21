--[[ 
-----------------------------------------------------
@filename       : EliminateManager
@Description    : 消消乐
@date           : 2020-12-24 16:31:09
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('eliminate.EliminateManager', Class.impl(Manager))

-- 新关卡开启提示缓存
StageNewOpenStorageKey = "StageNewOpenStorageKey"

--构造
function ctor(self)
    super.ctor(self)
    self:__init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    -- 区域配置列表
    self.mAreanConfigList = nil
    -- 任务奖励配置列表
    self.mTaskConfigList = nil
    -- 关卡（消消乐）配置列表
    self.mStageConfigList = nil
    -- 瓦片（消消乐）配置字典
    self.mMapTileConfigDic = nil
    -- 物件的类型相关信息数据配置字典
    self.mThingConfigDic = nil

    -- 当前局已经消除物件类型数量字典
    self.mNowThingCountDic = nil
end

-- 解析配置
function parseConfigData(self)
    self.mAreanConfigList = {}
    self.mStageConfigList = {}
    self.mMapTileConfigDic = {}
    self.mTaskConfigList = {}
    self.mThingConfigDic = {}

    local baseData = RefMgr:getData("xiaoxiaole_area_data")
    for areaId, data in pairs(baseData) do
        local areaConfigVo = LuaPoolMgr:poolGet(eliminate.EliminateAreaConfigVo)
        areaConfigVo:setData(areaId, data)
        table.insert(self.mAreanConfigList, areaConfigVo)
    end
    table.sort(self.mAreanConfigList, function(arenaConfigVo_1, arenaConfigVo_2)
        if (arenaConfigVo_1.areaId ~= arenaConfigVo_2.areaId) then
            return arenaConfigVo_1.areaId < arenaConfigVo_2.areaId
        end
        return false
    end)

    local baseData = RefMgr:getData("xiaoxiaole_dup_data")
    for stageId, stageData in pairs(baseData) do
        local stageConfigVo = LuaPoolMgr:poolGet(eliminate.EliminateStageConfigVo)
        stageConfigVo:setData(stageId, stageData)
        table.insert(self.mStageConfigList, stageConfigVo)

        local tileConfigDic = self.mMapTileConfigDic[stageConfigVo.mapId]
        if(not tileConfigDic)then
            tileConfigDic = {}
            self.mMapTileConfigDic[stageConfigVo.mapId] = tileConfigDic
        end
        for _, tileData in pairs(stageData.thing_list) do
            if(tileData.is_invalid == 0)then
                local tileConfigVo = LuaPoolMgr:poolGet(eliminate.EliminateTileConfigVo)
                tileConfigVo:setData(stageConfigVo.mapId, tileData)
                local keyRowCol = eliminate.GetTileIdByRowCol(tileConfigVo.rowIndex, tileConfigVo.colIndex)
                tileConfigDic[keyRowCol] = tileConfigVo
            end
        end
    end
    table.sort(self.mStageConfigList, function(stageConfigVo_1, stageConfigVo_2)
        if (stageConfigVo_1.mapId ~= stageConfigVo_2.mapId) then
            return stageConfigVo_1.mapId < stageConfigVo_2.mapId
        end
        return false
    end)
    
    local baseData = RefMgr:getData("xiaoxiaole_task_data")
    for taskId, data in pairs(baseData) do
        local taskConfigVo = LuaPoolMgr:poolGet(eliminate.EliminateTaskConfigVo)
        taskConfigVo:setData(taskId, data)
        table.insert(self.mTaskConfigList, taskConfigVo)
    end
    table.sort(self.mTaskConfigList, function(taskConfigVo_1, taskConfigVo_2)
        if (taskConfigVo_1.taskId ~= taskConfigVo_2.taskId) then
                return taskConfigVo_1.taskId < taskConfigVo_2.taskId 
        end
        return false
    end)

    local baseData = RefMgr:getData("xiaoxiaole_thing_data")
    for type, data in pairs(baseData) do
        local thingConfigVo = LuaPoolMgr:poolGet(eliminate.EliminateThingConfigVo)
        thingConfigVo:setData(type, data)
        self.mThingConfigDic[thingConfigVo.type] = thingConfigVo
    end
end

function getTaskConfigList(self)
    if(not self.mTaskConfigList)then
        self:parseConfigData()
    end
    return self.mTaskConfigList
end

function getAreaConfigList(self)
    if(not self.mAreanConfigList)then
        self:parseConfigData()
    end
    return self.mAreanConfigList
end

function getMapStageConfigList(self)
    if(not self.mStageConfigList)then
        self:parseConfigData()
    end
    return self.mStageConfigList
end

function getMapTileConfigDic(self)
    if(not self.mMapTileConfigDic)then
        self:parseConfigData()
    end
    return self.mMapTileConfigDic
end

function getMapStageConfigVo(self, mapId)
    local mapStageConfigList = self:getMapStageConfigList()
    for i = 1, #mapStageConfigList do
        local stageConfigVo = mapStageConfigList[i]
        if(stageConfigVo.mapId == mapId)then
            return stageConfigVo
        end
    end
    return nil
end

function getTileConfigDic(self, mapId)
    local mapTileConfigDic = self:getMapTileConfigDic()
    return mapTileConfigDic[mapId]
end

function getTileConfigVo(self, mapId, rowIndex, colIndex)
    local mapTileConfigDic = self:getTileConfigDic(mapId)
    if(mapTileConfigDic)then
        return mapTileConfigDic[eliminate.GetTileIdByRowCol(rowIndex, colIndex)]
    end
    return nil
end

function getTopTileConfigVoByCol(self, mapId, colIndex)
    local mapTileConfigDic = self:getTileConfigDic(mapId)
    if(mapTileConfigDic)then
        local configVo = nil
        for keyRowCol, tileConfigVo in pairs(mapTileConfigDic) do
            if(tileConfigVo.colIndex == colIndex)then
                if(not configVo)then
                    configVo = tileConfigVo
                else
                    if(configVo.rowIndex < tileConfigVo.rowIndex)then
                        configVo = tileConfigVo
                    end
                end
            end
        end
        return configVo
    end
end

function getBottomTileConfigVoByCol(self, mapId, colIndex)
    local mapTileConfigDic = self:getTileConfigDic(mapId)
    if(mapTileConfigDic)then
        local configVo = nil
        for keyRowCol, tileConfigVo in pairs(mapTileConfigDic) do
            if(tileConfigVo.colIndex == colIndex)then
                if(not configVo)then
                    configVo = tileConfigVo
                else
                    if(configVo.rowIndex > tileConfigVo.rowIndex)then
                        configVo = tileConfigVo
                    end
                end
            end
        end
        return configVo
    end
end

function getThingConfigVo(self, type)
    if(not self.mThingConfigDic)then
        self:parseConfigData()
    end
    return self.mThingConfigDic[type]
end

function setRunStageConfigVo(self, stageConfigVo)
    self.mStageConfigVo = stageConfigVo
end

function getRunStageConfigVo(self)
    return self.mStageConfigVo
end

-- 记录消除的同类物件数量
function setNowThingCountDic(self, dic)
    self.mNowThingCountDic = dic
end

function addNowThingCountDic(self, typeDic)
    for _, thingType in pairs(typeDic)do
        self:addNowThingCount(thingType, false)
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_ELIMINATE_COUNT)
    GameDispatcher:dispatchEvent(EventName.REQ_ELIMINATE_RECORD, typeDic)
end

function addNowThingCount(self, thingType, isDispatch)
    if(not self.mNowThingCountDic)then
        self.mNowThingCountDic = {}
    end
    self.mNowThingCountDic[thingType] = self:getNowThingCount(thingType) + 1
    if(isDispatch)then
        GameDispatcher:dispatchEvent(EventName.UPDATE_ELIMINATE_COUNT)
    end
end

function getNowThingCount(self, thingType)
    if(not self.mNowThingCountDic)then
        self.mNowThingCountDic = {}
    end
    return self.mNowThingCountDic[thingType] or 0
end


---------------------------------------------------------------------------- 协议数据 ----------------------------------------------------------------------------
-- 解析已通关关卡id
function praseHadPassStageIdList(self, hadPassStageIdList)
    self.mHadPassStageIdList = hadPassStageIdList
    GameDispatcher:dispatchEvent(EventName.UPDATE_ELIMINATE_PASS_STAGE_LIST)
end

-- 解析任务列表
function praseTaskList(self, taskMsgList)
    self.mTaskList = {}
    for i = 1, #taskMsgList do
        local taskVo = LuaPoolMgr:poolGet(task.TaskVo)
        taskVo:parseData(taskMsgList[i])
        table.insert(self.mTaskList, taskVo)
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_ELIMINATE_TASK_LIST)
end

-- 解析任务
function praseTask(self, taskMsg)
    local taskVo = self:getTaskVoById(taskMsg.id)
    if(taskVo)then
        taskVo:parseData(taskMsg)
        GameDispatcher:dispatchEvent(EventName.UPDATE_ELIMINATE_TASK, taskVo)
    end
end

function getTaskVoById(self, taskId)
    if(self.mTaskList and #self.mTaskList > 0)then
        for i = 1, #self.mTaskList do
            if(self.mTaskList[i].id == taskId)then
                return self.mTaskList[i]
            end
        end
    end
end

-- 是否指定区域是否已经通关
function isAreaPass(self, areaConfigVo)
    local isPass = true
    for i = 1, #areaConfigVo.stageIdList do
        if(not self:isStagePass(areaConfigVo.stageIdList[i]))then
            isPass = false
        end
    end
    return isPass
end

-- 是否指定关卡是否已经通关
function isStagePass(self, stageId)
    if(not self.mHadPassStageIdList)then
        return false
    else
        return table.indexof(self.mHadPassStageIdList, stageId) ~= false
    end
end

-- 是否有任务可领取
function hasTaskAward(self)
    local isBubble = false
    local taskConfigList = self:getTaskConfigList()
    for i = 1, #taskConfigList do
        local taskVo = self:getTaskVoById(taskConfigList[i].taskId)
        if(taskVo and taskVo:getState() == task.AwardRecState.CAN_REC)then
            isBubble = true
            break
        end
    end
    return isBubble
end

-- 是否有关卡新开放
function hasAreaOpenRed(self)
    local areaConfigList = eliminate.EliminateManager:getAreaConfigList()
    for i = 1, #areaConfigList do
        local areaConfigVo = areaConfigList[i]
        if(self:hasStageOpenRed(areaConfigVo))then
            return true
        end
    end
    return false
end

-- 是否有关卡新开放
function hasStageOpenRed(self, areaConfigVo)
    local stageIdList = areaConfigVo.stageIdList
    for i = 1, #stageIdList do
        local stageConfigVo = self:getMapStageConfigVo(stageIdList[i])
        local isOpen = not stageConfigVo:isLock() and stageConfigVo:isOpen()
        if isOpen and not StorageUtil:getBool1(eliminate.EliminateManager.StageNewOpenStorageKey .. stageIdList[i]) then
            return true
        end
    end
    return false
end

-- 获取消消乐是否需要红点提示
function getAllRed(self)
    if self:hasTaskAward() then
        return true
    end
    if self:hasAreaOpenRed() then
        return true
    end

    return false
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
