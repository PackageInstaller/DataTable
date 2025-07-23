module("purchase.AccRechargeManager", Class.impl(Manager))

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
    self.mAccPly = 0
    self.mAccRechargeAwardList = nil

    self.mAccRechargeList = nil
end

--析构函数
function dtor(self)
end

function parseAccRechargeConfig(self)
    self.mAccRechargeList = {}
    local baseData = RefMgr:getData("cum_recharge_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(purchase.AccRechargeVo)
        vo:parseData(data, id)
        table.insert(self.mAccRechargeList, vo)
    end
end

function __sortAcc(self, vo1, vo2)
    if (vo1 and vo2) then
        if (self:hasGeted(vo1.id) == self:hasGeted(vo2.id)) then
            return vo1.getNum > vo2.getNum
        else
            return vo1.getNum > vo2.getNum
        end
    end
    return false
end

function getAccRechargeConfig(self)
    if self.mAccRechargeList == nil then
        self:parseAccRechargeConfig()
    end
    table.sort(self.mAccRechargeList, function(vo1, vo2)
        if vo1 and vo2 then
            return vo1:sort() < vo2:sort()
        end
        return false
    end)
    return self.mAccRechargeList
end

function parseAccRechargeData(self, msg)
    self.mAccPly = msg.pay_rmb / 100
    self.mAccRechargeAwardList = msg.award_list
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACCRECHARGEPANEL)
    purchase.PurchaseManager:dispatchEvent(purchase.PurchaseManager.BUBBLE_CHANGE, purchase.PurchaseTab.RECHARGE)
end

--当前累积充值
function getAccPlyNum(self)
    return self.mAccPly
end

--累积充值是否可领取
function getAccIsCanRecive(self)
    for _, vo in ipairs(self:getAccRechargeConfig()) do
        if ((self:getAccPlyNum() >= vo.getNum) and (not self:hasGeted(vo.id))) then
            return true
        end
    end
    return false
end

--是否已经获取过
function hasGeted(self, id)
    return table.indexof01(self.mAccRechargeAwardList, id) > 0
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]