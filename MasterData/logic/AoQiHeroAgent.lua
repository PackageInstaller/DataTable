-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/agent/AoQiHeroAgent.lua

module("logic.extensions.aoqihero.agent.AoQiHeroAgent", package.seeall)

local AoQiHeroAgent = class("AoQiHeroAgent", BaseAgent)

function AoQiHeroAgent:sendPM_AoQiHeroInfoReq(activityId)
	local req = AoQiHeroExtension_pb.PM_AoQiHeroInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AoQiHeroAgent:handlePM_AoQiHeroInfoRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_AoQiHeroInfoRes(msg)
	end
end

function AoQiHeroAgent:sendPM_AoQiHeroRankInfoReq(activityId, typeId)
	local req = AoQiHeroExtension_pb.PM_AoQiHeroRankInfoReq()

	req.activityId = activityId
	req.typeId = typeId

	self:sendMsg(req)
end

function AoQiHeroAgent:handlePM_AoQiHeroRankInfoRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_AoQiHeroRankInfoRes(msg)
	end
end

function AoQiHeroAgent:sendPM_AoQiHeroUnlockPetReq(activityId, raceId)
	local req = AoQiHeroExtension_pb.PM_AoQiHeroUnlockPetReq()

	req.activityId = activityId
	req.raceId = raceId

	self:sendMsg(req)
end

function AoQiHeroAgent:handlePM_AoQiHeroUnlockPetRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_AoQiHeroUnlockPetRes(msg)
	end
end

function AoQiHeroAgent:sendPM_AoQiHeroUpgradePositionReq(activityId, posId)
	local req = AoQiHeroExtension_pb.PM_AoQiHeroUpgradePositionReq()

	req.activityId = activityId
	req.posId = posId

	self:sendMsg(req)
end

function AoQiHeroAgent:handlePM_AoQiHeroUpgradePositionRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_AoQiHeroUpgradePositionRes(msg)
	end
end

function AoQiHeroAgent:sendPM_AoQiHeroCardListReq(activityId)
	local req = AoQiHeroExtension_pb.PM_AoQiHeroCardListReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AoQiHeroAgent:handlePM_AoQiHeroCardListRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_AoQiHeroCardListRes(msg)
	end
end

function AoQiHeroAgent:sendPM_AoQiHeroSetCardListReq(activityId, raceIds)
	local req = AoQiHeroExtension_pb.PM_AoQiHeroSetCardListReq()

	req.activityId = activityId

	for i, v1 in ipairs(raceIds) do
		req.raceIds:append(v1)
	end

	self:sendMsg(req)
end

function AoQiHeroAgent:handlePM_AoQiHeroSetCardListRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_AoQiHeroSetCardListRes(msg)
	end
end

function AoQiHeroAgent:sendPM_AoQiHeroNormalChallengeReq(activityId, stageId, raceIds)
	local req = AoQiHeroExtension_pb.PM_AoQiHeroNormalChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	for i, v1 in ipairs(raceIds) do
		req.raceIds:append(v1)
	end

	self:sendMsg(req)
end

function AoQiHeroAgent:handlePM_AoQiHeroNormalChallengeRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_AoQiHeroNormalChallengeRes(msg)
	end
end

function AoQiHeroAgent:handlePM_NotifyAoQiHeroNormalChallengeEndRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_NotifyAoQiHeroNormalChallengeEndRes(msg)
	end
end

function AoQiHeroAgent:sendPM_AoQiHeroEndlessChallengeReq(activityId, stageId, raceIds)
	local req = AoQiHeroExtension_pb.PM_AoQiHeroEndlessChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	for i, v1 in ipairs(raceIds) do
		req.raceIds:append(v1)
	end

	self:sendMsg(req)
end

function AoQiHeroAgent:handlePM_AoQiHeroEndlessChallengeRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_AoQiHeroEndlessChallengeRes(msg)
	end
end

function AoQiHeroAgent:handlePM_NotifyAoQiHeroEndlessChallengeEndRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_NotifyAoQiHeroEndlessChallengeEndRes(msg)
	end
end

function AoQiHeroAgent:sendPM_AoQiHeroEndlessGainPrizeReq(activityId, prizeId)
	local req = AoQiHeroExtension_pb.PM_AoQiHeroEndlessGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function AoQiHeroAgent:handlePM_AoQiHeroEndlessGainPrizeRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_AoQiHeroEndlessGainPrizeRes(msg)
	end
end

function AoQiHeroAgent:sendPM_AoQiHeroPvPRecordReq(activityId)
	local req = AoQiHeroExtension_pb.PM_AoQiHeroPvPRecordReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AoQiHeroAgent:handlePM_AoQiHeroPvPRecordRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_AoQiHeroPvPRecordRes(msg)
	end
end

