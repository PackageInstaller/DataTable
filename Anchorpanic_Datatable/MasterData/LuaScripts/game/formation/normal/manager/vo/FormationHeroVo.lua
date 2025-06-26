module("formation.FormationHeroVo", Class.impl())

function parseMsgData(self, pt_formation_hero_info)
    -- 英雄位置
    self.heroPos = pt_formation_hero_info.pos
    -- 英雄id
    self.heroId = pt_formation_hero_info.hero_id
    -- 英雄来源
    self.sourceType = pt_formation_hero_info.hero_source

    -- 英雄tid
    self.m_heroTid = pt_formation_hero_info.tid
    -- -- 英雄等级
    -- self.m_heroLvl = pt_formation_hero_info.lv
    -- -- 英雄进化等级
    -- self.m_evolutionLvl = pt_formation_hero_info.evolution

    -- 是否固定英雄
    self.isFixedHero = nil
    -- 是否队长
    self.isCaptainHero = pt_formation_hero_info.is_captain == 1
end

function copy(self, formationHeroVo)
    self.heroPos = formationHeroVo.heroPos
    self.heroId = formationHeroVo.heroId
    self.sourceType = formationHeroVo.sourceType

    self.m_heroTid = formationHeroVo.m_heroTid
    -- self.m_heroLvl = formationHeroVo.m_heroLvl
    -- self.m_evolutionLvl = formationHeroVo.m_evolutionLvl

    self.isFixedHero = formationHeroVo.isFixedHero
    self.isCaptainHero = formationHeroVo.isCaptainHero

    return self
end

function onRecover(self)
    self.isFixedHero = nil
    self.isCaptainHero = false
end

function getHeroTid(self)
    if (self.sourceType == formation.HERO_SOURCE_TYPE.OWN) then
        local heroVo = hero.HeroManager:getHeroVo(self.heroId)
        if (heroVo) then
            return heroVo.tid
        else
            Debug:log_error("FormationHeroVo", string.format("找不到id为%s的英雄数据", self.heroId))
            return 1110
        end
    elseif self:getIsMonster() then
        local monsterTidVo = monster.MonsterManager:getMonsterVo(self.heroId)
        return monsterTidVo.tid
    elseif (self.sourceType == formation.HERO_SOURCE_TYPE.ARENA) then
        return self.m_heroTid
    end
    return 0
end

function getModel(self)
    if (self.sourceType == formation.HERO_SOURCE_TYPE.OWN) then
        local heroVo = hero.HeroManager:getHeroVo(self.heroId)
        if (heroVo) then
            return heroVo:getHeroModel()
        else
            Debug:log_error("FormationHeroVo", string.format("找不到id为%s的英雄数据", self.heroId))
            return 1110
        end
    elseif self:getIsMonster() then
        local monsterConfigVo = monster.MonsterManager:getMonsterVo01(self:getHeroTid())
        return monsterConfigVo.model
    elseif (self.sourceType == formation.HERO_SOURCE_TYPE.ARENA) then
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(self:getHeroTid())
        if (heroConfigVo) then
            return heroConfigVo:getHeroModel()
        end
    end
    return 0
end

-- function getHeroLvl(self)
--     if (self.sourceType == formation.HERO_SOURCE_TYPE.OWN) then
--         local heroVo = hero.HeroManager:getHeroVo(self.heroId)
--         return heroVo.lvl
--     elseif self:getIsMonster() then
--         local monsterTidVo = monster.MonsterManager:getMonsterVo(self.heroId)
--         return monsterTidVo.lvl
--     elseif (self.sourceType == formation.HERO_SOURCE_TYPE.ARENA) then
--         return self.m_heroLvl
--     end
--     return 0
-- end

-- function getHeroEvolutionLvl(self)
--     if (self.sourceType == formation.HERO_SOURCE_TYPE.OWN) then
--         local heroVo = hero.HeroManager:getHeroVo(self.heroId)
--         return heroVo.evolutionLvl
--     elseif self:getIsMonster() then
--         local monsterTidVo = monster.MonsterManager:getMonsterVo(self.heroId)
--         return monsterTidVo.evolutionLvl
--     elseif (self.sourceType == formation.HERO_SOURCE_TYPE.ARENA) then
--         return self.m_evolutionLvl
--     end
--     return 0
-- end

function getPrefabName(self)
    if (self.sourceType == formation.HERO_SOURCE_TYPE.OWN) then
        local heroVo = hero.HeroManager:getHeroVo(self.heroId)
        return heroVo:getPrefabName()
    elseif self:getIsMonster() then
        local monsterTidVo = monster.MonsterManager:getMonsterVo(self.heroId)
        return monsterTidVo:getBaseConfig():getPrefabName()
    elseif (self.sourceType == formation.HERO_SOURCE_TYPE.ARENA) then
        return ""
    end
    return ""
end

function getIsMonster(self)
    if (self.sourceType == formation.HERO_SOURCE_TYPE.OWN) then
        return false
    elseif (self.sourceType == formation.HERO_SOURCE_TYPE.ARENA) then
        return false
        -- elseif (self.sourceType == formation.HERO_SOURCE_TYPE.MAIN_STORY) then
        --     return true
        -- elseif (self.sourceType == formation.HERO_SOURCE_TYPE.MAZE_SUPPORT) then
        --     return true
        -- elseif (self.sourceType == formation.HERO_SOURCE_TYPE.MAIN_EXPLORE_SUPPORT) then
        --     return true
        -- elseif (self.sourceType == formation.HERO_SOURCE_TYPE.TEACHING) then
        --     return true
        -- elseif (self.sourceType == formation.HERO_SOURCE_TYPE.PROTECT_PEOPLE) then
        --     return true
    end
    return true
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]