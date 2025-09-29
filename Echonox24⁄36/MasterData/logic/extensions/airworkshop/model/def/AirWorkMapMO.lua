-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/def/AirWorkMapMO.lua

module("logic.extensions.airworkshop.model.def.AirWorkMapMO", package.seeall)

local M = class("AirWorkMapMO")

function M:ctor()
	self._buildingMOList = {}
	self._heroMOList = {}
	self._ambushMOList = {}
	self._extraWinCondition = false
	self._tagList = {}
	self._bornMOList = {}
	self._leaveMOList = {}
	self._updateHeroIds = {}
	self._refreshHeroList = {}
end

function M:initByAgent(mapNO, attributeNOs)
	self._sceneId = mapNO.sceneId

	for i, v in ipairs(mapNO.building) do
		local unitMO = AirWorkBuildingMO.New(v)

		table.insert(self._buildingMOList, unitMO)
	end

	for i, v in ipairs(mapNO.normalUnit) do
		local unitMO = AirWorkHeroMO.New(v)

		table.insert(self._heroMOList, unitMO)
	end

	for i, v in ipairs(mapNO.ambushUnit) do
		local unitMO = AirWorkAmbushMO.New(v)

		table.insert(self._ambushMOList, unitMO)
	end

	self._cellMsg = mapNO.cellMsg

	for i, v in ipairs(mapNO.initTags) do
		table.insert(self._tagList, v)
	end

	for i, v in ipairs(mapNO.bornCell) do
		local unitMO = AirWorkBornMO.New(v)

		table.insert(self._bornMOList, unitMO)
	end

	self._extraWinCondition = mapNO.extraWinCondition

	if self._extraWinCondition.id == 1 then
		for i = 1, #self._extraWinCondition.params, 2 do
			local x = self._extraWinCondition.params[i]
			local z = self._extraWinCondition.params[i + 1]
			local unitMO = AirWorkLeaveMO.New(BoardIndexConverter.coordinatesToUnionIndex(x, z))

			table.insert(self._leaveMOList, unitMO)
		end
	end

	if attributeNOs then
		for k, attrNO in pairs(attributeNOs) do
			local heroMO = self:getHeroOrAmbushMO(attrNO.heroId)

			if heroMO then
				heroMO:initAttrByAgent(attrNO)
			end
		end
	end
end

function M:init(id)
	self._sceneId = id

	local sceneCO = AirWorkShopConfig.instance:getSceneCO(id)
	local levelCode = sceneCO.levelId
	local levelCO = BattleConfig.instance:getBattleLevelCO(levelCode)

	if levelCO and levelCO.bornPosList then
		for _, pos in pairs(levelCO.bornPosList) do
			local cellNO = BattleExtension_pb.BornCellNO()

			cellNO.cell.x = pos.x
			cellNO.cell.z = pos.y
			cellNO.direction = pos.direction

			local unitMO = AirWorkBornMO.New(cellNO)

			table.insert(self._bornMOList, unitMO)
		end
	end

	table.insert(self._tagList, 1)
end

function M:trans2AgentForm(mapInfoNO)
	mapInfoNO.sceneId = self:getSceneId()

	for i, v in ipairs(self._buildingMOList) do
		table.insert(mapInfoNO.building, v:trans2AgentForm())
	end

	for i, v in ipairs(self._heroMOList) do
		table.insert(mapInfoNO.normalUnit, v:trans2AgentForm())
	end

	for i, v in ipairs(self._ambushMOList) do
		table.insert(mapInfoNO.ambushUnit, v:trans2AgentForm())
	end

	for i, v in ipairs(self._tagList) do
		table.insert(mapInfoNO.initTags, v)
	end

	for i, v in ipairs(self._bornMOList) do
		table.insert(mapInfoNO.bornCell, v:trans2AgentForm())
	end

	if self._extraWinCondition and self._extraWinCondition.id ~= 0 then
		mapInfoNO.extraWinCondition.id = self._extraWinCondition.id

		for i, v in ipairs(self._extraWinCondition.params) do
			table.insert(mapInfoNO.extraWinCondition.params, v)
		end
	end

	return mapInfoNO
end

