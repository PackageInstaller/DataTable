-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleAdjustCameraInMoveAndAttackCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleAdjustCameraInMoveAndAttackCommand", package.seeall)

local M = class("BattleAdjustCameraInMoveAndAttackCommand", BattleCommandBase)

function M:createByCommand(movedEventNO, targetUnionIndex, entityId)
	local cmd = M:createInstance()

	if targetUnionIndex then
		cmd:setOnlyMove(false)
	else
		cmd:setOnlyMove(true)
	end

	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(entityId)
	local originUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())
	local movements = movedEventNO.movement
	local toUnionIndex

	if #movements == 0 then
		toUnionIndex = originUnionIndex
	else
		local lastCoordinates = movements[#movements]

		toUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(lastCoordinates.x, lastCoordinates.z)
	end

	cmd:setUnionIndex(originUnionIndex, toUnionIndex, targetUnionIndex)
	cmd:setEntityId(entityId)

	return cmd
end

function M:create(targetUnionIndex, originUnionIndex, toUnionIndex, entityId)
	local cmd = M:createInstance()

	if targetUnionIndex then
		cmd:setOnlyMove(false)
	else
		cmd:setOnlyMove(true)
	end

	cmd:setUnionIndex(originUnionIndex, toUnionIndex, targetUnionIndex)
	cmd:setEntityId(entityId)

	return cmd
end

function M:setOnlyMove(state)
	self._onlyMove = state
end

function M:setUnionIndex(originUnionIndex, toUnionIndex, targetUnionIndex)
	self._targetUnionIndex = targetUnionIndex
	self._toUnionIndex = toUnionIndex
	self._originUnionIndex = originUnionIndex
end

function M:setOnlyMove(state)
	self._onlyMove = state
end

function M:setEntityId(entityId)
	self._entityId = entityId
end

function M:onInit()
	self._entityId = 0
	self._onlyMove = false
	self._targetUnionIndex = 0
	self._toUnionIndex = 0
end

function M:onClear()
	self._entityId = 0
	self._onlyMove = false
	self._fromUnionIndex = 0
	self._toUnionIndex = 0
end

function M:_followCamera2Target()
	if self._onlyMove then
		self:_followCameraByMove()
	else
		self:_followCameraByAttack()
	end
end

function M:_followCameraByNoAction()
	return
end

function M:_followCameraByMove()
	local fromUnionIndex = self._originUnionIndex
	local toUnionIndex = self._toUnionIndex

	if fromUnionIndex == toUnionIndex then
		self:_followCameraByNoAction()

		return
	end

	local battleFlow = BattleMgr.instance:getActiveBattleFlow()
	local boardMgr = battleFlow.boardMgr
	local unit = battleFlow.unitMgr:getUnit(self._entityId)

	if unit then
		local tx, ty, tz = boardMgr:getCellPosition(toUnionIndex):Get()
		local fx, fy, fz = boardMgr:getCellPosition(fromUnionIndex):Get()
		local speed = unit.mover:getSpeed()
		local length = math.abs(tx - fx) + math.abs(tz - fz)
		local gridLength = SpaceX.CheckBoardSetting.GetSideLength()

		VirtualCameraMgr.instance:doFollowPosition(tx, ty, tz, length * gridLength / speed)
	end
end

function M:_followCameraByAttack()
	local toUnionIndex = self._toUnionIndex
	local targetUnionIndex = self._targetUnionIndex
	local battleFlow = BattleMgr.instance:getActiveBattleFlow()
	local cmd = BattleAdjustFollowCenter2Command:create(toUnionIndex, targetUnionIndex)

	battleFlow.cmdExecuter:executeCommand(cmd)
	cmd:stop()
end

function M:execute(battleFlow)
	self:_followCamera2Target()
	self:finish(true)
end

return M
