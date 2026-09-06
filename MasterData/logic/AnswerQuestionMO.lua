-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/answerscene/model/AnswerQuestionMO.lua

module("logic.extensions.answerscene.model.AnswerQuestionMO", package.seeall)

local AnswerQuestionMO = class("AnswerQuestionMO")

function AnswerQuestionMO:ctor()
	self.questionId = 0
	self.question = nil
	self.answers = nil
	self.questStartStamp = 0
	self.questEndStamp = 0
	self.hasUseTips = false
end

function AnswerQuestionMO:getStartDeltaTime()
	return self.questStartStamp - ServerTime.now()
end

function AnswerQuestionMO:isDoing()
	local startTime = self.questStartStamp
	local endTime = self.questEndStamp
	local now = ServerTime.now()

	return startTime <= now and now < endTime
end

function AnswerQuestionMO:getEndDeltaTime()
	return self.questEndStamp - ServerTime.now()
end

function AnswerQuestionMO:isPassed()
	return self:getEndDeltaTime() <= 0
end

return AnswerQuestionMO
