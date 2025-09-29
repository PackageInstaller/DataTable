-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/actioncardhandler/RogueAction_AddSanHandler.lua

module("logic.extensions.roguelike.flow.component.handler.actioncardhandler.RogueAction_AddSanHandler", package.seeall)

local M = class("RogueAction_AddSanHandler", IRogueCardActionHandler)

function M:execAction(judgeHandler, matchCountOrigin, curRoundMatchCount, actionBase)
	local judgeModel = judgeHandler._mgr.flow.judgeModel
	local isAddSan = judgeModel:getRoleActionIsAddSan()

	if isAddSan then
		local actionCo = judgeModel:getRoleSelectActionCo()
		local effectIds = judgeModel:getRoleActionEffectId()
		local count = math.floor(curRoundMatchCount) + actionBase

		RoguelikeController.instance:execEffectIds(effectIds, nil, nil, count)

		local msg = string.format(actionCo.effectDesc, count)

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
	end
end

function M:getPredictionValue(actionCo, resultOrigin, diceResultCount, minResultCount, actionBase)
	local judgeModel = RogueMgr.instance:getRogueFlow().judgeModel
	local actionId = actionCo.id
	local result, paramsF = judgeModel:getRoleActionAndEffect(judgeModel.RoleActionType.ReduceSan, actionId)
	local params = string.split(paramsF, "#")
	local count = math.floor(tonumber(params[#params]) * diceResultCount) + actionBase
	local minCount = math.floor(tonumber(params[#params]) * minResultCount) + actionBase

	count = count == 0 and "?" or count

	return string.format(actionCo.effectDesc, string.format(self._formatText, minCount, count))
end

return M
