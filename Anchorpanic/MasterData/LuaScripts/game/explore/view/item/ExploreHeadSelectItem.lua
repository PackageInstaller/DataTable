module('explore.ExploreHeadSelectItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
	super.onInit(self, go)
	self.mHeadNode = self:getChildTrans("mHeadNode")
	self.mImgFight = self:getChildGO("mImgFight")
	self.mTxtFight = self:getChildGO("mTxtFight"):GetComponent(ty.Text)
	self.mImgSelectState = self:getChildGO("mImgSelectState")
end

function getTrans(self)
	return self:getChildTrans("mImgToucher")
end

function setData(self, param)
	super.setData(self, param)
	local dataVo = self.data:getDataVo().dataVo
	if(dataVo) then
		-- 我方英雄vo
		if(self.mHeadGrid) then
			self.mHeadGrid:poolRecover()
			self.mHeadGrid = nil
		end
		local heroVo = dataVo
		self.mHeadGrid = HeroHeadGrid:poolGet()
		self.mHeadGrid:setData(heroVo)
		self.mHeadGrid:setParent(self.mHeadNode)
		self.mHeadGrid:setLvl(heroVo.lvl)
		self.mHeadGrid:setType(true)
		self.mHeadGrid:setEleType(true)
		self.mTxtFight.text = _TT(1365)
		self.mIsSelect = explore.exploreManager:getHeroSelect(heroVo.id)
		self.mImgSelectState:SetActive(self.mIsSelect)
		if(explore.exploreManager:getExploreHeroById(heroVo.id)) then 
			self.mImgFight:SetActive(true)
		else
			self.mImgFight:SetActive(false)
		end
		self:addOnClick(self:getChildGO("mImgToucher"), self.onClickHeadHandler)
	else
		self:deActive()
	end
end

function onClickHeadHandler(self, args)
	local manager = self.data:getDataVo().manager
	local dataVo = self.data:getDataVo().dataVo
	if(dataVo.__cname == hero.HeroVo.__cname) then
		-- 我方英雄vo
		local heroVo = dataVo	
		manager:dispatchEvent(manager.EXPLORE_HERO_SELECT_CHANGE, {heroId = heroVo.id, heroTid = heroVo.tid, heroSourceType = formation.HERO_SOURCE_TYPE.OWN, isInFormation = self.mIsInFormation})
	elseif(dataVo.__cname == monster.MonsterTidConfigVo.__cname) then
		-- 援助我方的怪物vo
		local monsterTidVo = dataVo
		manager:dispatchEvent(manager.EXPLORE_HERO_SELECT_CHANGE, {heroId = monsterTidVo.uniqueTid, heroTid = monsterTidVo.tid, heroSourceType = formation.HERO_SOURCE_TYPE.MAIN_STORY, isInFormation = self.mIsInFormation})
	end
end

function deActive(self)
	super.deActive(self)
	if(self.mHeadGrid) then
		self.mHeadGrid:poolRecover()
		self.mHeadGrid = nil
	end
	self.mImgSelectState:SetActive(false)
	self:removeOnClick(self:getChildGO("mImgToucher"))
end

function onDelete(self)
	super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