function AoQiHeroAgent:sendPM_AoQiHeroPvPSetDefFormationReq(activityId, items, creepsMasterId)
	local req = AoQiHeroExtension_pb.PM_AoQiHeroPvPSetDefFormationReq()

	req.activityId = activityId
	req.creepsMasterId = creepsMasterId

	for i, v in ipairs(items) do
		local itemViews = req.items:add()

		itemViews:ParseFromString(v:SerializeToString())
	end

	self:sendMsg(req)
end

function AoQiHeroAgent:handlePM_AoQiHeroPvPSetDefFormationRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_AoQiHeroPvPSetDefFormationRes(msg)
	end
end

function AoQiHeroAgent:sendPM_AoQiHeroPvPMatchReq(activityId)
	local req = AoQiHeroExtension_pb.PM_AoQiHeroPvPMatchReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AoQiHeroAgent:handlePM_AoQiHeroPvPMatchRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function AoQiHeroAgent:sendPM_AoQiHeroPvPCancelMatchReq()
	local req = AoQiHeroExtension_pb.PM_AoQiHeroPvPCancelMatchReq()

	self:sendMsg(req)
end

function AoQiHeroAgent:handlePM_AoQiHeroPvPCancelMatchRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_AoQiHeroPvPCancelMatchRes(msg)
	end
end

function AoQiHeroAgent:handlePM_NotifyAoQiHeroPvPMailFailRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_NotifyAoQiHeroPvPMailFailRes(msg)
	end
end

function AoQiHeroAgent:handlePM_NotifyAoQiHeroPvpGameStartRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_NotifyAoQiHeroPvpGameStartRes(msg)
	end
end

function AoQiHeroAgent:sendPM_AoQiHeroPvPLeaveRoomReq()
	local req = AoQiHeroExtension_pb.PM_AoQiHeroPvPLeaveRoomReq()

	self:sendMsg(req)
end

function AoQiHeroAgent:handlePM_AoQiHeroPvPLeaveRoomRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_AoQiHeroPvPLeaveRoomRes(msg)
	end
end

function AoQiHeroAgent:sendPM_AoQiHeroPvPFightStartReq(activityId, raceIds)
	local req = AoQiHeroExtension_pb.PM_AoQiHeroPvPFightStartReq()

	req.activityId = activityId

	for i, v in ipairs(raceIds) do
		req.raceIds:append(v)
	end

	self:sendMsg(req)
end

function AoQiHeroAgent:handlePM_AoQiHeroPvPFightStartRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_AoQiHeroPvPFightStartRes(msg)
	end
end

function AoQiHeroAgent:handlePM_NotifyAoQiHeroPvPFightEndRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function AoQiHeroAgent:handlePM_NotifyAoQiHeroPvPRoomEndRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_NotifyAoQiHeroPvPRoomEndRes(msg)
	end
end

function AoQiHeroAgent:sendPM_AoQiHeroBattleStartReq(actionId, clientKey, raceIds, myMaxHp, myLeftHp, enemyCharacters)
	local req = AoQiHeroExtension_pb.PM_AoQiHeroBattleStartReq()

	req.actionId = actionId
	req.clientKey = clientKey

	for i, v in ipairs(raceIds) do
		req.raceIds:append(v)
	end

	req.myMaxHp = myMaxHp
	req.myLeftHp = myLeftHp

	for i, v in ipairs(enemyCharacters) do
		local view = req.enemyCharacters:add()

		view:ParseFromString(v:SerializeToString())
	end

	self:sendMsg(req)
end

function AoQiHeroAgent:handlePM_AoQiHeroBattleStartRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_AoQiHeroBattleStartRes(msg)
	end
end

function AoQiHeroAgent:sendPM_AoQiHeroSyncBattleReq(actionId, encryptedKey, isWin, oneCircle)
	local req = AoQiHeroExtension_pb.PM_AoQiHeroSyncBattleReq()

	req.actionId = actionId
	req.encryptedKey = encryptedKey

	if isWin ~= nil then
		req.isWin = isWin
	end

	req.oneCircle:ParseFromString(oneCircle:SerializeToString())
	self:sendMsg(req)
end

function AoQiHeroAgent:handlePM_AoQiHeroSyncBattleRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_AoQiHeroSyncBattleRes(msg)
	end
end

function AoQiHeroAgent:handlePM_NotifyAoQiHeroBattleReadyStart(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_NotifyAoQiHeroBattleReadyStart(msg)
	end
end

function AoQiHeroAgent:sendPM_AoQiHeroGainDailyPrizeReq(activityId)
	local req = AoQiHeroExtension_pb.PM_AoQiHeroGainDailyPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AoQiHeroAgent:handlePM_AoQiHeroGainDailyPrizeRes(status, msg)
	if status == 0 then
		AoQiHeroController.instance:handlePM_AoQiHeroGainDailyPrizeRes(msg)
	end
end

AoQiHeroAgent.instance = AoQiHeroAgent.New()

return AoQiHeroAgent
