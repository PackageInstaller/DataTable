-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/view/RoomBackpackType1View.lua

module("logic.extensions.housebackpack.view.RoomBackpackType1View", package.seeall)

local M = class("RoomBackpackType1View", ViewComponent)
local BackpackShowType = CommEnum.RoomBackpackShowType

function M:ctor()
	self._sortAscending = false
	self._sortType = CommEnum.RoomBackPackSortType.None
end

function M:buildUI()
	self._type1Go = self:getGo("furniture_backpack_view_-722996039")
	self._btnFilter = self:getBtn("furniture_backpack_view_-19482657")
	self._normalGo = goutil.findChild(self._btnFilter.gameObject, "normal")
	self._selectGo = goutil.findChild(self._btnFilter.gameObject, "select")
	self._txtNormal = goutil.findChildTextComponent(self._btnFilter.gameObject, "normal/Label")
	self._txtSelect = goutil.findChildTextComponent(self._btnFilter.gameObject, "select/Label")
	self._btnAtmosphere = self:getBtn("furniture_backpack_view_1549375773")
	self._btnFilter2 = self:getBtn("furniture_backpack_view_-964304893")
	self._btnRecycle = self:getBtn("furniture_backpack_view_-1894432921")
	self._btnAdd = self:getBtn("furniture_backpack_view_-974006979")
	self._txtCapacity = self:getText("furniture_backpack_view_-1751215023")

	local downGo = self:getGo("furniture_backpack_view_1526962178")

	self._decomposeView = Astral.LuaComponentContainer.Add(downGo, RoomBackpackDecomposeView)

	self._decomposeView:setRegistry(self._viewPresentor._viewElementsRegistry)
	self._decomposeView:buildUI()

	local panelFilterGo = self:getGo("furniture_backpack_view_1211329829")

	self._filterPanelView = Astral.LuaComponentContainer.Add(panelFilterGo, RoomBackpackFilterPanelView)
end

function M:bindEvents()
	self._btnFilter:AddClickListener(self._onClickFilter, self)
	self._btnAtmosphere:AddClickListener(self._onClickAtmosphere, self)
	self._btnFilter2:AddClickListener(self._onClickFilter2, self)
	self._btnRecycle:AddClickListener(self._onClickRecycleBtn, self)
	self._btnAdd:AddClickListener(self._onClickAddBtn, self)
	GlobalDispatcher:addEventListener(EventType.ROOM_BACKPACK_TO_SWITCH_SHOW_TYPE, self._dealSwitchShowType, self)
	GlobalDispatcher:addEventListener(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED, self._refreshForCurShowType, self)
	HouseDispatcher:addEventListener(HouseEventType.HOUSE_GOODS_STORE_CHANGE, self._refreshForCurShowType, self)
end

function M:unbindEvents()
	self._btnFilter:RemoveClickListener()
	self._btnAtmosphere:RemoveClickListener()
	self._btnFilter2:RemoveClickListener()
	self._btnRecycle:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.ROOM_BACKPACK_TO_SWITCH_SHOW_TYPE, self._dealSwitchShowType, self)
	GlobalDispatcher:removeEventListener(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED, self._refreshForCurShowType, self)
	HouseDispatcher:removeEventListener(HouseEventType.HOUSE_GOODS_STORE_CHANGE, self._refreshForCurShowType, self)
end

function M:onEnter()
	self._decomposeView:onEnter()
end

function M:onExit()
	self._decomposeView:onExit()
	RoomBackpackModel.instance:resetFurnitureSubTypeFilterList()
	RoomBackpackModel.instance:resetFurnitureSuitFilterList()
end

function M:_onClickFilter()
	self._filterPanelView:setVisible(not self._filterPanelView:getVisible())
end

function M:_onClickAtmosphere()
	self._sortAscending = not self._sortAscending
	self._sortType = CommEnum.RoomBackPackSortType.Atmosphere

	self:_updateSortBtns()
	GlobalDispatcher:dispatchEvent(EventType.ROOM_BACKPACK_SORT_TYPE, self._sortType, self._sortAscending)
end

function M:_onClickFilter2()
	ViewMgr.instance:open(ViewName.RoomBackPackFurnitureFilterView, param)
end

function M:_dealSwitchShowType(e, showType)
	local sortData = RoomBackpackModel.instance:getSortData(showType)

	if sortData.ascending == nil then
		-- block empty
	end

	self._sortAscending = sortData.ascending
	self._sortType = sortData.sortType

	local isShow = showType == BackpackShowType.FurnitureShowType or showType == BackpackShowType.DrawingShowType or showType == BackpackShowType.TradeMaterialShowType

	self._type1Go:SetActive(isShow)
	self._btnAtmosphere.gameObject:SetActive(showType == BackpackShowType.FurnitureShowType)
	self._btnFilter2.gameObject:SetActive(showType == BackpackShowType.FurnitureShowType)
	self:_updateSortBtns()

	if not isShow then
		return
	end

	self._filterPanelView:setShowType(showType)

	isShow = showType == BackpackShowType.FurnitureShowType

	self._decomposeView:setEnabled(false)
	self._btnRecycle.gameObject:SetActive(isShow)

	isShow = showType == BackpackShowType.TradeMaterialShowType

	self._btnAdd.gameObject:SetActive(isShow and RoomBackpackModel.instance:getCanAddGoodsStore())
