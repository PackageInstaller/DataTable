-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/agent/BoccaccioChapterAgent.lua

module("logic.extensions.boccacciochapter.agent.BoccaccioChapterAgent", package.seeall)

local BoccaccioChapterAgent = class("BoccaccioChapterAgent", BaseAgent)

function BoccaccioChapterAgent:sendPM_BoccaccioChapterInfoReq(activityId)
	local req = BoccaccioChapterExtension_pb.PM_BoccaccioChapterInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BoccaccioChapterAgent:handlePM_BoccaccioChapterInfoRes(status, msg)
	BoccaccioChapterController.instance:handlePM_BoccaccioChapterInfoRes(status, msg)
end

function BoccaccioChapterAgent:sendPM_BoccaccioChapter1ClgReq(activityId, stageId, form)
	local req = BoccaccioChapterExtension_pb.PM_BoccaccioChapter1ClgReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function BoccaccioChapterAgent:sendPM_BoccaccioChapter2ClgReq(activityId, storyId, stageId, form)
	local req = BoccaccioChapterExtension_pb.PM_BoccaccioChapter2ClgReq()

	req.activityId = activityId
	req.storyId = storyId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function BoccaccioChapterAgent:sendPM_BoccaccioChapter3ClgReq(activityId, stageId, form, signUpBuff)
	local req = BoccaccioChapterExtension_pb.PM_BoccaccioChapter3ClgReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.signUpBuff = signUpBuff

	self:sendMsg(req)
end

function BoccaccioChapterAgent:sendPM_BoccaccioChapter4ClgReq(activityId, form, isTrail)
	local req = BoccaccioChapterExtension_pb.PM_BoccaccioChapter4ClgReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.isTrail = isTrail

	self:sendMsg(req)
end

function BoccaccioChapterAgent:handlePM_BoccaccioChapterClgRes(status, msg)
	if status == 0 then
		BoccaccioChapterController.instance:handlePM_BoccaccioChapterClgRes(msg)
	end
end

function BoccaccioChapterAgent:sendPM_BoccaccioChapterOneClickGainProgressPrizeReq(activityId, chapter)
	local req = BoccaccioChapterExtension_pb.PM_BoccaccioChapterOneClickGainProgressPrizeReq()

	req.activityId = activityId
	req.chapter = chapter

	self:sendMsg(req)
end

function BoccaccioChapterAgent:handlePM_BoccaccioChapterOneClickGainProgressPrizeRes(status, msg)
	if status == 0 then
		BoccaccioChapterController.instance:handlePM_BoccaccioChapterOneClickGainProgressPrizeRes(msg)
	end
end

function BoccaccioChapterAgent:sendPM_BoccaccioChapter2RecoverySequenceReq(activityId, storyId)
	local req = BoccaccioChapterExtension_pb.PM_BoccaccioChapter2RecoverySequenceReq()

	req.activityId = activityId
	req.storyId = storyId

	self:sendMsg(req)
end

function BoccaccioChapterAgent:handlePM_BoccaccioChapter2RecoverySequenceRes(status, msg)
	if status == 0 then
		BoccaccioChapterController.instance:handlePM_BoccaccioChapter2RecoverySequenceRes(msg)
	end
end

function BoccaccioChapterAgent:sendPM_BoccaccioChapter2FindErrorWordReq(activityId, storyId, errorWordId)
	local req = BoccaccioChapterExtension_pb.PM_BoccaccioChapter2FindErrorWordReq()

	req.activityId = activityId
	req.storyId = storyId
	req.errorWordId = errorWordId

	self:sendMsg(req)
end

function BoccaccioChapterAgent:handlePM_BoccaccioChapter2FindErrorWordRes(status, msg)
	if status == 0 then
		BoccaccioChapterController.instance:handlePM_BoccaccioChapter2FindErrorWordRes(msg)
	end
end

function BoccaccioChapterAgent:sendPM_BoccaccioChapter2ReplaceWordReq(activityId, storyId, errorWordId)
	local req = BoccaccioChapterExtension_pb.PM_BoccaccioChapter2ReplaceWordReq()

	req.activityId = activityId
	req.storyId = storyId
	req.errorWordId = errorWordId

	self:sendMsg(req)
