--[[-----------------------------------------------------
@filename       : GrowthFundVo
@Description    : 成长基金数据
@date           : 2023-01-30 13:53:48
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('purchase.GrowthFundVo', Class.impl())

function parseMsg(self, key, cusMsg)
    self.sort = key
    --解锁关卡
    self.lvl = cusMsg.level
    -- 普通掉落
    self.nomalDrop = cusMsg.primary_fund
    -- 付费掉落
    self.moneyDrop = cusMsg.senior_fund
end

--获取解锁要求
function getLvlDsc(self)
    return _TT(29570, self.lvl)
end

--获取普通掉落奖励
function getNomalDropAward(self)
    return AwardPackManager:getAwardListById(self.nomalDrop)
end

--获取付费掉落奖励
function getMoneyDropAward(self)
    return AwardPackManager:getAwardListById(self.moneyDrop)
end

--获取是否已购买
function getIsBuy(self)
    return purchase.GrowthFundManager:getIsGrowthFundMoney()
end

--获取是否高级奖励已领取
function getIsReceiveMoneyAward(self)
    if purchase.GrowthFundManager:getIsGrowthFundMoney() then
        return table.indexof(purchase.GrowthFundManager:getGrowthFundedSList(), self.sort)
    end
    return false
end

--获取是否普通奖励已领取
function getIsReceiveNomalAward(self)
    return table.indexof(purchase.GrowthFundManager:getGrowthFundedNList(), self.sort)
end

--获取是否已解锁
function getIsUnLock(self)
    return role.RoleManager:getRoleVo():getPlayerLvl() >= self.lvl
end
--获取排序
function getSort(self)
    local sort = self.sort
    if (self:getIsUnLock() and self:getIsReceiveMoneyAward() and self:getIsReceiveNomalAward()) then
        sort = sort + 100
    end
    return sort
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]