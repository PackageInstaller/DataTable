-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echoitem/controller/EchoItemController.lua

module("logic.extensions.echoitem.controller.EchoItemController", package.seeall)

local M = class("EchoItemController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self._tempData = BaseListModel.New()

	self:onReset()
end

function M:onReset()
	self._tempData:clear()

	self._filterType = CommEnum.QualityFilterType.All
end

local function _setHeroEchoItem(heroId, echoItemData)
	if not heroId or heroId == 0 then
		return
	end

	local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if not heroData then
		printError("背包中不存在该卡牌　heroId = " .. tostring(heroId))

		return
	end

	local heroEchoItemData = heroData:getHeroEchoItemData()

	heroEchoItemData:setEchoItem(echoItemData)
end

function M:refreshEchoItems(items)
	for i, item in ipairs(items) do
		local uuid = item.uuid
		local level = item.level
		local heroId = item.hero
		local echoItemData = ItemModel.instance:getItemDataByUuid(uuid)

		if not echoItemData then
			printError("背包中不存在该回响物 uuid = " .. tostring(uuid))

			return
		end

		_setHeroEchoItem(echoItemData:getHeroId(), nil)
		echoItemData:setLevel(level)
		echoItemData:setHeroId(heroId)
		_setHeroEchoItem(heroId, echoItemData)
	end

	local isUpgrade = false

	GlobalDispatcher:dispatchEvent(EventType.ECHO_ITEM_INFO_REFRESH, isUpgrade)
end

function M:setFilterType(filterType)
	self._filterType = filterType

	self:_applyFilter()
	GlobalDispatcher:dispatchEvent(EventType.ECHO_ITEM_FILTER_CHANGE)
end

function M:getFilterType()
	return self._filterType
end

function M:_applyFilter()
	self._tempData:clear()

	local echoItemMoList = ItemModel.instance:getItemsByType(GameEnum.ItemTypeEnum.EchoItemType)

	for i, echoItemMo in ipairs(echoItemMoList) do
		if (self._filterType == CommEnum.QualityFilterType.All or echoItemMo:getQuality() == self._filterType) and (self:getCurHeroCareer() == echoItemMo:getCareer() or echoItemMo:getCareer() == 0) then
			self._tempData:addMo(echoItemMo)
		end
	end
end

function M:getFilterEchoItemData()
	self:_applyFilter()
	self._tempData:sortMoList(ItemUtil.commonSortFunc)

	return self._tempData
end

function M:getDefaultEchoItemData()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false
	local moList = self._tempData:getMoList()

	for _, echoItemMo in ipairs(moList) do
		if echoItemMo:getHeroId() == heroData:getId() then
			return echoItemMo
		end
	end

	return self._tempData:getMoByIndex(1)
end

function M:getCurHeroEchoItem()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	if heroData then
		local heroEchoItemData = heroData:getHeroEchoItemData()

		return heroEchoItemData:getEchoItem()
	end
end

function M:getCurHeroCareer()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	if heroData then
		return heroData:getCareer()
	end
end

function M:hasEchoCanEquip(includeInOtherCard)
	local canEquip = false
	local _filterType = CommEnum.QualityFilterType.All
	local echoItemMoList = ItemModel.instance:getItemsByType(GameEnum.ItemTypeEnum.EchoItemType)
	local _tempMoLst = {}

	for i, echoItemMo in ipairs(echoItemMoList) do
		if (_filterType == CommEnum.QualityFilterType.All or echoItemMo:getQuality() == _filterType) and (self:getCurHeroCareer() == echoItemMo:getCareer() or echoItemMo:getCareer() == 0) then
			table.insert(_tempMoLst, echoItemMo)
		end
	end

	if includeInOtherCard then
		canEquip = #_tempMoLst > 0
	else
		for _, echoData in pairs(_tempMoLst) do
			if echoData:getHeroId() == 0 then
				canEquip = true
			end
		end
	end

	return canEquip
end

function M:checkRedPoint()
	local isActive = false
	local echoItem = self:getCurHeroEchoItem()

	isActive = (not echoItem or false) and self:hasEchoCanEquip(false)

	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleCarryEcho, false) then
		isActive = false
	end

	printWarn("==checkRedPoint=isActive=", isActive)
	GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
		key = RedDotType.ERedDotKey.ECHO,
		isActive = isActive
	})
end

M.instance = M.New()

return M
