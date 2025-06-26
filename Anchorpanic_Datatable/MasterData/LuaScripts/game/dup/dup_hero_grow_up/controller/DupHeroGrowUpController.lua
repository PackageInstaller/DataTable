module('dup.DupHeroGrowUpController', Class.impl(dup.DupDailyBaseController))

function getMgr(self)
    local mgr = dup.DupDailyUtil:getDupMgr(DupType.DUP_HERO_GROW_UP)
    return mgr
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
