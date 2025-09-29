-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/actioncardhandler/RogueAction_Attack2HurtHandler.lua

module("logic.extensions.roguelike.flow.component.handler.actioncardhandler.RogueAction_Attack2HurtHandler", package.seeall)

local M = class("RogueAction_Attack2HurtHandler", IRogueCardActionHandler)

function M:execAction(judgeHandler, matchCountOrigin, curRoundMatchCount, actionBase)
	local judgeModel = judgeHandler._mgr.flow.judgeModel
	local result, params = judgeModel:getRoleActionAndEffect(judgeModel.RoleActionType.Attack2Hurt)

	if result then
		local actionCo = judgeModel:getRoleSelectActionCo()
		local paramList = string.split(params, "#")
		local param1 = string.gsub(paramList[2], "X", curRoundMatchCount)
		local count1 = TableUtil.strToTable(param1).result

		count1 = tostring(count1) == "inf" and 0 or count1

		local attackCount = tonumber(paramList[1])
		local hurtCount = math.floor(tonumber(count1)) + actionBase

		if attackCount > 0 then
			local msg1 = string.format(actionCo.effectDesc, hurtCount)

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg1)

			local monsterProp = judgeHandler._mgr.flow.model:getCurMonster().monsterProp
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

			local effectId = RoguelikeConfig.instance:getConstEffect(paramList[3])

			if effectId and effectId ~= 0 then
				local roleId = RogueMgr.instance:getModel():getCurRoleMo():getRoleId()

				judgeHandler:execClientEffects({
					effectId
				}, hurtCount * -1, roleId)
			end
		end
	end
end

function M:getPredictionValue(actionCo, resultOrigin, diceResultCount, minResultCount, actionBase)
	local judgeModel = RogueMgr.instance:getRogueFlow().judgeModel
	local actionId = actionCo.id
	local result, params = judgeModel:getRoleActionAndEffect(judgeModel.RoleActionType.Attack2Hurt, actionId)

	if result then
		local paramList = string.split(params, "#")
		local param1 = string.gsub(paramList[2], "X", diceResultCount)
		local param2 = string.gsub(paramList[2], "X", minResultCount)
		local count1 = TableUtil.strToTable(param1).result
		local count2 = TableUtil.strToTable(param2).result
		local attackCount = count2 + actionBase
		local minCount = count1 + actionBase

		minCount = math.max(0, minCount)
		attackCount = attackCount == 0 and "?" or attackCount

		return string.format(actionCo.effectDesc, string.format(self._formatText, minCount, attackCount))
	end
end

return M
