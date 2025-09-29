-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/actioncardhandler/RogueAction_AttackHandler.lua

module("logic.extensions.roguelike.flow.component.handler.actioncardhandler.RogueAction_AttackHandler", package.seeall)

local M = class("RogueAction_AttackHandler", IRogueCardActionHandler)

function M:execAction(judgeHandler, matchCountOrigin, curRoundMatchCount, actionBase)
	local judgeModel = judgeHandler._mgr.flow.judgeModel
	local isAttack, attackParam = judgeModel:getRoleActionIsTakeDamage()

	if isAttack then
		local attackCount = math.floor(tonumber(attackParam) * curRoundMatchCount) + actionBase
		local monsterProp = judgeHandler._mgr.flow.model:getCurMonster().monsterProp

		RogueBroadcastModel.instance:addMoByHpChange(attackCount, RogueMgr.instance:getModel():getCurRoleMo():getRoleId(), monsterProp:getId(), false)

		local reduceMonsterHp = attackCount - #judgeHandler._mgr._curRoundCombatDice
		local wallCount = attackCount < #judgeHandler._mgr._curRoundCombatDice and attackCount or #judgeHandler._mgr._curRoundCombatDice

		if #judgeHandler._mgr._curRoundCombatDice > 0 then
			local msg = string.format(RoguelikeConfig.getBroadCast("Role_Wall_Neutralize"), wallCount)

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, false)
		end

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
end

function M:getPredictionValue(actionCo, resultOrigin, diceResultCount, minResultCount, actionBase)
	local judgeModel = RogueMgr.instance:getRogueFlow().judgeModel
	local actionId = actionCo.id
	local result, params = judgeModel:getRoleActionAndEffect(judgeModel.RoleActionType.TakeDamage, actionId)
	local result2, params2 = judgeModel:getRoleActionAndEffect(judgeModel.RoleActionType.AddDiceWall, actionId)
	local damageCount = math.floor(tonumber(params) * diceResultCount) + actionBase
	local minCount = math.floor(tonumber(params) * minResultCount) + actionBase

	damageCount = damageCount == 0 and "?" or damageCount

	if result2 then
		local wallCount = math.floor(tonumber(params2) * diceResultCount) + actionBase
		local minCount2 = math.floor(tonumber(params2) * minResultCount) + actionBase

		wallCount = wallCount == 0 and "?" or wallCount

		return string.format(actionCo.effectDesc, string.format(self._formatText, minCount, damageCount), string.format(self._formatText, minCount2, wallCount))
	end

	return string.format(actionCo.effectDesc, string.format(self._formatText, minCount, damageCount))
end

return M
