-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/actioncardhandler/RogueAction_AddCardEntryNextHandler.lua

module("logic.extensions.roguelike.flow.component.handler.actioncardhandler.RogueAction_AddCardEntryNextHandler", package.seeall)

local M = class("RogueAction_AddCardEntryNextHandler", IRogueCardActionHandler)

function M:execAction(judgeHandler, matchCountOrigin, curRoundMatchCount, actionBase)
	local judgeModel = judgeHandler._mgr.flow.judgeModel
	local result, params = judgeModel:getRoleActionAndEffect(judgeModel.RoleActionType.AddCardEntryNext)

	if result then
		local actionCo = judgeModel:getRoleSelectActionCo()
		local count = math.floor(curRoundMatchCount) + actionBase
		local entryId = tonumber(params)

		for i = 1, count do
			RogueMgr.instance:getRogueFlow().stateMgr:addClientNextCardEntry(entryId)
		end

		if count > 0 then
			RogueBroadcastModel.instance:addMoByEntry(entryId, count)
		end

		local msg = string.format(actionCo.effectDesc, count)

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
	end
end

function M:getPredictionValue(actionCo, resultOrigin, diceResultCount, minResultCount, actionBase)
	local judgeModel = RogueMgr.instance:getRogueFlow().judgeModel
	local actionId = actionCo.id
	local result, params = judgeModel:getRoleActionAndEffect(judgeModel.RoleActionType.AddCardEntryNext, actionId)
	local count = math.floor(diceResultCount) + actionBase
	local minCount = math.floor(minResultCount) + actionBase

	count = count == 0 and "?" or count

	return string.format(actionCo.effectDesc, string.format(self._formatText, minCount, count))
end

return M
