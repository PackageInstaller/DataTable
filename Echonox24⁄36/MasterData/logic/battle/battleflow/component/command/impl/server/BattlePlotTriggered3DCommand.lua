-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattlePlotTriggered3DCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattlePlotTriggered3DCommand", package.seeall)

local BattlePlotTriggered3DCommand = class("BattlePlotTriggered3DCommand", BattleCommandBase)

function BattlePlotTriggered3DCommand:parseServerCommand(cmdParser, plotTriggered3D)
	cmdParser:turnOnFlag(BattleCmdParser.Flag_In3dPlot)

	local cmd = BattlePlotTriggered3DCommand:createInstance()

	cmd:setPlotCode(plotTriggered3D.plot)
	cmdParser:addCommand(cmd)
	cmdParser:addCommand(BattleDelayCommand:create(0))
	BattleCmdUtil.parseServerCommandBatch(cmdParser, plotTriggered3D.events)
	cmdParser:turnOnFlag(BattleCmdParser.Flag_In3dPlot)
end

function BattlePlotTriggered3DCommand:onInit()
	self._plotCode = 0
end

function BattlePlotTriggered3DCommand:onClear()
	self._plotCode = 0
end

function BattlePlotTriggered3DCommand:execute(battleFlow)
	local plotPerformanceMgr = battleFlow.plotPerformanceMgr
	local resPath = BattleConfig.instance:getBattlePlotEventChain3dResPath(self._plotCode)
	local url = GameUrl.getBattlePlotPerformanceUrl(resPath)

	BattleMainViewFacade.instance:lockOperation()
	plotPerformanceMgr:start(url, self._onPlotFinish, self)
end

function BattlePlotTriggered3DCommand:_onPlotFinish()
	BattleMainViewFacade.instance:unlockOperation()
	self:finish(true)
end

function BattlePlotTriggered3DCommand:toString()
	return string.format("[plot triggered 3d command, plotCode = %s]", self._plotCode)
end

function BattlePlotTriggered3DCommand:setPlotCode(plotCode)
	self._plotCode = plotCode

	return self
end

return BattlePlotTriggered3DCommand
