-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/actioncardhandler/RogueAction_Shield2CoinHandler.lua

module("logic.extensions.roguelike.flow.component.handler.actioncardhandler.RogueAction_Shield2CoinHandler", package.seeall)

local M = class("RogueAction_Shield2CoinHandler", IRogueCardActionHandler)

function M:execAction(judgeHandler, matchCountOrigin, curRoundMatchCount, actionBase)
	local judgeModel = judgeHandler._mgr.flow.judgeModel
	local result, params = judgeModel:getRoleActionAndEffect(judgeModel.RoleActionType.Shield2Coin)

	if result then
		local actionCo = judgeModel:getRoleSelectActionCo()
		local paramList = string.split(params, "#")
		local param1 = string.gsub(paramList[1], "X", curRoundMatchCount)
		local diceWall = judgeModel:getRoleDiceWall()

		param1 = string.gsub(param1, "F", diceWall)

		local count1 = TableUtil.strToTable(param1).result

		count1 = tostring(count1) == "inf" and 0 or count1

		local attackCount = math.floor(tonumber(count1)) + actionBase

		if attackCount > 0 then
			judgeModel:setRoleDiceWall(0)
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_ROLE_DICE_WALL, 0)

			local msg = string.format(actionCo.effectDesc, attackCount)

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
		end

		local effectId = RoguelikeConfig.instance:getConstEffect(paramList[2])

		if effectId and effectId ~= 0 then
			judgeHandler:execClientEffects({
				effectId
			}, attackCount)
		end

		RogueMgr.instance:getRogueFlow().judgeMgr:clearRoleDiceWall()
	end
end

function M:getPredictionValue(actionCo, resultOrigin, diceResultCount, minResultCount, actionBase)
	local judgeModel = RogueMgr.instance:getRogueFlow().judgeModel
	local actionId = actionCo.id
	local result, params = judgeModel:getRoleActionAndEffect(judgeModel.RoleActionType.Shield2Coin, actionId)

	if result then
		local paramList = string.split(params, "#")
		local param1 = string.gsub(paramList[1], "X", diceResultCount)
		local param2 = string.gsub(paramList[1], "X", minResultCount)
		local diceWall = judgeModel:getRoleDiceWall()

		param1 = string.gsub(param1, "F", diceWall)
		param2 = string.gsub(param2, "F", diceWall)

		local count1 = TableUtil.strToTable(param1).result
		local count2 = TableUtil.strToTable(param2).result

		count1 = tostring(count1) == "inf" and 0 or count1
		count2 = tostring(count2) == "inf" and 0 or count2

		local attackCount = math.floor(count1) + actionBase
		local minCount = math.floor(count2) + actionBase

		minCount = math.max(0, minCount)
		attackCount = attackCount == 0 and "?" or attackCount

		local countStr = attackCount == minCount and minCount or string.format(self._formatText, minCount, attackCount)

		return string.format(actionCo.effectDesc, countStr)
	end
end

return M
