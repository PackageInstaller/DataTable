-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/agent/BeastRichmanAgent.lua

module("logic.extensions.beastrichman.agent.BeastRichmanAgent", package.seeall)

local BeastRichmanAgent = class("BeastRichmanAgent", BaseAgent)

function BeastRichmanAgent:sendPM_BeastRichManInfoReq(activityId)
	local req = BeastRichManExtension_pb.PM_BeastRichManInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BeastRichmanAgent:handlePM_BeastRichManInfoRes(status, msg)
	if status == 0 then
		BeastRichmanController.instance:handlePM_BeastRichManInfoRes(msg)
	end
end

function BeastRichmanAgent:sendPM_BeastRichManGainDailyPrizeReq(activityId)
	local req = BeastRichManExtension_pb.PM_BeastRichManGainDailyPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BeastRichmanAgent:handlePM_BeastRichManGainDailyPrizeRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId

		BeastRichmanModel.instance:onGainDailyPrizeRes(activityId)
		GlobalDispatcher:dispatch(GlobalNotify.BeastRichManGainDailyPrizeRes)
	end
end

function BeastRichmanAgent:sendPM_BeastRichManMoveReq(activityId, zoneId, diceType, param)
	local req = BeastRichManExtension_pb.PM_BeastRichManMoveReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.diceType = diceType
	req.param = param

	self:sendMsg(req)
end

function BeastRichmanAgent:handlePM_BeastRichManMoveRes(status, msg)
	if status == 0 then
		BeastRichmanController.instance:handlePM_BeastRichManMoveRes(msg)
	end
end

function BeastRichmanAgent:sendPM_BeastRichManHandleGridReq(activityId, zoneId, gridId, param)
	local req = BeastRichManExtension_pb.PM_BeastRichManHandleGridReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.gridId = gridId
	req.param = param

	self:sendMsg(req)
end

function BeastRichmanAgent:handlePM_BeastRichManHandleGridRes(status, msg)
	if status == 0 then
		BeastRichmanController.instance:handlePM_BeastRichManHandleGridRes(msg)
	end
end

function BeastRichmanAgent:sendPM_BeastRichManHandleEventReq(activityId, zoneId, gridId, param)
	local req = BeastRichManExtension_pb.PM_BeastRichManHandleEventReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.gridId = gridId
	req.param = param

	self:sendMsg(req)
end

function BeastRichmanAgent:handlePM_BeastRichManHandleEventRes(status, msg)
	if status == 0 then
		BeastRichmanController.instance:handlePM_BeastRichManHandleEventRes(msg)
	end
end

function BeastRichmanAgent:sendPM_BeastRichManUseCardReq(activityId, cardId)
	local req = BeastRichManExtension_pb.PM_BeastRichManUseCardReq()

	req.activityId = activityId
	req.cardId = cardId

	self:sendMsg(req)
end

function BeastRichmanAgent:handlePM_BeastRichManUseCardRes(status, msg)
	if status == 0 then
		BeastRichmanModel.instance:onUseCardRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BeastRichManUseCardRes)
	end
end

function BeastRichmanAgent:sendPM_BeastRichManFightBeastReq(activityId, zoneId, bossType, bossId, stageId, form)
	local req = BeastRichManExtension_pb.PM_BeastRichManFightBeastReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.bossType = bossType
	req.bossId = bossId

	if stageId then
		req.stageId = stageId
	end

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function BeastRichmanAgent:handlePM_BeastRichManFightBeastRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.BeastRichManFightBeastRes)
	end
end

function BeastRichmanAgent:handlePM_NotifyBeastRichManFightBeastFinishRes(status, msg)
	if status == 0 then
		local bossType = msg.bossType
		local damage = msg.damage

		BeastRichmanModel.instance:onFightBeastFinishRes(msg)

		if BeastRichManEnum.BossType.Boss == bossType then
			local desc = string.format("对敌方精灵造成的总伤害<color=#c54949>%s</color>点", damage)
			local isReach = true

			BattleSettlementController.instance:addConditionElement(desc, isReach)
		end

		GlobalDispatcher:dispatch(GlobalNotify.NotifyBeastRichManFightBeastFinishRes)
	end
end

function BeastRichmanAgent:sendPM_BeastRichManGainHangingReq(activityId)
	local req = BeastRichManExtension_pb.PM_BeastRichManGainHangingReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BeastRichmanAgent:handlePM_BeastRichManGainHangingRes(status, msg)
	if status == 0 then
		BeastRichmanController.instance:handlePM_BeastRichManGainHangingRes(msg)
	end
end

function BeastRichmanAgent:handlePM_BeastRichManScoreChangeRes(status, msg)
	if status == 0 then
		BeastRichmanController.instance:handlePM_BeastRichManScoreChangeRes(msg)
	end
end

function BeastRichmanAgent:sendPM_BeastRichManTotalRankInfoReq(activityId)
	local req = BeastRichManExtension_pb.PM_BeastRichManTotalRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BeastRichmanAgent:handlePM_BeastRichManTotalRankInfoRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local rankInfoList = msg.rankInfoList
		local myRank = msg.myRank

		BeastRichmanModel.instance:onSetRankInfo(activityId, BeastRichManEnum.RankTabType.Total, rankInfoList, myRank)
		GlobalDispatcher:dispatch(GlobalNotify.BeastRichManTotalRankInfoRes)
	end
end

function BeastRichmanAgent:sendPM_BeastRichManSubRankInfoReq(activityId, bossType, bossId)
	local req = BeastRichManExtension_pb.PM_BeastRichManSubRankInfoReq()

	req.activityId = activityId
	req.bossType = bossType
	req.bossId = bossId

	self:sendMsg(req)
end

function BeastRichmanAgent:handlePM_BeastRichManSubRankInfoRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local rankInfoList = msg.rankInfoList
		local myRank = msg.myRank

		BeastRichmanModel.instance:onSetRankInfo(activityId, BeastRichManEnum.RankTabType.Sub, rankInfoList, myRank)
		GlobalDispatcher:dispatch(GlobalNotify.BeastRichManSubRankInfoRes)
	end
end

function BeastRichmanAgent:sendPM_BeastRichManScoreRankInfoReq(activityId)
	local req = BeastRichManExtension_pb.PM_BeastRichManScoreRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BeastRichmanAgent:handlePM_BeastRichManScoreRankInfoRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local rankInfoList = msg.rankInfoList
		local myRank = msg.myRank

		BeastRichmanModel.instance:onSetRankInfo(activityId, BeastRichManEnum.RankTabType.Score, rankInfoList, myRank)
		GlobalDispatcher:dispatch(GlobalNotify.BeastRichManScoreRankInfoRes)
	end
end

function BeastRichmanAgent:sendPM_BeastRichManBeastPrizeInfoReq(activityId)
	local req = BeastRichManExtension_pb.PM_BeastRichManBeastPrizeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BeastRichmanAgent:handlePM_BeastRichManBeastPrizeInfoRes(status, msg)
	if status == 0 then
		BeastRichmanModel.instance:handleGetPrizeInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BeastRichManBeastPrizeInfoRes)
	end
end

function BeastRichmanAgent:sendPM_BeastRichManBeastGainPrizeReq(activityId, prizeId)
	local req = BeastRichManExtension_pb.PM_BeastRichManBeastGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function BeastRichmanAgent:handlePM_BeastRichManBeastGainPrizeRes(status, msg)
	if status == 0 then
		BeastRichmanModel.instance:handleGetCollectPrize(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BeastRichManGainBeastPrizeRes)
	end
end

BeastRichmanAgent.instance = BeastRichmanAgent.New()

return BeastRichmanAgent
