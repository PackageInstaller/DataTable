module('preFight.PreFightDupExpController', Class.impl(preFight.BaseController))


--注册server发来的数据
function registerMsgHandler(self)
    local msgHandlerList = super.registerMsgHandler(self)
    return msgHandlerList
end

function getPanelClass(self)
    return preFight.PreFightDupExpPanel
end

function getManager(self)
    return preFight.PreFightDupExpManager
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
