--[[ 
-----------------------------------------------------
@filename       : FormationCaptainSelectItem
@Description    : 阵型-队长选择项
@date           : 2021-05-12 17:00:26
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('formation.FormationCaptainSelectItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
    super.onInit(self, go)
	self.mNodeCardTrans = self:getChildTrans("mHeroCardNode")
	self.mImgCaptainGo = self:getChildGO("mImgCaptain")
    self.mGuideClick = self:getChildGO("mGuideClick")
    self:addOnClick(self.mGuideClick, self.onClickItemHandler)
end

function getGuideTrans(self)
    return self.mGuideClick.transform
end

function setData(self, param)
    super.setData(self, param)
	local teamId = self.data:getDataVo().teamId
	local formationId = self.data:getDataVo().formationId
	local manager = self.data:getDataVo().manager
	local formationHeroVo = self.data:getDataVo().formationHeroVo
	local dataVo = self.data:getDataVo().dataVo
    if (dataVo) then
		if(dataVo.__cname == hero.HeroVo.__cname) then 						-- 我方英雄vo
			local heroVo = dataVo
			local function __onLoadFinishHandler()
				self.mHeroCard:setDetailVisible(false)
			end
			if (not self.mHeroCard) then
				self.mHeroCard = hero.HeroCard:poolGet()
			end
			self.mHeroCard:setData(heroVo, nil, __onLoadFinishHandler)
			self.mHeroCard:setStarLvl(heroVo.evolutionLvl)
			self.mHeroCard:setParent(self.mNodeCardTrans)
			self.mHeroCard:setShowUseState(false)

			self.m_isInFormation = manager:isHeroInFormation(teamId, heroVo.id, formation.HERO_SOURCE_TYPE.OWN)
			self.m_isInAssist = manager:isHeroInAssist(teamId, heroVo.id)

		elseif(dataVo.__cname == monster.MonsterTidConfigVo.__cname) then 	-- 援助我方的怪物vo
			local monsterTidVo = dataVo
			local monsterConfigVo = dataVo:getBaseConfig()
			local function __onLoadFinishHandler()
				self.mHeroCard:setDetailVisible(false)
			end
			if (not self.mHeroCard) then
				self.mHeroCard = hero.HeroCard:poolGet()
			end
			self.mHeroCard:setData(xx, nil, __onLoadFinishHandler)
			self.mHeroCard:setStarLvl(xx.evolutionLvl)
			self.mHeroCard:setParent(self.mNodeCardTrans)
			self.mHeroCard:setShowUseState(false)

			self.m_isInFormation = manager:isHeroInFormation(teamId, monsterTidVo.uniqueTid, formation.HERO_SOURCE_TYPE.MAIN_STORY)
			self.m_isInAssist = false
		end

		self.mImgCaptainGo:SetActive(formationHeroVo:getIsMonster())
    else
        self:deActive()
    end
end

function onClickItemHandler(self)
	local manager = self.data:getDataVo().manager
	local dataVo = self.data:getDataVo().dataVo
	if(dataVo.__cname == hero.HeroVo.__cname) then
		-- 我方英雄vo
		local heroVo = dataVo
		manager:dispatchEvent(manager.HERO_FORMATION_CAPTAIN_SELECT, {heroId = heroVo.id, heroTid = heroVo.tid, heroSourceType = formation.HERO_SOURCE_TYPE.OWN, isInFormation = self.m_isInFormation, isInAssist = self.m_isInAssist})
	elseif(dataVo.__cname == monster.MonsterTidConfigVo.__cname) then
		-- 援助我方的怪物vo
		local monsterTidVo = dataVo
		local monsterConfigVo = dataVo:getBaseConfig()
		manager:dispatchEvent(manager.HERO_FORMATION_CAPTAIN_SELECT, {heroId = monsterTidVo.uniqueTid, heroTid = monsterTidVo.tid, heroSourceType = formation.HERO_SOURCE_TYPE.MAIN_STORY, isInFormation = self.m_isInFormation, isInAssist = self.m_isInAssist})
	end
end

function deActive(self)
    super.deActive(self)
    if (self.mHeroCard) then
        self.mHeroCard:poolRecover()
        self.mHeroCard = nil
    end
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
