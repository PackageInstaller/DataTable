-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/WorkRogueEncounterRoll.lua

module("logic.extensions.roguelike.flow.work.WorkRogueEncounterRoll", package.seeall)

local M = class("WorkRogueEncounterRoll", WorkRogueRollBase)

function M:onEnter(context)
	local roleDices = RogueMgr.instance:getRogueFlow().judgeMgr:createRoleDice()

	self._dicePos = RogueMgr.instance:getRogueFlow().model:getPlayerDicePos()

	if roleDices then
		for k, v in pairs(roleDices) do
			print("ROGUE", "玩家 骰子图案", v:getUpPattern())
		end
	else
		print("玩家骰子为空")
	end

	if not RogueMgr.instance:getNeedShowDice() then
		self:onDone(WorkResult.Succeed)

		return
	end

	self._dices = roleDices

	RogueMgr.instance:getRogueFlow().diceMgr:getDiceInst(function(inst)
		self:onGetDiceRes(inst)
	end)
end

function M:getStopOffset()
	return Vector3.New(4, 0, 0)
end

return M
