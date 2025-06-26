--[[ 
-----------------------------------------------------
@filename       : FormationDisasterSelectItem
@Description    : 灾厄战员选择item
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('formation.FormationDisasterSelectItem', Class.impl(formation.FormationHeroSelectItem))

function __update(self)
    local teamId = self.data:getDataVo().teamId
    local formationId = self.data:getDataVo().formationId
    local isShowRemove = self.data:getDataVo().isShowRemove
    local manager = self.data:getDataVo().manager
    local dataVo = self.data:getDataVo().dataVo
    if (dataVo) then
        if (dataVo.__cname == hero.HeroVo.__cname) then 						-- 我方英雄vo
            local heroVo = dataVo
            if (not self.m_headGrid) then
                self.m_headGrid = hero.HeroCard:poolGet()
            end
            self.m_headGrid:setData(heroVo)
            self.m_headGrid:setParent(self.m_cardNode)
            self.m_headGrid:setScale(0.78)
            self.m_headGrid:setCallBack(self, self.__onClickHeadHandler)

            self.m_isInFormation = manager:isHeroInFormation(teamId, heroVo.id, formation.HERO_SOURCE_TYPE.OWN)
            self.m_isInAssist = manager:isHeroInAssist(teamId, heroVo.id)

            self.m_goSource:SetActive(false)

        elseif (dataVo.__cname == monster.MonsterTidConfigVo.__cname) then 	-- 援助我方的怪物vo
            local monsterTidVo = dataVo
            local monsterConfigVo = dataVo:getBaseConfig()
            if (not self.m_headGrid) then
                self.m_headGrid = hero.MonsterCard:poolGet()
            end
            self.m_headGrid:setData(monsterTidVo)
            self.m_headGrid:setParent(self.m_cardNode)
            self.m_headGrid:setScale(0.78)
            self.m_headGrid:setCallBack(self, self.__onClickHeadHandler)

            self.m_isInFormation = manager:isHeroInFormation(teamId, monsterTidVo.uniqueTid, formation.HERO_SOURCE_TYPE.MAIN_STORY)
            self.m_isInAssist = false

            self.m_goSource:SetActive(not isShowRemove)
            self.m_imgSource:SetImg(UrlManager:getPackPath("formation/formation_3.png"), false)
        end

        self.m_goUseState:SetActive(false)
        if (isShowRemove) then
            self.m_goRemove:SetActive(true)
        else
            self.m_goRemove:SetActive(false)
            if (self.m_isInFormation) then
                self.m_goUseState:SetActive(true)
                self.m_textUseState.text = hero.HeroUseCodeManager:getTipByUseCode(hero.HeroUseCodeManager.IN_TEAM_FORMATION) --"出战中"
                self.m_textUseState.color = hero.HeroUseCodeManager:getTipColorByUseCode(hero.HeroUseCodeManager.IN_TEAM_FORMATION)
            elseif (self.m_isInAssist) then
                self.m_goUseState:SetActive(true)
                self.m_textUseState.text = hero.HeroUseCodeManager:getTipByUseCode(hero.HeroUseCodeManager.IN_ASSIST_FIGHT) --"助战中"
                self.m_textUseState.color = hero.HeroUseCodeManager:getTipColorByUseCode(hero.HeroUseCodeManager.IN_ASSIST_FIGHT)
            else
                local teamIndex = self:getHeroInTeam()
                if teamIndex > 0 then
                    self.m_goUseState:SetActive(true)
                    self.m_textUseState.text = _TT(104017,teamIndex) -- hero.HeroUseCodeManager:getTipByUseCode(hero.HeroUseCodeManager.IN_TEAM_FORMATION) --"出战中"
                    self.m_textUseState.color = hero.HeroUseCodeManager:getTipColorByUseCode(hero.HeroUseCodeManager.IN_TEAM_FORMATION)
                    return
                end

                self.m_goUseState:SetActive(false)
                self.m_textUseState.text = ""
            end
        end
    else
        self:deActive()
    end
end

function __onClickHeadHandler(self, args)
    local manager = self.data:getDataVo().manager
    local dataVo = self.data:getDataVo().dataVo

    local teamIndex = self:getHeroInTeam()
    if not self.m_isInFormation and teamIndex > 0 then
        gs.Message.Show(_TT(104017,teamIndex))
        return
    end

    if (dataVo.__cname == hero.HeroVo.__cname) then
        -- 我方英雄vo
        local heroVo = dataVo
        -- if(hero.HeroUseCodeManager:getIsCanUse(heroVo.id, true, {hero.HeroUseCodeManager.IN_TEAM_FORMATION, hero.HeroUseCodeManager.IN_ARENA_DEFENSE})) then
        manager:dispatchEvent(manager.HERO_FORMATION_SELECT, { heroId = heroVo.id, heroTid = heroVo.tid, heroSourceType = formation.HERO_SOURCE_TYPE.OWN, isInFormation = self.m_isInFormation, isInAssist = self.m_isInAssist })
        -- end
    elseif (dataVo.__cname == monster.MonsterTidConfigVo.__cname) then
        -- 援助我方的怪物vo
        local monsterTidVo = dataVo
        local monsterConfigVo = dataVo:getBaseConfig()
        manager:dispatchEvent(manager.HERO_FORMATION_SELECT, { heroId = monsterTidVo.uniqueTid, heroTid = monsterTidVo.tid, heroSourceType = formation.HERO_SOURCE_TYPE.MAIN_STORY, isInFormation = self.m_isInFormation, isInAssist = self.m_isInAssist })
    end

    -- local teamIndex,teamId,heroPos = self:getHeroInTeam()
    -- if teamIndex > 0 then
    --     manager:setSelectFormationHeroList(teamId,teamIndex,dataVo.id, dataVo.tid,formation.HERO_SOURCE_TYPE.OWN,heroPos, false)
    -- end
end

-- 获取战员已上阵队伍序号
function getHeroInTeam(self)
    local manager = self.data:getDataVo().manager
    local dataVo = self.data:getDataVo().dataVo
    local teamList = manager:getAllTeamIdList()
    for i, teamId in ipairs(teamList) do
        if teamId ~= formation.DISASTAERIMID then
            local formationHeroList = manager:getSelectFormationHeroList(teamId)
            for _, vo in ipairs(formationHeroList) do
                if vo.heroId == dataVo.id then
                    return i,teamId,vo.heroPos
                end
            end
        end
    end
    return 0,0,0
end

return _M