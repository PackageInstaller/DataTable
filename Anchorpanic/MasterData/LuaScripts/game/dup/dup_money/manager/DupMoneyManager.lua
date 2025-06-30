--[[ 
    金币副本
    @author Jacob
]]
module('dup.DupMoneyManager', Class.impl(dup.DupDailyBaseManager))

function ctor(self)
    super.ctor(self)

    self:setDupType(DupType.DUP_MONEY, PreFightBattleType.DupMoney)
end

function getViewName(self)
    return dup.DupMoneyPanel
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
