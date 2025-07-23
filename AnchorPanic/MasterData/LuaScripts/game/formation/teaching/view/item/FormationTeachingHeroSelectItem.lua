module('formation.FormationTeachingHeroSelectItem', Class.impl(formation.FormationHeroSelectItem))

function __onClickHeadHandler(self, args)
    local manager = self.data:getDataVo().manager
    local dataVo = self.data:getDataVo().dataVo

    -- 援助我方的怪物vo
    local monsterTidVo = dataVo
    local monsterConfigVo = dataVo:getBaseConfig()
    manager:dispatchEvent(manager.HERO_FORMATION_SELECT, { heroId = monsterTidVo.uniqueTid, heroTid = monsterTidVo.tid, heroSourceType = formation.HERO_SOURCE_TYPE.TEACHING, isInFormation = self.m_isInFormation, isInAssist = self.m_isInAssist })
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
