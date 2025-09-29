-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/model/EquipSuitModel.lua

module("logic.extensions.equipment.model.EquipSuitModel", package.seeall)

local M = class("EquipSuitModel", BaseModel)

function M:ctor()
	self._suitDataList = nil
	self._suitDataMap = nil
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._suitDataList = BaseListModel.New()

	self:initSuitCoList()
end

function M:getSuitData()
	return self._suitDataList
end

function M:initSuitCoList()
	self._suitDataList:clear()

	self._suitDataMap = {}

	local totalSuitData = EquipSuitData.New({
		name = "tip_all_equip_suit",
		isOwner = true,
		id = CommEnum.CommonAll
	})

	self._suitDataList:addMo(totalSuitData)

	self._suitDataMap[CommEnum.CommonAll] = totalSuitData

	local equipSuitList = EquipmentConfig.instance:getConfigList(ConfigName.EquipmentSuit)

	for i, equipSuitCo in ipairs(equipSuitList) do
		local suitData = EquipSuitData.New(equipSuitCo)

		self._suitDataList:addMo(suitData)

		self._suitDataMap[suitData.id] = suitData
	end

	table.sort(self._suitDataList, function(item1, item2)
		return item1:getId() < item2:getId()
	end)
end

function M:getSuitDataById(suitId)
	return self._suitDataMap[suitId]
end

function M:getAllSuitMap()
	return self._suitDataMap
end

function M:updateSuitNum()
	local suitDataMoList = self._suitDataList:getMoList()

	for i, suitDataMo in ipairs(suitDataMoList) do
		suitDataMo:clearTotalNum()
	end

	local totalSuitData = self:getSuitDataById(CommEnum.CommonAll)
	local equipDataMoList = ItemModel.instance:getItemsByType(GameEnum.ItemTypeEnum.EquipItemType)

	for i, equipMo in ipairs(equipDataMoList) do
		local part = equipMo:getPart()

		totalSuitData:addPartNum(part)

		local suitId = equipMo:getSuitId()
		local suitData = self:getSuitDataById(suitId)

		if suitData then
			suitData:addPartNum(part)
		end
	end
end

function M:getSuitOwnList()
	local allSuit = self._suitDataMap
	local allEquips = ItemModel.instance:getItemsByType(GameEnum.ItemTypeEnum.EquipItemType)
	local flag = {}
	local res = {
		allSuit[CommEnum.CommonAll]
	}

	for i, equipMo in ipairs(allEquips) do
		local suitId = equipMo:getSuitId()

		if not flag[suitId] and allSuit[suitId] then
			table.insert(res, allSuit[suitId])

			flag[suitId] = true
		end
	end

	return res
end

function M:getAllSuitListWithOwnTag()
	local allSuit = self._suitDataList:getMoList()
	local allEquips = ItemModel.instance:getItemsByType(GameEnum.ItemTypeEnum.EquipItemType)
	local flag = {}

	for i, equipMo in ipairs(allEquips) do
		local suitId = equipMo:getSuitId()

		flag[suitId] = true
	end

	for k, v in pairs(allSuit) do
		local id = v:getId()

		if id == CommEnum.CommonAll then
			v:setIsOwner(true)
		else
			v:setIsOwner(flag[id] or false)
		end
	end

	return allSuit
end

M.instance = M.New()

return M