function M:getSceneId()
	return self._sceneId
end

function M:getBattlePreloadMOList(outList)
	for i, buildMO in ipairs(self._buildingMOList) do
		local tabType = buildMO:getTabType()

		if tabType == AirWorkShopEnum.TabEnum.Highland or tabType == AirWorkShopEnum.TabEnum.Message then
			table.insert(outList, buildMO)
		end
	end
end

function M:getBuildingList()
	return self._buildingMOList
end

function M:getHeroMOList()
	return self._heroMOList
end

function M:getAmbushMOList()
	return self._ambushMOList
end

function M:getCondition()
	return self._extraWinCondition
end

function M:setCondition(condition)
	self._extraWinCondition = condition
end

function M:getTags()
	return self._tagList
end

function M:setTags(tagList)
	self._tagList = tagList
end

function M:getBorns()
	return self._bornMOList
end

function M:getLeaveMOs()
	return self._leaveMOList
end

function M:updateLeaveParams()
	return
end

function M:getHeroOrAmbushMO(code)
	local mo = self:getHeroMO(code)

	mo = mo or self:getAmbushMO(code)

	return mo
end

function M:getHeroMO(id)
	for i, v in ipairs(self._heroMOList) do
		if v:getId() == id then
			return v
		end
	end
end

function M:getAmbushMO(id)
	for i, v in ipairs(self._ambushMOList) do
		if v:getId() == id then
			return v
		end
	end
end

function M:isBornPos(unionIndex)
	for i, v in ipairs(self._bornMOList) do
		if v:getUnionIndex() == unionIndex then
			return true
		end
	end

	return false
end

function M:deepCopy()
	local newMapMO = AirWorkMapMO.New()
	local no = BattleExtension_pb.AirMapInfoNO()

	newMapMO:initByAgent(self:trans2AgentForm(no))
	self:deepCopyClientPart(newMapMO)

	return newMapMO
end

function M:deepCopyClientPart(newMapMO)
	for i, v in ipairs(newMapMO:getHeroMOList()) do
		v:deepCopyClientPart(self:getHeroMO(v:getId()))
	end

	for i, v in ipairs(newMapMO:getAmbushMOList()) do
		v:deepCopyClientPart(self:getAmbushMO(v:getId()))
	end
end

function M:addHeroMO(entityId, heroId, unionIndex, msgMO, heroAttrInfo)
	local heroMO = AirWorkHeroMO:createInstance(entityId, heroId, unionIndex, msgMO, heroAttrInfo)

	table.insert(self._heroMOList, heroMO)

	return heroMO
end

function M:addAmbushMO(entityId, heroId, unionIndex, condition, params, msgMO, heroAttrInfo)
	local ambushMO = AirWorkAmbushMO:createInstance(entityId, heroId, unionIndex, condition, params, msgMO, heroAttrInfo)

	table.insert(self._ambushMOList, ambushMO)

	return ambushMO
end

function M:removeUnitMO(entityId)
	for i, unitMO in ipairs(self._heroMOList) do
		if unitMO:getEntityId() == entityId then
			table.remove(self._heroMOList, i)

			return true
		end
	end

	for i, unitMO in ipairs(self._ambushMOList) do
		if unitMO:getEntityId() == entityId then
			table.remove(self._ambushMOList, i)

			return true
		end
	end

	for i, unitMO in ipairs(self._buildingMOList) do
		if unitMO:getEntityId() == entityId then
			table.remove(self._buildingMOList, i)

			return true
		end
	end

	for i, unitMO in ipairs(self._bornMOList) do
		if unitMO:getEntityId() == entityId then
			table.remove(self._bornMOList, i)

			return true
		end
	end

	for i, unitMO in ipairs(self._leaveMOList) do
		if unitMO:getEntityId() == entityId then
			table.remove(self._leaveMOList, i)

			return true
		end
	end
end

function M:clearHeroAndAmubush()
	table.clear(self._heroMOList)
	table.clear(self._ambushMOList)
end

function M:addHighlandMO(entityId, buildId, unionIndex, msgMO)
	local buidMO = AirWorkBuildingMO:createInstance(entityId, buildId, unionIndex, msgMO)

	table.insert(self._buildingMOList, buidMO)

	return buidMO
