-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/actioncardhandler/RogueAction_ReduceDiceWallHandler.lua

module("logic.extensions.roguelike.flow.component.handler.actioncardhandler.RogueAction_ReduceDiceWallHandler", package.seeall)

local M = class("RogueAction_ReduceDiceWallHandler", IRogueCardActionHandler)

function M:execAction(judgeHandler, matchCountOrigin, curRoundMatchCount, actionBase)
	local judgeModel = judgeHandler._mgr.flow.judgeModel
	local isReduceDiceWall, reduceParam = judgeModel:getRoleActionIsReduceDiceWall()

	if isReduceDiceWall then
		local actionCo = judgeModel:getRoleSelectActionCo()
		local reduceCount = math.floor(tonumber(reduceParam) * curRoundMatchCount) + actionBase
		local wallCount = reduceCount < #judgeHandler._mgr._curRoundCombatDice and reduceCount or #judgeHandler._mgr._curRoundCombatDice

		if #judgeHandler._mgr._curRoundCombatDice > 0 then
			local msg = string.format(actionCo.effectDesc, wallCount)

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, false)
		end

		for i = #judgeHandler._mgr._curRoundCombatDice, #judgeHandler._mgr._curRoundCombatDice - wallCount + 1, -1 do
			local dice2 = judgeHandler._mgr._curRoundCombatDice[i]

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_MATCH_DICE, judgeHandler:getPlayerMatchDiceId(), dice2:getId(), RoguelikeConst.DICE_MATCH_TYPE.DICE_WALL)
			table.remove(judgeHandler._mgr._curRoundCombatDice, i)
		end
	end
end

function M:getPredictionValue(actionCo, resultOrigin, diceResultCount, minResultCount, actionBase)
	local judgeModel = RogueMgr.instance:getRogueFlow().judgeModel
	local actionId = actionCo.id
	local result, params = judgeModel:getRoleActionAndEffect(judgeModel.RoleActionType.ReduceDiceWall, actionId)

	if result then
		local damageCount = math.floor(tonumber(params) * diceResultCount) + actionBase
		local minCount = math.floor(tonumber(params) * minResultCount) + actionBase

		damageCount = damageCount == 0 and "?" or damageCount

		return string.format(actionCo.effectDesc, string.format(self._formatText, minCount, damageCount))
	end
end

return M
