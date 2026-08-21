module("MoneyManager", Class.impl(Manager))

-- 资产显示列表改变
MONEY_LIST_CHANGE = "MONEY_LIST_CHANGE"

--构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

function __initData(self)
    -- 默认显示列表  金币，钛金石，抗疫血清
    self.m_defaultMoneyList = { MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID }
    -- 当前资产类型列表
    self.m_curMoneyList = self.m_defaultMoneyList
end

function setMoneyTidList(self, moneyTidList, cusType)
    local isClear = false
    if (not moneyTidList) then
        moneyTidList = self.m_defaultMoneyList
        isClear = true
    end
    self.m_curMoneyList = moneyTidList

    self:dispatchEvent(self.MONEY_LIST_CHANGE, { isClear = isClear, frontType = cusType })
end

function modifyMoneyBarColor(self, cusType)
    self:dispatchEvent(self.MONEY_LIST_CHANGE, { isClear = false, frontType = cusType })
end

function getMoneyTidList(self)
    return self.m_curMoneyList
end

--析构函数
function dtor(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
