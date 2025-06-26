--[[ 
-----------------------------------------------------
@filename       : NoviceActivityConst
@Description    : 新手活动管理器
@date           : 2023-6-5 16:50:35
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.noviceActivity.manager.NoviceActivityManager', Class.impl(Manager))
UPDATE_RED = "UPDATE_RED"
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

--初始化
function __init(self)
    self.mNoviceActivityPlanList = {}
    self.mNoviceActivityPlanTaskDic = nil
    self.mNoviceActivityPlanDic = nil
    -- 招募 
    self.heroRecruitedTimes = 0
    self.mActivityRecruitConfig = {}
    self.mActivityRecruitMsgDic = {}
    -- 手环招募 
    self.braceletsRecruitedTimes = 0
    self.mActivityBraceletsConfig = {}
    self.mActivityBraceletMsgDic = {}

    --成长返还
    self.mActivityReturnConfig = {}
    self.mActivityReturnMsgDic = {}
    self.todoEventList = {}

    self.rechargeEndTime = nil
    self.totalCount = nil
    self.rewardList = nil
    
    self.ssrEndTime = nil
    self.ssrState = nil
    --self.rewardList 
end

function setNoviceUpdate(self, canUpdate)
    self.update = canUpdate
end

function getNoviceUpdate(self)
    return self.update
end

function setTodoEvent(self, call, act)
    table.insert(self.todoEventList, { fun = call, act = act })
    --self.todoEvent = call
end

function todoEvent(self)
    for k, v in pairs(self.todoEventList) do
        if v then
            v:fun(v.act)
        end
    end
    self.todoEvent = {}
    -- if self.todoEvent then
    --     self:todoEvent()
    --     self.todoEvent = nil
    -- end
end

--解析抽奖配置
function parseNoviceStrollData(self)
    self.mRaffleDic = {}
    self.mRaffleMaxId = 0
    local baseData = RefMgr:getData("novice_stroll_data")
    for id, data in pairs(baseData) do
        local vo = noviceActivity.NoviceActivityRaffleVo.new()
        vo:parseRaffleData(id, data)
        self.mRaffleDic[id] = vo
        self.mRaffleMaxId = id > self.mRaffleMaxId and id or self.mRaffleMaxId
    end
end

function getNoviceStrollMaxId(self)
    if self.mRaffleDic == nil then
        self:parseNoviceStrollData()
    end
    return self.mRaffleMaxId
end
--获取抽奖配置
function getNoviceStrollData(self, step)
    if self.mRaffleDic == nil then
        self:parseNoviceStrollData()
    end
    return self.mRaffleDic[step]
end

--解析转盘数据
function parseServeRaffle(self, msg)
    self.m_RaffleTime = msg.end_time
    self.gear = msg.gear
    --GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_RED_STATE)
end

--解析转盘结果
function parseServerRaffleDraw(self, msg)
    self.gear = msg.gear
    self.pos = msg.pos
    --GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_RED_STATE)
    GameDispatcher:dispatchEvent(EventName.UPDATE_RAFFLE_REWARD)
end

--获取抽奖阶段
function getServerRaffleGear(self)
    return self.gear
end

--获取抽奖时间
function getRaffleTime(self)
    return self.m_RaffleTime
end

--获取抽奖位置
function getRafflePos(self)
    return self.pos
end

function checkRaffleBubble(self)
    local isRed = false
    if self.gear then
        local raffleData = self:getNoviceStrollData(self.gear)
        if raffleData then
            if MoneyUtil.judgeNeedMoneyCountByTid(raffleData.cost[1], raffleData.cost[2], true, true) then
                isRed = true
            end
        end
    end
    return isRed
end

