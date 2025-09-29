-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/view/RoomBackpackDecomposeView.lua

module("logic.extensions.housebackpack.view.RoomBackpackDecomposeView", package.seeall)

local M = class("RoomBackpackDecomposeView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self._mainGo:SetActive(false)

	self._registry = nil
end

function M:setRegistry(registry)
	self._registry = registry
end

function M:buildUI()
	self._btnBack = self._registry:getBtn("furniture_backpack_view_1784621511")
	self._btnResolve = self._registry:getBtn("furniture_backpack_view_517229304")
	self._txtSelectNum = self._registry:getText("furniture_backpack_view_1008084051")
	self._currencyItemGo = self._registry:getGo("5&currency_item_1957261791")
	self._txtHint2Go = self._registry:getGo("furniture_backpack_view_-1962740364")
	self._imgMoneyIcon = self._registry:getImage("5&currency_item_-1010472309")
	self._txtMoneyCount = self._registry:getText("5&currency_item_716111503")
end

function M:onEnter()
	GlobalDispatcher:addEventListener(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED, self._refreshView, self)
	self._btnBack:AddClickListener(self._onClickBackBtn, self)
	self._btnResolve:AddClickListener(self._onClickResolveBtn, self)
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED, self._refreshView, self)
	self._btnBack:RemoveClickListener()
	self._btnResolve:RemoveClickListener()
end

function M:OnDestroy()
	return
end

function M:setEnabled(enabled)
	self._mainGo:SetActive(enabled)
end

function M:_refreshView()
	if not RoomBackpackModel.instance:isInRecycling() then
		return
	end

	local maxSelectNum = RoomBackpackModel.instance:getMaxRecycleNum()
	local itemDataTable = RoomBackpackModel.instance:getRecycleItems()
	local itemDataCount = RoomBackpackModel.instance:getRecycleItemsCount()

	self._txtSelectNum.text = string.format(lang("tip_room_recycle_capacity"), itemDataCount, maxSelectNum)

	local code = false
	local count = 0

	for _, itemData in ipairs(itemDataTable) do
		local decomposeReward = itemData:getDecomposeReward()

		if decomposeReward.code then
			code = code or decomposeReward.code
			count = count + decomposeReward.count
		end
	end

	if code then
		self._currencyItemGo:SetActive(true)
		self._txtHint2Go:SetActive(true)

		local itemCo = BackpackConfig.instance:getItemInfoByItemId(code)

		if itemCo then
			IconLoader.setSprite(self._imgMoneyIcon, IconType.ItemIcon, itemCo.icon)

			self._txtMoneyCount.text = TextFormatter.formatNumber(count)
		end
	else
		self._currencyItemGo:SetActive(false)
		self._txtHint2Go:SetActive(false)
	end
end

function M:_onClickBackBtn()
	GlobalDispatcher:dispatchEvent(EventType.ROOM_BACKPACK_EXIT_RECYCLE)
end

function M:_onClickResolveBtn()
	if not RoomBackpackModel.instance:isInRecycling() then
		return
	end

	local uuids = RoomBackpackModel.instance:getRecycleUuids()

	if #uuids == 0 then
		FloatWordMgr.instance:show(lang("tip_select_recycle_furniture"))

		return
	end

	local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_ask_recycle_furniture"))

	dialog:setConfirmListener(function()
		HouseAgent.instance:sendDecomposeFurnituresRequest(uuids)
	end, self)
end

return M
