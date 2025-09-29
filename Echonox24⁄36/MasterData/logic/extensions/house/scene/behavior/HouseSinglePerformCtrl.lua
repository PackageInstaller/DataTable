-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/behavior/HouseSinglePerformCtrl.lua

module("logic.extensions.house.scene.behavior.HouseSinglePerformCtrl", package.seeall)

local M = class("HouseSinglePerformCtrl", HousePerformCtrl)
local AnimationState = HouseEnum.AnimationState
local PerformCtrlType = HouseEnum.PerformCtrlType
local PlayerStatus = HouseEnum.PlayerStatus

function M:getCtrlType()
	return PerformCtrlType.Single
end

function M:reFindAllUsablePerformCO()
	self._usablePerformCOs = {}

	local dict = HouseConfig.instance:getPerformCODict()

	for _, performCO in pairs(dict) do
		local canPlay = self:_canPlayDefaultPerform(performCO)

		if canPlay and performCO:getPerformType() == PerformCtrlType.Single and performCO:isHeroIdsMatch(self._id) and performCO:isStatusMatch(self._performUnitA) then
			local canPerform = false
			local isEating = self._performUnitA.model:judgeStatus(PlayerStatus.Eating)
			local isSleeping = self._performUnitA.model:judgeStatus(PlayerStatus.Sleeping)
			local isElevator = self._performUnitA.model:judgeStatus(PlayerStatus.Elevator)
			local isWaitingElevator = self._performUnitA.model:judgeStatus(PlayerStatus.WaitingElevator)

			if isEating or isSleeping or isElevator or isWaitingElevator then
				if not performCO:interruptAI() then
					canPerform = true
				end
			else
				canPerform = true
			end

			if canPerform then
				table.insert(self._usablePerformCOs, performCO)
			end
		end
	end

	return self._usablePerformCOs
end

function M:_beforeStartPerform()
	M.super._beforeStartPerform(self)
	self._performUnitA.performCtrl:setRunningCtrl(self)

	if self._currPerformCO:interruptAI() then
		self._performUnitA.ai:stopCurrentAI()
		self._performUnitA.navMesh:setNavMeshAgentStatus(false)
		self._performUnitA.navMeshMover:setStopChangeAngle(true)
		self._performUnitA.meshModel:play(AnimationState.Idle, true)
	end
end

function M:_beforeEndPerform(isInterrput)
	M.super._beforeEndPerform(self, isInterrput)
	self._performUnitA.performCtrl:setRunningCtrl(nil)

	if self._currPerformCO:interruptAI() then
		self._performUnitA.navMesh:setNavMeshAgentStatus(true)
		self._performUnitA.navMeshMover:setStopChangeAngle(false)
		self._performUnitA.ai:setStop(false)
	end
end

return M
