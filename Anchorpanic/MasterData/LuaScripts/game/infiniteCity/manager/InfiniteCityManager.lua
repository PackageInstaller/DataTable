--[[ 
-----------------------------------------------------
@filename       : InfiniteCityManager
@Description    : 无限城活动数据管理
@date           : 2021-03-01 11:23:16
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.infinityCity.manager.InfiniteCityManager', Class.impl(Manager))

-- 面板数据更新
EVENT_INFINITECITY_DATA_UPDATE = "EVENT_INFINITECITY_DATA_UPDATE"
-- 灾害选择变化
EVENT_DISASTER_SELECT_UPDATE = "EVENT_DISASTER_SELECT_UPDATE"
-- 补给选择变化
EVENT_SUPPLY_SELECT_UPDATE = "EVENT_SUPPLY_SELECT_UPDATE"
-- 无限榜数据更新
EVENT_RANK_DATA_UPDATE = "EVENT_RANK_DATA_UPDATE"
-- 特殊关卡开启通知
EVENT_SPECIAL_OPEN = "EVENT_SPECIAL_OPEN"
-- 目标奖励数据更新
EVENT_TARGET_DATA_UPDATE = "EVENT_TARGET_DATA_UPDATE"
-- 功能红点通知
EVENT_RED_FLAG = "EVENT_RED_FLAG"

--构造
function ctor(self)
    super.ctor(self)
    self:init()
end

--析构
function dtor(self)
end

--初始化
function init(self)
    self.startTime = 0
    self.endTime = 0
    self.selectDisasterList = {}
    self.selectSupplyList = {}

    self.activityViewList = {}

    -- 选择的难度
    self.hardLevel = 1
    -- 一键选择灾害等级
    self.disasterLevel = nil
end

-- 解析副本数据
function parseDupBaseData(self)
    self.dupBaseData = {}
    local baseData = RefMgr:getData("infinite_city_dup_data")
    for key, data in pairs(baseData) do
        local vo = infiniteCity.InfiniteCityDupVo.new()
        vo:parseData(key, data)
        self.dupBaseData[key] = vo
    end
end

-- 解析灾害数据
function parseDisasterBaseData(self)
    self.disasterBaseData = {}
    local baseData = RefMgr:getData("infinite_disaster_data")
    for key, data in pairs(baseData) do
        local vo = infiniteCity.InfiniteCityDisasterVo.new()
        vo:parseData(key, data)
        self.disasterBaseData[key] = vo
    end
end

-- 解析补给数据
function parseSupplyBaseData(self)
    self.supplyBaseData = {}
    local baseData = RefMgr:getData("infinite_supplies_data")
    for key, data in pairs(baseData) do
        local vo = infiniteCity.InfiniteCitySupplyVo.new()
        vo:parseData(key, data)
        self.supplyBaseData[key] = vo
    end
end

-- 解析战利品数据
function parseTrophyBaseData(self)
    self.trophyBaseData = {}
    local baseData = RefMgr:getData("infinite_spoils_data")
    for key, data in pairs(baseData) do
        local vo = infiniteCity.InfiniteCityTrophyVo.new()
        vo:parseData(key, data)
        self.trophyBaseData[key] = vo
    end
end

-- 解析目标奖励数据
function parseTargetBaseData(self)
    self.targetBaseData = {}
    local baseData = RefMgr:getData("infinite_reward_data")
    for key, data in pairs(baseData) do
        local vo = infiniteCity.InfiniteCityTargetVo.new()
        vo:parseData(key, data)
        self.targetBaseData[vo.id] = vo
    end
end

----------------------------------------------------------------------
-- 解析无限城信息
function parseInfiniteCityInfoMsg(self, msg)
    self.startTime = msg.start_time
    self.endTime = msg.end_time
    self.activeSupply = msg.open_battle_supply
    self.hardLevel = msg.hard_level
    self.cityData = {}
    self.maxDupId = 0

    for i, dupVo in ipairs(self:getDupList()) do
        -- 重置副本状态
        dupVo.isPass = nil
    end

    for k, v in pairs(msg.city_data_list) do
        local dupVo = self:getDupBaseData(v.city_id)
        self.maxDupId = math.max(dupVo.id, self.maxDupId)
        if dupVo then
            dupVo:parseMsg(v)
        end
    end
    -- if self.showBtnCall then
    --     self.showBtnCall(self.showBtnCallThis, funcopen.FuncOpenConst.FUNC_ID_INFINITE_CITY)
    -- end
    self:dispatchEvent(self.EVENT_INFINITECITY_DATA_UPDATE)
end

-- 解析战斗结算的战利品
function parseInfiniteCityTrophySelectMsg(self, msg)
    self.trophySelectData = msg
end

-- 解析排行榜数据
function parseInfiniteCityRankMsg(self, msg)
    self.myRank = msg.my_rank
    self.myScore = msg.my_score
    self.rankList = {}
    for i, v in ipairs(msg.rank_list) do
        local vo = infiniteCity.InfiniteCityRankVo.new()
        vo:parseMsg(v)
        table.insert(self.rankList, vo)
    end

    self:dispatchEvent(self.EVENT_RANK_DATA_UPDATE)
end

-- 特殊关卡开启通知
function parseInfiniteCitySpecialOpenMsg(self, msg)
    self.isSpecialOpen = true
    self:dispatchEvent(self.EVENT_SPECIAL_OPEN)
end

-- 解析目标奖励数据
function parseInfiniteCityTargetInfoMsg(self, msg)
    self.targetMsgData = {}
    for i, v in ipairs(msg.target_list) do
        self.targetMsgData[v.id] = { count = v.count_now, state = v.state }
    end
    self:dispatchEvent(self.EVENT_TARGET_DATA_UPDATE)

    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_INFINITE_CITY, self:getRedFlag())
end

-- 解析目标奖励更新
function parseInfiniteCityTargetUpdateMsg(self, msg)
    if not self.targetMsgData then
        self.targetMsgData = {}
    end
    for i, v in ipairs(msg.update_list) do
        self.targetMsgData[v.id] = { count = v.count_now, state = v.state }
    end
    self:dispatchEvent(self.EVENT_TARGET_DATA_UPDATE)

    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_INFINITE_CITY, self:getRedFlag())
