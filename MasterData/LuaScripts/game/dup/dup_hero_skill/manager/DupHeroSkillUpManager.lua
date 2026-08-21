--[[ 
    战员增幅副本
    @author Zzz
]]
module('dup.DupHeroSkillUpManager', Class.impl(dup.DupDailyBaseManager))

function ctor(self)
    super.ctor(self)

    self:setDupType(DupType.DUP_HERO_SKILL, PreFightBattleType.DupHeroSkill)
end

function getViewName(self)
    return dup.DupHeroSkillUpPanel
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
