-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/agent/BattleAgent.lua

module("logic.extensions.battle.agent.BattleAgent", package.seeall)

local BattleAgent = class("BattleAgent", BaseAgent)

function BattleAgent:handlePM_DoUserActionRes(status, msg)
	BattleItemController.instance:popUseItem(status)
	BattleController.instance:onContinueFightRes()
end

function BattleAgent:sendPM_DoUserActionReq(battleId, battleItemId, teamId, targetId)
	local req = BattleExtension_pb.PM_DoUserActionReq()

	req.battleId = battleId
	req.battleItemId = battleItemId

	local targets = BattlePublicDef_pb.PM_TargetCharacter()

	targets.targetTeamId = teamId
	targets.targetPlayerId = 0
	targets.targetCharacterId = targetId

	table.insert(req.targets, targets)
	self:sendMsg(req)
end

function BattleAgent:handlePM_ContinueFightRes(status, msg)
	if status == 0 then
		BattleController.instance:onContinueFightRes()
	else
		printInfo("错误码:" .. status)
	end
end

function BattleAgent:sendPM_ContinueFightReq(battId, retreat)
	local req = BattleExtension_pb.PM_ContinueFightReq()

	req.battleId = battId
	req.isRetreat = retreat

	self:sendMsg(req)
end

function BattleAgent:handlePM_BtlEndRes(status, msg)
	if status == 0 then
		BattleModel.instance:onBattleResult(msg)
	else
		BattleModel.instance:pushErrorRound(status)
	end
end

function BattleAgent:handlePM_NewRoundsGenRes(status, msg)
	if status == 0 then
		local battid = msg.battleId
		local newroundsresult = msg.newRoundsResult

		BattleModel.instance:pushOneRoundResult(battid, newroundsresult)
	else
		BattleModel.instance:pushErrorRound(status)
	end
end

function BattleAgent:handlePM_BtlStartRes(status, msg)
	if status == 0 then
		BattleController.instance:onBattleStart(msg)
	else
		BattleModel.instance:onBtlStartError(status)
	end
end

function BattleAgent:sendFightSceneMonsterReq(masterId, sceneZoneId)
	local req = BattleExtension_pb.FightSceneMonsterReq()

	req.masterId = masterId
	req.sceneZoneId = sceneZoneId

	self:sendMsg(req)
end

function BattleAgent:handleFightSceneMonsterRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
end

function BattleAgent:showChangeSet(changeSetId, name)
	if name == "handleFightSceneMonsterRes" then
		printInfo("野外战斗设置changeSetId", changeSetId)
		BattleSettlementModel.instance:setChangeSetId(changeSetId)
	else
		BattleAgent.super.showChangeSet(self, changeSetId, name)
	end
end

function BattleAgent:sendPM_GetMutatedSceneInfoReq()
	local req = BattleExtension_pb.PM_GetMutatedSceneInfoReq()

	self:sendMsg(req)
end

function BattleAgent:handlePM_GetMutatedSceneInfoRes(status, msg)
	if status == 0 then
		local scenezoneid = msg.sceneZoneId

		GlobalDispatcher:dispatch(GlobalNotify.GetMonCaptureScene, scenezoneid)
	end
end

function BattleAgent:handlePM_NotifyCatchSourcemonRes(status, msg)
	if status == 0 then
		local monsterid = msg.monsterId

		BattleItemsModel.instance:forbidPushCatchUnits()

		if monsterid ~= -1 then
			local catchedSourcemons = msg.catchedSourcemons

			BattleItemsModel.instance:pushCatchedSourcemons(catchedSourcemons)
			CityController.instance:removeMonster(BattleModel.instance.monsterZoneId, monsterid)
		end
	end
end

function BattleAgent:sendPM_SkipReq(battleId)
	local req = BattleExtension_pb.PM_SkipReq()

	req.battleId = battleId

	self:sendMsg(req)
end

function BattleAgent:handlePM_SkipRes(status, msg)
	if status == 0 then
		BattleController.instance:onContinueFightRes()
	end
end

BattleAgent.instance = BattleAgent.New()

return BattleAgent
