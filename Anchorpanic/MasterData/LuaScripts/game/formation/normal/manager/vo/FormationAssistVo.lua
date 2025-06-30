--[[ 
-----------------------------------------------------
@filename       : FormationAssistVo
@Description    : 助战数据vo
@date           : 2022-03-1 20:03:20
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("formation.FormationAssistVo", Class.impl())

function parseMsgData(self, pt_hero_assist_fight)
    -- 助战战员位置
    self.heroPos = pt_hero_assist_fight.pos
    -- 战员id
    self.heroId = pt_hero_assist_fight.hero_id
end

function copy(self, formationAssistVo)
    self.heroPos = formationAssistVo.heroPos
    self.heroId = formationAssistVo.heroId
    return self
end

function onRecover(self)
end

function getHeroTid(self)
    local heroVo = hero.HeroManager:getHeroVo(self.heroId)
    if (heroVo) then
        return heroVo.tid
    else
        Debug:log_error("FormationAssistVo", string.format("找不到id为%s的英雄数据", self.heroId))
        return 1110
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
