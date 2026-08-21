--[[-----------------------------------------------------
@filename       : GradeGiftVo
@Description    : 等级礼包数据
@date           : 2023-01-29 9:22:48
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('purchase.GradeGiftVo', Class.impl())

function parseGradeGiftMsg(self, key, cusMsg)
    --等级礼包所需等级
    self.lvl = cusMsg.level
    --等级礼包排序
    self.sort = key
    --等级礼包类型
    self.giftType = cusMsg.gift_type
    -- 等级礼包掉落id
    self.drop = cusMsg.drop
    --等级礼包花费
    self.costCoin = cusMsg.cost_coin
    -- 等级礼包货币类型
    self.costType = cusMsg.cost_type
end
--获取等级礼包类型
function getGiftType(self)
    return self.giftType
end
--获取消费货币数量
function getCostCoinNum(self)
    return self.costCoin
end
--等级礼包货币类型
function getCostType(self)
    return self.costType
end
--等级礼包等级
function getGiftLvl(self)
    return self.lvl
end

--等级礼包是否可以领取
function getIsCanRec(self)
    return role.RoleManager:getRoleVo():getPlayerLvl() >= self.lvl
end

--等级礼包是否已领取
function getIsReced(self)
    return purchase.GradeGiftManager:getGradeGiftRecOverByType(self.giftType)
end

--等级礼包是否已领取
function getIsSeniorReced(self)
    return purchase.GradeGiftManager:getGradeGiftRecOverByType(self.giftType)
end

--等级礼包进阶礼包可否领取
function getIsSeniorCanRec(self)
    if ((MoneyUtil.getMoneyCountByTid(MoneyTid.PAY_ITIANIUM_TID) >= self.costCoin) and (role.RoleManager:getRoleVo():getPlayerLvl() >= self.lvl)) then
        return true
    end
    return false
end

--等级礼包进阶礼包是否充足
function getIsSeniorCan(self)
    return MoneyUtil.getMoneyCountByTid(MoneyTid.PAY_ITIANIUM_TID) >= self.costCoin
end

--获取掉落包
function getDropAward(self)
    return AwardPackManager:getAwardListById(self.drop)
end

--等级礼包等级
function getGiftLvlDsc(self)
    return _TT(50045, self.lvl)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]