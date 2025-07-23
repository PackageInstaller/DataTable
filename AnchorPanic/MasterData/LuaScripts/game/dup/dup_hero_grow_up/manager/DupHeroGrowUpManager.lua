--[[ 
    战员增幅副本
    @author Zzz
]]
module('dup.DupHeroGrowUpManager', Class.impl(dup.DupDailyBaseManager))

function ctor(self)
    super.ctor(self)

    self:setDupType(DupType.DUP_HERO_GROW_UP, PreFightBattleType.DupHeroGrowUp)
end

function getViewName(self)
    return dup.DupHeroGrowUpPanel
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
