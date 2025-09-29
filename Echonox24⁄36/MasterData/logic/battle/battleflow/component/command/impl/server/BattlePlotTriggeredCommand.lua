-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattlePlotTriggeredCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattlePlotTriggeredCommand", package.seeall)

local BattlePlotTriggeredCommand = class("BattlePlotTriggeredCommand", BattleCommandBase)

function BattlePlotTriggeredCommand:parseServerCommand(cmdParser, plotTriggeredNO)
	local cmd = BattlePlotTriggeredCommand:createInstance()

	cmd:setPlotType(plotTriggeredNO.type)
	cmd:setPlotCode(plotTriggeredNO.id)
	cmdParser:addCommand(cmd)
end

function BattlePlotTriggeredCommand:onInit()
	self._plotType = 0
	self._plotCode = 0
end

function BattlePlotTriggeredCommand:onClear()
	self._plotType = 0
	self._plotCode = 0
end

function BattlePlotTriggeredCommand:execute(battleFlow)
	local isProxyMode = battleFlow.model:isProxyMode()

	if self._plotType == 1 then
		if isProxyMode then
			self:finish(true)
		else
			StoryMgr.instance:startSingle(self._plotCode, false, self._onPlotFinish, self)
		end
	elseif self._plotType == 2 then
		local triggerCO = BattleConfig.instance.instance:getClientEventTriggerCO(self._plotCode)

		if triggerCO.type == 1 then
			local sceneGameObjectMgr = battleFlow.sceneGameObjectMgr

			sceneGameObjectMgr:addSceneEffect(GameUrl.get3dEffectSceneCommonUrl(triggerCO.resPath))
			self:finish(true)
		elseif isProxyMode then
			self:finish(true)
		else
			if BattleLog.enableError then
				BattleLog.error(string.format("unhandle trigger type %s", triggerCO.type))
			end

			self:finish(true)
		end
	else
		if BattleLog.enableError then
			BattleLog.error(string.format("unhandle plotType %s", self._plotType))
		end

		self:finish(true)
	end
end

function BattlePlotTriggeredCommand:_onPlotFinish()
	self:finish(true)
end

function BattlePlotTriggeredCommand:toString()
	return string.format("[plot triggered command, plotType = %s, plotCode = %s]", self._plotType, self._plotCode)
end

function BattlePlotTriggeredCommand:setPlotType(plotType)
	self._plotType = plotType
end

function BattlePlotTriggeredCommand:setPlotCode(plotCode)
	self._plotCode = plotCode

	return self
end

return BattlePlotTriggeredCommand
