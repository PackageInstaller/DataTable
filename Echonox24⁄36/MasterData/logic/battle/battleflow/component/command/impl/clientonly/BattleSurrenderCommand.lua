-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleSurrenderCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleSurrenderCommand", package.seeall)

local BattleSurrenderCommand = class("BattleSurrenderCommand", BattleCommandBase)

function BattleSurrenderCommand:create(delay)
	local cmd = BattleSurrenderCommand:createInstance()

	cmd:setDelay(delay)

	return cmd
end

function BattleSurrenderCommand:onInit()
	self._timeWaiter = TimeWaiter.New()
	self._delay = false
end

function BattleSurrenderCommand:onClear(interrupt)
	self._timeWaiter:clear()

	self._delay = false
end

function BattleSurrenderCommand:execute(battleFlow)
	local model = battleFlow.model
	local resultMO = model:getResultMO()

	if resultMO:isValid() then
		self:finish(true)

		return
	end

	if self._delay then
		self._timeWaiter:start(self._delay, self._sendSurrenderRequest, self)
	else
		self:_sendSurrenderRequest()
	end
end

function BattleSurrenderCommand:_sendSurrenderRequest()
	local netAgent = BattleMgr.instance:getNetAgent()

	netAgent:sendSurrenderRequest()
	self:finish(true)
end

function BattleSurrenderCommand:toString()
	return string.format("[BattleSurrenderCommand delay = %s]", tostring(self._delay))
end

function BattleSurrenderCommand:setDelay(delay)
	self._delay = delay
end

return BattleSurrenderCommand
