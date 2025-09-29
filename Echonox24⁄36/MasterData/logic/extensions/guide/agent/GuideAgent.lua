-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/agent/GuideAgent.lua

module("logic.extensions.guide.agent.GuideAgent", package.seeall)

local GuideAgent = class("GuideAgent", BaseAgent)

function GuideAgent:ctor()
	return
end

function GuideAgent:sendGetGuideInfoRequest()
	local msg = NewbieExtension_pb.GetGuideInfoRequest()

	self:sendMsg(msg)
end

function GuideAgent:handleGetGuideInfoReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.LOAD_GUIDE_DATA_FINISH)
		GuideModel.instance:initGuide(msg.finished)
		GuideController.instance:initGuide()

		if ViewMgr.instance:isOpen(ViewName.MainUIView) then
			GuideController.instance:_onTriggerGuide()
		end
	end
end

function GuideAgent:sendFinishGuideRequest(code, finishType, lastStepId)
	local msg = NewbieExtension_pb.FinishGuideRequest()

	msg.code = code

	self:sendMsg(msg)
end

function GuideAgent:handleFinishGuideReply(status, msg)
	return
end

function GuideAgent:handleStartGuideReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function GuideAgent:sendSetPlotAnswersRequest(plotAnswers)
	local req = NewbieExtension_pb.SetPlotAnswersRequest()

	for k, v in pairs(plotAnswers) do
		local answer = NewbieExtension_pb.PlotAnswerNO()

		answer.question = k

		table.insert(answer.answer, v)
		table.insert(req.answers, answer)
		GuideModel.instance:addPlotAnswers(k, {
			v
		})
	end

	self:sendMsg(req)
end

function GuideAgent:handleSetPlotAnswersReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.ON_SET_PLOT_ANSWERS_REPLY)
	end
end

function GuideAgent:sendGetPlotAnswersRequest()
	local req = NewbieExtension_pb.GetPlotAnswersRequest()

	self:sendMsg(req)
end

function GuideAgent:handleGetPlotAnswersReply(status, msg)
	if status == 0 then
		GuideModel.instance:initPlotAnswers(msg.answers)
	end
end

function GuideAgent:sendJumpPlotRequest(code, type)
	local req = NewbieExtension_pb.JumpPlotRequest()

	req.code = tostring(code)
	req.type = type

	self:sendMsg(req)
end

function GuideAgent:handleJumpPlotReply(status, msg)
	return
end

GuideAgent.instance = GuideAgent.New()

return GuideAgent
