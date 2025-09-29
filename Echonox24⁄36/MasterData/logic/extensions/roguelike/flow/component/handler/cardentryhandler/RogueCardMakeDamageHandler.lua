-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/cardentryhandler/RogueCardMakeDamageHandler.lua

module("logic.extensions.roguelike.flow.component.handler.cardentryhandler.RogueCardMakeDamageHandler", package.seeall)

local M = class("RogueCardMakeDamageHandler", IRogueCardEntryHandler)

function M:execEntry(entryCo, judgeHandler)
	local judgeModel = judgeHandler._mgr.flow.judgeModel
	local params = string.split(entryCo.effect, "#")
	local msg = entryCo.desc

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)

	local attackCount = tonumber(params[2])
	local monsterProp = judgeHandler._mgr.flow.model:getCurMonster().monsterProp
	local reduceMonsterHp = attackCount - #judgeHandler._mgr._curRoundCombatDice
	local wallCount = attackCount < #judgeHandler._mgr._curRoundCombatDice and attackCount or #judgeHandler._mgr._curRoundCombatDice

	for i = #judgeHandler._mgr._curRoundCombatDice, #judgeHandler._mgr._curRoundCombatDice - wallCount + 1, -1 do
		local dice2 = judgeHandler._mgr._curRoundCombatDice[i]
		local diceId = judgeHandler:getPlayerMatchDiceId()

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_MATCH_DICE, diceId, dice2:getId(), RoguelikeConst.DICE_MATCH_TYPE.DICE_WALL)
		table.remove(judgeHandler._mgr._curRoundCombatDice, i)
	end

	if monsterProp:getIsHpImmuneAttack() then
		local msg = string.format(RoguelikeConfig.getBroadCast("Monster_Immune_Damage"), monsterProp:getName())

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, false)
	elseif reduceMonsterHp > 0 then
		monsterProp:reduceHp(reduceMonsterHp)

		for k, v in pairs(judgeHandler._mgr._curRoundMatchPlayerDice) do
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_MATCH_DICE, v, nil, RoguelikeConst.DICE_MATCH_TYPE.MONSTER)
		end

		local msg = string.format(RoguelikeConfig.getBroadCast("Role_Attack_Count"), RogueMgr.instance:getModel():getCurRoleMo():getName() .. "[head" .. RogueMgr.instance:getModel():getCurRoleMo():getModelId() .. "|32]", reduceMonsterHp)

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, false)
	end
end

function M:getEffectParam(entryCo)
	local params = string.split(entryCo.effect, "#")

	return {
		2,
		params[1],
		tonumber(params[2])
	}
end

return M