end

function M:_refreshForCurShowType()
	local showType = RoomBackpackModel.instance:getCurShowType()

	if showType ~= BackpackShowType.FurnitureShowType and showType ~= BackpackShowType.DrawingShowType and showType ~= BackpackShowType.TradeMaterialShowType then
		return
	end

	self:_updateFilterText(showType)
	self:_updateSortBtns()
	self:_updateFilterBtn(showType)
	self._decomposeView:setEnabled(RoomBackpackModel.instance:isInRecycling())

	local dataList = RoomBackpackModel.instance:getCurShownItems()
	local itemMoList = RoomBackpackModel.instance:getCurShowTypeAllItems()
	local count = 0

	for _, mo in ipairs(itemMoList) do
		local isOnline = true

		if mo.getIsOnline then
			isOnline = mo:getIsOnline()
		end

		if isOnline then
			count = count + mo:getCount()
		end
	end

	if showType == BackpackShowType.FurnitureShowType then
		self._txtCapacity.text = string.format(lang("tip_room_furniture_capacity"), count)
	elseif showType == BackpackShowType.DrawingShowType then
		self._txtCapacity.text = string.format(lang("tip_room_draw_capacity"), count, #dataList)
	elseif showType == BackpackShowType.TradeMaterialShowType then
		local capacity = RoomBackpackModel.instance:getGoodsStore()

		self._txtCapacity.text = string.format(lang("tip_room_material_capacity"), count, capacity)

		self._btnAdd.gameObject:SetActive(RoomBackpackModel.instance:getCanAddGoodsStore())
	end
end

function M:_onClickRecycleBtn()
	GlobalDispatcher:dispatchEvent(EventType.ROOM_BACKPACK_ENTER_RECYCLE)
end

function M:_onClickAddBtn()
	local function confirmCallback()
		LivingFacilitiesAgent.instance:sendAddGoodsStoreRequest()
	end

	local houseGoodsBagExtendNum = HouseConfig.instance:getHouseConst("HouseGoodsBagExtendNum").numValues
	local curNum = RoomBackpackModel.instance:getGoodsStore()
	local index = table.indexof(houseGoodsBagExtendNum, curNum)
	local nextNum = houseGoodsBagExtendNum[index + 1]
	local cost = RoomBackpackModel.instance:getAddGoodsStoreCost()

	if not cost then
		if enableLog then
			printError(string.format("无法找到cost,curNum[%s] nextNum[%s]", curNum, nextNum))
		end

		return
	end

	local itemCO = BackpackConfig.instance:getItemInfoByItemId(cost.code)
	local content = langF("tip_cost_up_max", cost.count, itemCO.name, nextNum)
	local dialog = Dialog.showMessage(lang("tip_title"), content)

	dialog:setConfirmListener(confirmCallback, self)
end

function M:_onFilterBack()
	return
end

function M:_updateFilterText(showType)
	local filterCfg = RoomBackpackModel.instance:getFilterCfg(showType)
	local filterType = filterCfg:getFilterType()
	local name = ""
	local isNormal = false

	if showType == BackpackShowType.FurnitureShowType then
		name = CommEnum.FurnitureFilterType2Name[filterType]
		isNormal = filterType == CommEnum.RoomFurnitureFilterType.All
	end

	if showType == BackpackShowType.DrawingShowType then
		name = CommEnum.DrawingFilterType2Name[filterType]
		isNormal = filterType == CommEnum.RoomDrawingFilterType.All
	end

	if showType == BackpackShowType.TradeMaterialShowType then
		name = CommEnum.TradeMaterialFilterType2Name[filterType]
		isNormal = filterType == CommEnum.RoomTradeMaterialFilterType.All
	end

	self._txtNormal.text = name
	self._txtSelect.text = name

	self._normalGo:SetActive(isNormal)
	self._selectGo:SetActive(not isNormal)
end

function M:_updateFilterBtn(showType)
	local isFilting = false

	if showType == BackpackShowType.FurnitureShowType then
		local furnitureSubTypeFilter = RoomBackpackModel.instance:getFurnitureSubTypeFilterList()
		local furnitureSuitFilter = RoomBackpackModel.instance:getFurnitureSuitFilterList()

		isFilting = #furnitureSubTypeFilter > 0 or #furnitureSuitFilter > 0
	end

	local normal = goutil.findChild(self._btnFilter2, "normal")
	local select = goutil.findChild(self._btnFilter2, "select")

	goutil.setActive(normal, not isFilting)
	goutil.setActive(select, isFilting)
end

function M:_updateSortBtns()
	self:_updateAsmosphereBtn()
end

function M:_updateAsmosphereBtn()
	local isAsmospereSelected = self._sortType == CommEnum.RoomBackPackSortType.Atmosphere
	local btnGo = self._btnAtmosphere.gameObject
	local selectedGO = goutil.findChild(btnGo, "select")
	local normalGO = goutil.findChild(btnGo, "normal")
	local upGO = goutil.findChild(btnGo, "select/imgUp")
	local downGO = goutil.findChild(btnGo, "select/imgDown")

	goutil.setActive(selectedGO, isAsmospereSelected)
	goutil.setActive(normalGO, not isAsmospereSelected)
	goutil.setActive(upGO, self._sortAscending == true)
	goutil.setActive(downGO, self._sortAscending == false)
end

return M
