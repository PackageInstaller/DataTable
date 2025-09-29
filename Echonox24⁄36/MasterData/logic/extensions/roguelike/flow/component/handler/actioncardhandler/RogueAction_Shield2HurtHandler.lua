-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/actioncardhandler/RogueAction_Shield2HurtHandler.lua

module("logic.extensions.roguelike.flow.component.handler.actioncardhandler.RogueAction_Shield2HurtHandler", package.seeall)

local M = class("RogueAction_Shield2HurtHandler", IRogueCardActionHandler)

function M:execAction(judgeHandler, matchCountOrigin, curRoundMatchCount, actionBase)
	local judgeModel = judgeHandler._mgr.flow.judgeModel
	local result, params = judgeModel:getRoleActionAndEffect(judgeModel.RoleActionType.Shield2Hurt)

	if result then
		local actionCo = judgeModel:getRoleSelectActionCo()
		local paramList = string.split(params, "#")
		local param1 = string.gsub(paramList[2], "X", curRoundMatchCount)
		local count1 = TableUtil.strToTable(param1).result

		count1 = tostring(count1) == "inf" and 0 or count1

		local attackCount = math.floor(count1) + actionBase
		local diceCount = tonumber(paramList[1])

		judgeModel:addRoleDiceWall(diceCount)

		local msg = string.format(actionCo.effectDesc, attackCount)

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)

		local effectId = RoguelikeConfig.instance:getConstEffect(paramList[3])

		if effectId and effectId ~= 0 then
			judgeHandler:execClientEffects({
				effectId
			}, attackCount * -1)
		end
	end
end

function M:getPredictionValue(actionCo, resultOrigin, diceResultCount, minResultCount, actionBase)
	local judgeModel = RogueMgr.instance:getRogueFlow().judgeModel
	local actionId = actionCo.id
	local result, params = judgeModel:getRoleActionAndEffect(judgeModel.RoleActionType.Shield2Hurt, actionId)

	if result then
		local paramList = string.split(params, "#")
		local param1 = string.gsub(paramList[2], "X", minResultCount)
		local param2 = string.gsub(paramList[2], "X", diceResultCount)
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
