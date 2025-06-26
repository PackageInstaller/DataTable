module("permit.PermitManager", Class.impl(Manager))
--构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__initData()
end

function __initData(self)
    --通行证配置列表
    self.mPermitDataList = {}
    --通行证阶段奖励数据列表
    self.mPermitStageVoList = {}
    --通行证阶段奖励数据列表
    self.mPermitMsgVo = nil
    --通行证已领取等级列表
    self.mPermitedNLvList = {}
    --当前通行证等级
    self.mCurPermitLv = 1
    --通行证已领取等级列表
    self.mPermitedSLvList = {}
    --购买通行证类别 0.未购买 1.68 2.98
    self.mBuyPermitType = 0
    --通行证活动结束时间
    self.mActivityTime = 0
end

-- 解析通行证配置列表
function parsePermitMsg(self, msg)
    if msg then
        self.mPermitMsgVo = msg
        self.mCurPermitLv = msg.lv
        self.mBuyPermitType = msg.unlock_gear
        self.mPermitedSLvList = msg.gained_senior_reward
        self.mPermitedNLvList = msg.gained_primary_reward
        self.mActivityTime = msg.remain_time
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_PERMIT_PANEL)
    self:updateBubble()
end

-- 解析购买通行证结果
function parsePermitBuyMsg(self, msg)
    if msg.result == 1 then
        gs.Message.Show(_TT(81008))
        self.mCurPermitLv = self.mCurPermitLv + msg.buy_lv
        GameDispatcher:dispatchEvent(EventName.UPDATE_PERMIT_LV, true)
        self:updateBubble()
    end
end

-- 解析领取通行证结果
function parsePermitRecMsg(self, msg)
    if msg.result == 1 then
        if msg.is_senior > 0 then
            if (not table.indexof(self.mPermitedSLvList, msg.lv)) then
                table.insert(self.mPermitedSLvList, msg.lv)
            end
        else
            if (not table.indexof(self.mPermitedNLvList, msg.lv)) then
                table.insert(self.mPermitedNLvList, msg.lv)
            end
        end
        GameDispatcher:dispatchEvent(EventName.UPDATE_PERMIT_RECIVE)
        self:updateBubble()
    end
end

-- 解析通行证配置列表
function parsePermitData(self)
    self.mPermitDataList = {}
    self.mPermitStageVoList = {}
    local baseData = RefMgr:getData("permit_data")
    for key, data in pairs(baseData) do
        local vo = permit.PermitVo.new()
        vo:parseMsg(key, data)
        if vo.keyReward > 0 then
            table.insert(self.mPermitStageVoList, vo)
        end
        table.insert(self.mPermitDataList, vo)
    end
    table.sort(self.mPermitStageVoList, function(a, b) return a.lv > b.lv end)
    table.sort(self.mPermitDataList, function(a, b) return a.lv < b.lv end)
end

function getPermitList(self)
    if #self.mPermitDataList <= 0 then
        self:parsePermitData()
    end
    return self.mPermitDataList or {}
end

function getPermitedNLvList(self)
    return self.mPermitedNLvList or {}
end
--获取通行证等级
function getPermitedLv(self)
    return self.mCurPermitLv or 1
end

function getPermitedSLvList(self)
    return self.mPermitedSLvList or {}
end

function getPermitedMsgVo(self)
    return self.mPermitMsgVo or nil
end
--活动是否开始
function getIsPermitActivityAction(self)
    if activity.ActivityManager:getActivityVoById(activity.ActivityId.Permit) then
        local clientTime = GameManager:getClientTime()
        local RemainingTime = activity.ActivityManager:getActivityVoById(activity.ActivityId.Permit):getEndTime() - clientTime
        local isShow = RemainingTime > 0 and 1 or 0
        return RemainingTime > 0
    end
    return false
end

--type -1 是否已购买
function getIsBuyPermit(self, type)
    if type == self.mBuyPermitType then
        return true
    elseif type == -1 then
        return (self.mBuyPermitType > 0) and true or false
    end
    return false
end

function getPermitVoByLv(self, lv)
    return self:getPermitList()[lv]
end
--获取当前等级至X级之间的奖励列表
function getPermitLvStageAwardList(self, endLv)
    local awardList = {}
    local tempList = {}
    local temp2List = {}
    local tempListDic = {}
    for _, permitVo in pairs(self:getPermitList()) do
        if permitVo.lv > self.mCurPermitLv and permitVo.lv <= endLv then
            for _, propsVo in ipairs(permitVo:getNoamlAwardList()) do
                table.insert(tempList, propsVo)
                table.insert(temp2List, propsVo)
            end
            if permitVo:getIsBuy() then
                for _, propsVo1 in ipairs(permitVo:getSeniorAwardList()) do
                    table.insert(tempList, propsVo1)
                    table.insert(temp2List, propsVo1)
                end
            end
        end
    end
    for _, voL in ipairs(tempList) do
        for k, voR in ipairs(temp2List) do
            if voR.tid == voL.tid then
                if tempListDic[voR.tid] then
                    tempListDic[voR.tid].num = tempListDic[voR.tid].num + voR.num
                else
                    tempListDic[voR.tid] = {num = voR.num, tid = voR.tid}
                end
                table.remove(temp2List, k)
                voR = nil
            end
        end
    end
    for _, Vo in pairs(tempListDic) do
        table.insert(awardList, Vo)
    end
    return awardList or {}
end

function getCurPermitStageData(self)
    local tempVo = nil
    if #self.mPermitStageVoList <= 0 then
        self:parsePermitData()
    end
    for _, vo in ipairs(self.mPermitStageVoList) do
        if (self:getPermitedLv() <= vo.lv) and (not vo:getIsUnlock()) then
            tempVo = vo
        elseif self:getPermitedLv() >= self.mPermitStageVoList[1].lv then
            return vo
        end
    end
    return tempVo
end

function getPermitIndex(self)
    local toIndex = 0
    for _, permitVo in ipairs(self:getPermitList()) do
        if permitVo:getIsUnlock() then
            if (not permitVo:getIsNomalRecived()) then
                toIndex = permitVo.lv - 1
                return toIndex
            elseif ((not permitVo:getIsSeniorRecived()) and permitVo:getIsBuy()) then
                toIndex = permitVo.lv - 1
                return toIndex
            end
        end
    end
    if toIndex < 1 then
        toIndex = self:getPermitedLv() - 1
    end
    return toIndex
end

function getCanReciveNum(self)
    local toIndex = 0
    for _, permitVo in ipairs(self:getPermitList()) do
        if permitVo:getIsUnlock() then
            if ((not permitVo:getIsNomalRecived()) or ((not permitVo:getIsSeniorRecived()) and permitVo:getIsBuy())) then
                toIndex = toIndex + 1
            end
        end
    end
    return toIndex
end

function updateRed(self)
    return self:getCanReciveNum() >= 1
end

function updateBubble(self)
    local isFlag = self:getCanReciveNum() >= 1
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
end

-- 显示状态（主UI使用）
function checkShowState(self)
    local isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_PERMIT)
    if not isOpen then
        return false
    end

    if not activity.ActivityManager:checkIsOpenByFuncId(funcopen.FuncOpenConst.FUNC_ID_PERMIT) then
        return false
    end

    return true
end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
