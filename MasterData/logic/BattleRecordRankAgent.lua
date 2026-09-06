-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/agent/BattleRecordRankAgent.lua

module("logic.extensions.battlerecordrank.agent.BattleRecordRankAgent", package.seeall)

local BattleRecordRankAgent = class("BattleRecordRankAgent", BaseAgent)

function BattleRecordRankAgent:sendPM_BattleRecordGetRankReq(rankKey, startRank, endRank)
	local req = BattleRecordRankExtension_pb.PM_BattleRecordGetRankReq()

	req.rankKey = rankKey
	req.startRank = startRank
	req.endRank = endRank

	self:sendMsg(req)
end

function BattleRecordRankAgent:handlePM_BattleRecordGetRankRes(status, msg)
	if status == 0 then
		BattleRecordRankController.instance:onBattleRanks(msg)
	end
end

function BattleRecordRankAgent:sendPM_BattleRecordGetLatestRecordsReq(rankKey)
	local req = BattleRecordRankExtension_pb.PM_BattleRecordGetLatestRecordsReq()

	req.rankKey = rankKey

	self:sendMsg(req)
end

function BattleRecordRankAgent:handlePM_BattleRecordGetLatestRecordsRes(status, msg)
	if status == 0 then
		BattleRecordRankController.instance:onBattleLatestRecords(msg)
	end
end

function BattleRecordRankAgent:sendPM_BattleRecordGetBattleDetailReq(rankKey, rank)
	local req = BattleRecordRankExtension_pb.PM_BattleRecordGetBattleDetailReq()

	req.rankKey = rankKey
	req.rank = rank

	self:sendMsg(req)
end

function BattleRecordRankAgent:handlePM_BattleRecordGetBattleDetailRes(status, msg)
	if status == 0 then
		BattleRecordRankController.instance:onBattleRecordDetails(msg)
	end
end

function BattleRecordRankAgent:sendPM_BattleRecordGetBattleVideoReq(rankKey, rank)
	local req = BattleRecordRankExtension_pb.PM_BattleRecordGetBattleVideoReq()

	req.rankKey = rankKey
	req.rank = rank

	self:sendMsg(req)
end

function BattleRecordRankAgent:sendPM_BattleRecordGetBattleVideoReq2(rankKey, battleId)
	local req = BattleRecordRankExtension_pb.PM_BattleRecordGetBattleVideoReq()

	req.rankKey = rankKey
	req.battleId = battleId

	self:sendMsg(req)
end

function BattleRecordRankAgent:handlePM_BattleRecordGetBattleVideoRes(status, msg)
	BattleRecordRankController.instance:onBattleRecordVideo(status, msg)
end

function BattleRecordRankAgent:sendPM_SubmitBattleVideoReq(submit)
	local req = BattleRecordRankExtension_pb.PM_SubmitBattleVideoReq()

	req.submit = submit

	self:sendMsg(req)
end

function BattleRecordRankAgent:handlePM_SubmitBattleVideoRes(status, msg)
	if status == 0 then
		printInfo("提交战斗录像成功")
	end
end

BattleRecordRankAgent.instance = BattleRecordRankAgent.New()

return BattleRecordRankAgent
