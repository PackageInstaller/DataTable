--[[ 
    战员晋升副本
    @author Zzz
]]
module('dup.DupHeroStarUpManager', Class.impl(dup.DupDailyBaseManager))

function ctor(self)
    super.ctor(self)

    self:setDupType(DupType.DUP_HERO_STAR_UP, PreFightBattleType.DupHeroStarUp)
end

function getViewName(self)
    return dup.DupHeroStarUpPanel
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
