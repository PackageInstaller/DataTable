module("training.TrainingManager", Class.impl(Manager))

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
    -- 开始累计时间戳0-未玩过
    self.startTime = nil
    -- 精英点
    self.elite = nil
    -- 已经触发的商人次数
    self.shopActiveTimes = nil
    -- 商人的状态0-未触发1-触发了未购买
    self.shopState = nil
    -- 已经产出的奖励列表
    self.gainAwardList = nil

    -- 训练阶段id
    self.stepId = nil
    -- 训练副本id
    self.dupId = nil

    -- 模拟训练-配置字典
    self.m_configDic = nil
    -- 模拟训练-随机事件字典
    self.m_eventDic = nil
    -- 模拟训练-副本配置字典
    self.m_dupConfigDic = nil
    -- 模拟训练-商店配置字典
    self.m_shopConfigDic = nil
end

--析构函数
function dtor(self)
end

function parseTrainingConfigData(self)
    self.m_eventDic = {}
    self.m_configDic = {}
    local baseData = RefMgr:getData("training_data")
    for stepId, data in pairs(baseData) do
        if (not self.m_eventDic[stepId]) then
            self.m_eventDic[stepId] = {}
        end
        for eventId, eventData in pairs(data.event) do
            local eventConfigVo = training.TrainingEventConfigVo.new()
            eventConfigVo:parseData(eventId, eventData)
            self.m_eventDic[stepId][eventConfigVo.eventId] = eventConfigVo
        end

        local vo = LuaPoolMgr:poolGet(training.TrainingConfigVo)
        vo:parseData(stepId, data)
        self.m_configDic[vo.stepId] = vo
    end
end

function parseDupConfigData(self)
    self.m_dupConfigDic = {}
    local baseData = RefMgr:getData("training_dup_data")
    for dupId, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(training.TrainingDupConfigVo)
        vo:parseData(dupId, data)
        -- if(not self.m_dupConfigDic[vo.stepId])then
        --     self.m_dupConfigDic[vo.stepId] = {}
        -- end
        -- self.m_dupConfigDic[vo.stepId][dupId] = vo
        self.m_dupConfigDic[dupId] = vo
    end
end

function parseShopConfigData(self)
    self.m_shopConfigDic = {}
    local baseData = RefMgr:getData("training_shop")
    for activeTimes, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(training.TrainingShopConfigVo)
        vo:parseData(activeTimes, data)
        self.m_shopConfigDic[vo.activeTimes] = vo
    end
end

-- 根据训练阶段id获取训练配置vo
function getTrainingConfigVo(self, stepId)
    if (not self.m_configDic) then
        self:parseTrainingConfigData()
    end
    stepId = stepId or self.stepId or 0
    return self.m_configDic[stepId]
end

-- 根据训练事件id获取事件配置vo
function getTrainingEventConfigVo(self, stepId, eventId)
    if (not self.m_eventDic) then
        self:parseTrainingConfigData()
    end
    stepId = stepId or self.stepId or 0
    eventId = eventId or 0
    if (self.m_eventDic[stepId]) then
        return self.m_eventDic[stepId][eventId]
    end
    return nil
end

-- 根据副本id获取副本配置vo
function getTrainingDupConfigVo(self, dupId)
    if (not self.m_dupConfigDic) then
        self:parseDupConfigData()
    end
    -- stepId = stepId or self.stepId or 0
    dupId = dupId or self.dupId or 0
    -- if(self.m_dupConfigDic[stepId])then
    --     return self.m_dupConfigDic[stepId][dupId]
    -- end
    return self.m_dupConfigDic[dupId]
    -- return nil
end

-- 根据商店触发次数获取商店配置vo
function getTrainingShopConfigVo(self, activeTimes)
    if (not self.m_shopConfigDic) then
        self:parseShopConfigData()
    end
    activeTimes = activeTimes or self.shopActiveTimes or 0
    if (self.m_shopConfigDic[activeTimes]) then
        return self.m_shopConfigDic[activeTimes]
    end
    return nil
end

-- 战斗结算界面用
function getDupName(self, dupId)
    if (not self.m_dupConfigDic) then
        self:parseDupConfigData()
    end
    for stepId, dupVo in pairs(self.m_dupConfigDic) do
        if (dupVo.dupId == dupId) then
            -- 策划说固定显示
            return _TT(43002), _TT(43006)
        end
    end
    return "", ""
end

---------------------------------------------------------------------------------服务器数据---------------------------------------------------------------------------------
-- 返回面板信息
function parsePanelInfoMsgHandler(self, msg)
    self.startTime = msg.start_time
    self.stepId = msg.step_id
    self.dupId = msg.dup_id
    self.elite = msg.score
    self.shopActiveTimes = msg.businessman_times
    self.shopState = msg.businessman_state
    self.gainAwardList = {}
    for _, v in pairs(msg.award_list) do
        local propsVo = LuaPoolMgr:poolGet(props.PropsVo)
        propsVo:setPropsAwardMsgData(v)
        table.insert(self.gainAwardList, propsVo)
    end
end

function getDeltaTime(self)
    if (self.startTime == nil or self.startTime == 0) then
        return 0
    else
        local clientTime = GameManager:getClientTime()
        local maxDeltaTime = sysParam.SysParamManager:getValue(SysParamType.TRAINING_MAX_MINUTE) * 60
        local deltaTime = clientTime - self.startTime
        return math.min(deltaTime, maxDeltaTime)
    end
end

---------------------------------------------------------------------------------主界面入口状态---------------------------------------------------------------------------------
function getStateStr(self)
    local tipStr = nil
    local titleStr = nil

    if (not tipStr and self.elite and self.elite >= sysParam.SysParamManager:getValue(SysParamType.TRAINING_MAX_ELITE)) then
        tipStr = _TT(43002) --"阶段考核"
    end
    if (not tipStr and self.shopState and self.shopState == 1) then
        tipStr = _TT(43004) --"加速训练"
    end
    if (not titleStr and self:isBubble()) then
        titleStr = _TT(43005) --"训练完成"
    else
        titleStr = _TT(43006) --"模拟训练"
    end

    return titleStr or "", tipStr or ""
end

---------------------------------------------------------------------------------红点---------------------------------------------------------------------------------
function isBubble(self)
    local isBubble = false
    local minTime = sysParam.SysParamManager:getValue(SysParamType.TRAINING_BUBBLE_TIP_TIME)
    if (self:getDeltaTime() >= minTime * 60) then
        isBubble = true
    end
    return isBubble
end

function isBubbleChange(self)
    local isChange = false
    local isBubble = self:isBubble()
    if (self.m_isBubble ~= isBubble) then
        self.m_isBubble = isBubble
        isChange = true
    end
    return isChange
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
