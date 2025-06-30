module('preFight.PreFightDupExpPanel', Class.impl(preFight.BasePanel))

function getManager(self)
    return preFight.PreFightDupExpManager
end

function getItemName(self)
    return preFight.PreFightDupExpItem
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
