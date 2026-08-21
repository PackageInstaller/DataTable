--[[ 
    玩家体力数据模块，策划改啦，体力就是抗疫血清
    @author Jacob
]]
module("stamina.StaminaManager", Class.impl(Manager))

-- 体力更新
EVENT_STAMINA_UPDATE = "EVENT_STAMINA_UPDATE"

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
    -- 玩家体力
    self.mStamina = nil
    -- 已购买次数
    self.mBuyTimes = nil
    -- 限购次数（0不限）
    self.mLimitTimes = nil

    -- 体力购买配置
    self.mStaminaExchangeDic = nil
end

-- 解析体力兑换表
function praseExchangeConfig(self)
    self.mStaminaExchangeDic = {}
    local baseData = RefMgr:getData("stamina_exchange")
    for buyTimes, data in pairs(baseData) do
        local vo = stamina.StaminaExchangeVo.new()
        vo:parseConfigData(buyTimes, data)
        self.mStaminaExchangeDic[vo.buyTimes] = vo
    end
end

-- 根据购买次数获取兑换vo
function getExchangeVo(self, cusBuyTimes)
    if (not self.mStaminaExchangeDic) then
        self:praseExchangeConfig()
    end
    if (cusBuyTimes == 0) then
        logError('购买次数需要大于1。当前为0')
    end
    local exchangeVo = self.mStaminaExchangeDic[cusBuyTimes]
    if (not exchangeVo) then
        for buyTimes, vo in pairs(self.mStaminaExchangeDic) do
            if (cusBuyTimes >= buyTimes) then
                exchangeVo = vo
            end
        end
    end
    return exchangeVo
end

function parseMsg(self, msg)
    self.mBuyTimes = msg.buy_times
    self.mLimitTimes = msg.max_buy_times
    self.mNextAddTime = msg.next_add_time
    self.mAllAddTime = msg.all_add_time
    self:setStamina(msg.stamina)
end

-- 剩余体力
function getStamina(self)
    return self.mStamina or 0
end

function setStamina(self, cusValue)
    if self.mStamina ~= cusValue then
        self.mStamina = cusValue
        -- 页面更新
        self:dispatchEvent(EVENT_STAMINA_UPDATE)
        -- 货币栏更新（统一）
        GameDispatcher:dispatchEvent(EventName.MONEY_BAR_UPDATE, MoneyTid.ANTIEPIDEMIC_SERUM_TID)
    end
end

-- 已购买次数
function buyTimes(self)
    return self.mBuyTimes
end

-- 限购次数（0不限）
function limitTimes(self)
    return self.mLimitTimes
end
-- 下次自然增加体力的时间戳0-不增加
function nextAddTime(self)
    return self.mNextAddTime
end
-- 恢复所有体力的时间戳0-不增加
function allAddTime(self)
    return self.mAllAddTime
end

-- 是否可以用货币购买
function isLimitBuy(self)
    if (self:limitTimes() == 0) then
        return false
    else
        return self:limitTimes() - self:buyTimes() <= 0
    end
end

-- 取当前等级对应的自然恢复血清上限（不存在则返回当前血清）
function getCurLvlMaxStamina(self)
    local roleLvlUpVo = role.RoleManager:getCurLvlVo()
    if roleLvlUpVo then
        return roleLvlUpVo.maxStamina
    end
    return MoneyUtil.getMoneyCountByTid(MoneyTid.ANTIEPIDEMIC_SERUM_TID)
end

-- 检查体力是否满足战斗
-- cusIsByProps 为 nil 则默认顺序检测道具使用、货币购买
function checkStamina(self, cusBattleType, cusIsByProps, cusCostStamina, cusCallFun, cusCallObj)
    local myStamina = self:getStamina()
    if (myStamina >= cusCostStamina) then
        cusCallFun(cusCallObj)
        return true
    end

    if (cusIsByProps == nil or cusIsByProps == true) then
        local addTotalStamina = 0
        local propsList = bag.BagManager:getPropsListByEffect(UseEffectType.ADD_STAMINA)
        if (#propsList > 0) then
            for i = 1, #propsList do
                addTotalStamina = addTotalStamina + propsList[i].effectList[1]
            end

            local myStamina = self:getStamina()
            -- 道具条件满足使用获得体力
            if (myStamina + addTotalStamina >= cusCostStamina) then
                GameDispatcher:dispatchEvent(EventName.OPEN_ADD_STAMINA_PANEL, { isByProps = cusIsByProps, needCost = cusCostStamina, callFun = cusCallFun, callObj = cusCallObj })
                return true
            end
        end

        -- gs.Message.Show2(_TT(26318))
        -- return false
    end

    if (cusIsByProps == nil or cusIsByProps == false) then
        if (self:isLimitBuy()) then
            -- gs.Message.Show("血清不足")
            gs.Message.Show2(_TT(26318))
            return false
        else
            -- 通过宝石购买体力的不需要判断是否够宝石
            GameDispatcher:dispatchEvent(EventName.OPEN_ADD_STAMINA_PANEL, { isByProps = cusIsByProps, needCost = cusCostStamina, callFun = cusCallFun, callObj = cusCallObj })
            return true
        end
    end

    return false
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