end

function BoccaccioChapterAgent:handlePM_BoccaccioChapter2ReplaceWordRes(status, msg)
	if status == 0 then
		BoccaccioChapterController.instance:handlePM_BoccaccioChapter2ReplaceWordRes(msg)
	end
end

function BoccaccioChapterAgent:sendPM_BoccaccioChapter3SignUpReq(activityId)
	local req = BoccaccioChapterExtension_pb.PM_BoccaccioChapter3SignUpReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BoccaccioChapterAgent:handlePM_BoccaccioChapter3SignUpRes(status, msg)
	if status == 0 then
		BoccaccioChapterController.instance:handlePM_BoccaccioChapter3SignUpRes(msg)
	end
end

function BoccaccioChapterAgent:sendPM_BoccaccioChapter3SaveClgReq(activityId, isSave)
	local req = BoccaccioChapterExtension_pb.PM_BoccaccioChapter3SaveClgReq()

	req.activityId = activityId
	req.isSave = isSave

	self:sendMsg(req)
end

function BoccaccioChapterAgent:handlePM_BoccaccioChapter3SaveClgRes(status, msg)
	if status == 0 then
		BoccaccioChapterController.instance:handlePM_BoccaccioChapter3SaveClgRes(msg)
	end
end

function BoccaccioChapterAgent:sendPM_BoccaccioChapter4RankViewReq(activityId)
	local req = BoccaccioChapterExtension_pb.PM_BoccaccioChapter4RankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BoccaccioChapterAgent:handlePM_BoccaccioChapter4RankViewRes(status, msg)
	if status == 0 then
		BoccaccioChapterController.instance:handlePM_BoccaccioChapter4RankViewRes(msg)
	end
end

function BoccaccioChapterAgent:sendPM_BoccaccioChapterFirstClickReq(activityId, chapterId)
	local req = BoccaccioChapterExtension_pb.PM_BoccaccioChapterFirstClickReq()

	req.activityId = activityId
	req.chapterId = chapterId

	self:sendMsg(req)
end

function BoccaccioChapterAgent:handlePM_BoccaccioChapterFirstClickRes(status, msg)
	if status == 0 then
		BoccaccioChapterController.instance:handlePM_BoccaccioChapterFirstClickRes(msg)
	end
end

function BoccaccioChapterAgent:handlePM_BoccaccioChapter1NotifyClgRes(status, msg)
	if status == 0 then
		BoccaccioChapterController.instance:handlePM_BoccaccioChapter1NotifyClgRes(msg)
	end
end

function BoccaccioChapterAgent:handlePM_BoccaccioChapter2NotifyClgRes(status, msg)
	if status == 0 then
		BoccaccioChapterController.instance:handlePM_BoccaccioChapter2NotifyClgRes(msg)
	end
end

function BoccaccioChapterAgent:handlePM_BoccaccioChapter3NotifyClgRes(status, msg)
	if status == 0 then
		BoccaccioChapterController.instance:handlePM_BoccaccioChapter3NotifyClgRes(msg)
	end
end

function BoccaccioChapterAgent:handlePM_BoccaccioChapter4NotifyClgRes(status, msg)
	if status == 0 then
		BoccaccioChapterController.instance:handlePM_BoccaccioChapter4NotifyClgRes(msg)
	end
end

function BoccaccioChapterAgent:sendPM_BoccaccioChapterUnlockPlotReq(activityId, plotId)
	local req = BoccaccioChapterExtension_pb.PM_BoccaccioChapterUnlockPlotReq()

	req.activityId = activityId
	req.plotId = plotId

	self:sendMsg(req)
end

function BoccaccioChapterAgent:handlePM_BoccaccioChapterUnlockPlotRes(status, msg)
	if status == 0 then
		BoccaccioChapterController.instance:handlePM_BoccaccioChapterUnlockPlotRes(msg)
	end
end

BoccaccioChapterAgent.instance = BoccaccioChapterAgent.New()

return BoccaccioChapterAgent
