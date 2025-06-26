--[[ 
-----------------------------------------------------
@filename       : MiningManager
@Description    : 捞宝藏数据管理
@date           : 2023-11-28 17:22:32
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.manager.MiningManager', Class.impl(Manager))

-- 任务更新
EVENT_TASK_UPDATE = "EVENT_TASK_UPDATE"
-- 阶段奖励更新
EVENT_STAR_AWARD_UPDATE = "EVENT_STAR_AWARD_UPDATE"

-- 新副本开启提示缓存
DupNewOpenStorageKey = "DupNewOpenStorageKey"

--构造
function ctor(self)
    super.ctor(self)
    self:init()
end

-- Override 重置数据
function resetData(self)
    self:init()
end

--析构
function dtor(self)
end

--初始化
function init(self)
    -- 当前波次
    self.currWave = 1
    -- 当前积分
    self.currScore = 0
    -- 当前抓取物id
    self.currCatchId = 0
    -- 抓子状态0 收爪 1 伸爪
    self.currCatchState = 0

    -- 抓到菠菜加速
    self.spinachSpeed = 0
    -- 菠菜加速结束时间
    self.spinachOverTime = 0

    -- 宝箱打开得到的id
    self.boxCatchEventId = 0

    -- 抓取速度
    self.mGrabSpeed = 1

    self.mTaskConfigDic = nil
    -- 副本信息
    self.mDupInfoDic = {}
    -- 当前通关的副本id，缓存用于可能断线没发送给后端成功
    self.passDupId = nil
end

function parseConfigData(self)
    self.mMiningDupData = {}
    local baseData = RefMgr:getData("miner_dup_data")
    for key, data in pairs(baseData) do
        local baseVo = mining.MiningDupVo.new()
        baseVo:parseData(key, data)
        self.mMiningDupData[key] = baseVo
    end

    self.mMiningWaveData = {}
    local baseData = RefMgr:getData("miner_wave_data")
    for key, data in pairs(baseData) do
        local baseVo = mining.MiningWaveVo.new()
        baseVo:parseData(key, data)
        self.mMiningWaveData[key] = baseVo
    end

    self.mMiningEventData = {}
    local baseData = RefMgr:getData("miner_event_data")
    for key, data in pairs(baseData) do
        local baseVo = mining.MiningEventVo.new()
        baseVo:parseData(key, data)
        self.mMiningEventData[key] = baseVo
    end

    self.mStarConfigDic = {}
    local baseData = RefMgr:getData("miner_star_data")
    for key, data in pairs(baseData) do
        local baseVo = mining.MiningStarVo.new()
        baseVo:parseData(key, data)
        self.mStarConfigDic[key] = baseVo
    end

    self.mSkillConfigDic = {}
    local baseData = RefMgr:getData("miner_event_skill_data")
    for key, data in pairs(baseData) do
        local baseVo = mining.MiningSkillVo.new()
        baseVo:parseData(key, data)
        self.mSkillConfigDic[key] = baseVo
    end

    self.mTaskConfigDic = {}
    local baseData = RefMgr:getData("miner_task_data")
    for key, data in pairs(baseData) do
        local baseVo = mining.MiningTaskVo.new()
        baseVo:parseData(key, data)
        self.mTaskConfigDic[key] = baseVo
    end

    self.mRewardConfigDic = {}
    local baseData = RefMgr:getData("miner_reward_data")
    for key, data in pairs(baseData) do
        local baseVo = mining.MiningRewardVo.new()
        baseVo:parseData(key, data)
        self.mRewardConfigDic[key] = baseVo
    end

end

--- *s2c* 挖矿信息 18130
function onParseMinerPanelMsg(self, msg)
    self.mStarAwardStateList = msg.gained_list
    self.mDupInfoDic = {}
    for i, v in ipairs(msg.dup_list) do
        self.mDupInfoDic[v.id] = v.point
    end

    for i, v in ipairs(msg.task_list) do
        local taskVo = self:getTaskConfigVo(v.id)
        if not taskVo then
            logError("===========矿工任务数据前后端不一致===========" .. v.id)
        end
        taskVo:parseMsg(v)
    end
end

--- *s2c* 挖矿任务进度更新 18132
function onParseMinerTaskUpdateMsg(self, msg)
    local taskVo = self:getTaskConfigVo(msg.task_info.id)
    if not taskVo then
        logError("===========矿工任务数据前后端不一致===========")
    end
    taskVo:parseMsg(msg.task_info)
    self:dispatchEvent(self.EVENT_TASK_UPDATE)
end

--- *s2c* 挖矿任务领取 返回 18134
function onParseMinerTaskGainMsg(self, msg)
    for i, v in ipairs(msg.task_id_list) do
        local taskVo = self:getTaskConfigVo(v)
        if not taskVo then
            logError("===========矿工任务数据前后端不一致===========")
        end
        taskVo.state = 2
    end
    self:dispatchEvent(self.EVENT_TASK_UPDATE)
end

--- *s2c* 更新挖矿信息 18136
function onParseMinerInfoMsg(self, msg)
    self.mDupInfoDic[msg.dup_info.id] = msg.dup_info.point
end

--- *s2c* 挖矿获取阶段奖励返回 18138
function onParseMinerRewardMsg(self, msg)
    if msg.result == 1 then
        for i, v in ipairs(msg.id_list) do
            table.insert(self.mStarAwardStateList, v)
        end
        self:dispatchEvent(self.EVENT_STAR_AWARD_UPDATE)
    end
end

-- 取副本的积分
function getPlayerDupRecord(self, dupId)
    return self.mDupInfoDic[dupId] or 0
end

-- 阶段奖励状态
function getStarAwardState(self, starAward_id)
    if not self.mStarAwardStateList then
        return false
    end
    if table.indexof(self.mStarAwardStateList, starAward_id) ~= false then
        return true
    end
    return false
end

-- 判断是否有阶段奖励可领取
function getStarHaveAward(self)
    local curStar = 0
    for _, dupVo in pairs(self:getDupList()) do
        curStar = curStar + self:getPlayerDupStar(dupVo.id)
    end

    local isHaveAward = false
    local starRewardList = self:getRewardList()
    for i = 1, #starRewardList do
        local rewardVo = starRewardList[i]
        local isGet = self:getStarAwardState(rewardVo.id)
        if curStar >= starRewardList[i].star_num and isGet == false then
            isHaveAward = true
            break
        end
    end

    return isHaveAward
end

-- 是否有任务奖励可领取
function hasTaskAward(self)
    local list = self:getTasklist()
    for i, taskVo in ipairs(list) do
        if taskVo.state == 0 then
            return true
        end
    end
    return false
end

-- 是否有副本新开放
function hasDupOpenRed(self)
    for i, dupVo in ipairs(self:getDupList()) do
        local isOpen = not self:getDupIsLock(dupVo) and self:getDupIsOpenTime(dupVo)
        if isOpen and not StorageUtil:getBool1(mining.MiningManager.DupNewOpenStorageKey .. dupVo.id) then
            return true
        end
    end
    return false
end

-- 获取冬雪捕捞是否需要红点提示
function getAllRed(self)
    if self:getStarHaveAward() then
        return true
    end
    if self:hasTaskAward() then
        return true
    end
    if self:hasDupOpenRed() then
        return true
    end
    return false
end



-- 取副本列表
function getDupList(self)
    if not self.mMiningDupData then
        self:parseConfigData()
    end
    local list = table.values(self.mMiningDupData)
    table.sort(list, function(a, b)
        return a.id < b.id
    end)
    return list
end

-- 取副本数据
function getDupVo(self, cusId)
    if not self.mMiningDupData then
        self:parseConfigData()
    end
    return self.mMiningDupData[cusId]
end

-- 波次数据
function getWaveVo(self, cusId)
    if not self.mMiningWaveData then
        self:parseConfigData()
    end
    return self.mMiningWaveData[cusId]
end

-- 随机取一个波次数据
function getRandomWaveVo(self)
    if not self.mMiningWaveData then
        self:parseConfigData()
    end
    local keys = table.keys(self.mMiningWaveData)
    local index = math.random(1, #keys)
    local key = keys[index]
    return self.mMiningWaveData[key]
end

-- 事件数据
function getEventVo(self, cusId)
    if not self.mMiningEventData then
        self:parseConfigData()
    end
    return self.mMiningEventData[cusId]
end

--获取星星配置
function getStarConfigVo(self, cusId)
    if not self.mStarConfigDic then
        self:parseConfigData()
    end

    return self.mStarConfigDic[cusId]
end

-- 获取事件技能配置
function getEventSkillVo(self, cusId)
    if not self.mSkillConfigDic then
        self:parseConfigData()
    end

    return self.mSkillConfigDic[cusId]
end

-- 取任务配置
function getTaskConfigVo(self, cusId)
    if not self.mTaskConfigDic then
        self:parseConfigData()
    end
    return self.mTaskConfigDic[cusId]
end

-- 取任务列表
function getTasklist(self)
    if not self.mTaskConfigDic then
        self:parseConfigData()
    end
    local list = table.values(self.mTaskConfigDic)
    table.sort(list, function(a, b)
        if a.state < b.state then
            return true
        elseif a.state > b.state then
            return false
        else
            return a.id < b.id
        end
    end)
    return list
end

-- 取副本列表
function getRewardList(self)
    if not self.mRewardConfigDic then
        self:parseConfigData()
    end
    local list = table.values(self.mRewardConfigDic)
    table.sort(list, function(a, b)
        return a.id < b.id
    end)
    return list
end

-- 是否锁定未开放
function getDupIsLock(self, dupVo)
    if dupVo.preId == 0 then
        return false
    end
    local record = self:getPlayerDupRecord(dupVo.preId)
    if record > 0 then
        return false
    end
    return true
end

-- 是否开放时间
function getDupIsOpenTime(self, dupVo)
    local isOpen = true
    if not table.empty(dupVo.beginTime) then
        local openTime = TimeUtil.transTime2(dupVo.beginTime)
        isOpen = GameManager:getClientTime() > openTime
    end
    return isOpen
end




-- 抓取速度
function getGrabSpeed(self)
    if self.spinachOverTime > GameManager:getClientTime() then
        -- 菠菜加速
        return self.spinachSpeed
    end
    return self.mGrabSpeed
end

-- 抓取速度
function setGrabSpeed(self, speed)
    self.mGrabSpeed = speed
end

-- 获取抓取到的分数
function getCatchScore(self)
    local catchId = self.currCatchId
    local idList = string.split(catchId, "_")
    local eventId = tonumber(idList[2])
    if self.boxCatchEventId > 0 then
        -- 宝箱的优先
        eventId = self.boxCatchEventId
        self.boxCatchEventId = 0
    end
    local eventVo = mining.MiningManager:getEventVo(eventId)
    if eventVo and eventVo.point > 0 then
        return eventVo.point
    end
    return 0
end

-- 获取积分星级
function getPlayerDupStar(self, dupId, record)
    local star = 0
    local dupVo = self:getDupVo(dupId)
    record = record or self:getPlayerDupRecord(dupId)
    if dupVo then
        for i = 1, #dupVo.starList do
            local starConfigVo = self:getStarConfigVo(dupVo.starList[i])
            if record >= starConfigVo.point then
                star = i
            end
        end
    end

    return star
end

return _M