end

function M:addBornPos(unionIndex, direction)
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)
	local cellNO = BattleExtension_pb.BornCellNO()

	cellNO.cell.x = x
	cellNO.cell.z = z
	cellNO.direction = direction or BattleEnum.Direction.Up

	local bornMO = AirWorkBornMO.New(cellNO)

	table.insert(self._bornMOList, bornMO)

	return bornMO
end

function M:addLeaveMO(unionIndex)
	local leaveMO = AirWorkLeaveMO.New(unionIndex)

	table.insert(self._leaveMOList, leaveMO)

	return leaveMO
end

function M:getRefreshHeros()
	return self._refreshHeroList
end

function M:getRefreshCount()
	local count = 0

	for k, v in pairs(self._refreshHeroList) do
		count = count + 1
	end

	return count
end

function M:transHeroDatCreateType2Agent()
	for i, v in ipairs(self._heroMOList) do
		local attrInfo = v:getHeroAttrInfo()

		attrInfo.isCreateByAgent = true
	end

	for i, v in ipairs(self._ambushMOList) do
		local attrInfo = v:getHeroAttrInfo()

		attrInfo.isCreateByAgent = true
	end

	table.clear(self._refreshHeroList)
end

function M:hasMarkRefreshHero(heroId)
	return self._refreshHeroList[heroId]
end

function M:isSame(mapMO)
	if self._sceneId ~= mapMO:getSceneId() then
		return false
	end

	local buildMOList = mapMO:getBuildingList()

	if #self._buildingMOList ~= #buildMOList then
		printWarn("viking_isSame__buildingMOList", #self._buildingMOList, #buildMOList)

		return false
	end

	for i, buildMO in ipairs(self._buildingMOList) do
		if not buildMO:isSame(buildMOList[i]) then
			return false
		end
	end

	local heroMOList = mapMO:getHeroMOList()

	if #self._heroMOList ~= #heroMOList then
		printWarn("viking_isSame__buildingMOList", #self._heroMOList, #heroMOList)

		return false
	end

	for i, heroMO in ipairs(self._heroMOList) do
		if not heroMO:isSame(heroMOList[i]) then
			printWarn("viking_isSame__heroMO", heroMO:getId())

			return false
		end
	end

	local ambushMOList = mapMO:getAmbushMOList()

	if #self._ambushMOList ~= #ambushMOList then
		return false
	end

	for i, heroMO in ipairs(self._ambushMOList) do
		if not heroMO:isSame(ambushMOList[i]) then
			return false
		end
	end

	local tagIdList = mapMO:getTags()

	if #self._tagList ~= #tagIdList then
		return false
	end

	for i, tagId in ipairs(self._tagList) do
		if tagId ~= tagIdList[i] then
			return false
		end
	end

	local condition = mapMO:getCondition()

	if AirWorkShopDefSceneUtil.hasExtraWinCondition(condition) ~= AirWorkShopDefSceneUtil.hasExtraWinCondition(self._extraWinCondition) then
		return false
	end

	if self._extraWinCondition and condition then
		if self._extraWinCondition.id ~= condition.id then
			return false
		end

		if self._extraWinCondition.id == condition.id then
			if #self._extraWinCondition.params ~= #condition.params then
				return false
			end

			for i, v in ipairs(self._extraWinCondition.params) do
				if v ~= condition.params[i] then
					return false
				end
			end
		end
	end

	if mapMO:getRefreshCount() ~= self:getRefreshCount() then
		printWarn("viking_isSame_refreshHeroList", mapMO:getRefreshCount(), self:getRefreshCount())

		return false
	end

	local leaveList = mapMO:getLeaveMOs()

	for i, leaveMO in ipairs(leaveList) do
		if self._leaveMOList[i]:getUnionIndex() ~= leaveMO:getUnionIndex() then
			return false
		end
	end

	local bornList = mapMO:getBorns()

	if #bornList ~= #self._bornMOList then
		return false
	end

	for i, born in ipairs(bornList) do
		if self._bornMOList[i]:getUnionIndex() ~= born:getUnionIndex() then
			return false
		end
	end

	return true
end

return M
