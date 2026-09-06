-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/agent/AoQiAttackForceAgent.lua

module("logic.extensions.aoqiattackforce.agent.AoQiAttackForceAgent", package.seeall)

local AoQiAttackForceAgent = class("AoQiAttackForceAgent", BaseAgent)

function AoQiAttackForceAgent:sendPM_AoQiAttackForceInfoReq(activityId)
	local req = AoQiAttackForceExtension_pb.PM_AoQiAttackForceInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AoQiAttackForceAgent:handlePM_AoQiAttackForceInfoRes(status, msg)
	if status == 0 then
		AoQiAttackForceController.instance:handleGetInfo(msg)
	end
end

function AoQiAttackForceAgent:sendPM_AoQiAttackForceSetEquipmentReq(activityId, equipmentId, isUse)
	local req = AoQiAttackForceExtension_pb.PM_AoQiAttackForceSetEquipmentReq()

	req.activityId = activityId
	req.equipmentId = equipmentId
	req.isUse = isUse

	self:sendMsg(req)
end

function AoQiAttackForceAgent:handlePM_AoQiAttackForceSetEquipmentRes(status, msg)
	if status == 0 then
		AoQiAttackForceController.instance:handleAdjustEquipment(msg)
	end
end

function AoQiAttackForceAgent:sendPM_AoQiAttackForceChallengeStartGameReq(activityId, challengeId, clientKey)
	local req = AoQiAttackForceExtension_pb.PM_AoQiAttackForceChallengeStartGameReq()

	req.activityId = activityId
	req.challengeId = challengeId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function AoQiAttackForceAgent:handlePM_AoQiAttackForceChallengeStartGameRes(status, msg)
	if status == 0 then
		AoQiAttackForceController.instance:handleStartGame(msg)
	end
end

function AoQiAttackForceAgent:sendPM_AoQiAttackForceChallengeEndGameReq(activityId, challengeId, waveId, goldNum, encryptedKey, upgradeEquipmentTimes)
	local req = AoQiAttackForceExtension_pb.PM_AoQiAttackForceChallengeEndGameReq()

	req.activityId = activityId
	req.challengeId = challengeId
	req.waveId = waveId
	req.goldNum = goldNum
	req.encryptedKey = encryptedKey
	req.upgradeEquipmentTimes = upgradeEquipmentTimes

	self:sendMsg(req)
end

function AoQiAttackForceAgent:handlePM_AoQiAttackForceChallengeEndGameRes(status, msg)
	if status == 0 then
		AoQiAttackForceController.instance:handleEndClg(msg)
	end
end

function AoQiAttackForceAgent:sendPM_AoQiAttackForceChallengeSweepReq(activityId, challengeId)
	local req = AoQiAttackForceExtension_pb.PM_AoQiAttackForceChallengeSweepReq()

	req.activityId = activityId
	req.challengeId = challengeId

	self:sendMsg(req)
end

function AoQiAttackForceAgent:handlePM_AoQiAttackForceChallengeSweepRes(status, msg)
	if status == 0 then
		AoQiAttackForceController.instance:handleSweepClg(msg)
	end
end

function AoQiAttackForceAgent:sendPM_AoQiAttackForceEndlessStartGameReq(activityId, clientKey)
	local req = AoQiAttackForceExtension_pb.PM_AoQiAttackForceEndlessStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function AoQiAttackForceAgent:handlePM_AoQiAttackForceEndlessStartGameRes(status, msg)
	if status == 0 then
		AoQiAttackForceController.instance:handleFinalClg(msg)
	end
end

function AoQiAttackForceAgent:sendPM_AoQiAttackForceEndlessEndGameReq(activityId, killNum, goldNum, encryptedKey, upgradeEquipmentTimes)
	local req = AoQiAttackForceExtension_pb.PM_AoQiAttackForceEndlessEndGameReq()

	req.activityId = activityId
	req.killNum = killNum
	req.goldNum = goldNum
	req.encryptedKey = encryptedKey
	req.upgradeEquipmentTimes = upgradeEquipmentTimes

	self:sendMsg(req)
end

function AoQiAttackForceAgent:handlePM_AoQiAttackForceEndlessEndGameRes(status, msg)
	if status == 0 then
		AoQiAttackForceController.instance:handleEndFinalClg()
	end
end

function AoQiAttackForceAgent:sendPM_AoQiAttackForceUpgradeEquipmentReq(activityId, equipmentId)
	local req = AoQiAttackForceExtension_pb.PM_AoQiAttackForceUpgradeEquipmentReq()

	req.activityId = activityId
	req.equipmentId = equipmentId

	self:sendMsg(req)
end

function AoQiAttackForceAgent:handlePM_AoQiAttackForceUpgradeEquipmentRes(status, msg)
	if status == 0 then
		AoQiAttackForceController.instance:handleUpgradeEquipment(msg)
	end
end

function AoQiAttackForceAgent:sendPM_AoQiAttackForceRankInfoReq(activityId)
	local req = AoQiAttackForceExtension_pb.PM_AoQiAttackForceRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AoQiAttackForceAgent:handlePM_AoQiAttackForceRankInfoRes(status, msg)
	if status == 0 then
		AoQiAttackForceController.instance:handleGetRankInfo(msg)
	end
end

function AoQiAttackForceAgent:sendPM_AoQiAttackForceHeroChallengeStartGameReq(activityId, clientKey)
	local req = AoQiAttackForceExtension_pb.PM_AoQiAttackForceHeroChallengeStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function AoQiAttackForceAgent:handlePM_AoQiAttackForceHeroChallengeStartGameRes(status, msg)
	if status == 0 then
		AoQiAttackForceController.instance:handleHeroClg(msg)
	end
end

function AoQiAttackForceAgent:sendPM_AoQiAttackForceHeroChallengeEndGameReq(activityId, waveId, goldNum, killNum, encryptedKey, upgradeEquipmentTimes)
	local req = AoQiAttackForceExtension_pb.PM_AoQiAttackForceHeroChallengeEndGameReq()

	req.activityId = activityId
	req.waveId = waveId
	req.killNum = killNum
	req.goldNum = goldNum
	req.encryptedKey = encryptedKey
	req.upgradeEquipmentTimes = upgradeEquipmentTimes

	self:sendMsg(req)
end

function AoQiAttackForceAgent:handlePM_AoQiAttackForceHeroChallengeEndGameRes(status, msg)
	if status == 0 then
		AoQiAttackForceController.instance:handleEndHeroClg(msg)
	end
end

function AoQiAttackForceAgent:sendPM_AoQiAttackForceHeroChallengeSweepReq(activityId)
	local req = AoQiAttackForceExtension_pb.PM_AoQiAttackForceHeroChallengeSweepReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AoQiAttackForceAgent:handlePM_AoQiAttackForceHeroChallengeSweepRes(status, msg)
	if status == 0 then
		AoQiAttackForceController.instance:handleHeroSweepClg(msg)
	end
end

function AoQiAttackForceAgent:sendPM_AoQiAttackForceHeroRankInfoReq(activityId)
	local req = AoQiAttackForceExtension_pb.PM_AoQiAttackForceHeroRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AoQiAttackForceAgent:handlePM_AoQiAttackForceHeroRankInfoRes(status, msg)
	if status == 0 then
		AoQiAttackForceController.instance:handleGetHeroRankInfo(msg)
	end
end

AoQiAttackForceAgent.instance = AoQiAttackForceAgent.New()

return AoQiAttackForceAgent