end

-- 轮次结束
function parseInfiniteCityRoundEndMsg(self, msg)
    self.isRoundEnd = true
end

-- 解析上次已选补给
function parseInfiniteCityDefaultSupplyMsg(self, msg)
    self.selectSupplyList = {}
    for i, v in ipairs(msg.battle_supply_list) do
        table.insert(self.selectSupplyList, v)
    end
    self:dispatchEvent(self.EVENT_SUPPLY_SELECT_UPDATE)
end

----------------------------------------------------------
-- 活动是否开启（功能开启及活动时间）
function isOpen(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_INFINITE_CITY, false) == false then
        return false
    end
    if activity.ActivityManager:checkIsOpenByFuncId(funcopen.FuncOpenConst.FUNC_ID_INFINITE_CITY) == false then
        return false
    end
    return true
end

-- function registerActivity(self, showBtnCall, showBtnCallThis)
--     self.showBtnCall = showBtnCall
--     self.showBtnCallThis = showBtnCallThis
-- end
-- 获取对应的副本数据
function getDupBaseData(self, cusId)
    if not self.dupBaseData then
        self:parseDupBaseData()
    end
    return self.dupBaseData[cusId]
end
-- 副本列表
function getDupList(self)
    if not self.dupBaseData then
        self:parseDupBaseData()
    end
    local list = {}
    for i, v in pairs(self.dupBaseData) do
        table.insert(list, v)
    end
    table.sort(list, function(a, b)
        return a.sort < b.sort
    end)
    return list
end

