-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/round/BattleRoundContinue.lua

module("logic.extensions.battle.model.round.BattleRoundContinue", package.seeall)

local BattleRoundContinue = class("BattleRoundContinue", BattleRoundBase)

function BattleRoundContinue:ctor()
	self.roundType = BattleRoundBase.RoundContinue
	self.isRespont = nil
	self.isRetreat = false
end

function BattleRoundContinue:start()
	BattleRoundContinue.super.start(self)
	self:_sendRequest()
end

function BattleRoundContinue:isDone()
	return self.isRespont or BattleModel.instance:hasReceivedResult()
end

function BattleRoundContinue:update(deltaTime)
	return
end

function BattleRoundContinue:_sendRequest()
	if self:isDone() then
		return
	end

	local battleModel = BattleModel.instance
	local battleItemsModel = BattleItemsModel.instance
	local battleId = battleModel:getBattleId()

	if battleModel:getActionMode() ~= GameEnum.ActionModel.NoneAction then
		if not self.isRetreat and battleItemsModel.targetUnits and #battleItemsModel.targetUnits > 0 then
			local targetUnit = battleItemsModel.targetUnits[1]

			BattleAgent.instance:sendPM_DoUserActionReq(battleId, targetUnit.itemId, targetUnit.teamId, targetUnit.targetId)
		else
			BattleAgent.instance:sendPM_ContinueFightReq(battleId, self.isRetreat)
		end
	else
		BattleAgent.instance:sendPM_ContinueFightReq(battleId, self.isRetreat)
	end
end

return BattleRoundContinue
