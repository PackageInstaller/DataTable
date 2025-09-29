-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/team/unit/TeamUnitMgr.lua

module("logic.extensions.team.unit.TeamUnitMgr", package.seeall)

local TeamUnitMgr = class("TeamUnitMgr")
local kEmptyTable = {}

function TeamUnitMgr:ctor()
	self._heroId2Unit = {}
end

function TeamUnitMgr:onClear()
	for _, unit in pairs(self._heroId2Unit) do
		unit.namebar:clear()
		self:removeUnit(unit)
		TeamUnitGenerator.destroyUnit(unit)
	end

	self._heroId2Unit = {}
end

function TeamUnitMgr:createUnit(heroMO, index)
	local unit = TeamUnitGenerator.createUnit(heroMO, index)

	unit.meshModel:lookAtDirVec3(MeshModelDirection.Right)

	self._heroId2Unit[heroMO:getId()] = unit

	return unit
end

function TeamUnitMgr:getAllUnits()
	return self._heroId2Unit
end

function TeamUnitMgr:getUnit(heroId)
	return self._heroId2Unit[heroId]
end

function TeamUnitMgr:getUnitByEntityCode(heroId)
	for k, v in pairs(self._heroId2Unit) do
		if v.heroId == heroId then
			return v
		end
	end
end

function TeamUnitMgr:getUnitOnUnionIndex(unionIndex)
	if not unionIndex then
		return false
	end

	local cellMO = self._boardModel:getBoardCellMO(unionIndex)

	if not cellMO then
		if BattleLog.enableError then
			BattleLog.error(string.format("TeamUnitMgr::cannot find CellMO[%s]", unionIndex))
		end

		return false
	end

	return self:getUnit(cellMO:getOwnerEntityId())
end

function TeamUnitMgr:removeUnit(unit)
	local heroId = unit.heroId

	self._heroId2Unit[heroId] = nil
end

TeamUnitMgr.instance = TeamUnitMgr.New()

return TeamUnitMgr