-- 解析升格计划配置表
function parseUpgradePlanConfig(self)
    self.mNoviceActivityPlanDic = {}
    self.mNoviceActivityPlanList = {}
    local baseData = RefMgr:getData("novice_upgrade_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(noviceActivity.NoviceActivityUpgradePlanVo)
        vo:parseConfig(id, data)
        self.mNoviceActivityPlanDic[id] = vo
        table.insert(self.mNoviceActivityPlanList, vo)
    end
end

-- 解析升格计划配置表
function parseUpgradePlanMsg(self, msg)
    self.mNoviceActivityPlanTaskDic = {}
    for _, vo in ipairs(msg.task_list) do
        local taskVo = self:getUpgradePlanDic(vo.id)
        if taskVo then
            taskVo:setState(vo.state)
            taskVo:setCount(vo.count)
            self.mNoviceActivityPlanTaskDic[vo.id] = taskVo
        end
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_UPGRADE_PLAN_VIEW)
    self:dispatchEvent(self.UPDATE_RED, noviceActivity.NoviceActivityConst.NOVICEACTIVITY_PROMOTIONPLAN)
end

-- 解析升格计划配置表
function parseUpgradePlanTaskUpdateMsg(self, msg)
    for _, taskVo in ipairs(msg.task_list) do
        local curTaskVo = self.mNoviceActivityPlanTaskDic[taskVo.id]
        if curTaskVo then
            curTaskVo:setState(taskVo.state)
            curTaskVo:setCount(taskVo.count)
            GameDispatcher:dispatchEvent(EventName.UPDATE_UPGRADE_PLAN_ITEM)
        end
    end
    self:dispatchEvent(self.UPDATE_RED, noviceActivity.NoviceActivityConst.NOVICEACTIVITY_PROMOTIONPLAN)
end

-- 解析升格计划奖励领取
function parseUpgradePlanTaskReciveMsg(self, msg)
    local list = {}
    local taskVo = self.mNoviceActivityPlanTaskDic[msg.id]
    if taskVo then
        taskVo:setState(2)
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_UPGRADE_PLAN_ITEM)
    self:dispatchEvent(self.UPDATE_RED, noviceActivity.NoviceActivityConst.NOVICEACTIVITY_PROMOTIONPLAN)
end

