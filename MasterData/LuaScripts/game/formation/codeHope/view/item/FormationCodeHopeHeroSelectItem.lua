--[[ 
-----------------------------------------------------
@filename       : FormationCodeHopeHeroSelectItem
@Description    : 代号·希望副本战员选择item
@date           : 2021-05-18 14:21:55
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('formation.FormationCodeHopeHeroSelectItem', Class.impl(formation.FormationHeroSelectItem))

function onInit(self, go)
    super.onInit(self, go)
    self.mImgStaminaBg = self:getChildGO("mImgStaminaBg")
    self.mImgStaminaBar = self:getChildGO("mImgStaminaBar"):GetComponent(ty.Image)
    self.mTxtStamina = self:getChildGO("mTxtStamina"):GetComponent(ty.Text)
    self.ImgStamina = self:getChildGO("ImgStamina")
end

function setData(self, param)
    super.setData(self, param)
    self:__update()
end

function __update(self)
    local teamId = self.data:getDataVo().teamId
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

        if (isShowRemove) then
            self.m_goRemove:SetActive(true)
            self.m_goUseState:SetActive(false)
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

            self.mImgStaminaBg:SetActive(true)
            if not self:dupIsPass() then
                if self:hasHeroStamina() then
                    self.ImgStamina:SetActive(false)
                else
                    self.ImgStamina:SetActive(true)
                end
            end
        end
        self:updateStamina()
    else
        self:deActive()
    end
end

function updateStamina(self)
    local heroStaminaInfo = dup.DupCodeHopeManager:getHeroInfo(dup.DupCodeHopeManager:getChapterByDupId(formation.FormationCodeHopeManager:getData().dupId), self.data:getDataVo().dataVo.id)

    self.mImgStaminaBar.fillAmount = heroStaminaInfo.remaidCount / heroStaminaInfo.maxCount
    self.mTxtStamina.text = heroStaminaInfo.remaidCount
end

-- 副本是否已通关
function dupIsPass(self)
    return dup.DupCodeHopeManager:getDupIsPass(formation.FormationCodeHopeManager:getData().dupId)
end

function getRemaidStamina(self)
    local heroStaminaInfo = dup.DupCodeHopeManager:getHeroInfo(dup.DupCodeHopeManager:getChapterByDupId(formation.FormationCodeHopeManager:getData().dupId), self.data:getDataVo().dataVo.id)
    return heroStaminaInfo.remaidCount
end

function hasHeroStamina(self)
    local dupVo = dup.DupCodeHopeManager:getDupVo(formation.FormationCodeHopeManager:getData().dupId)
    if self:getRemaidStamina() >= dupVo.needNum then
        return true
    end
    return false
end

function __onClickHeadHandler(self, args)
    if not self:hasHeroStamina() and not self.data:getDataVo().isShowRemove and not self:dupIsPass() then
        -- gs.Message.Show2("该战员耐力不足，无法出战")
        gs.Message.Show2(_TT(29127))
        return
    end

    local manager = self.data:getDataVo().manager
    local dataVo = self.data:getDataVo().dataVo
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
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]