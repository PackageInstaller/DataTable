-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/DecomposePreviewPanelView.lua

module("logic.extensions.backpack.view.DecomposePreviewPanelView", package.seeall)

local M = class("DecomposePreviewPanelView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._txtSelectCount = goutil.findChildTextComponent(self._mainGo, "node/txtSelectCount2")
	self._scrollContentGo = goutil.findChild(self._mainGo, "node/resolveD6Scroll/viewPort/content")
	self._itemTemplate = goutil.findChild(self._mainGo, "backpack_item")
	self._btnAdd = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGo, "node/btnAdd"))
	self._btnResolve = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGo, "node/btnResolve"))
end

function M:_bindEvents()
	self._btnAdd:AddClickListener(self._onClickAdd, self)
	self._btnResolve:AddClickListener(self._onClickResolve, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_FILTER_UPDATE, self._updateView, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_MUL_SELECT_EVENT, self._updateView, self)
end

function M:_unbindEvents()
	self._btnAdd:RemoveClickListener()
	self._btnResolve:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_FILTER_UPDATE, self._updateView, self)
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_MUL_SELECT_EVENT, self._updateView, self)
end

function M:onEnter()
	self:_bindEvents()

	self._showType = ItemModel.instance:getCurShowType()
end

function M:onExit()
	self:_unbindEvents()
end

function M:setViewPresentor(presentor)
	self._presentor = presentor
end

function M:setVisible(visible)
	self._mainGo:SetActive(visible)
end

function M:_updateView()
	if not self._mainGo.activeSelf then
		return
	end

	self._moList = BackpackDecomposeModel.instance:getItemDataTable()
	self._txtSelectCount.text = string.format("已选：%d", #self._moList)

	goutil.clearChildren(self._scrollContentGo)

	local items = {}

	for _, mo in ipairs(self._moList) do
		local id, count = mo:getDecomposedItem()

		if not items[id] then
			items[id] = count
		else
			items[id] = items[id] + count
		end
	end

	for id, count in pairs(items) do
		local itemData = ItemUtil.createItemData({
			itemId = tonumber(id),
			count = count
		})
		local itemGo = goutil.clone(self._itemTemplate)

		goutil.setActive(itemGo, true)
		goutil.addChildToParent(itemGo, self._scrollContentGo)

		local itemView = Astral.LuaComponentContainer.Add(itemGo, ItemCell)

		itemView:updateData(itemData)
		itemView:setShowSelectedEffect(false)
		itemView:setIsHideGetWay(true)
	end
end

function M:_onClickAdd()
	local maxSelectNum = BackpackDecomposeModel.instance:getMaxSelectNum(isFurniture)
	local dataList = ItemModel.instance:getShowTypeDataList(self._showType)
	local moList = dataList:getMoList()

	if self._showType == CommEnum.MainBackpackShowType.EchoShowType then
		moList = TableUtil.reverseTable(moList)

		GlobalDispatcher:dispatchEvent(EventType.BACKPACK_ECHO_AUTO_SELECT_EVENT)
	end

	for _, mo in ipairs(moList) do
		if not BackpackDecomposeModel.instance:getIsContainer(mo) and maxSelectNum > BackpackDecomposeModel.instance:getItemDataTableCount() then
			BackpackDecomposeModel.instance:addItemData(mo)
		end
	end

	local items = BackpackDecomposeModel.instance:getItemDataTable()

	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_MUL_SELECT_EVENT, items)
end

function M:_onClickResolve()
	if BackpackDecomposeModel.instance:getItemDataTableCount() == 0 then
		FloatWordMgr.instance:show(lang("tip_select_resolve_equip"))

		return
	end

	local itemDataTable = BackpackDecomposeModel.instance:getItemDataTable()
	local temp = {}
	local uuids = {}

	for _, itemData in ipairs(itemDataTable) do
		if itemData:getQuality() == CommEnum.QualityFilterType.S or itemData:getLevel() > 1 then
			table.insert(temp, itemData)
		end

		table.insert(uuids, itemData:getUuid())
	end

	local callback

	if self._showType == CommEnum.MainBackpackShowType.EchoShowType then
		function callback()
			EchoItemAgent.instance:sendDecomposeEchoItemRequest(uuids)
		end
	else
		function callback()
			EquipmentAgent.instance:sendEquipDecomposeRequest(uuids)
		end
	end

	if #temp > 0 then
		local params = {
			moList = temp,
			confirmCallback = callback
		}

		ViewMgr.instance:open(ViewName.ResolveItemTips, params)
	else
		callback()
	end
end

return M
