--[[ 
    经验副本
    @author Jacob
]]
module('dup.DupExpManager', Class.impl(dup.DupDailyBaseManager))

function ctor(self)
    super.ctor(self)

    self:setDupType(DupType.DUP_EXP, PreFightBattleType.DupExp)
end

function getViewName(self)
    return dup.DupExpPanel
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
