module('preFight.PreFightDupMoneyPanel', Class.impl(preFight.BasePanel))

function getManager(self)
    return preFight.PreFightDupMoneyManager
end

function getItemName(self)
    return preFight.PreFightDupMoneyItem
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
