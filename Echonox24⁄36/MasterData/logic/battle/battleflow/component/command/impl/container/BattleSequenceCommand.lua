-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/container/BattleSequenceCommand.lua

module("logic.battle.battleflow.component.command.impl.container.BattleSequenceCommand", package.seeall)

local BattleSequenceCommand = class("BattleSequenceCommand", BattleCommandBase, IBattleContainerCommand, IBattleCommandHandler)

function BattleSequenceCommand:create(cmdParser, eventNOList)
	local sequence = BattleSequenceCommand:createInstance()

	cmdParser:pushCmdContainer(sequence)
	BattleCmdUtil.parseServerCommandBatch(cmdParser, eventNOList)
	cmdParser:popCmdContainer()

	return sequence
end

function BattleSequenceCommand:onInit()
	self._flow = false
	self._runningContext = false
	self._curCommand = false
	self._commands = {}
end

function BattleSequenceCommand:onClear(interrupt)
	self._flow = false
	self._runningContext = false

	if self._curCommand then
		self._curCommand:safeInterrupt()

		self._curCommand = false
	end

	for _, cmd in ipairs(self._commands) do
		cmd:safeInterrupt()
	end

	BattleTableUtil.clearTable(self._commands)
end

function BattleSequenceCommand:execute(battleFlow, runningContext)
	self._flow = battleFlow
	self._runningContext = runningContext

	self:_tryNextCommand()
end

function BattleSequenceCommand:_tryNextCommand()
	local cmdList = self._commands

	if not cmdList or #cmdList <= 0 then
		self:finish(true)

		return
	end

	local cmd = table.remove(cmdList, 1)

	self._curCommand = cmd

	if BattleLog.enableLog then
		BattleLog.log(string.format("BattleSequenceCommand::execute commands %s", cmd:toString()))
	end

	cmd:setCommandHandler(self)
	cmd:execute(self._flow, self._runningContext)
end

function BattleSequenceCommand:onCommandFinish(cmd, success)
	self._curCommand = false

	self:_tryNextCommand()
end

function BattleSequenceCommand:toString()
	return string.format("[sequence command count = %s]", #self._commands)
end

function BattleSequenceCommand:addCommand(command)
	if BattleLog.enableLog then
		BattleLog.log(string.format("BattleSequenceCommand::add commands %s", command:toString()))
	end

	table.insert(self._commands, command)

	return self
end

return BattleSequenceCommand
