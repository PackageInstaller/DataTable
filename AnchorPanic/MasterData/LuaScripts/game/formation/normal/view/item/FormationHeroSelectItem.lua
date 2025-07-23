
module('formation.FormationHeroSelectItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
	super.onInit(self, go)
	self.m_cardNode = self:getChildTrans("CardNode")	

	self.m_goUseState = self:getChildGO("GroupUseState")
	self.m_textUseState = self:getChildGO("TextUseState"):GetComponent(ty.Text)

	self.m_goRemove = self:getChildGO("ImgRemove")
	self:getChildGO("TextRemove"):GetComponent(ty.Text).text = _TT(1270)

	self.m_goSource = self:getChildGO("ImgSource")
	self.m_imgSource = self.m_goSource:GetComponent(ty.AutoRefImage)

	self.m_guideClick = self:getChildGO("GuideClick")

	self.mGroupHeroHp = self:getChildGO("mGroupHeroHpItem")
	self.mImgProBar = self:getChildGO("mImgProBar"):GetComponent(ty.Image)
	self.mTxtCont = self:getChildGO("mTxtCont"):GetComponent(ty.Text)
	self:addOnClick(self.m_guideClick, self.__onClickHeadHandler)
end

function getGuideTrans(self)
	return self.m_guideClick.transform
end

function setData(self, param)
	self.mGroupHeroHp:SetActive(false)
	super.setData(self, param)
    self:__update()
end

function __update(self)
	
	local teamId = self.data:getDataVo().teamId
	local isShowRemove = self.data:getDataVo().isShowRemove
	local manager = self.data:getDataVo().manager
	local dataVo = self.data:getDataVo().dataVo
	if(dataVo) then
		if(dataVo.__cname == hero.HeroVo.__cname) then 						-- 我方英雄vo
			local heroVo = dataVo
			if(not self.m_headGrid) then
				self.m_headGrid = hero.HeroCard:poolGet()
			end
			self.m_headGrid:setData(heroVo)
			self.m_headGrid:setParent(self.m_cardNode)
			self.m_headGrid:setScale(0.78)
			self.m_headGrid:setCallBack(self, self.__onClickHeadHandler)

			self.m_isInFormation = manager:isHeroInFormation(teamId, heroVo.id, formation.HERO_SOURCE_TYPE.OWN)
			self.m_isInAssist = manager:isHeroInAssist(teamId, heroVo.id)
			
			self.m_goSource:SetActive(false)

		elseif(dataVo.__cname == monster.MonsterTidConfigVo.__cname) then 	-- 援助我方的怪物vo
			local monsterTidVo = dataVo
			local monsterConfigVo = dataVo:getBaseConfig()
			if(not self.m_headGrid) then
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

		if(isShowRemove)then
			self.m_goRemove:SetActive(true)
			self.m_goUseState:SetActive(false)
		else
			self.m_goRemove:SetActive(false)
			if(self.m_isInFormation)then
				self.m_goUseState:SetActive(true)
				self.m_textUseState.text = hero.HeroUseCodeManager:getTipByUseCode(hero.HeroUseCodeManager.IN_TEAM_FORMATION) --"出战中"
				self.m_textUseState.color = hero.HeroUseCodeManager:getTipColorByUseCode(hero.HeroUseCodeManager.IN_TEAM_FORMATION)
			elseif(self.m_isInAssist)then
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

function __onClickHeadHandler(self, args)
	local manager = self.data:getDataVo().manager
	local dataVo = self.data:getDataVo().dataVo
	if(dataVo.__cname == hero.HeroVo.__cname) then
		-- 我方英雄vo
		local heroVo = dataVo
		-- if(hero.HeroUseCodeManager:getIsCanUse(heroVo.id, true, {hero.HeroUseCodeManager.IN_TEAM_FORMATION, hero.HeroUseCodeManager.IN_ARENA_DEFENSE})) then
			manager:dispatchEvent(manager.HERO_FORMATION_SELECT, {heroId = heroVo.id, heroTid = heroVo.tid, heroSourceType = formation.HERO_SOURCE_TYPE.OWN, isInFormation = self.m_isInFormation, isInAssist = self.m_isInAssist})
		-- end
	elseif(dataVo.__cname == monster.MonsterTidConfigVo.__cname) then
		-- 援助我方的怪物vo
		local monsterTidVo = dataVo
		local monsterConfigVo = dataVo:getBaseConfig()
		manager:dispatchEvent(manager.HERO_FORMATION_SELECT, {heroId = monsterTidVo.uniqueTid, heroTid = monsterTidVo.tid, heroSourceType = formation.HERO_SOURCE_TYPE.MAIN_STORY, isInFormation = self.m_isInFormation, isInAssist = self.m_isInAssist})
	end
end

function deActive(self)
	super.deActive(self)
	if(self.m_headGrid) then
		self.m_headGrid:poolRecover()
		self.m_headGrid = nil
	end
	self.m_goUseState:SetActive(false)
	self.m_goRemove:SetActive(false)
	self.m_goSource:SetActive(false)
end

function onDelete(self)
	super.onDelete(self)
	self:removeOnClick(self.m_guideClick, self.__onClickHeadHandler)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1270):	"移除"
]]
