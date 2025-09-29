-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/view/RoomBackPackFurnitureFilterView.lua

module("logic.extensions.housebackpack.view.RoomBackPackFurnitureFilterView", package.seeall)

local M = class("RoomBackPackFurnitureFilterView", ViewComponent)
local PageType = {
	Furniture = 1,
	Suit = 2
}
local HouseSubTypeList = {
	HouseEnum.FurnitureRealSubType.BigItem,
	HouseEnum.FurnitureRealSubType.SmallItem,
	HouseEnum.FurnitureRealSubType.Wall,
	HouseEnum.FurnitureRealSubType.Ceil,
	HouseEnum.FurnitureRealSubType.Ground
}

function M:ctor()
	self._furnitureData = {}
	self._furnitureFilterData = {}
	self._suitData = {}
	self._suitFilterData = {}
	self._curPage = PageType.Furniture
	self._furniturePageInited = false
	self._suitPageInited = false
end

function M:buildUI()
	self._btnClose = self:getBtn("0&middle_tips_common_bg_-1205189576")
	self._btnSave = self:getBtn("furniture_filter_tips_-1113225770")
	self._btnReset = self:getBtn("furniture_filter_tips_1052914948")
	self._toggleFurniture = self:getUIComponent("furniture_filter_tips_-1286930197", UIComponentType.SpaceXToggle)
	self._toggleSuit = self:getUIComponent("furniture_filter_tips_-1307751325", UIComponentType.SpaceXToggle)
	self._goFurniturePage = self:getGo("furniture_filter_tips_1844974006")
	self._goSuitPage = self:getGo("furniture_filter_tips_-1725465883")
	self._goFurnitureFilterModel = self:getGo("furniture_filter_tips_-1184527885")
	self._goSuitFilterAll = self:getGo("1&suit_filter_tab_414610683")

	goutil.setActive(self._goFurnitureFilterModel, false)
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSave:AddClickListener(self._onClickSave, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._toggleFurniture:AddListener(self._furnitureToggleChange, self)
	self._toggleSuit:AddListener(self._suitToggleChange, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnSave:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._toggleFurniture:RemoveListener()
	self._toggleSuit:RemoveListener()
end

function M:onEnter()
	local furnitureFilterData = RoomBackpackModel.instance:getFurnitureSubTypeFilterList()

	self._furnitureFilterData = {}

	table.insertto(self._furnitureFilterData, furnitureFilterData)

	local suitFilterData = RoomBackpackModel.instance:getFurnitureSuitFilterList()

	self._suitFilterData = {}

	table.insertto(self._suitFilterData, suitFilterData)
	self:_initPage()
	self:_refreshPage()
end

function M:onExit()
	return
end

function M:destroyUI()
	if self._furnitureData.filterAll then
		self._furnitureData.filterAll.itemBtn:RemoveClickListener()
	end

	if self._furnitureData.filterItems then
		for _, itemData in pairs(self._furnitureData.filterItems) do
			itemData.itemBtn:RemoveClickListener()
		end
	end

	if self._suitData.filterAll then
		self._suitData.filterAll.itemBtn:RemoveClickListener()
	end

	if self._suitData.filterItems then
		for _, itemData in pairs(self._suitData.filterItems) do
			itemData.itemBtn:RemoveClickListener()
		end
	end

	self._furnitureData = nil
	self._furnitureFilterData = nil
	self._suitData = nil
	self._suitFilterData = nil
	self._furniturePageInited = false
	self._suitPageInited = false
end

function M:_initPage()
	if self._curPage == PageType.Furniture and not self._furniturePageInited then
		self._furniturePageInited = true

		self:_initFurniturePage()
	elseif self._curPage == PageType.Suit and not self._suitPageInited then
		self._suitPageInited = true

		self:_initSuitPage()
	end
end

function M:_refreshPage()
	local isFurniturePage = self._curPage == PageType.Furniture

	goutil.setActive(self._goFurniturePage, isFurniturePage)
	goutil.setActive(self._goSuitPage, not isFurniturePage)

	if isFurniturePage then
		self:_refreshFurniturePage()
	else
		self:_refreshSuitPage()
	end
end

function M:_refreshFurniturePage()
	local isFilterAll = table.nums(self._furnitureFilterData) == 0

	goutil.setActive(self._furnitureData.filterAll.normalGo, not isFilterAll)
	goutil.setActive(self._furnitureData.filterAll.selectGo, isFilterAll)

	for subType, itemData in pairs(self._furnitureData.filterItems) do
		local isSelected = table.indexof(self._furnitureFilterData, subType)

		isSelected = checkbool(isSelected)

		goutil.setActive(itemData.normalGo, not isSelected)
		goutil.setActive(itemData.selectGo, isSelected)
	end
end

function M:_initFurniturePage()
	self:_initFurnitureFilterAll()
	self:_initFurnitureFilterType()
end

function M:_initFurnitureFilterAll()
	local filterContentGo = self:_createFurnitureFilterTypeItem(langF("tip_common_all"))
	local itemData = self:_createFurnitureFilterItem(filterContentGo, langF("tip_common_all"), 0, 0, function()
		self:_onClickFurnitureFilterAll()
	end)

	self._furnitureData.filterAll = itemData
end

function M:_initFurnitureFilterType()
	self._furnitureData.filterItems = self._furnitureData.filterItems or {}

	for _, firstType in pairs(HouseSubTypeList) do
		local filterContentGo = self:_createFurnitureFilterTypeItem(HouseEnum.FurnitureSubType2Name[firstType])

		for _, secondType in pairs(HouseEnum.FurnitureSecondType2Enum[firstType]) do
			local secondName = HouseEnum.FurnitureSecondType2Name[firstType][secondType]
			local itemData = self:_createFurnitureFilterItem(filterContentGo, secondName, firstType, secondType, function()
				self:_onClickFurnitureFilterItem(firstType, secondType)
			end)
			local subType = LivingFacilitiesFurnitureController.instance:getFurnitureSubType(firstType, secondType)

			self._furnitureData.filterItems[subType] = itemData
		end
	end
end

function M:_createFurnitureFilterTypeItem(name)
	local filterGo = goutil.clone(self._goFurnitureFilterModel)

	goutil.setActive(filterGo, true)
	goutil.addChildToParent(filterGo, self._goFurnitureFilterModel.transform.parent)

	local filterNameTxt = goutil.findChildTextComponent(filterGo, "sign/Text")
	local filterContentGo = goutil.findChild(filterGo, "allList")

	filterNameTxt.text = name

	return filterContentGo
end

function M:_createFurnitureFilterItem(parent, name, firstIndex, secondIndex, clickFunc)
	local itemGo = self:getResInstance(ResName.Common_team_filter_tab)

	goutil.addChildToParent(itemGo, parent)

	local normalGo = goutil.findChild(itemGo, "normal")
	local selectGo = goutil.findChild(itemGo, "select")
	local normalText = goutil.findChildTextComponent(normalGo, "Text")
	local selectText = goutil.findChildTextComponent(selectGo, "Text")
	local toggle = itemGo:GetComponent(UIComponentType.SpaceXToggle)
	local itemBtn = UIComponentType.ButtonAdapter(itemGo)

	itemBtn:AddClickListener(clickFunc, nil)

	toggle.enabled = false
	normalText.text = name
	selectText.text = name

	local itemData = {
		itemBtn = itemBtn,
		normalGo = normalGo,
		selectGo = selectGo,
		firstIndex = firstIndex,
		secondIndex = secondIndex
	}

	return itemData
end

function M:_onClickFurnitureFilterAll()
	table.clear(self._furnitureFilterData)
	self:_refreshFurniturePage()
end

function M:_onClickFurnitureFilterItem(firstType, secondType)
	local subType = LivingFacilitiesFurnitureController.instance:getFurnitureSubType(firstType, secondType)
	local i = table.indexof(self._furnitureFilterData, subType)

	if i then
		table.remove(self._furnitureFilterData, i)
	else
		table.insert(self._furnitureFilterData, subType)
	end

	if table.nums(self._furnitureData.filterItems) == #self._furnitureFilterData then
		table.clear(self._furnitureFilterData)
	end

	self:_refreshFurniturePage()
end

function M:_initSuitPage()
	self:_initSuitFilterAll()
	self:_initSuitFilterType()
end

function M:_initSuitFilterAll()
	local registry = ViewElementsRegistry.New(self._goSuitFilterAll)
	local normalGo = registry:findUIElement("suit_filter_tab_1328224882")
	local selectGo = registry:findUIElement("suit_filter_tab_-1013954580")
	local itemBtn = UIComponentType.ButtonAdapter(self._goSuitFilterAll)

	itemBtn:AddClickListener(self._onClickSuitFilterAll, self)

	local itemData = {
		itemBtn = itemBtn,
		normalGo = normalGo,
		selectGo = selectGo
	}

	self._suitData.filterAll = itemData
end

function M:_initSuitFilterType()
	local allThemeList = LivingFacilitiesFurniThemeModel.instance:getAllTheme()
	local themeList = {}

	table.insertto(themeList, allThemeList)
	table.remove(themeList, 1)

	self._suitData.filterItems = {}

	for _, themeMo in pairs(themeList) do
		local themeId = themeMo:getId()
		local itemData = self:_createSuitFilterItem(themeMo:getName(), function()
			self:_onClickSuitItem(themeId)
		end)

		self._suitData.filterItems[themeId] = itemData
	end
end

function M:_createSuitFilterItem(name, clickFunc)
	local itemGo = self:getResInstance(ResName.Room_suit_filter_tab)

	goutil.addChildToParent(itemGo, self._goSuitFilterAll.transform.parent)

	local registry = ViewElementsRegistry.New(itemGo)
	local normalGo = registry:findUIElement("suit_filter_tab_1328224882")
	local selectGo = registry:findUIElement("suit_filter_tab_-1013954580")
	local textNormal = registry:findUIElement("suit_filter_tab_-1228480378", UIComponentType.Text)
	local textSelect = registry:findUIElement("suit_filter_tab_-1257121630", UIComponentType.Text)

	textNormal.text = name
	textSelect.text = name

	local itemBtn = UIComponentType.ButtonAdapter(itemGo)

	itemBtn:AddClickListener(clickFunc, nil)

	local itemData = {
		itemBtn = itemBtn,
		normalGo = normalGo,
		selectGo = selectGo
	}

	return itemData
end

function M:_onClickSuitFilterAll()
	table.clear(self._suitFilterData)
	self:_refreshSuitPage()
end

function M:_onClickSuitItem(themeId)
	local i = table.indexof(self._suitFilterData, themeId)

	if i then
		table.remove(self._suitFilterData, i)
	else
		table.insert(self._suitFilterData, themeId)
	end

	if table.nums(self._suitData.filterItems) == #self._suitFilterData then
		table.clear(self._suitFilterData)
	end

	self:_refreshSuitPage()
end

function M:_refreshSuitPage()
	local isFilterAll = table.nums(self._suitFilterData) == 0

	goutil.setActive(self._suitData.filterAll.normalGo, not isFilterAll)
	goutil.setActive(self._suitData.filterAll.selectGo, isFilterAll)

	for themeId, itemData in pairs(self._suitData.filterItems) do
		local isSelected = table.indexof(self._suitFilterData, themeId)

		isSelected = checkbool(isSelected)

		goutil.setActive(itemData.normalGo, not isSelected)
		goutil.setActive(itemData.selectGo, isSelected)
	end
end

function M:_furnitureToggleChange(_, isOn)
	if isOn then
		self._curPage = PageType.Furniture

		self:_initPage()
		self:_refreshPage()
	end
end

function M:_suitToggleChange(_, isOn)
	if isOn then
		self._curPage = PageType.Suit

		self:_initPage()
		self:_refreshPage()
	end
end

function M:_onClickClose()
	self:close()
end

function M:_onClickSave()
	if self._curPage == PageType.Furniture then
		GlobalDispatcher:dispatchEvent(EventType.ROOM_BACKPACK_FURNITURE_SUBTYPE_FILTER, self._furnitureFilterData)
	else
		GlobalDispatcher:dispatchEvent(EventType.ROOM_BACKPACK_FURNITURE_SUIT_FILTER, self._suitFilterData)
	end

	self:close()
end

function M:_onClickReset()
	if self._curPage == PageType.Furniture then
		table.clear(self._furnitureFilterData)
	else
		table.clear(self._suitFilterData)
	end

	self:_refreshPage()
end

return M
