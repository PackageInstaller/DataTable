--[[ 
-----------------------------------------------------
@filename       : FormationArenaAttackSelectItem
@Description    : 竞技场防守战员选择item
@date           : 2021年12月2日 19:37:44
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('formation.FormationArenaAttackSelectItem', Class.impl(formation.FormationHeroSelectItem))

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
                self.m_goUseState:SetActive(false)
                self.m_textUseState.text = ""
            end
        end
    else
        self:deActive()
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]