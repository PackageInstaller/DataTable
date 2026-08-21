module('covenant.CovenantHelpHeroSelectItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
	super.onInit(self, go)
	self.m_gridNode = self:getChildTrans("HeadNode")
	self.m_goHelped = self:getChildGO("ImgHelped")
	self.m_imgHelped = self.m_goHelped:GetComponent(ty.AutoRefImage)
	self.m_goRemove = self:getChildGO("ImgRemove")
end

function getTrans(self)
	return self:getChildTrans("ImgToucher")
end

function setData(self, param)
	super.setData(self, param)
	
	local helperId = self.data:getDataVo().helperId
	local pos = self.data:getDataVo().pos
	local isShowRemove = self.data:getDataVo().isShowRemove
	local heroVo = self.data:getDataVo().heroVo
	if(heroVo) then
		if(not self.m_headGrid) then
			self.m_headGrid = HeroHeadSelectGrid:poolGet()
		end
		self.m_headGrid:setData(heroVo)
		self.m_headGrid:setParent(self.m_gridNode)
		self.m_headGrid:setLvl(heroVo.lvl)
		self.m_headGrid:setClickEnable(false)
		-- self.m_headGrid:setCallBack(self, self.__onClickHeadHandler)
		
		self.m_imgHelped:SetImg(hero.HeroUseCodeManager:getIconByUseCode(hero.HeroUseCodeManager.IN_HELPER_HELPED), false)
		if(isShowRemove)then
			if(self.m_headGrid) then
				self.m_headGrid:poolRecover()
				self.m_headGrid = nil
			end
			self.m_goRemove:SetActive(true)
			self.m_goHelped:SetActive(false)
		else
			self.m_goRemove:SetActive(false)
			self.m_goHelped:SetActive(heroVo.covanantHelperId ~= 0)
		end

		self:addOnClick(self:getChildGO("ImgToucher"), self.__onClickHeadHandler)
	else
		self:deActive()
	end
end

function __onClickHeadHandler(self, args)
	local helperId = self.data:getDataVo().helperId
	local pos = self.data:getDataVo().pos
	local isShowRemove = self.data:getDataVo().isShowRemove
	local heroVo = self.data:getDataVo().heroVo
	covenant.CovenantManager:dispatchEvent(covenant.CovenantManager.COVENANT_HELP_HERO_SELECT, {heroId = heroVo.id})
end

function deActive(self)
	super.deActive(self)
	if(self.m_headGrid) then
		self.m_headGrid:poolRecover()
		self.m_headGrid = nil
	end
	self.m_goRemove:SetActive(false)
	self:removeOnClick(self:getChildGO("ImgToucher"))
end

function onDelete(self)
	super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
