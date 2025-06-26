--[[ 
    手环副本
    @author Zzz
]]
module('dup.DupBraceletsManager', Class.impl(dup.DupDailyBaseManager))

function ctor(self)
    super.ctor(self)

    self:setDupType(DupType.DUP_BRACELETS, PreFightBattleType.DupBracelets)
end

function getViewName(self)
    return dup.DupBraceletsPanel
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
