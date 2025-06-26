module('dup.DupEquipLowController', Class.impl(dup.DupEquipBaseController))

function getMgr(self)
    local mgr = dup.DupDailyUtil:getDupMgr(DupType.DUP_EQUIP_LOW)
    return mgr
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
