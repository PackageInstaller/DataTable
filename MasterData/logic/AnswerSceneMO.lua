-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/answerscene/model/AnswerSceneMO.lua

module("logic.extensions.answerscene.model.AnswerSceneMO", package.seeall)

local AnswerSceneMO = class("AnswerSceneMO")

AnswerSceneMO.HelpType_ExceptError = 1
AnswerSceneMO.HelpType_Tips = 2

function AnswerSceneMO:ctor()
	self.questionList = nil
	self.questStartStamp = 0
	self.nextQuestionTime = 0
	self.curScores = 0
	self.curCombo = 0
	self.nextAddScores = 0
	self.helpers = nil
	self.endbaledClickAnswer = false
	self.exceptErrIndex = 0
	self.questionConfig = nil
	self.answerTimes = 0
	self.answerRightNum = 0
	self.bestCombo = 0
	self.helpers = nil
	self.seasonId = 1
end

function AnswerSceneMO:updateHelpers(helpConfig)
	local helpCos = AnswerSceneConfig.instance:getAllHelpCos()

	self.helpers = {}

	for i = 1, #helpCos do
		local helper = AnswerHelperMO.New()

		helper.iconPath = helpCos[i].icon
		helper.helperName = helpCos[i].name
		helper.helperDesc = helpCos[i].desc
		helper.helpType = helpCos[i].type

		local usedTimes = 0

		for j = 1, #helpConfig do
			if helpConfig[j].type == helpCos[i].type then
				usedTimes = helpConfig[j].usedTimes
			end
		end

		helper.helpTimes = helpCos[i].times - usedTimes
		self.helpers[helpCos[i].type] = helper
	end
end

function AnswerSceneMO:getQuestion()
	return self.questionConfig
end

function AnswerSceneMO:popQuestion()
	if self.questionConfig and not self.questionConfig:isPassed() then
		return self.questionConfig
	end

	self.questionConfig = nil

	if self.questionList then
		local idx

		for i = 1, #self.questionList do
			if not self.questionList[i]:isPassed() then
				idx = i
				self.questionConfig = self.questionList[i]

				break
			end
		end

		if idx then
			while idx > 0 do
				table.remove(self.questionList, 1)

				idx = idx - 1
			end
		end
	end

	return self.questionConfig
end

function AnswerSceneMO:createQuestion(questionId)
	local questCo = AnswerSceneConfig.instance:getQuestionCo(questionId)

	if not questCo then
		return
	end

	local answers = {}

	for i = 1, 4 do
		local txt = questCo["option" .. i]

		if not string.nilorempty(txt) then
			local answer = AnswerAnswerMO.New()

			answer.index = i
			answer.text = txt

			table.insert(answers, answer)
		end
	end

	local question = AnswerQuestionMO.New()

	question.question = questCo.question
	question.answers = answers

	return question
end

function AnswerSceneMO:consumeHelpTimes(type)
	if not self.helpers then
		return
	end

	for i = 1, #self.helpers do
		if self.helpers[i].helpType == type then
			self.helpers[i].helpTimes = self.helpers[i].helpTimes - 1
		end
	end
end

function AnswerSceneMO:exceptionOneErrAnswer()
	if not self.questionConfig then
		return
	end

	if self:isAllErrAnswerSigned() then
		return false
	end

	local questCo = AnswerSceneConfig.instance:getQuestionCo(self.questionConfig.questionId)

	self.exceptErrIndex = self.exceptErrIndex + 1

	if self.exceptErrIndex == questCo.correctOptionId then
		self.exceptErrIndex = self.exceptErrIndex + 1
	end

	return true
end

function AnswerSceneMO:isAllErrAnswerSigned()
	return self.exceptErrIndex >= #self.questionConfig.answers
end

function AnswerSceneMO:isSignedErrAnswer(index)
	if not self.questionConfig then
		return false
	end

	local questCo = AnswerSceneConfig.instance:getQuestionCo(self.questionConfig.questionId)

	if index == questCo.correctOptionId then
		return false
	end

	return index <= self.exceptErrIndex
end

function AnswerSceneMO:onNextQuestion()
	self.exceptErrIndex = 0
end

return AnswerSceneMO
