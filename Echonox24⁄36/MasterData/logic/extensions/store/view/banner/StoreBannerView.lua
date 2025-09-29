-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/banner/StoreBannerView.lua

module("logic.extensions.store.view.banner.StoreBannerView", package.seeall)

local M = class("StoreBannerView", StoreFragmentViewBase)

function M:buildUI()
	M.super.buildUI(self)

	self._bannerGos = {}
	self._bannerGos[StoreEnum.BannerType.MonthCard] = self._registry:getGo("store_super_value_panel_1333337512")
	self._bannerGos[StoreEnum.BannerType.SingleBanner] = self._registry:getGo("store_super_value_panel_2059095154")
	self._bannerGos[StoreEnum.BannerType.FirstCharge] = self._registry:getGo("store_super_value_panel_-1888584141")

	local go = self._registry:getMainGO()

	self._viewAnim = go:GetComponent(typeof(Astral.GUITimelineAniLua))
end

function M:destroyUI()
	self._viewAnim = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:_setEvents(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.JUMP_VIEW_EVENT, self._handleJump, self)
		GlobalDispatcher:addEventListener(EventType.JUMP_TO_CHARACTER_PREVIEW, self._handleJump, self)
	else
		GlobalDispatcher:removeEventListener(EventType.JUMP_VIEW_EVENT, self._handleJump, self)
		GlobalDispatcher:removeEventListener(EventType.JUMP_TO_CHARACTER_PREVIEW, self._handleJump, self)
	end
end

function M:onEnter()
	M.super.onEnter(self)
	self:_setEvents(true)

	self._isEnter = true

	if self._viewAnim then
		self._viewAnim:StopTimelineAni()
		self._viewAnim:PlayAniByName("open")
	end

	GlobalDispatcher:dispatchEvent(EventType.STORE_SHOW_MASK, false)
end

function M:onExit()
	M.super.onExit(self)
	self:_setEvents(false)

	self._isEnter = nil
end

function M:callBackFunc(tabCfg)
	self._tabId = tabCfg.code
	self._bannerMos = StoreModel.instance:getRecommendList()

	if not self._bannerMos then
		return
	end

	local jumpInfo = StoreModel.instance:getJumpInfo()

	self._targetId = jumpInfo and jumpInfo.targetStoreId or self._bannerMos[1]:getId()

	StoreModel.instance:setJumpInfo(false)
	self:initTopTog()
end

function M:initTopTog()
	if not self._bannerMos then
		return
	end

	self._selectIndex = 1

	local isOnlyOne = #self._bannerMos <= 1

	for i = 1, #self._bannerMos do
		local togItem = self._togList[i]

		if not togItem then
			local go = goutil.cloneAndSetParent(self._togGo, self._togGo.transform.parent)

			togItem = Astral.LuaComponentContainer.Add(go, StoreTopNavItem)

			togItem:setClickCallBack(self._clickStoreCallBack, self)

			self._togList[i] = togItem
		end

		local storeHotTabMo = self._bannerMos[i]

		if storeHotTabMo:getId() == self._targetId then
			self._selectIndex = i
		end

		local selectIndex = isOnlyOne and -1 or self._selectIndex

		togItem:setSelectIndex(selectIndex)
		togItem:setCellData(storeHotTabMo:getName(), storeHotTabMo, i, self._tabGroup)
		togItem:setRedPointData(StoreEnum.StoreBannerMapRedId[storeHotTabMo:getType()])
		goutil.setActive(togItem.go, true)
	end

	for i = #self._bannerMos + 1, #self._togList do
		goutil.setActive(self._togList[i].go, false)
	end

	self:_clickStoreCallBack(self._selectIndex, self._bannerMos[self._selectIndex])
end

function M:_clickStoreCallBack(index, storeHotTabMo, isClick)
	if self._selectIndex == index and isClick then
		return
	end

	local storeHotTabMo = self._bannerMos[index]

	if storeHotTabMo then
		UserUtil.uploadStoreTaPoint(storeHotTabMo:getName())
	end

	self._selectIndex = index

	for k, v in pairs(self._bannerGos) do
		if k == storeHotTabMo:getType() then
			self:_updateMoneyView(storeHotTabMo:getStoreId())
		end

		goutil.setActive(v, k == storeHotTabMo:getType())
	end

	self:_updateView(storeHotTabMo)
end

function M:_updateView(storeHotTabMo, index)
	self._curStoreHotTabMo = storeHotTabMo

	local type = storeHotTabMo:getType()

	if type == StoreEnum.BannerType.MonthCard then
		if not self._monthCardBanner then
			self._monthCardBanner = Astral.LuaComponentContainer.Add(self._bannerGos[type], StoreMonthCardBanner)

			self._monthCardBanner:setUIRegistry(self._registry)
		end

		self._monthCardBanner:updateView(storeHotTabMo)
	elseif type == StoreEnum.BannerType.FirstCharge then
		if not self._firstChargeBanner then
			self._firstChargeBanner = Astral.LuaComponentContainer.Add(self._bannerGos[type], StoreFirstChargeBanner)
		end

		self._firstChargeBanner:updateView(storeHotTabMo)
	else
		if not self._jumpBanner then
			self._jumpBanner = Astral.LuaComponentContainer.Add(self._bannerGos[type], StoreJumpBanner)

			self._jumpBanner:setUIRegistry(self._registry)
		end

		self._jumpBanner:updateView(storeHotTabMo)
	end
end

function M:_handleJump()
	local index = StoreModel.instance:getStoreTabIndexById(self._tabId)

	StoreModel.instance:setJumpInfo({
		index = index,
		tabId = self._tabId,
		targetStoreId = self._curStoreHotTabMo:getId()
	})
end

return M
