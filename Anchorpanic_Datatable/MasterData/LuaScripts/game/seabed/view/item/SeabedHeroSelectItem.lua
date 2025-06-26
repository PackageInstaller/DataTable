
module('seabed.SeabedHeroSelectItem', Class.impl('lib.component.BaseItemRender'))

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
	self:addOnClick(self.m_guideClick, self.__onClickHeadHandler)
end

function getGuideTrans(self)
	return self.m_guideClick.transform
end

function setData(self, param)
	super.setData(self, param)
    self:__update()
end

function __update(self)
	local teamId = self.data:getDataVo().teamId
	local isShowRemove = self.data:getDataVo().isShowRemove
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

			self.m_isInFormation = seabed.SeabedManager:getHeroInSelect( heroVo.id)
			self.m_isInAssist = false-- seabed.SeabedManager::isHeroInAssist(teamId, heroVo.id)
			self.m_goSource:SetActive(false)
	    end

		if(isShowRemove)then
			self.m_goRemove:SetActive(true)
			self.m_goUseState:SetActive(false)
		else
			self.m_goRemove:SetActive(false)
			self.m_goUseState:SetActive(false)
			self.m_textUseState.text = ""
		end
	else
		self:deActive()
	end
end

function __onClickHeadHandler(self, args)
	local heroVo = self.data:getDataVo().dataVo
	if seabed.SeabedManager:getHeroInSelect(heroVo.id) then
        seabed.SeabedManager:removeSelectHeroId(heroVo.id)
    else
        seabed.SeabedManager:addSelectHeroId(heroVo.id)
    end
    self.data:getDataVo().isShowRemove = seabed.SeabedManager:getHeroInSelect(heroVo.id)
    self:__update()

    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_HERO_SELECT_PANEL)
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
