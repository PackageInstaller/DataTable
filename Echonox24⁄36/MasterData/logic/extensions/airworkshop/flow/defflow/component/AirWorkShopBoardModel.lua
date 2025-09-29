-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/component/AirWorkShopBoardModel.lua

module("logic.extensions.airworkshop.flow.defflow.component.AirWorkShopBoardModel", package.seeall)

local M = class("AirWorkShopBoardModel", IAirWorkShopFlowComp)

function M:onInit()
	self._activeBoardMO = false
	self._tab2UnionIndexEntityIdList = {}
	self._tab2UnionIndexEntityIdList[AirWorkShopEnum.TabEnum.Highland] = {}
	self._tab2UnionIndexEntityIdList[AirWorkShopEnum.TabEnum.Hero] = {}
	self._tab2UnionIndexEntityIdList[AirWorkShopEnum.TabEnum.Building] = {}
	self._tab2UnionIndexEntityIdList[AirWorkShopEnum.TabEnum.Message] = {}
	self._tab2UnionIndexEntityIdList[AirWorkShopEnum.TabEnum.ExitPoint] = {}
	self._tab2UnionIndexEntityIdList[AirWorkShopEnum.TabEnum.BornPoint] = {}
end

function M:onStart()
	self._activeBoardMO = false
end

function M:onClear()
	self:_clearActiveBoardMO()

	for k, tabTable in pairs(self._tab2UnionIndexEntityIdList) do
		table.clear(tabTable)
	end
end

function M:setActiveBoardCode(checkerBoardCode)
	self:_clearActiveBoardMO()

	self._activeBoardMO = CheckerBoardMO:createInstance(checkerBoardCode)
end

function M:getActiveBoardMO()
	return self._activeBoardMO
end

function M:getBoardCellMO(unionIndex)
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)

	return self._activeBoardMO:getCellMO(x, z)
end

function M:getBoardCellMOByCoordinates(x, z)
	return self._activeBoardMO:getCellMO(x, z)
end

function M:isValideCoordinates(x, z)
	return self._activeBoardMO:isValideCoordinates(x, z)
end

function M:isActiveCoordinates(x, z)
	return self._activeBoardMO:isActiveCoordinates(x, z)
end

function M:getEntityOnBoard(unionIndex, tabType)
	if tabType and tabType > 0 then
		return self:_getEntityOnBoard(unionIndex, tabType)
	else
		for tab, _ in pairs(self._tab2UnionIndexEntityIdList) do
			local entityId = self:_getEntityOnBoard(unionIndex, tab)

			if entityId then
				return entityId
			end
		end
	end
end

function M:getAllEntityOnBoard(unionIndex, outList)
	for tab, _ in pairs(self._tab2UnionIndexEntityIdList) do
		local entityId = self:_getEntityOnBoard(unionIndex, tab)

		if entityId then
			table.insert(outList, entityId)
		end
	end
end

function M:getAllEntity()
	return self._tab2UnionIndexEntityIdList
end

function M:_getEntityOnBoard(unionIndex, tabType)
	local unionIndex2EntityIdList = self._tab2UnionIndexEntityIdList[tabType]

	if unionIndex2EntityIdList then
		return unionIndex2EntityIdList[unionIndex]
	end
end

function M:setUnitToUnionIndex(unit, unionIndex)
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)

	self:_unlinkUnit(unit)
	self:_linkUnit(unit, x, z)
end

function M:removeUnit(unit)
	self:_unlinkUnit(unit)
end

function M:_unlinkUnit(unit)
	local heightMapProxy = SpaceX.HeightMapProxy
	local addHeight = AirWorkShopDefSceneUtil.isCanFlyHighLand(unit)
	local transform = unit.transform
	local x, z = transform:getCoordinates()

	if self:isValideCoordinates(x, z) then
		if transform:isComposite() then
			local vertices = transform:getVertices()

			for _, vertex in pairs(vertices) do
				local vertexX, vertexZ = transform:transformCoordinates(vertex:getXZ())
				local vertexCellMO = self:getBoardCellMOByCoordinates(vertexX, vertexZ)
				local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(vertexX, vertexZ)

				self._tab2UnionIndexEntityIdList[unit.property:getTabType()][unionIndex] = nil

				if addHeight then
					heightMapProxy.SetCellAdditionalHeight(vertexX, vertexZ, 0)
				end
			end
		else
			local cellMO = self:getBoardCellMOByCoordinates(x, z)
			local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x, z)

			self._tab2UnionIndexEntityIdList[unit.property:getTabType()][unionIndex] = nil

			if addHeight then
				heightMapProxy.SetCellAdditionalHeight(x, z, 0)
			end
		end

		transform:resetCoordinates()
	end
end

function M:_linkUnit(unit, x, z)
	local heightMapProxy = SpaceX.HeightMapProxy
	local addHeight = AirWorkShopDefSceneUtil.isCanFlyHighLand(unit)
	local entityId = unit.property:getEntityId()
	local transform = unit.transform

	transform:setCoordinates(x, z)

	if transform:isComposite() then
		local vertices = transform:getVertices()

		for _, vertex in pairs(vertices) do
			local vertexX, vertexZ = transform:transformCoordinates(vertex:getXZ())
			local vertexCellMO = self:getBoardCellMOByCoordinates(vertexX, vertexZ)
			local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(vertexX, vertexZ)

			self._tab2UnionIndexEntityIdList[unit.property:getTabType()][unionIndex] = entityId

			if addHeight then
				heightMapProxy.SetCellAdditionalHeight(vertexX, vertexZ, BattleConst.HighlandHeight)
			end
		end
	else
		local cellMO = self:getBoardCellMOByCoordinates(x, z)
		local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x, z)

		self._tab2UnionIndexEntityIdList[unit.property:getTabType()][unionIndex] = entityId

		if addHeight then
			heightMapProxy.SetCellAdditionalHeight(x, z, BattleConst.HighlandHeight)
		end
	end
end

function M:_clearActiveBoardMO()
	if self._activeBoardMO then
		self._activeBoardMO:returnSelf()

		self._activeBoardMO = false
	end
end

return M
