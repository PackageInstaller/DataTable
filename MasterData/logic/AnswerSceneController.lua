-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/answerscene/controller/AnswerSceneController.lua

module("logic.extensions.answerscene.controller.AnswerSceneController", package.seeall)

local AnswerSceneController = class("AnswerSceneController", BaseController)
local answerSceneId = 125

function AnswerSceneController:onInit()
	self:onReset()
end

function AnswerSceneController:onReset()
	self._lastHelpType = 0
	self._lastEnterScene = 0
	self._enterSceneOnGetData = false
end

function AnswerSceneController:gotoAnswerSceneNpc()
	TaskController.instance:foreceClearState()
	UIStateManager.instance:clear(true)
	TaskController.instance:gotoNpc(10012028)
end

function AnswerSceneController:isAnsweringQuestion()
	local scene = SceneMgr.instance:getCurScene()

	return scene and scene:getSceneId() == answerSceneId
end

function AnswerSceneController:enterAnswerScene()
	if not self:checkAnswerSceneOpen() then
		FloatWordMgr.instance:show(lang("answerscene_closed"))

		return
	end

	AnswerSceneModel.instance:onReset()

	if AnswerSceneModel.instance:isDataReady() then
		self:_enterAnswerScene()
	else
		self._enterSceneOnGetData = true

		self:getAnswerSceneInfo()
	end
end

function AnswerSceneController:checkAnswerSceneOpen()
	if AnswerSceneModel.instance:getFitSeasonId() == 0 then
		return false
	end

	local seasonStartTime = AnswerSceneModel.instance:getSeasonOpenTime()
	local seasonEndTime = AnswerSceneModel.instance:getSeasonEndTime()
	local now = ServerTime.now()

	if now < seasonStartTime or seasonEndTime <= now then
		return false
	end

	local startStamp = AnswerSceneModel.instance:getQuestionStartTimestamp()
	local endStamp = AnswerSceneModel.instance:getQuestionEndTimestamp()

	if now < startStamp or endStamp <= now then
		return false
	end

	return true
end

function AnswerSceneController:exitAnswerScene()
	if checknumber(self._lastEnterScene) == 0 then
		return
	end

	self._enterSceneOnGetData = false

	SceneFacade.instance:enterCityFromThisScene(self._lastEnterScene)
end

function AnswerSceneController:getAnswerSceneInfo()
	if AnswerSceneModel.instance:isDataReady() then
		return AnswerSceneModel.instance:getData()
	end

	SceneAnswerAgent.instance:sendPM_SceneAnswerInfoReq()
end

function AnswerSceneController:onAnswerSceneInfo(msg)
	AnswerSceneModel.instance:onAnswerSceneInfo(msg)

	if self._enterSceneOnGetData then
		self._enterSceneOnGetData = false

		self:_enterAnswerScene()
		GlobalDispatcher:dispatch(GlobalNotify.OnAnswerSceneInfo)
	end
end

function AnswerSceneController:_enterAnswerScene()
	if AnswerSceneModel.instance:isAllQuestionFinish() then
		FloatWordMgr.instance:show(lang("answerscene_timelimits"))
	else
		local answerMo = AnswerSceneModel.instance:getData()

		if not answerMo or answerMo.nextQuestionTime <= 0 then
			FloatWordMgr.instance:show(lang("answerscene_closed"))

			return
		end

		local scene = SceneMgr.instance:getCurScene()

		self._lastEnterScene = scene:getSceneId()

		SceneFacade.instance:enterCityFromThisScene(answerSceneId)
	end
end

function AnswerSceneController:startNextQuestion()
	if AnswerSceneModel.instance:startNextQuestion() then
		GlobalDispatcher:dispatch(GlobalNotify.OnAnswerNextQuestion)
	end
end

function AnswerSceneController:answerQuestion(questId, answerIndex)
	if AnswerSceneModel.instance.testQuestions then
		return
	end

	AnswerSceneModel.instance:answerQuestion(questId, answerIndex)
	SceneAnswerAgent.instance:sendPM_SceneAnswerReq(questId, answerIndex)
end

function AnswerSceneController:onAnswerQuestion(msg)
	if AnswerSceneModel.instance.testQuestions then
		return
	end

	AnswerSceneModel.instance:onAnswerQuestion(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnAnswerQuestionRespond)
end

function AnswerSceneController:askForHelper(type)
	if AnswerSceneModel.instance.testQuestions then
		return
	end

	self._lastHelpType = type

	SceneAnswerAgent.instance:sendPM_SceneAnswerSeekHelpReq(type)
end

function AnswerSceneController:onAskForHelper()
	if self._lastHelpType == AnswerSceneMO.HelpType_ExceptError then
		SurveyController.instance:reportBehavior(SurveyBehaviorID.SCENE_ANSWER_USE_EXCEPTERR)
	else
		SurveyController.instance:reportBehavior(SurveyBehaviorID.SCENE_ANSWER_USE_TIPS)
	end

	AnswerSceneModel.instance:onAskForHelper(self._lastHelpType)
	GlobalDispatcher:dispatch(GlobalNotify.OnAnswerAskForHelp, self._lastHelpType)

	self._lastHelpType = 0
end

function AnswerSceneController:onNewQuestion(msg)
	if AnswerSceneModel.instance.testQuestions then
		return
	end

	if AnswerSceneModel.instance:isAllQuestionFinish() then
		return
	end

	AnswerSceneModel.instance:onNewQuestion(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnAnswerNewQuestion)
end

function AnswerSceneController:onSceneAnswerGainScorePrize(msg)
	AnswerSceneModel.instance:onSceneAnswerGainScorePrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnAnswerQuestionRespond)
end

AnswerSceneController.instance = AnswerSceneController.New()

return AnswerSceneController
