-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/answerscene/model/AnswerResultMO.lua

module("logic.extensions.answerscene.model.AnswerResultMO", package.seeall)

local AnswerResultMO = class("AnswerResultMO")

function AnswerResultMO:ctor()
	self.isRight = false
	self.questionId = 0
	self.answerIndex = 0
	self.addScores = 0
	self.isFinish = false
	self.report = nil
	self.scoreChangeSetId = nil
	self.changeSetId = nil
end

return AnswerResultMO