-- 当前副本id，0全部通关
function getCurDupId(self)
    local list = self:getDupList()
    for i = 1, #list do
        local vo = list[i]
        if vo.isPass == 0 then
            return vo.id
        end
    end
    return 0
end

-- 最大副本id
function getMaxDupId(self)
    return self.maxDupId
end

-- 获取灾害数据
function getDisasterBaseData(self, cusId)
    if not self.disasterBaseData then
        self:parseDisasterBaseData()
    end
    return self.disasterBaseData[cusId]
end

-- 获取特定等级的一个灾害数据
function getDisasterVoByLvl(self, cusLevel)
    if not self.disasterBaseData then
        self:parseDisasterBaseData()
    end
    for k, v in pairs(self.disasterBaseData) do
        if v.lvl == cusLevel then
            return v
        end
    end
    return nil
end

-- 灾害选择变化
function setSelectDisasterList(self, cusId)
    local index = table.indexof(self.selectDisasterList, cusId)
    local state = 1
    if index == false then
        state = 1
        table.insert(self.selectDisasterList, cusId)
    else
        state = 2
        table.remove(self.selectDisasterList, index)
    end

    self:dispatchEvent(self.EVENT_DISASTER_SELECT_UPDATE, { state = state, id = cusId })
end


-- 补给是否已激活
function getSupplyIsActive(self, cusId)
    if not self.activeSupply then
        return false
    end
    if table.indexof(self.activeSupply, cusId) ~= false then
        return true
    end
    return false
end

-- 补给配置列表
function getSuppplyList(self)
    if not self.supplyBaseData then
        self:parseSupplyBaseData()
    end
    local list = {}
    for i, v in pairs(self.supplyBaseData) do
        table.insert(list, v)
    end
    table.sort(list, function(a, b)
        if self:getSupplyIsActive(a.id) == true and self:getSupplyIsActive(b.id) == false then
            return true
        elseif self:getSupplyIsActive(a.id) == false and self:getSupplyIsActive(b.id) == true then
            return false
        else
            return a.id < b.id
        end
    end)
    return list
end

-- 补给选择变化
function setSelectSupplyList(self, cusId)
    local index = table.indexof(self.selectSupplyList, cusId)
    if index == false then
        table.insert(self.selectSupplyList, cusId)
    else
        table.remove(self.selectSupplyList, index)
    end

    self:dispatchEvent(self.EVENT_SUPPLY_SELECT_UPDATE)
end


-- 获取战利品数据
function getTrophyBaseData(self, cusId)
    if not self.trophyBaseData then
        self:parseTrophyBaseData()
    end
    return self.trophyBaseData[cusId]
end

-- 获取已选择的战利品列表
function getOwnTrophyList(self)
    local list = {}
    for i, vo in ipairs(self:getDupList()) do
        if vo.selectTrophyId and vo.selectTrophyId > 0 then
            table.insert(list, vo.selectTrophyId)
        end
    end
    return list
end

-- 获取无限榜数据
function getRankList(self)
    return self.rankList
end

-- 获取目标奖励基础数据
function getTargetBaseData(self, cusId)
    if not self.targetBaseData then
        self:parseTargetBaseData()
    end
    return self.targetBaseData[cusId]
end

-- 获取对应类型的目标奖励列表
function getTargetListByType(self, type)
    local list = {}
    for id, msgData in pairs(self.targetMsgData) do
        local data = self:getTargetBaseData(id)
        if data.taskType == type then
            table.insert(list, data)
        end
    end
    return list
end

-- 获取目标奖励状态
function getTargetMsgData(self, cusId)
    return self.targetMsgData[cusId]
end

-- 获取红点表示
function getRedFlag(self, cusType)
    if not self:isOpen() then
        return false
    end
    for id, msgData in pairs(self.targetMsgData) do
        local baseData = self:getTargetBaseData(id)
        if (not cusType or baseData.taskType == cusType) and msgData.state == 1 then
            return true
        end
    end
    return false
end

function getDupName(self)
    return "", ""
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
