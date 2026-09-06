-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/answerscene/model/AnswerSceneModel.lua

module("logic.extensions.answerscene.model.AnswerSceneModel", package.seeall)

local AnswerSceneModel = class("AnswerSceneModel", BaseModel)

function AnswerSceneModel:onInit()
	self:onReset()
end

function AnswerSceneModel:onReset()
	self._answerMO = nil
	self._questionId = 0
	self._answerIndex = 0
	self._isAllFinished = false
	self._resultList = nil
	self.nextQuestionStartTime = 0
	self._questionsMap = nil
end

function AnswerSceneModel:isDataReady()
	return self._answerMO ~= nil
end

function AnswerSceneModel:clearData()
	self._answerMO = nil
end

function AnswerSceneModel:getData()
	return self._answerMO
end

function AnswerSceneModel:getSeasonOpenTime()
	local openTimeCo = AnswerSceneConfig.instance:getOpenTimeCo(self:getFitSeasonId())

	return openTimeCo and GameUtil.string2time(openTimeCo.startTime)
end

function AnswerSceneModel:getSeasonEndTime()
	local openTimeCo = AnswerSceneConfig.instance:getOpenTimeCo(self:getFitSeasonId())

	return openTimeCo and GameUtil.string2time(openTimeCo.endTime)
end

function AnswerSceneModel:getFitSeasonId()
	local seasonId = 0
	local dataList = AnswerSceneConfig.instance:getOpenTimeCoDataList()

	for _, data in ipairs(dataList) do
		if GameUtil.getTimePeriod(data.startTime, data.endTime) == GameUtil.inTimePeriod then
			seasonId = data.seasonId

			break
		end
	end

	return seasonId
end

function AnswerSceneModel:onAnswerSceneInfo(msg)
	local report = msg.report

	self._answerMO = AnswerSceneMO.New()
	self._answerMO.answerTimes = report.anwerTimes
	self._answerMO.answerRightNum = report.rightNum
	self._answerMO.curScores = report.score
	self._answerMO.questStartStamp = self:getQuestionStartTimestamp()
	self._answerMO.nextQuestionTime = checknumber(math.ceil(msg.nextQuestionTime / 1000))
	self._questionId = 0
	self._answerIndex = 0

	self._answerMO:updateHelpers(msg.times)

	self._isAllFinished = self:checkAllQuestionFinish()
end

function AnswerSceneModel:getQuestionStartTimestamp()
	local startTime = AnswerSceneConfig.instance:getParamsValue("START_TIME")
	local dateStrs = string.split(startTime, ":")
	local dTime = ServerTime.nowDateServerLook()

	return GameUtil.date2time(dTime.year, dTime.month, dTime.day, checknumber(dateStrs[1]), checknumber(dateStrs[2]), checknumber(dateStrs[3]))
end

function AnswerSceneModel:getQuestionEndTimestamp()
	local endTime = AnswerSceneConfig.instance:getParamsValue("END_TIME")
	local dateStrs = string.split(endTime, ":")
	local dTime = ServerTime.nowDateServerLook()

	return GameUtil.date2time(dTime.year, dTime.month, dTime.day, checknumber(dateStrs[1]), checknumber(dateStrs[2]), checknumber(dateStrs[3]))
end

function AnswerSceneModel:getQuestionStartDate()
	local startTime = self:getQuestionStartTimestamp()

	return GameUtil.time2date(startTime)
end

function AnswerSceneModel:getQuestionEndDate()
	local endTime = self:getQuestionEndTimestamp()

	return GameUtil.time2date(endTime)
end

function AnswerSceneModel:onAskForHelper(type)
	if self._answerMO then
		self._answerMO:consumeHelpTimes(type)

		if type == AnswerSceneMO.HelpType_ExceptError then
			if self._answerMO.questionConfig then
				self._answerMO.questionConfig.hasUseExceptError = true
			end

			self._answerMO:exceptionOneErrAnswer()
		elseif self._answerMO.questionConfig then
			self._answerMO.questionConfig.hasUseTips = true
		end
	end
end

function AnswerSceneModel:isDoingQuestion()
	return self._answerMO and self._answerMO.questionConfig and self._answerMO.questionConfig:isDoing()
end

function AnswerSceneModel:getQuestionAnswerErrShowIndex()
	if not self._answerMO or not self._answerMO.questionConfig then
		return 0
	end

	local answers = self._answerMO.questionConfig.answers

	for i = 1, #answers do
		if answers[i].index == self._answerMO.exceptErrIndex then
			return i
		end
	end

	return 0
end

function AnswerSceneModel:answerQuestion(questionId, answerIndex)
	self._questionId = questionId
	self._answerIndex = answerIndex
end

