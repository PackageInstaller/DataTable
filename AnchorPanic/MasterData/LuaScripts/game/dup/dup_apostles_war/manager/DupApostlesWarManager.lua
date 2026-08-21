--[[
-----------------------------------------------------
@filename       : DupApostlesWarManager
@Description    : ***
@date           : ***
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_apostle_war.manager.DupApostlesWarManager', Class.impl(Manager))

-- 副本数据更新
EVENT_DATA_UPDATE = "EVENT_DATA_UPDATE"
-- 目标奖励信息更新
EVENT_GOAL_UPDATE = "EVENT_GOAL_UPDATE"

--构造
function ctor(self)
    super.ctor(self)
    self:init()
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
    self.mConfigDic = {}
    self.mGoalConfigDic = {}
    self.mRewardBaseList = {}
    self.mBossInfoDic = nil

    self.ClositerDic = {}
    self.mDupList = {}
    self.mStarAwardDic = {}
    self.mRankList = {}
    self.mCurrentBossId = 1
    self.mPanelInfo = nil
    self.mIsTrain = false
    self.mBeginFightTime = 0
    -- self.mBossData = nil
end

-- function setBossData(self, data)
--     self.mBossData = data
-- end

-- function getBossData(self)
--     return self.mBossData
-- end

-- 初始化怪物基础配置表
function parseConfigData(self)
    self.mConfigDic = {}
    self.mGoalConfigDic = {}
    self.mRewardBaseList = {}
    self.mBossInfoDic = {}
    local baseData = RefMgr:getData("apostles_data")
    for key, data in pairs(baseData) do
        local vo = dup.DupApostlesWarVo.new()
        vo:parseData(key, data)
        self.mConfigDic[vo.id] = vo
    end

    local baseData = RefMgr:getData("apostles_goal_data")
    for key, data in pairs(baseData) do
        local vo = dup.DupApostlesWarGoalVo.new()
        vo:parseData(key, data)
        self.mGoalConfigDic[key] = vo
    end

    baseData = RefMgr:getData('apostles_rank_data')
    for key, data in pairs(baseData) do
        local rewardVo = LuaPoolMgr:poolGet(rank.RankRewardVo)
        rewardVo:parseData(key, data)
        table.insert(self.mRewardBaseList, rewardVo)
    end
    baseData = RefMgr:getData('apostles_boss_data')
    for key, data in pairs(baseData) do
        local vo = manual.ManualMonsterConfigVo.new()
        vo:parseData(index, data)
        self.mBossInfoDic[vo.model] = vo
    end
    table.sort(self.mRewardBaseList, function(a, b)
        return a.leftRank < b.leftRank
    end)
end

-- 初始化副本界面信息配置表
function parseApostlesClositerData(self)
    self.ClositerDic = {}
    local baseData = RefMgr:getData("boss_cloister_data")
    for key, data in pairs(baseData) do
        local vo = dup.DupApostlesCloisterVo.new()
        vo:parseData(key, data)
        self.ClositerDic[vo.id] = vo
    end
end

function getClositerDataById(self, id)
    if (self.ClositerDic == nil or #self.ClositerDic == 0) then
        self:parseApostlesClositerData()
    end
    return self.ClositerDic[id]
end

function checkIsBoss(self, model)
    if (self.ClositerDic == nil or #self.ClositerDic == 0) then
        self:parseApostlesClositerData()
    end
    local modelList = {}
    for k, bossVo in pairs(self.ClositerDic) do
        for _, model in ipairs(bossVo.bossModelList) do
            table.insert(modelList, model)
        end
    end
    return table.indexof(modelList, model) ~= false
end

-- 初始化星级奖励配置表
function parseStartConfigData(self)
    self.mStarAwardDic = {}
    local baseData = RefMgr:getData("boss_cloister_star_data")
    for key, data in pairs(baseData) do
        local vo = dup.DupApostlesStarVo.new()
        vo:parseData(key, data)
        self.mStarAwardDic[vo.id] = vo
    end
end

function getStarDataById(self, id)
    if self.mStarAwardDic == nil or #self.mStarAwardDic == 0 then
        self:parseStartConfigData()
    end
    return self.mStarAwardDic[id]
end

-- 初始化副本信息配置表
function parseApostlesDupData(self)
    self.mDupList = {}
    local baseData = RefMgr:getData("boss_cloister_dup_data")
    for key, data in pairs(baseData) do
        local vo = dup.DupApostlesDataVo.new()
        vo:parseData(key, data)
        self.mDupList[key] = vo
    end
end

function getDupDataById(self, id)
    if self.mDupList == nil or #self.mDupList == 0 then
        self:parseApostlesDupData()
    end
    return self.mDupList[id]
end

-- 解析服务器数据
function onApostlesInfoMsg(self, msg)
    self.bossId = msg.boss_id
    self.skillIds = msg.skill_list
    self.minPassTime = msg.min_pass_time
    self.goalRewards = msg.goal_reward
    for i, v in ipairs(msg.goal_reward) do
        local vo = self:getGoalRewardData(v.key)
        if vo then
            vo.state = v.value
        end
    end
    self:dispatchEvent(self.EVENT_DATA_UPDATE)
end

-- 解析排行榜
function parseApostlesRankInfoMsg(self, msg)
    self.myRank = msg.my_rank
    self.myPassTime = msg.my_pass_cost_time
    for i, v in ipairs(msg.rank_list) do
        local vo = rank.RankBaseVo.new()
        vo:parseMsg(v)
        table.insert(self.mRankList, vo)
    end
    GameDispatcher:dispatchEvent(EventName.EVENT_RANK_UPDATE)
end

-- 领取返回
function onApostlesGoalRewardMsg(self, msg)
    if msg.result == 1 then
        local vo = self:getGoalRewardData(msg.goal_id)
        if vo then
            vo.state = 2
        end
    else
        gs.Message.Show(_TT(36516))
    end
    self:dispatchEvent(self.EVENT_GOAL_UPDATE)

    self:checkFlag()
end

function getDupBaseVo(self, id)
    if not self.mDupList or #self.mDupList == 0 then
        self:parseApostlesDupData()
    end
    return self.mDupList[id]
end

-- 获取目标奖励列表
function getGoalRewardList(self)
    if not self.mGoalConfigDic or #self.mGoalConfigDic == 0 then
        self:parseConfigData()
    end
    local list = table.values(self.mGoalConfigDic)
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

-- 根据模型id获取boss数据
function getBossInfoVoToModel(self, model)
    if not self.mBossInfoDic then
        self:parseConfigData()
    end
    return self.mBossInfoDic[model]
end

-- 取排行榜列表
function getRankList(self)
    return self.mRankList
end

-- 获取目标配置
function getGoalRewardData(self, cusId)
    if not self.mGoalConfigDic then
        self:parseConfigData()
    end
    return self.mGoalConfigDic[cusId]
end

-- 排行奖励数据
function getRewardList(self)
    if self.mRewardBaseList == nil then
        self:parseConfigData()
    end
    return self.mRewardBaseList
end

function checkFlag(self)
    local isFlag = false
    local isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_APOSTLE2_WAR)
    if isOpen then
        if not self.mPanelInfo then
            return isFlag
        end
        local hasGetList = self.mPanelInfo.receivedStarId

        local rewardVo = self:getClositerDataById(self.mPanelInfo.id)
        if rewardVo then
            local rewardList = rewardVo.taskRewardList
            for k, v in pairs(rewardList) do
                if (self.mPanelInfo.starNum >= v.star) then
                    isFlag = true
                    for i = 1, #hasGetList do
                        if (hasGetList[i] == v.id) then
                            isFlag = false
                        end
                    end
                end
                if isFlag then
                    break
                end
            end
        end
    end
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, isFlag, funcopen.FuncOpenConst.FUNC_ID_APOSTLE2_WAR)
    return isFlag
end

function setCurrentBossId(self, data)
    self.mCurrentBossId = data
end

function getCurrentBossId(self)
    if (self.mCurrentBossId == nil) then
        return 1
    end
    return self.mCurrentBossId
end

function setRecordTime(self)
    local currentTime = GameManager:getClientTime()
    local lastResetTime = self:getPanelInfo().endTime
    self.mBeginFightTime = lastResetTime - currentTime
end

function getWeekEndInFight(self)
    if not self:getPanelInfo() then
        return false
    end
    local currentTime = GameManager:getClientTime()
    local lastResetTime = self:getPanelInfo().endTime
    return self.mBeginFightTime < (lastResetTime - currentTime)
end

-- 获取重置时间
function getResetTimeStr(self)
    local endTime = 0
    if self:getPanelInfo() then
        endTime = self:getPanelInfo().endTime
    end
    -- local nextResetTime = 15 * 3600 * 24 + lastResetTime
    local currentTime = GameManager:getClientTime()
    local reamainTime = endTime - currentTime
    return TimeUtil.getFormatTimeBySeconds_1(reamainTime), reamainTime
end

-- 本次是否结束
function getWeekEnd(self)
    local _, reamainTime = self:getResetTimeStr()
    return reamainTime <= 0
end

-- 获取副本章节名和副本名
function getDupName(self, cusId)
    local dupVo = self:getDupBaseVo(cusId)
    GameDispatcher:dispatchEvent(EventName.REQ_DUP_APOSTLES2_PANEL_INFO)
    return "使徒之战2.副本", dupVo.bossId
end

function getRecommandFight(self, cusId)
    local dupVo = self:getDupBaseVo(cusId)
    return dupVo.recommandFight
end

-- 接收使徒之战2面板信息
function onApostlesPanelInfoMsg(self, msg)
    -- if not self.mPanelInfo then
    self.mPanelInfo = dup.DupApostlesPanelInfoVo:new()
    -- end
    self.mPanelInfo:parseData(msg)
    GameDispatcher:dispatchEvent(EventName.UPDATE_DUP_APOSTLES_PANEL)
    self:checkFlag()
end

function getPanelInfo(self)
    return self.mPanelInfo
end

--接收领取奖励返回
function onApostlesStarRewardMsg(self, msg)
    if msg.result == 1 then
        GameDispatcher:dispatchEvent(EventName.REQ_DUP_APOSTLES2_PANEL_INFO)
    else
    end
end

-- 获取额外上阵的战员列表
function getExtraHeros(self, cusId)
    local dupVo = self:getDupBaseVo(cusId)
    return dupVo.extraHeros
end

return _M

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(30047):"使徒之战"
语言包: _TT(36516):"领取失败"
]]
