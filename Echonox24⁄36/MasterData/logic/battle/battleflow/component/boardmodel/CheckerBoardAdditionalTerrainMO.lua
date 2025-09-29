-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/boardmodel/CheckerBoardAdditionalTerrainMO.lua

module("logic.battle.battleflow.component.boardmodel.CheckerBoardAdditionalTerrainMO", package.seeall)

local CheckerBoardAdditionalTerrainMO = class("CheckerBoardAdditionalTerrainMO", AbstractGlobalReusable)

function CheckerBoardAdditionalTerrainMO:createFromAdditionalTerrainNO(additionalTerrainNO)
	return CheckerBoardAdditionalTerrainMO:createInstance(additionalTerrainNO.code, additionalTerrainNO.round, additionalTerrainNO.triggered)
end

function CheckerBoardAdditionalTerrainMO:createFromAdditionalTerrainInfo(additionalTerrainInfo)
	return CheckerBoardAdditionalTerrainMO:createInstance(additionalTerrainInfo.code, additionalTerrainInfo.round, additionalTerrainInfo.triggered)
end

function CheckerBoardAdditionalTerrainMO:getCapacity()
	return BattleConst.ObjPoolCapacityMid
end

function CheckerBoardAdditionalTerrainMO:ctor(code, round, triggered)
	self._code = false
	self._round = false
	self._triggered = false

	self:reuse(code, round, triggered)
end

function CheckerBoardAdditionalTerrainMO:reset()
	self._code = false
	self._round = false
	self._triggered = false
end

function CheckerBoardAdditionalTerrainMO:reuse(code, round, triggered)
	self._code = code
	self._round = round
	self._triggered = triggered
end

function CheckerBoardAdditionalTerrainMO:destroy()
	self:reset()
end

function CheckerBoardAdditionalTerrainMO:getCode()
	return self._code
end

function CheckerBoardAdditionalTerrainMO:getRound()
	return self._round
end

function CheckerBoardAdditionalTerrainMO:getTriggered()
	return self._triggered
end

function CheckerBoardAdditionalTerrainMO:updateTerrain(terrainInfo)
	self._triggered = terrainInfo.triggered
end

function CheckerBoardAdditionalTerrainMO:decRound()
	if self._round > 0 then
		self._round = self._round - 1
	end
end

function CheckerBoardAdditionalTerrainMO:equals(additionalTerrainMO)
	return self._code == additionalTerrainMO:getCode()
end

return CheckerBoardAdditionalTerrainMO