function AnswerSceneModel:onAnswerQuestion(msg)
	self._isAllFinished = msg.isFinish or msg.isLast
	self._hadGainPrize = msg.report.hadGainPrize

	local answerScores = msg.report.score - self._answerMO.curScores

	self._answerMO.curCombo = msg.combo
	self._answerMO.answerTimes = msg.report.anwerTimes
	self._answerMO.answerRightNum = msg.report.rightNum
	self._answerMO.curScores = msg.report.score
	self._answerMO.nextAddScores = AnswerSceneConfig.instance:getComboScores(msg.combo)
	self._answerMO.bestCombo = msg.report.bestCombo

	local resultMo = AnswerResultMO.New()

	resultMo.isRight = msg.right
	resultMo.questionId = msg.questionId
	resultMo.answerIndex = msg.optionId
	resultMo.addScores = answerScores
	resultMo.changeSetId = msg.changeSetId

	if self._questionsMap then
		self._questionsMap[msg.questionId] = nil
	end

	self._resultList = self._resultList or {}

	table.insert(self._resultList, resultMo)

	if self._isAllFinished then
		resultMo = AnswerResultMO.New()
		resultMo.report = msg.report
		resultMo.isFinish = true

		if msg:HasField("scoreChangeSetId") then
			resultMo.scoreChangeSetId = msg.scoreChangeSetId

			MaterialController.instance:saveChangeSetToTemp(msg.scoreChangeSetId)
		end

		table.insert(self._resultList, resultMo)
	end
end

function AnswerSceneModel:popAnswerResult()
	if self._resultList and #self._resultList > 0 then
		return table.remove(self._resultList, 1)
	end
end

function AnswerSceneModel:getAnswerResultCount()
	if self._resultList then
		return #self._resultList
	end

	return 0
end

function AnswerSceneModel:getLastAnswer()
	return self._questionId, self._answerIndex
end

function AnswerSceneModel:onNewQuestion(msg)
	self._answerMO.questionList = self._answerMO.questionList or {}

	local question = self._answerMO:createQuestion(msg.questionId)

	if question then
		self._questionsMap = self._questionsMap or {}
		self._questionsMap[msg.questionId] = true
		question.questionId = msg.questionId
		question.questStartStamp = math.floor(checknumber(msg.answerTime) / 1000)
		question.questEndStamp = question.questStartStamp + self:getQuestionContinuedTime()
		self.nextQuestionStartTime = question.questStartStamp + self:getQuestionIntervalTime()

		table.insert(self._answerMO.questionList, question)
	end
end

function AnswerSceneModel:startNextQuestion()
	self._questionId = 0
	self._answerIndex = 0

	if not self._answerMO.questionConfig or self._answerMO.questionConfig:isPassed() then
		self._answerMO:popQuestion()
		self._answerMO:onNextQuestion()

		return true
	end

	return false
end

function AnswerSceneModel:getQuestionContinuedTime()
	return AnswerSceneConfig.instance:getParamsInt("PLAYER_QUESTION_TIME")
end

function AnswerSceneModel:getQuestionIntervalTime()
	return AnswerSceneConfig.instance:getParamsInt("QUESTION_INTERVAL")
end

function AnswerSceneModel:getAnswerTimesLimit()
	return AnswerSceneConfig.instance:getParamsInt("ANSWER_TIMES_LIMIT")
end

function AnswerSceneModel:checkAllQuestionFinish()
	local maxQuestions = self:getAnswerTimesLimit()

	return maxQuestions <= ((self._answerMO or nil) and self._answerMO.answerTimes)
end

function AnswerSceneModel:isAllQuestionFinish()
	return self._isAllFinished
end

function AnswerSceneModel:hadGainPrize()
	return self._hadGainPrize
end

function AnswerSceneModel:isAnswerAll()
	if not self._answerMO then
		return false
	end

	local maxQuestions = self:getAnswerTimesLimit()

	return maxQuestions <= self._answerMO.answerTimes
end

function AnswerSceneModel:isAllAnswerRespond()
	if not self._questionMap then
		return true
	end

	for k, v in pairs(self._questionMap) do
		if v then
			return true
		end
	end

	return false
end

function AnswerSceneModel:onSceneAnswerGainScorePrize(msg)
	self._hadGainPrize = true
	self._isAllFinished = true
	self._answerMO.answerTimes = msg.report.anwerTimes
	self._answerMO.answerRightNum = msg.report.rightNum
	self._answerMO.curScores = msg.report.score
	self._answerMO.bestCombo = msg.report.bestCombo

	local resultMo = AnswerResultMO.New()

	resultMo.report = msg.report
	resultMo.isFinish = true

	if msg:HasField("changeSetId") then
		resultMo.scoreChangeSetId = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	self._resultList = self._resultList or {}

	table.insert(self._resultList, resultMo)
end

AnswerSceneModel.instance = AnswerSceneModel.New()

return AnswerSceneModel
