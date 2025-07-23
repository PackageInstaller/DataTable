module("purchase.MonthCardManager", Class.impl(Manager))

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
    -- 已购买次数
    self.mBuyTimes = nil
    -- 剩余天数
    self.mLeftDays = nil
    --是否已购买月卡
    self.mIsBuy = 0
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 解析体力月卡面板信息
function parseStrengthInfoMsg(self,msg)
    self.mStrengthBuyTimes = msg.buy_times
    self.mStrengthLeftDays = msg.left_days
    self.mStrengthIsBuy = msg.is_buy
    GameDispatcher:dispatchEvent(EventName.UPDATE_STRENGTH_CARD_INFO)
end


-- 解析服务器面板信息
function parsePanelInfoMsg(self, msg)
    --已购买次数(月卡到期次数归0)
    self.mBuyTimes = msg.buy_times
    --月卡剩余天数
    self.mLeftDays = msg.left_days
    --是否已购买月卡
    self.mIsBuy = msg.is_buy
    GameDispatcher:dispatchEvent(EventName.UPDATE_MONTH_CARD_INFO)
end

-- 获取已购买次数(月卡激活情况下累计次数，月卡到期次数归0)
function getHadBuyTimes(self)
    return self.mBuyTimes or 0
end

function getStrengthBuyTimes(self)
    return self.mStrengthBuyTimes or 0
end
-- 获取剩余天数
function getLeftDays(self)
    return self.mLeftDays or 0
end
--获取是否已购买过月卡
function getIsPurchased(self)
    return self.mIsBuy > 0
end

function getIsBuyMonthlyed(self)
    return self:getLeftDays() > 0
end

function getStrengthLeftDays(self)
    return self.mStrengthLeftDays or 0
end

function getIsBuyStrengthMonthlyed(self)
    return self:getStrengthLeftDays() > 0
end

-- 获取是否已领取
function getIsReceive(self)
    if self:getLeftDays() > 0 then
        return dailyCheckIn.DailyCheckInManager:getIsSign()
    end
    return false
end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]