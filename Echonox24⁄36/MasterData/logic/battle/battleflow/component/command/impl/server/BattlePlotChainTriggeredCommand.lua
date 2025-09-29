-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattlePlotChainTriggeredCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattlePlotChainTriggeredCommand", package.seeall)

local BattlePlotChainTriggeredCommand = class("BattlePlotChainTriggeredCommand", BattleCommandBase)

function BattlePlotChainTriggeredCommand:parseServerCommand(cmdParser, plotChainTriggeredNO)
	cmdParser:turnOnFlag(BattleCmdParser.Flag_InPlot)

	local cmd = BattlePlotChainTriggeredCommand:createInstance()

	cmd:setPlotChainTriggerKey(plotChainTriggeredNO.groupCode, plotChainTriggeredNO.chainCode)
	cmdParser:addCommand(cmd)
	BattleCmdUtil.parseServerCommandBatch(cmdParser, plotChainTriggeredNO.events)
	cmdParser:addCommand(BattlePlotChainEndedCommand:createInstance())
	cmdParser:turnOffFlag(BattleCmdParser.Flag_InPlot)
end

function BattlePlotChainTriggeredCommand:onInit()
	self._groupCode = false
	self._chainCode = false
end

function BattlePlotChainTriggeredCommand:onClear()
	self._groupCode = false
	self._chainCode = false
end

function BattlePlotChainTriggeredCommand:execute(battleFlow)
	local model = battleFlow.model

	model:setPhase(BattleEnum.Phase.PLOT)

	if not model:isProxyMode() then
		BattleRoundReportViewFacade.instance:setVisible(false)
		self:showPlotChangeTip()
	end

	self:finish(true)
end

function BattlePlotChainTriggeredCommand:showPlotChangeTip()
	local battlePlotChainCO = BattleConfig.instance:getBattlePlotEventChainCO(self._groupCode, self._chainCode)

	if battlePlotChainCO and not string.nilorempty(battlePlotChainCO.answer) then
		ViewMgr.instance:openSpecialView(ViewName.StoryUnlockTipView, {
			index = 1,
			desc = false
		})
	end
end

function BattlePlotChainTriggeredCommand:setPlotChainTriggerKey(groupCode, chainCode)
	self._groupCode = groupCode
	self._chainCode = chainCode

	return self
end

function BattlePlotChainTriggeredCommand:toString()
	return "[plot chain triggered command]"
end

return BattlePlotChainTriggeredCommand
