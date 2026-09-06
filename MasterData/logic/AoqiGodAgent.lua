-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/agent/AoqiGodAgent.lua

module("logic.extensions.aoqigod.agent.AoqiGodAgent", package.seeall)

local AoqiGodAgent = class("AoqiGodAgent", BaseAgent)

function AoqiGodAgent:sendPM_AoqiGodInfoReq(activityId)
	local req = AoqiGodExtension_pb.PM_AoqiGodInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AoqiGodAgent:handlePM_AoqiGodInfoRes(status, msg)
	if status == 0 then
		AoqiGodController.instance:handlePM_AoqiGodInfoRes(msg)
	end
end

function AoqiGodAgent:sendPM_AoqiGodSeekHelpReq(activityId, challengeId, costDiamond, selectItem)
	local req = AoqiGodExtension_pb.PM_AoqiGodSeekHelpReq()

	req.activityId = activityId
	req.challengeId = challengeId
	selectItem = selectItem or {}

	local addOn = AoqiGodExtension_pb.PM_AoqiGodSeekHelpCharmAddOn()
	local hasInfo = checknumber(costDiamond) > 0 or #selectItem > 0

	if checknumber(costDiamond) > 0 then
		addOn.diamondCount = costDiamond
	end

	for _, v in ipairs(selectItem) do
		local flowerInfo = addOn.flowerIdAndCount:add()
		local flowerIdAndCount = CommonStructDef_pb.PM_PairInt()

		flowerIdAndCount.left = v.id
		flowerIdAndCount.right = v.num

		flowerInfo:ParseFromString(flowerIdAndCount:SerializeToString())
	end

	if hasInfo == true then
		req.addOn:ParseFromString(addOn:SerializeToString())
	end

	self:sendMsg(req)
end

function AoqiGodAgent:handlePM_AoqiGodSeekHelpRes(status, msg)
	if status == 0 then
		AoqiGodController.instance:handlePM_AoqiGodSeekHelpRes(msg)
	end
end

function AoqiGodAgent:sendPM_AoqiGodSeekHelpWallReq(activityId)
	local req = AoqiGodExtension_pb.PM_AoqiGodSeekHelpWallReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AoqiGodAgent:handlePM_AoqiGodSeekHelpWallRes(status, msg)
	if status == 0 then
		AoqiGodController.instance:handlePM_AoqiGodSeekHelpWallRes(msg)
	end
end

function AoqiGodAgent:sendPM_AoqiGodRefreshHelpWallReq(activityId, challengeId)
	local req = AoqiGodExtension_pb.PM_AoqiGodRefreshHelpWallReq()

	req.activityId = activityId

	if challengeId then
		req.challengeId = challengeId
	end

	self:sendMsg(req)
end

function AoqiGodAgent:handlePM_AoqiGodRefreshHelpWallRes(status, msg)
	if status == 0 then
		AoqiGodController.instance:handlePM_AoqiGodRefreshHelpWallRes(msg)
	end
end

function AoqiGodAgent:sendPM_AoqiGodSearchSeekHelpItemReq(activityId, searchInfo, searchUserId)
	local req = AoqiGodExtension_pb.PM_AoqiGodSearchSeekHelpItemReq()

	req.activityId = activityId

	if searchInfo then
		req.searchInfo = searchInfo
	end

	if searchUserId then
		req.searchUserId = searchUserId
	end

	self:sendMsg(req)
end

function AoqiGodAgent:handlePM_AoqiGodSearchSeekHelpItemRes(status, msg)
	if status == 0 then
		AoqiGodController.instance:handlePM_AoqiGodSearchSeekHelpItemRes(msg)
	end
end

function AoqiGodAgent:sendPM_AoqiGodGetHelpItemInfoReq(activityId, targetUserId, id)
	local req = AoqiGodExtension_pb.PM_AoqiGodGetHelpItemInfoReq()

	req.activityId = activityId
	req.targetUserId = targetUserId
	req.id = id

	self:sendMsg(req)
end

function AoqiGodAgent:handlePM_AoqiGodGetHelpItemInfoRes(status, msg)
	AoqiGodController.instance:handlePM_AoqiGodGetHelpItemInfoRes(status, msg)
end

function AoqiGodAgent:sendPM_AoqiGodAcceptHelpItemReq(activityId, targetUserId, id)
	local req = AoqiGodExtension_pb.PM_AoqiGodAcceptHelpItemReq()

	req.activityId = activityId
	req.targetUserId = targetUserId
	req.id = id

	self:sendMsg(req)
end

function AoqiGodAgent:handlePM_AoqiGodAcceptHelpItemRes(status, msg)
	if status == 0 then
		AoqiGodController.instance:handlePM_AoqiGodAcceptHelpItemRes(msg)
	end
end

function AoqiGodAgent:sendPM_AoqiGodGiveUpHelpItemReq(activityId, targetUserId, id)
	local req = AoqiGodExtension_pb.PM_AoqiGodGiveUpHelpItemReq()

	req.activityId = activityId
	req.targetUserId = targetUserId
	req.id = id

	self:sendMsg(req)
end

function AoqiGodAgent:handlePM_AoqiGodGiveUpHelpItemRes(status, msg)
	if status == 0 then
		AoqiGodController.instance:handlePM_AoqiGodGiveUpHelpItemRes(msg)
	end
end

function AoqiGodAgent:sendPM_AoqiGodHelpRecordReq(activityId)
	local req = AoqiGodExtension_pb.PM_AoqiGodHelpRecordReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AoqiGodAgent:handlePM_AoqiGodHelpRecordRes(status, msg)
	if status == 0 then
		AoqiGodController.instance:handlePM_AoqiGodHelpRecordRes(msg)
	end
end

function AoqiGodAgent:sendPM_AoqiGodRankReq(activityId)
	local req = AoqiGodExtension_pb.PM_AoqiGodRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AoqiGodAgent:handlePM_AoqiGodRankRes(status, msg)
	if status == 0 then
		AoqiGodController.instance:handlePM_AoqiGodRankRes(msg)
	end
end

function AoqiGodAgent:sendPM_AoqiGodChallengeRankReq(activityId)
	local req = AoqiGodExtension_pb.PM_AoqiGodChallengeRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AoqiGodAgent:handlePM_AoqiGodChallengeRankRes(status, msg)
	if status == 0 then
		AoqiGodController.instance:handlePM_AoqiGodChallengeRankRes(msg)
	end
end

function AoqiGodAgent:handlePM_NotifyAoqiGodChallengeFinishRes(status, msg)
	if status == 0 then
		AoqiGodController.instance:handlePM_NotifyAoqiGodChallengeFinishRes(msg)
	end
end

function AoqiGodAgent:sendPM_AoqiGodChangeBuffSwitchReq(enable)
	local req = AoqiGodExtension_pb.PM_AoqiGodChangeBuffSwitchReq()

	req.enable = checkbool(enable)

	self:sendMsg(req)
end

function AoqiGodAgent:handlePM_AoqiGodChangeBuffSwitchRes(status, msg)
	if status == 0 then
		AoqiGodController.instance:handlePM_AoqiGodChangeBuffSwitchRes(msg)
	end
end

AoqiGodAgent.instance = AoqiGodAgent.New()

return AoqiGodAgent
