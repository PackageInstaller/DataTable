-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/answerfunc/agent/AnswerProblemUnlockPlotAgent.lua

module("logic.extensions.answerfunc.agent.AnswerProblemUnlockPlotAgent", package.seeall)

local AnswerProblemUnlockPlotAgent = class("AnswerProblemUnlockPlotAgent", BaseAgent)

function AnswerProblemUnlockPlotAgent:sendPM_AnswerProblemUnlockPlotInfoReq(activityId)
	local req = AnswerProblemUnlockPlotExtension_pb.PM_AnswerProblemUnlockPlotInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnswerProblemUnlockPlotAgent:handlePM_AnswerProblemUnlockPlotInfoRes(status, msg)
	if status == 0 then
		AnswerFuncController.instance:scSendAnswerProblemUnlockPlotInfo(msg)
	end
end

function AnswerProblemUnlockPlotAgent:sendPM_AnswerProblemUnlockPlotGainPrizeReq(activityId, onlyId)
	local req = AnswerProblemUnlockPlotExtension_pb.PM_AnswerProblemUnlockPlotGainPrizeReq()

	req.activityId = activityId
	req.onlyId = onlyId

	self:sendMsg(req)
end

function AnswerProblemUnlockPlotAgent:handlePM_AnswerProblemUnlockPlotGainPrizeRes(status, msg)
	if status == 0 then
		AnswerFuncController.instance:scSendAnswerProblemUnlockPlotGainPrize(msg)
	end
end

function AnswerProblemUnlockPlotAgent:sendPM_AnswerProblemUnlockPlotStartAnswerReq(activityId, clientKey)
	local req = AnswerProblemUnlockPlotExtension_pb.PM_AnswerProblemUnlockPlotStartAnswerReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function AnswerProblemUnlockPlotAgent:handlePM_AnswerProblemUnlockPlotStartAnswerRes(status, msg)
	if status == 0 then
		AnswerFuncController.instance:scSendAnswerProblemUnlockPlotStartAnswer(msg)
	end
end

function AnswerProblemUnlockPlotAgent:sendPM_AnswerProblemUnlockPlotAnswerReq(activityId, isRight, curQuestionId, clientEncryptedKey)
	local req = AnswerProblemUnlockPlotExtension_pb.PM_AnswerProblemUnlockPlotAnswerReq()

	req.activityId = activityId
	req.isRight = isRight
	req.curQuestionId = curQuestionId
	req.clientEncryptedKey = clientEncryptedKey

	self:sendMsg(req)
end

function AnswerProblemUnlockPlotAgent:handlePM_AnswerProblemUnlockPlotAnswerRes(status, msg)
	if status == 0 then
		AnswerFuncController.instance:scSendAnswerProblemUnlockPlotAnswer(msg)
	end
end

function AnswerProblemUnlockPlotAgent:sendPM_AnswerProblemUnlockPlotAnswerEndReq(activityId)
	local req = AnswerProblemUnlockPlotExtension_pb.PM_AnswerProblemUnlockPlotAnswerEndReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnswerProblemUnlockPlotAgent:handlePM_AnswerProblemUnlockPlotAnswerEndRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function AnswerProblemUnlockPlotAgent:handlePM_AnswerProblemUnlockPlotResultRes(status, msg)
	if status == 0 then
		AnswerFuncController.instance:scSendAnswerProblemUnlockPlotResult(msg)
	end
end

function AnswerProblemUnlockPlotAgent:sendPM_AnswerProblemSelectTypeReq(activityId, typeId)
	local req = AnswerProblemUnlockPlotExtension_pb.PM_AnswerProblemSelectTypeReq()

	req.activityId = activityId
	req.typeId = typeId

	self:sendMsg(req)
end

function AnswerProblemUnlockPlotAgent:handlePM_AnswerProblemSelectTypeRes(status, msg)
	if status == 0 then
		AnswerFuncController.instance:handlePM_AnswerProblemSelectTypeRes(msg)
	end
end

AnswerProblemUnlockPlotAgent.instance = AnswerProblemUnlockPlotAgent.New()

return AnswerProblemUnlockPlotAgent
