-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/authority/new/CharacterAuthorityDetailTips.lua

module("logic.extensions.charactersystem.view.authority.new.CharacterAuthorityDetailTips", package.seeall)

local M = class("CharacterAuthorityDetailTips")

M.TipsTabTyp = {
	OverView = 2,
	Node = 1
}

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local mainGO = self:getMainGo()
	local registry = self:getRegistry()
	local adapter = StaticPagerAdapter.New(registry)

	self._viewPager = ViewPager.New(registry:findUIElement("authority_main_panel_copy_1711236645"))

	self._viewPager:setViewPresentor(self._viewPresentor)
	self._viewPager:setAdapter(adapter)
	self._viewPager:setPageChangeCallBack(self._onPageChange, self)
	adapter:addFragmentView(CharacterAuthorityTipsNodeFragmentView.New(registry:findUIElement("authority_main_panel_copy_-615994398")))
	adapter:addFragmentView(CharacterAuthorityTipsOverviewFragmentView.New(registry:findUIElement("authority_main_panel_copy_1396488088")))

	self._toggleTipsTabControl = ToggleTabControl.New()

	self._toggleTipsTabControl:setViewPager(self._viewPager)
	self._toggleTipsTabControl:addToggleTab(registry:findUIElement("authority_main_panel_copy_-787862130", UIComponentType.SpaceXToggle))
	self._toggleTipsTabControl:addToggleTab(registry:findUIElement("authority_main_panel_copy_-1641357854", UIComponentType.SpaceXToggle))
end

function M:destroyUI()
	self:setEvent(false)

	self._go = nil
	self.mainGO = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = nil
	end

	self._viewPager:destroy()
	self._toggleTipsTabControl:destroy()

	self._viewPager = nil
	self._toggleTipsTabControl = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self:setEvent(true)
end

function M:onExit()
	self:setEvent(false)
	self._viewPager:clear()
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_ADD_EVENT, self._handleGainItemAdd, self)
		GlobalDispatcher:addEventListener(EventType.ON_USE_ITEM_REPLY, self._handleUseItemReply, self)
		GlobalDispatcher:addEventListener(EventType.HERO_POWER_UNLOCK, self._handleHeroPowerUnlock, self)
	else
		GlobalDispatcher:removeEventListener(EventType.GAIN_ITEM_ADD_EVENT, self._handleGainItemAdd, self)
		GlobalDispatcher:removeEventListener(EventType.ON_USE_ITEM_REPLY, self._handleUseItemReply, self)
		GlobalDispatcher:removeEventListener(EventType.HERO_POWER_UNLOCK, self._handleHeroPowerUnlock, self)
	end
end

function M:_handleGainItemAdd(e, params)
	if self._viewPager and self._viewPager:getPage() == M.TipsTabTyp.Node then
		local view = self._viewPager:getAdapter():getView(M.TipsTabTyp.Node)

		view:refreshCostCount()
	end
end

function M:_handleUseItemReply(e)
	if self._viewPager and self._viewPager:getPage() == M.TipsTabTyp.Node then
		local view = self._viewPager:getAdapter():getView(M.TipsTabTyp.Node)

		view:refreshCostCount()
	end
end

function M:_handleHeroPowerUnlock(e, nodeStatusCache)
	if nodeStatusCache then
		self:_onPageChange(self._viewPager:getPage())
	end
end

function M:setlectTab(index)
	self._toggleTipsTabControl:selectTab(index)
end

function M:setHeroData(heroData, maxPowerLv)
	self._heroData = heroData
	self._maxPowerLevel = maxPowerLv
	self._maxNodeId = maxPowerLv * 5
end

function M:_onPageChange(index)
	local view = self._viewPager:getAdapter():getView(index)

	view:setHeroData(self._heroData, self._maxPowerLevel)
	view:refreshPanel(self._nodeLv, self._nodeIndexInLv, self._nodeId)
end

function M:refreshTipsInfo(nodeLv, nodeId, bySelected)
	self._nodeLv = nodeLv
	self._nodeId = nodeId
	self._nodeIndexInLv = nodeId and nodeId % 5 or 0
	self._nodeIndexInLv = self._nodeIndexInLv == 0 and 5 or self._nodeIndexInLv

	local needRefresh = self._cacheNodeId and self._cacheNodeId ~= nodeId or not self._cacheNodeId

	self._cacheNodeId = nodeId

	if needRefresh and not bySelected then
		CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_qinhedugundong, nil, nil, nil)
	end

	self:_onPageChange(self._viewPager:getPage())
end

return M
