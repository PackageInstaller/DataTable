-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/def/AirWorkBuildingMO.lua

module("logic.extensions.airworkshop.model.def.AirWorkBuildingMO", package.seeall)

local M = class("AirWorkBuildingMO", AirWorkUnitMOBase)

function M:createInstance(entityId, buildId, unionIndex, msgMO)
	local mo = AirWorkBuildingMO.New()

	mo:setEntityId(entityId)
	mo:setId(buildId)
	mo:setUnionIndex(unionIndex)
	mo:setMsgMO(msgMO)

	return mo
end

function M:_initByAgent(unitNO)
	self:setId(unitNO.id)
	self:setUnionIndex(BoardIndexConverter.coordinatesToUnionIndex(unitNO.cell.x, unitNO.cell.z))

	local msgMO = AirWorkMessageMO:createByAgent(unitNO.msg)

	self:setMsgMO(msgMO)
end

function M:trans2AgentForm()
	local buildingNO = BattleExtension_pb.BuildingNO()

	buildingNO.id = self._id
	buildingNO.cell.x, buildingNO.cell.z = BoardIndexConverter.unionIndexToCoordinates(self._unionIndex)

	if self._messageMO then
		self._messageMO:trans2AgentForm(buildingNO.msg)
	end

	return buildingNO
end

function M:setId(id)
	self._id = id

	local buildCO = AirWorkShopConfig.instance:getBuildingCO(id)

	if buildCO.type == 1 then
		self._unitType = AirWorkShopEnum.UnitType.GroundBuilding
		self._tabType = AirWorkShopEnum.TabEnum.Highland
	elseif buildCO.type == 2 then
		self._unitType = AirWorkShopEnum.UnitType.SpecialBuilding
		self._tabType = AirWorkShopEnum.TabEnum.Building
	elseif buildCO.type == 3 then
		self._unitType = AirWorkShopEnum.UnitType.Message
		self._tabType = AirWorkShopEnum.TabEnum.Message
	end
end

function M:getUnitType()
	return self._unitType
end

function M:getTabType()
	return self._tabType
end

function M:getId()
	return self._id
end

function M:setUnionIndex(unionIndex)
	self._unionIndex = unionIndex
end

function M:getUnionIndex()
	return self._unionIndex or -1
end

function M:getPosition()
	return BoardIndexConverter.unionIndexToCoordinates(self._unionIndex)
end

function M:setMsgMO(mo)
	self._messageMO = mo
end

function M:getMsgMO()
	return self._messageMO
end

function M:isSame(buildMO)
	if self._unionIndex ~= buildMO:getUnionIndex() then
		return false
	end

	if self._id ~= buildMO:getId() then
		return false
	end

	if self._tabType ~= buildMO:getTabType() then
		return false
	end

	if self._messageMO then
		local msgMO = buildMO:getMsgMO()

		if not self._messageMO:isSame(msgMO) then
			return false
		end
	elseif buildMO:getMsgMO() then
		return false
	end

	return true
end

return M
