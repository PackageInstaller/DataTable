-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/AirWorkShopDefSceneModel.lua

module("logic.extensions.airworkshop.flow.defflow.AirWorkShopDefSceneModel", package.seeall)

local M = class("AirWorkShopDefSceneModel", BaseModel)
local kPreviewKey = "air_workshop_preview"

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._isDragging = false
	self._isEnableAdjustment = false
	self._isShowUnitUI = true
	self._tabType = false
	self._enterLevelId = false
	self._enterBattleType = false
	self._currentTeamCharacterCodeList = {}
	self._availableHeroMOList = {}
	self._availableBuildingCOList = {}
	self._availableHighlandCOList = {}
	self._availableMessageCOList = {}
	self._tabType2UnitCount = {}
	self._tabType2UnitLimit = {}
	self._unitType2UnitLimit = {}
	self._previewSelectList = {}
	self._curState = AirWorkShopEnum.DefState.Edit
	self._saveIndex = false
	self._bakeMapMO = false
end

function M:clear()
	self._isMainViewOpen = false
	self._isDragging = false
	self._isEnableAdjustment = false
	self._isShowUnitUI = true
	self._tabType = false
	self._enterLevelId = false
	self._enterBattleType = false
	self._curState = AirWorkShopEnum.DefState.Edit
	self._bakeMapMO = false

	BattleTableUtil.clearTable(self._currentTeamCharacterCodeList)
	BattleTableUtil.clearTable(self._availableHeroMOList)
	BattleTableUtil.clearTable(self._availableBuildingCOList)
	BattleTableUtil.clearTable(self._availableHighlandCOList)
	BattleTableUtil.clearTable(self._availableMessageCOList)
	BattleTableUtil.clearTable(self._tabType2UnitCount)
	BattleTableUtil.clearTable(self._tabType2UnitLimit)
	BattleTableUtil.clearTable(self._unitType2UnitLimit)
end

function M:onEnterScene()
	self:_buildAvailableHeroMOList()
	self:_buildAvailableBuildingMOList()
	self:_buildAvailableHighlandMOList()
	self:_buildAvailableMessageMOList()
	self:_initUnitLimit()
end

function M:onExitScene()
	self:clear()
end

function M:_buildAvailableHeroMOList()
	table.insertto(self._availableHeroMOList, HeroDepotModel.instance:getHeroDepotData():getHeroDataList())
end

function M:_buildAvailableBuildingMOList()
	local buildCOList = AirWorkShopConfig.instance:getAllBuildingCO()

	for i, buildCO in pairs(buildCOList) do
		if buildCO.type == 2 and AirWorkShopModel.instance:getIsSceneOrBuildingUnlockById(GameEnum.UnlockTypeEnum.Building, buildCO.id) then
			table.insert(self._availableBuildingCOList, buildCO)
		end
	end
end

function M:_buildAvailableHighlandMOList()
	local buildCOList = AirWorkShopConfig.instance:getAllBuildingCO()

	for i, buildCO in pairs(buildCOList) do
		if buildCO.type == 1 and AirWorkShopModel.instance:getIsSceneOrBuildingUnlockById(GameEnum.UnlockTypeEnum.Building, buildCO.id) then
			table.insert(self._availableHighlandCOList, buildCO)
		end
	end
end

function M:_buildAvailableMessageMOList()
	local buildCOList = AirWorkShopConfig.instance:getAllBuildingCO()

	for i, buildCO in pairs(buildCOList) do
		if buildCO.type == 3 and AirWorkShopModel.instance:getIsSceneOrBuildingUnlockById(GameEnum.UnlockTypeEnum.Building, buildCO.id) then
			table.insert(self._availableMessageCOList, buildCO)
		end
	end
end

function M:setDragging(isDragging)
	self._isDragging = isDragging
end

function M:isDragging()
	return self._isDragging
end

function M:setEnableAdjustment(enable)
	self._isEnableAdjustment = enable
end

function M:isEnableAdjustment()
	return self._isEnableAdjustment
end

function M:setShowUnitUI(show)
	self._isShowUnitUI = show
end

function M:isShowUnitUI()
	return self._isShowUnitUI
end

function M:isValidBornUnionIndex(unionIndex)
	return true
end

function M:getCurrentTeamCharacterCodeList()
	return self._currentTeamCharacterCodeList
end

function M:getAvailableHeroMOList()
	return self._availableHeroMOList
end

function M:getAvailableBuildingCOList()
	return self._availableBuildingCOList
end

function M:getAvailableHighlandCOList()
	return self._availableHighlandCOList
end

function M:getAvailableMessageCOList()
	return self._availableMessageCOList
end

function M:setCharacterInTeam(characterCode)
	local currentTeamCharacterCodeList = self:getCurrentTeamCharacterCodeList()

	table.insert(currentTeamCharacterCodeList, characterCode)

	local availableHeroMOList = self:getAvailableHeroMOList()

	for index, heroMO in ipairs(availableHeroMOList) do
		if characterCode == heroMO:getId() then
			table.remove(availableHeroMOList, index)

			return index
		end
	end

	return false
end

function M:setCharacterOutTeam(characterCode, indexInList)
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(characterCode)
	local availableHeroMOList = self:getAvailableHeroMOList()

	if not self:_isInHeroList(characterCode, availableHeroMOList) then
		if indexInList and indexInList <= #availableHeroMOList then
			table.insert(availableHeroMOList, indexInList, heroMO)
		else
			table.insert(availableHeroMOList, heroMO)
		end
	end

	local currentTeamCharacterCodeList = self:getCurrentTeamCharacterCodeList()

	table.removebyvalue(currentTeamCharacterCodeList, characterCode)
