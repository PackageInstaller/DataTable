-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/battleflow/command/DoomBattleSkillTriggeredCommand.lua

module("logic.extensions.dungeon.battleflow.command.DoomBattleSkillTriggeredCommand", package.seeall)

local DoomBattleSkillTriggeredCommand = class("DoomBattleSkillTriggeredCommand", BattleCommandBase)

function DoomBattleSkillTriggeredCommand:parseServerCommand(cmdParser, skillTriggeredEventNO)
	local battleFlow = BattleMgr.instance:getActiveBattleFlow()
	local doomLogic = battleFlow.doomLogic
	local doomSkillCode = doomLogic:getDoomSkillId()
	local skillId = skillTriggeredEventNO.code

	if skillId ~= doomSkillCode then
		BattleSkillTriggeredCommand:parseServerCommand(cmdParser, skillTriggeredEventNO)

		return
	end

	if self:_isForecastStage(skillTriggeredEventNO) then
		BattleSkillTriggeredCommand:parseServerCommand(cmdParser, skillTriggeredEventNO)

		return
	end

	local targetEntityIds = doomLogic:getSelectedTargetEntityIds()
	local focusEntityId = targetEntityIds[1] or skillTriggeredEventNO.entity

	cmdParser:addCommand(BattleAdjustFollowCenterCommand:create(focusEntityId, 0))
	BattleSkillTriggeredCommand:parseServerCommandWithoutCheck(cmdParser, skillTriggeredEventNO)
end

function DoomBattleSkillTriggeredCommand:_isForecastStage(skillTriggeredEventNO)
	for _, effectNO in ipairs(skillTriggeredEventNO.effects) do
		for _, eventNO in ipairs(effectNO.events) do
			if BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_doomForecast) then
				return true
			end
		end
	end

	return false
end

return DoomBattleSkillTriggeredCommand