-- 解析招募 配置表
function parseNoviceActivityRecruitConfig(self)
    local baseData = RefMgr:getData("novice_recruit_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(noviceActivity.NoviceActivityRecruitVo)
        vo:parseData(id, data)
        self.mActivityRecruitConfig[id] = vo
    end
end

-- 解析手环 配置表
function parseNoviceActivityBraceletsConfig(self)
    local baseData = RefMgr:getData("novice_create_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(noviceActivity.NoviceActivityCreateVo)
        vo:parseData(id, data)
        self.mActivityBraceletsConfig[id] = vo
    end
end

-- 解析升级返回 配置表
function parseNoviceActivityReturnConfig(self)
    local baseData = RefMgr:getData("novice_return_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(noviceActivity.NoviceActivityReturnVo)
        vo:parseData(id, data)
        self.mActivityReturnConfig[id] = vo
    end
end

-- 解析战员招募MSG
function parseNoviceActivityRecruitMsg(self, msg)
    self.heroRecruitedTimes = msg.recruit_times
    if next(msg.received_list) then
        for _, id in pairs(msg.received_list) do
            self.mActivityRecruitMsgDic[id] = id
        end
    end
    self:dispatchEvent(self.UPDATE_RED, noviceActivity.NoviceActivityConst.NOVICEACTIVITY_LINKPLAN)
end

-- update 战员招募MSG
function updateNoviceActivityRecruitMsg(self, id)
    if self.mActivityRecruitMsgDic[id] == nil then
        self.mActivityRecruitMsgDic[id] = id
    end
    self:dispatchEvent(self.UPDATE_RED, noviceActivity.NoviceActivityConst.NOVICEACTIVITY_LINKPLAN)
end


-- 解析手环招募MSG
function parseNoviceActivityBraceletsMsg(self, msg)
    self.braceletsRecruitedTimes = msg.recruit_times
    if next(msg.received_list) then
        for _, id in pairs(msg.received_list) do
            self.mActivityBraceletMsgDic[id] = id
        end
    end
    self:dispatchEvent(self.UPDATE_RED, noviceActivity.NoviceActivityConst.NOVICEACTIVITY_RECRUITPLAN)
end

-- update 手环招募MSG
function updateNoviceActivityBraceletsMsg(self, id)
    if self.mActivityBraceletMsgDic[id] == nil then
        self.mActivityBraceletMsgDic[id] = id
        --    self.braceletsRecruitedTimes = table.nums(self.mActivityBraceletMsgDic)
    end
    self:dispatchEvent(self.UPDATE_RED, noviceActivity.NoviceActivityConst.NOVICEACTIVITY_RECRUITPLAN)
end


-- 解析战员成长返还MSG
function parseNoviceActivityReturnMsg(self, msg)
    if next(msg.task_list) then
        for _, taskVo in pairs(msg.task_list) do
            self.mActivityReturnMsgDic[taskVo.id] = {
                id = taskVo.id,
                count = taskVo.count,
                --1:未完成，0:已完成未领奖，2：已领取奖励
                state = taskVo.state
            }
        end
    end
    self:dispatchEvent(self.UPDATE_RED, noviceActivity.NoviceActivityConst.NOVICEACTIVITY_RETURN)
    GameDispatcher:dispatchEvent(EventName.UPDATE_RECEIVE_RETURN)
end


--  update  战员成长返还MSG
function updateNoviceActivityReturnMsg(self, msg)
    if next(msg.task_list) then
        for _, taskVo in pairs(msg.task_list) do
            local mTaskVo = self.mActivityReturnMsgDic[taskVo.id]
            mTaskVo.id = taskVo.id
            mTaskVo.count = taskVo.count
            mTaskVo.state = taskVo.state
        end
    end
    self:dispatchEvent(self.UPDATE_RED, noviceActivity.NoviceActivityConst.NOVICEACTIVITY_RETURN)
    GameDispatcher:dispatchEvent(EventName.UPDATE_RECEIVE_RETURN)
end

--  update  战员成长返还MSG
function oReturnAwardRecivedMsg(self, id)
    local mTaskVo = self.mActivityReturnMsgDic[id]
    if mTaskVo then
        mTaskVo.state = 2
    else
        logError("异常Msg数据，领取Id 不在之前后端数据中")
        self.mActivityReturnMsgDic[id] = {
            id = id,
            count = 999,
            --1:未完成，0:已完成未领奖，2：已领取奖励
            state = 2
        }
    end
    self:dispatchEvent(self.UPDATE_RED, noviceActivity.NoviceActivityConst.NOVICEACTIVITY_RETURN)
end


-- 检查招募奖品是否领取
function checkRecruitReceived(self, id)
    if self:getRecuitItemConfigById(id) ~= nil then
        return self.mActivityRecruitMsgDic[id] ~= nil
    else
        error("task Id is not in Config Table")
    end
end

-- 检查招募奖品是否领取
function checkBraceletsReceived(self, id)
    if self:getBraceletsRecuitItemConfigById(id) ~= nil then
        return self.mActivityBraceletMsgDic[id] ~= nil
    else
        error("task Id is not in Config Table")
    end
end

-- 检查成长返还是否领取
function checkReturnReceived(self, id)
    if self:getReturnConfigById(id) ~= nil then
        local msgVo =    self.mActivityReturnMsgDic[id]
        if msgVo then
            return msgVo.state == 0
        else
            return false
        end
    else
        error("task Id is not in Config Table")
    end
end


function getUpgradePlanList(self)
    local list = {}
    if self.mNoviceActivityPlanTaskDic then
        for k, taskVo in pairs(self.mNoviceActivityPlanTaskDic) do
            table.insert(list, taskVo)
        end
        table.sort(list, function(vo1, vo2)
            return vo1:getState() < vo2:getState()
        end)
    end
    return list
end

function getUpgradePlanDic(self, id)
    if not self.mNoviceActivityPlanDic then
        self:parseUpgradePlanConfig()
    end
    return self.mNoviceActivityPlanDic[id]
end

-- 返回活动招募奖励列表
function getRecuitConfig(self)
    if next(self.mActivityRecruitConfig) == nil then
        self:parseNoviceActivityRecruitConfig()
    end
    return self.mActivityRecruitConfig
end

-- 返回活动铸痕奖励列表
function getBraceletsConfig(self)
    if next(self.mActivityBraceletsConfig) == nil then
        self:parseNoviceActivityBraceletsConfig()
    end
    return self.mActivityBraceletsConfig
end

-- 返回成长返回奖励列表
function getReturnConfig(self)
    if next(self.mActivityReturnConfig) == nil then
        self:parseNoviceActivityReturnConfig()
    end
    return self.mActivityReturnConfig
end


--获得 活动招募配置表Vo
function getRecuitItemConfigById(self, id)
    if next(self.mActivityRecruitConfig) == nil then
        self:parseNoviceActivityRecruitConfig()
    end

    return self.mActivityRecruitConfig[id]
end

--获得 活动 手环招募配置表Vo
function getBraceletsRecuitItemConfigById(self, id)
    if next(self.mActivityBraceletsConfig) == nil then
        self:parseNoviceActivityBraceletsConfig()
    end

    return self.mActivityBraceletsConfig[id]
end

--获得 成长返回 配置表Vo
function getReturnConfigById(self, id)
    if next(self.mActivityReturnConfig) == nil then
        self:parseNoviceActivityReturnConfig()
    end
    return self.mActivityReturnConfig[id]
end

--获得 成长返回 配置表Vo
function getReturnMsgVoById(self, id)
    return self.mActivityReturnMsgDic[id]
end

--获得 最大招募值 
function getMaxRecruit(self)
    if next(self.mActivityRecruitConfig) == nil then
        self:parseNoviceActivityBraceletsConfig()
    end
    if not self.maxRecruit then
        self.maxRecruit = self.mActivityRecruitConfig[#self.mActivityRecruitConfig]
    end
    local max = self.maxRecruit.needNum
    return max == nil and 180 or max
end
--获得 最大抽卡值
function getMaxBracelets(self)
    if next(self.mActivityBraceletsConfig) == nil then
        self:parseNoviceActivityBraceletsConfig()
    end
    if not self.maxBracelets then
        self.maxBracelets = self.mActivityBraceletsConfig[#self.mActivityBraceletsConfig]
    end
    local max = self.maxBracelets.needNum
    return max == nil and 180 or max
end

function updateBubble(self, type)
    local isFlag = self:updateBublleRecruit()
    local funcId = funcopen.FuncOpenConst.FUNC_ID_FACTORY_NOVICEACTIVITY_RECRUIT
    if type == noviceActivity.NoviceActivityConst.NOVICEACTIVITY_RECRUITPLAN then
        isFlag = self:updateBublleBracelects()
        funcId = funcopen.FuncOpenConst.FUNC_ID_FACTORY_NOVICEACTIVITY_BRACELECTS
    elseif type == noviceActivity.NoviceActivityConst.NOVICEACTIVITY_PROMOTIONPLAN then
        isFlag = self:updateBubllePlan()
        funcId = funcopen.FuncOpenConst.FUNC_ID_FACTORY_NOVICEACTIVITY_UPGRADEPLAN
    elseif type == noviceActivity.NoviceActivityConst.NOVICEACTIVITY_RETURN then
        isFlag = self:updateBublleReturn()
        funcId = funcopen.FuncOpenConst.FUNC_ID_NOVICEACTIVITY_RETURN
    elseif type == noviceActivity.NoviceActivityConst.NOVICEACTIVITY_RECHARGE then
        isFlag = self:updateBublleRecharge()
        funcId = funcopen.FuncOpenConst.FUNC_ID_NOVICEACTIVITY_RECHARGE
    elseif type == noviceActivity.NoviceActivityConst.NOVICEAVTIVITY_SSR then
        isFlag = self:updatebublleSsr()
        funcId = funcopen.FuncOpenConst.FUNC_ID_NOVICEACTIVITY_SSR
    end
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_NOVICE_ACTIVITY, isFlag, funcId)
    return isFlag
end
--升格计划红点
function updateBubllePlan(self)
    for _, taskVo in ipairs(self:getUpgradePlanList()) do
        if taskVo:getState() == task.AwardRecState.CAN_REC then
            return true
        end
    end
    return false
end

--累计链接红点
function updateBublleRecruit(self)
    for _, curVo in pairs(self:getRecuitConfig()) do
        local canReceive = not self:checkRecruitReceived(curVo.id) and self.heroRecruitedTimes >= curVo.needNum
        if canReceive then
            return true
        end
    end
    return false
end
--累计铸造红点
function updateBublleBracelects(self)
    for _, curVo in pairs(self:getBraceletsConfig()) do
        local canReceive = not self:checkBraceletsReceived(curVo.id) and self.braceletsRecruitedTimes >= curVo.needNum
        if canReceive then
            return true
        end
    end
    return false
end

--成长返还红点
function updateBublleReturn(self)
    for _, curVo in pairs(self:getReturnConfig()) do
        local canReceive = self:checkReturnReceived(curVo.id)
        if canReceive then
            return true
        end
    end
    return false
end


function updateBublleRecharge(self)
    local list = self:getRechargeList()
    for i = 1, #list, 1 do
        if list[i]:getState() == Celebration.CelebrationConst.CelebrationTaskState.Recive then
            return true
        end
    end
    return false
end

function updatebublleSsr(self)
    return self:getSSROptionalState() == Celebration.CelebrationConst.AwardState.Recive
end

--------------------------------------------------------------------------------------------
function parseNoviceRechargeData(self)
    self.mNoviceRechargeData = {}
    local baseData = RefMgr:getData("novice_recharge_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(noviceActivity.NoviceActivityRechargeVo)
        vo:parseData(id, data)
        self.mNoviceRechargeData[vo.index] = vo
    end
end

function getRechargeList(self)
    if self.mNoviceRechargeData == nil then
        self:parseNoviceRechargeData()
    end

    local list = {}
    for k, vo in pairs(self.mNoviceRechargeData) do
        table.insert(list, vo)
    end
    return self.mNoviceRechargeData
end

function parseSsrPanelInfoMsg(self, msg)
    self.ssrEndTime = msg.end_time
    self.ssrState = msg.state
    self:dispatchEvent(self.UPDATE_RED, noviceActivity.NoviceActivityConst.NOVICEAVTIVITY_SSR)
    GameDispatcher:dispatchEvent(EventName.UPDATE_SSROPTIONAL_INFO)
    if self.ssrEndTime == 0 then
        GameDispatcher:dispatchEvent(EventName.ACTIVITY_NOVICE_UPDATE)
    end
    --
    --GameDispatcher:dispatchEvent(EventName.ACTIVITY_NOVICE_UPDATE)
    --0-不可领取,1-可领取,2-已领取
end


function getSSrEndTime(self)
    return self.ssrEndTime == nil and 0 or self.ssrEndTime
end

function getSSROptionalState(self)
    return self.ssrState == nil and 0 or self.ssrState
end


function parseNoviceActivityRechargeMsg(self, msg)
    self.rechargeEndTime = msg.end_time
    self.totalCount = msg.total_count
    self.rewardList = msg.reward_list

    self:dispatchEvent(self.UPDATE_RED, noviceActivity.NoviceActivityConst.NOVICEACTIVITY_RECHARGE)
    GameDispatcher:dispatchEvent(EventName.ACTIVITY_NOVICE_UPDATE)
end

function getNoviceActivityRechargeEndTime(self)
    return self.rechargeEndTime == nil and 0 or self.rechargeEndTime

end

function getRechargeNum(self)
    return self.totalCount == nil and 0 or self.totalCount / 100
end

function updateNoviceActivityRechargeMsg(self, msg)
    if self.rewardList == nil then
        self.rewardList = {}
    end

    --if table.indexof01(self.rewardList) < 0  then
    table.insert(self.rewardList, msg.recharge_id)
    --end
    self:dispatchEvent(self.UPDATE_RED, noviceActivity.NoviceActivityConst.NOVICEACTIVITY_RECHARGE)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_ACC_RECHARGE_LIST)
end


function checkRechargeIsRecivedAward(self, id)
    return table.indexof(self.rewardList, id)
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]