end

function M:_isInHeroList(characterCode, availableHeroMOList)
	for i, v in ipairs(availableHeroMOList) do
		if v:getId() == characterCode then
			return true
		end
	end

	return false
end

function M:setCurTabType(tab)
	self._tabType = tab

	AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.ON_EDIT_TAB_UPDATE)
end

function M:setCurState(state)
	self._curState = state
end

function M:getCurState()
	return self._curState
end

function M:setCoverHighlandIdAndCreate(id)
	self._coverHighlandId = id
end

function M:getCoverHighlandId()
	return self._coverHighlandId
end

function M:getCurTabType()
	return self._tabType
end

function M:_initUnitLimit()
	local model = AirWorkShopDefMgr.instance:getModel()
	local levelCO = model:getLevelCO()

	self._tabType2UnitLimit[AirWorkShopEnum.TabEnum.Hero] = levelCO.entityLimit
	self._tabType2UnitLimit[AirWorkShopEnum.TabEnum.Highland] = levelCO.highBuildingLimit
	self._tabType2UnitLimit[AirWorkShopEnum.TabEnum.Building] = levelCO.effectBuildingLimit
	self._tabType2UnitLimit[AirWorkShopEnum.TabEnum.Message] = levelCO.messageBuildingLimit
	self._unitType2UnitLimit[AirWorkShopEnum.UnitType.Ambush] = levelCO.ambushEntityLimit
end

function M:refreshUnitCount()
	local unitCount = 0
	local highlandCount = 0
	local buildingCount = 0
	local messageCount = 0
	local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr()
	local allUnit = unitMgr:getAllUnit()

	for k, unit in pairs(allUnit) do
		local tabType = unit.property:getTabType()

		if tabType == AirWorkShopEnum.TabEnum.Hero then
			unitCount = unitCount + 1
		elseif tabType == AirWorkShopEnum.TabEnum.Highland then
			highlandCount = highlandCount + 1
		elseif tabType == AirWorkShopEnum.TabEnum.Building then
			buildingCount = buildingCount + 1
		elseif tabType == AirWorkShopEnum.TabEnum.Message then
			messageCount = messageCount + 1
		end
	end

	self._tabType2UnitCount[AirWorkShopEnum.TabEnum.Hero] = unitCount
	self._tabType2UnitCount[AirWorkShopEnum.TabEnum.Highland] = highlandCount
	self._tabType2UnitCount[AirWorkShopEnum.TabEnum.Building] = buildingCount
	self._tabType2UnitCount[AirWorkShopEnum.TabEnum.Message] = messageCount

	AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.ON_ADD_OR_REMOVE_UNIT)
end

function M:getCurTabTypeCount(tab)
	return self._tabType2UnitCount[tab] or 0
end

function M:getCurTabTypeLimit(tab)
	return self._tabType2UnitLimit[tab] or 0
end

function M:getCurUnitTypeLimit(type)
	return self._unitType2UnitLimit[type]
end

function M:getMapMO()
	local model = AirWorkShopDefMgr.instance:getModel()

	return model:getModiedMapMO()
end

function M:removeUnitMO(unit)
	local entityId = unit.property:getEntityId()
	local mapMO = self:getMapMO()

	mapMO:removeUnitMO(entityId)
end

function M:getLevelMO()
	local model = AirWorkShopDefMgr.instance:getModel()
	local levelId = model:getLevelId()

	return AirWorkMapModel.instance:getLevelMOById(levelId)
end

function M:getPreviewSelect(type)
	if #self._previewSelectList == 0 then
		self:initPreviewSelect()
	end

	return self._previewSelectList[type] == 1
end

function M:setPreviewSelect(type, state)
	local id = PlayerModel.instance:getId()
	local value = state and 1 or 0

	self._previewSelectList[type] = value

	Astral.LocalStorage.Instance:SetInt(string.format("%s_%s_%s", id, kPreviewKey, type), value)
end

function M:initPreviewSelect()
	local id = PlayerModel.instance:getId()

	for type = 1, 4 do
		self._previewSelectList[type] = Astral.LocalStorage.Instance:GetInt(string.format("%s_%s_%s", id, kPreviewKey, type), 1)
	end

	self._previewSelectList[AirWorkShopEnum.TabEnum.ExitPoint] = 1
	self._previewSelectList[AirWorkShopEnum.TabEnum.BornPoint] = 1
end

function M:setSaveIndex(index)
	self._saveIndex = index
end

function M:getSaveIndex()
	if self._saveIndex then
		return self._saveIndex
	end

	return AirWorkMapModel.instance:getNextMaxIndex()
end

function M:bakeMap(mapMO)
	self._bakeMapMO = mapMO:deepCopy()
end

function M:getBakeMap()
	return self._bakeMapMO
end

function M:bakeMapForLeave(mapMO)
	self._bakeMapMOForLeave = mapMO:deepCopy()
end

function M:getBakeMapForLeave()
	return self._bakeMapMOForLeave
end

function M:setDefMainViewOpenStatus(status)
	self._isMainViewOpen = status
end

function M:getDefMainViewOpenStatus(status)
	return self._isMainViewOpen
end

M.instance = M.New()

return M
