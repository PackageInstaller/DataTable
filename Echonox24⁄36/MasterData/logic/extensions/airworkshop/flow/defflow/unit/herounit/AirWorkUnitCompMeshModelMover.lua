-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/unit/herounit/AirWorkUnitCompMeshModelMover.lua

module("logic.extensions.airworkshop.flow.defflow.unit.herounit.AirWorkUnitCompMeshModelMover", package.seeall)

local M = class("AirWorkUnitCompMeshModelMover", BattleUnitCompMeshModelMover)
local kMappingLayers = {
	SYSTEM = 2,
	BUSINESS = 3,
	BASE = 1
}
local kMappingLayerOrder = {
	kMappingLayers.BUSINESS,
	kMappingLayers.SYSTEM,
	kMappingLayers.BASE
}

function M:_onPosChanged()
	local x, z = self._mover:getPos()
	local wp = self._mover:getCurWayPoint()

	if wp then
		if wp.x ~= x or wp.y ~= z then
			self._meshModel:lookAt(wp.x, 0, wp.y)
		end

		self:playWalk()
	end

	local y = self._offsetVec3.y

	if not self._ignoreTerrain then
		local boardMgr

		if AirWorkShopDefMgr.instance:isInDefFlow() then
			boardMgr = AirWorkShopDefMgr.instance:getBoardMgr()
		else
			boardMgr = BattleMgr.instance:getBoardMgr()
		end

		if self._unit.property:getTabType() == AirWorkShopEnum.TabEnum.Hero then
			y = y + boardMgr:calculateWorldYOffset(x, z)
		else
			y = y + boardMgr:calculateBaseWorldYOffset(x, z)
		end
	end

	self._position:Set(x + self._offsetVec3.x, y, z + self._offsetVec3.z)
	Astral.TransformUtil.SetPos(self._trs, self._position:Get())
end

return M
