-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/facade/StoreMainFacade.lua

module("logic.extensions.store.facade.StoreMainFacade", package.seeall)

local StoreMainFacade = class("StoreMainFacade", BaseFacade)

function StoreMainFacade:ctor()
	self._storeMainView = false
end

function StoreMainFacade:registerView(view)
	local views = view._viewPresentor._views

	self._isRegistered = true
	self._storeMainView = views[1]
	self._storeRecommondView = views[2]
	self._storeMonthCardView = views[3]
	self._storeCharacterView = views[4]
	self._storeCommonView = views[5]
end

function StoreMainFacade:unregisterView()
	if not self:_checkView() then
		return false
	end

	self._isRegistered = false
	self._storeMainView = false
	self._storeRecommondView = false
	self._storeMonthCardView = false
	self._storeCharacterView = false
	self._storeCommonView = false
end

function StoreMainFacade:showRecommendView()
	if not self:_checkView() then
		return
	end

	self._storeRecommondView:setVisible(true)
	self._storeMonthCardView:setVisible(false)
	self._storeCommonView:setVisible(false)
end

function StoreMainFacade:setCharacterView(visible)
	if not self:_checkView() then
		return
	end

	self._storeCharacterView:setVisible(visible)
end

function StoreMainFacade:showMonthCardView()
	if not self:_checkView() then
		return
	end

	self._storeRecommondView:setVisible(false)
	self._storeMonthCardView:setVisible(true)
	self._storeCommonView:setVisible(false)
end

function StoreMainFacade:showGoodsView(storeMo)
	if not self:_checkView() then
		return
	end

	self._storeRecommondView:setVisible(false)
	self._storeMonthCardView:setVisible(false)
	self._storeCommonView:setVisible(true, storeMo)
end

function StoreMainFacade:_checkView()
	if not self._isRegistered then
		printWarn("StoreMainView:need to register view first!")

		return false
	end

	return true
end

function StoreMainFacade:showStoreMain(tabIndex, data)
	ViewMgr.instance:open(ViewName.StoreMainViewViewPresentor, {
		tabIndex = tabIndex,
		data = data
	})
end

function StoreMainFacade:jumpToStore(tabId, storeId, goodsId, simulat)
	local index = StoreModel.instance:getStoreTabIndexById(tabId)

	if not index then
		if enableWarnLog then
			printWarn("Jump To Store Failed , can't find tabId:", tabId)
		end

		return false
	end

	local storeMo = StoreModel.instance:getStoreMoByID(storeId)

	if storeMo and not storeMo:getIsOnLine() then
		FloatWordMgr.instance:show(lang("tip_store_mall_outline"))

		return false
	end

	if goodsId and goodsId > 0 then
		local hasFind = false
		local goodlist = StoreModel.instance:getGoodsList(tabId, storeId)

		for index, goodMo in pairs(goodlist) do
			if goodMo:getGoodsId() == goodsId then
				hasFind = true

				break
			end
		end

		if not hasFind then
			FloatWordMgr.instance:show(lang("tip_store_good_outline"))

			return false
		end
	end

	StoreModel.instance:setJumpInfo({
		index = index,
		tabId = tabId,
		targetStoreId = storeId,
		targetGoodsId = goodsId
	})

	if simulat then
		return true
	end

	if not ViewMgr.instance:isOpen(ViewName.StoreMainViewViewPresentor) then
		ViewMgr.instance:open(ViewName.StoreMainViewViewPresentor, {
			tabIndex = index
		})
	else
		if not self:_checkView() then
			return false
		end

		self._storeMainView:jumpTab(index)
	end

	return true
end

function StoreMainFacade:showShippingTips(goodMo)
	ViewMgr.instance:open(ViewName.StoreShoppingTipsViewPresentor, goodMo)
end

function StoreMainFacade:jumpToSkinStore(skinId)
	local storeList = StoreModel.instance:getStoresByStoreType(StoreEnum.MallType.Skin)
	local storeMo = storeList[1]

	if not storeMo then
		return
	end

	local tabId = storeMo:getTabId()
	local storeId = storeMo:getId()
	local list = StoreModel.instance:getGoodsList(tabId, storeId)
	local goodsId

	for i = 1, #list do
		if list[i]:getSkinId() == skinId then
			goodsId = list[i]:getGoodsId()
		end
	end

	self:jumpToStore(tabId, storeId, goodsId)
end

StoreMainFacade.instance = StoreMainFacade.New()

return StoreMainFacade
