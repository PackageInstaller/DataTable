module('preFight.PreFightDupMoneyController', Class.impl(preFight.BaseController))

--注册server发来的数据
function registerMsgHandler(self)
    local msgHandlerList = super.registerMsgHandler(self)
    return msgHandlerList
end

function getPanelClass(self)
    return preFight.PreFightDupMoneyPanel
end

function getManager(self)
    return preFight.PreFightDupMoneyManager
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
