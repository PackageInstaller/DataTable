-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/ResolveItemTipsView.lua

module("logic.extensions.backpack.view.ResolveItemTipsView", package.seeall)

local M = class("ResolveItemTipsView", ViewComponent)

function M:buildUI()
	self._btnCancel = self:getBtn("3&btn_left_-1571983320")
	self._btnConfirm = self:getBtn("4&btn_right_1251431307")
	self._btnClose = self:getBtn("universal_second_tips_common_bg_1201003252")
	self._txtTitle = self:getText("universal_second_tips_common_bg_-1535781828")
	self._scrollRectComp1 = self:getGo("resolve_item_hint_tips_-1585602844"):GetComponent(UIComponentType.ScrollRect)
	self._scrollContent1 = self:getGo("resolve_item_hint_tips_2004077091")
	self._itemTemplate = goutil.findChild(self.mainGO, "backpack_item")

	self._itemTemplate:SetActive(false)

	self._scrollRectComp2 = self:getGo("resolve_item_hint_tips_188646708"):GetComponent(UIComponentType.ScrollRect)
	self._scrollContent2 = self:getGo("resolve_item_hint_tips_429741376")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
end

function M:unbindEvents()
	self._btnCancel:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
end

function M:onEnter()
	local params = self:getFirstParam()

	self._showType = params.showType
	self._useItems = TableUtil.reverseTable(params.useItems)
	self._getItems = self:calGetItems()

	self:refreshItemScroll()

	self._scrollRectComp1.horizontalNormalizedPosition = 0
	self._scrollRectComp2.horizontalNormalizedPosition = 0
end

function M:onExit()
	return
end

function M:refreshItemScroll()
	goutil.clearChildren(self._scrollContent1)
	table.sort(self._useItems, ItemUtil.commonSortFunc)

	for index = 1, #self._useItems do
		local itemGo = goutil.clone(self._itemTemplate)

		itemGo:SetActive(true)
		goutil.addChildToParent(itemGo, self._scrollContent1)

		local view = Astral.LuaComponentContainer.Add(itemGo, ItemCell)
		local itemData = self._useItems[index]

		view:updateData(itemData)
		view:setShowSelectedEffect(false)
		view:setNumVisibleInGainItem()
		view:setIsHideGetWay(true)
		view:setIsHideLock(true)

		local normalComp = view:getComponent("animation")

		normalComp:setAlpha(1)
	end

	goutil.clearChildren(self._scrollContent2)

	for index = 1, #self._getItems do
		local itemGo = goutil.clone(self._itemTemplate)

		itemGo:SetActive(true)
		goutil.addChildToParent(itemGo, self._scrollContent2)

		local view = Astral.LuaComponentContainer.Add(itemGo, ItemCell)
		local itemData = self._getItems[index]

		view:updateData(itemData)
		view:setShowSelectedEffect(false)
		view:setNumVisibleInGainItem()
		view:setIsHideGetWay(true)

		local normalComp = view:getComponent("animation")

		normalComp:setAlpha(1)
	end
end

function M:calGetItems()
	local res = {}

	MainBackpackModel.instance:calRecycleGetItems(self._useItems, res)

	return res
end

function M:_onClickClose()
	self:back()
end

function M:_onClickConfirm()
	if self._showType then
		GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_DO_RECYCLE, self._showType)
	else
		local uuids = EquipIntensifyRecycleModel.instance:getRecycleUUids()

		EquipmentAgent.instance:sendEquipDecomposeRequest(uuids, false)
	end

	self:back()
end

return M
