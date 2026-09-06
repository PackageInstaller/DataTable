-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/answerscene/view/AnswerSceneView.lua

module("logic.extensions.answerscene.view.AnswerSceneView", package.seeall)

local AnswerSceneView = class("AnswerSceneView", ViewComponent)
local AnswerSceneHelpTimesTips = {
	[AnswerSceneMO.HelpType_Tips] = "answerscene_helptip_notimes",
	[AnswerSceneMO.HelpType_ExceptError] = "answerscene_help_excep_error_notimes"
}

function AnswerSceneView:buildUI()
	AnswerSceneView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._blockMask = self:getGo("blockMask")
	self._btnChat = self:getBtn("Nego_Chat")

	self:_initNextCounting()
	self:_initQuestion()
	self:_initHelpers()
	self:_initResult()
	self:_initNoOpened()
end

function AnswerSceneView:_initNextCounting()
	self._nextCounting = self:getGo("nodeNextCounting")
	self._nextCountingTime = self:getGo("nodeNextCounting/downCount/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self._nodeResultCounting = self:getGo("nodeResultCounting")
	self._resultNextTime = self:getTxt("nodeResultCounting/nextTime")
end

function AnswerSceneView:_initNoOpened()
	self._nodeUnopened = self:getGo("nodeUnopened")
	self._unopenedCountingTime = self:getTxt("nodeUnopened/downCount/txtNum")

	local txtTips = self:getTxt("nodeUnopened/downCount/txt")

	txtTips.text = lang("answerscene_noopened")
end

function AnswerSceneView:_initQuestion()
	self._questionNode = self:getGo("nodeQuestion")
	self._question = self:getGo("nodeQuestion/question")
	self._score = self:getTxt("nodeQuestion/score/txt")
	self._progress = self:getTxt("nodeQuestion/progress/txt")
	self._comboGo = self:getGo("nodeQuestion/combo")
	self._combo = self:getGo("nodeQuestion/combo/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self._nextAddScore = self:getTxt("nodeQuestion/nextTip/txtTip")
	self._imgDowncount = self:getGo("nodeQuestion/question/imgDowncount")
	self._questionCountTime = self._imgDowncount:GetComponent(typeof(UIImgNumeralText))
	self._txtQuestion = self:getTxt("nodeQuestion/question/txtQuestion")
	self._questionAnswersNode = self:getGo("nodeQuestion/question/options")
	self._questionAnswers = {}
	self._questionAnswers[1] = self:_buildQuestAnswerNode(self:getGo("nodeQuestion/question/options/answerItem"))
	self._questionBg1 = self:getGo("nodeQuestion/question/img1").transform
	self._questionBg2 = self:getGo("nodeQuestion/question/img2").transform
end

function AnswerSceneView:_buildQuestAnswerNode(prefab)
	local color = goutil.findChild(prefab, "color"):GetComponent(typeof(UIImageColorChange))
	local rightGo = goutil.findChild(prefab, "right")
	local errorGo = goutil.findChild(prefab, "error")
	local selectGo = goutil.findChild(prefab, "select")
	local answer = goutil.findChildTextComponent(prefab, "answer")
	local btnSel = Framework.ButtonAdapter.GetFrom(prefab, "btnSel")

	return {
		go = prefab,
		answer = answer,
		errorGo = errorGo,
		rightGo = rightGo,
		color = color,
		btnSel = btnSel,
		selectGo = selectGo
	}
end

function AnswerSceneView:_initHelpers()
	local helper1 = self:getGo("nodeQuestion/btnRid")
	local helper2 = self:getGo("nodeQuestion/btnTip")

	self._helpersNode = {}
	self._helpersNode[1] = self:_initOneHelper(helper1)
	self._helpersNode[2] = self:_initOneHelper(helper2)
end

function AnswerSceneView:_initOneHelper(go)
	local helper = {}

	helper.go = go
	helper.headIcon = goutil.findChild(go, "head")
	helper.helpNum = goutil.findChildTextComponent(go, "useNum/txtNum")
	helper.txtName = goutil.findChildTextComponent(go, "txtName")
	helper.txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	helper.btn = Framework.ButtonAdapter.Get(go)
	helper.tipsNode = goutil.findChild(go, "tip")
	helper.tipsText = goutil.findChildTextComponent(go, "tip/txtDesc")

	return helper
end

function AnswerSceneView:_initResult()
	self._answerRight = self:getGo("nodeQuestion/bingo")
	self._answerWrong = self:getGo("nodeQuestion/wrong")
	self._resultRightScores = self:getTxt("nodeQuestion/bingo/txtNum")
	self._rightAnswerTxt = self:getTxt("nodeQuestion/wrong/txtNum")

	self._answerRight:SetActive(false)
	self._answerWrong:SetActive(false)
end

function AnswerSceneView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnChat:AddClickListener(self._onClickChat, self)
end

function AnswerSceneView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnChat:RemoveClickListener()

	for i = 1, #self._questionAnswers do
		self._questionAnswers[i].btnSel:RemoveClickListener()
	end

	for i = 1, #self._helpersNode do
		self._helpersNode[i].btn:RemoveClickListener()
	end
end

function AnswerSceneView:destroyUI()
	return
end

function AnswerSceneView:onEnter()
	AnswerSceneView.super.onEnter(self)

	self._isFirstQuestion = true

	GlobalDispatcher:addListener(GlobalNotify.OnAnswerSceneInfo, self._onDataReady, self)
	GlobalDispatcher:addListener(GlobalNotify.OnAnswerSelected, self._selectAnswer, self)
	GlobalDispatcher:addListener(GlobalNotify.OnAnswerAskForHelp, self._onAnswerAskForHelp, self)
	GlobalDispatcher:addListener(GlobalNotify.OnAnswerNextQuestion, self._onAnswerNextQuestion, self)
	GlobalDispatcher:addListener(GlobalNotify.OnAnswerQuestionRespond, self._onAnswerQuestionRespond, self)
	GlobalDispatcher:addListener(GlobalNotify.OnAnswerNewQuestion, self._onAnswerNewQuestion, self)
	self:_refreshView()
	settimer(1, self._tickAnswerSceneAcClosed, self)
end

function AnswerSceneView:onEnterFinished()
	AnswerSceneView.super.onEnterFinished(self)
end

function AnswerSceneView:onExit()
	self._currQuestion = nil
	self._testQuestionIndex = nil
	self._isFirstQuestion = nil
	self._isPlayingResultAnim = nil
	self._closedTimeStamp = nil
	self._hasShowQuestion = nil

	self:_clearHelperIcons()
	UnityTweens.TweenBase.DestroyAll(self._comboGo)
	removetimer(self._tickAnswerSceneAcClosed, self)
	removetimer(self._refreshNextStartTime, self)
	removetimer(self._refreshOpenTime, self)
	removetimer(self._refreshAnswerStartTime, self)
	removetimer(self._refreshCurrQuestionTime, self)
	removetimer(self._refreshWaitingResultTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnAnswerNewQuestion, self._onAnswerNewQuestion, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnAnswerNextQuestion, self._onAnswerNextQuestion, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnAnswerSceneInfo, self._onDataReady, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnAnswerSelected, self._selectAnswer, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnAnswerAskForHelp, self._onAnswerAskForHelp, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnAnswerQuestionRespond, self._onAnswerQuestionRespond, self)
	AnswerSceneView.super.onExit(self)
end

function AnswerSceneView:onExitFinished()
	return
end

function AnswerSceneView:_refreshView()
	local answerMo = AnswerSceneController.instance:getAnswerSceneInfo()

	if not answerMo then
		self:_onWaitingData()
	else
		self:_onDataReady()
	end
end

function AnswerSceneView:_tickAnswerSceneAcClosed()
	if AnswerSceneModel.instance.testQuestions then
		return
	end

	self._closedTimeStamp = self._closedTimeStamp or AnswerSceneModel.instance:getQuestionEndTimestamp()

	local now = ServerTime.now()

	if now >= self._closedTimeStamp and AnswerSceneModel.instance:isAllAnswerRespond() then
		removetimer(self._tickAnswerSceneAcClosed, self)
		self:_showResultView()
	end
end

function AnswerSceneView:_onWaitingData()
	self._blockMask:SetActive(true)
	self._nextCounting:SetActive(false)
	self._questionNode:SetActive(false)
	self._nodeUnopened:SetActive(false)
	self._nodeResultCounting:SetActive(false)
end

function AnswerSceneView:_onDataReady()
	local answerMo = AnswerSceneController.instance:getAnswerSceneInfo()

	if not AnswerSceneModel.instance.testQuestions and answerMo.questStartStamp > 0 and ServerTime.now() < answerMo.questStartStamp then
		self:_onWaitingOpened()

		return
	end

	self._currComboNum = 0

	self:_onDoingQuesition()
end

function AnswerSceneView:_onWaitingOpened()
	self._blockMask:SetActive(true)
	self._nextCounting:SetActive(false)
	self._nodeResultCounting:SetActive(false)
	self._questionNode:SetActive(false)
	self._nodeUnopened:SetActive(true)
	settimer(1, self._refreshOpenTime, self)
	self:_refreshOpenTime()
end

function AnswerSceneView:_refreshOpenTime()
	local answerMo = AnswerSceneController.instance:getAnswerSceneInfo()
	local remainTime = answerMo.questStartStamp - ServerTime.now()

	self._unopenedCountingTime.text = math.floor(math.max(remainTime, 0))

	if remainTime <= 0 then
		self:_onDoingQuesition()
	end
end

function AnswerSceneView:_onWaitingFirstQuesition()
	self._blockMask:SetActive(true)
	self._nextCounting:SetActive(true)
	self._questionNode:SetActive(false)
	self._nodeUnopened:SetActive(false)
	self._nodeResultCounting:SetActive(false)
	removetimer(self._refreshAnswerStartTime, self)
	settimer(1, self._refreshAnswerStartTime, self)
	self:_refreshAnswerStartTime()
end

function AnswerSceneView:_refreshAnswerStartTime()
	local remainTime = 0

	if self._currQuestion then
		remainTime = self._currQuestion:getStartDeltaTime()
	else
		local answerMo = AnswerSceneController.instance:getAnswerSceneInfo()

		if answerMo.nextQuestionTime <= 0 then
			answerMo.nextQuestionTime = ServerTime.now() + 35
		end

		remainTime = answerMo.nextQuestionTime - ServerTime.now()
	end

	self._nextCountingTime:SetNum(math.floor(math.max(remainTime, 0)))

	if remainTime <= 0 then
		removetimer(self._refreshAnswerStartTime, self)
		self:_onDoingQuesition()
	end
end

function AnswerSceneView:_onWaitingNextQuesition()
	self._blockMask:SetActive(true)
	self._nextCounting:SetActive(false)
	self._questionNode:SetActive(true)
	self._nodeUnopened:SetActive(false)
	self._nodeResultCounting:SetActive(true)
	removetimer(self._refreshNextStartTime, self)
	settimer(0, self._refreshNextStartTime, self)
	self:_refreshNextStartTime()
end

function AnswerSceneView:_refreshNextStartTime()
	local remainTime = 0

	remainTime = self._currQuestion and self._currQuestion:getStartDeltaTime() or AnswerSceneModel.instance.nextQuestionStartTime - ServerTime.now()
	self._resultNextTime.text = string.format(lang("answerscene_next_timecount"), math.floor(math.max(remainTime, 0)))

	if remainTime <= 0 then
		removetimer(self._refreshNextStartTime, self)
	end
end

function AnswerSceneView:_onDoingQuesition()
	removetimer(self._refreshOpenTime, self)

	if not self._currQuestion or self._currQuestion:isPassed() then
		removetimer(self._refreshNextStartTime, self)
		removetimer(self._refreshAnswerStartTime, self)
		removetimer(self._refreshCurrQuestionTime, self)

		local answerMo = AnswerSceneController.instance:getAnswerSceneInfo()

		self._currQuestion = answerMo:popQuestion()
	end

	if not self._currQuestion and AnswerSceneModel.instance.testQuestions then
		self:_testQuestions()
	end

	if not self._currQuestion and self._isFirstQuestion then
		self._isFirstQuestion = false

		self:_onWaitingFirstQuesition()
	elseif self._currQuestion then
		local isFirstQuestion = self._isFirstQuestion

		self._isFirstQuestion = false

		if not self._currQuestion:isDoing() then
			if isFirstQuestion then
				self:_onWaitingFirstQuesition()
			else
				self:_onWaitingNextQuesition()
			end
		else
			self:_refreshQuestionNode()
		end
	elseif self._hasShowQuestion then
		self:_onWaitingNextQuesition()
	else
		self:_waitingQuestion()
	end
end

function AnswerSceneView:_waitingQuestion()
	self._blockMask:SetActive(true)
	self._nextCounting:SetActive(false)
	self._questionNode:SetActive(false)
	self._nodeUnopened:SetActive(false)
	self._nodeResultCounting:SetActive(false)
end

function AnswerSceneView:_refreshQuestionNode()
	self._hasShowQuestion = true

	self._blockMask:SetActive(false)
	self._nextCounting:SetActive(false)
	self._nodeUnopened:SetActive(false)
	self._questionNode:SetActive(true)
	self._answerRight:SetActive(false)
	self._answerWrong:SetActive(false)
	self._nodeResultCounting:SetActive(false)
	removetimer(self._refreshNextStartTime, self)
	removetimer(self._refreshAnswerStartTime, self)
	self:_refreshScoresAndCombo()
	self:_updateCurrQuestionTime()
	self:_refreshQuestions()
	GlobalDispatcher:dispatch(GlobalNotify.OnStartNewQuestion)
end

function AnswerSceneView:_refreshScoresAndCombo()
	local answerMo = AnswerSceneController.instance:getAnswerSceneInfo()
	local maxTimes = AnswerSceneModel.instance:getAnswerTimesLimit()

	self._progress.text = string.format(lang("answerscene_progress"), answerMo.answerTimes, maxTimes)
	self._score.text = string.format(lang("answerscene_scores"), answerMo.curScores)
	self._nextAddScore.text = string.format(lang("answerscene_nextaddscoretip"), answerMo.nextAddScores)

	self:_refreshCombo(answerMo.curCombo)
end

function AnswerSceneView:_refreshCombo(currCombo)
	if not self._currComboNum then
		self._currComboNum = currCombo

		self._combo:SetNum(currCombo)

		if self._currComboNum < self._currComboNum then
			self:_stopComboAnim()
			self:_playComboAnim()
		end
	end
end

function AnswerSceneView:_playComboAnim()
	UnityTweens.TweenScale.Create(self._comboGo, Vector3.New(1, 1, 1), Vector3.New(1.5, 1.5, 1.5), 0.3, UnityTweens.EaseType.easeOutBack)
	UnityTweens.TweenScale.Create(self._comboGo, Vector3.New(1.5, 1.5, 1.5), Vector3.New(1, 1, 1), 0.2, UnityTweens.EaseType.linear, 0.3)
end

function AnswerSceneView:_stopComboAnim()
	UnityTweens.TweenBase.DestroyAll(self._comboGo)
end

function AnswerSceneView:_updateCurrQuestionTime()
	removetimer(self._refreshCurrQuestionTime, self)
	settimer(0, self._refreshCurrQuestionTime, self)
	self:_refreshCurrQuestionTime()
end

function AnswerSceneView:_refreshCurrQuestionTime()
	local remainTime = 0

	if self._currQuestion then
		remainTime = self._currQuestion:getEndDeltaTime()
	end

	if remainTime <= 0 and not AnswerSceneModel.instance.testQuestions then
		if self._questionCountTime.gameObject.activeSelf then
			self._questionCountTime.gameObject:SetActive(false)
		end

		GlobalDispatcher:dispatch(GlobalNotify.OnEndCurrQuestion)

		self._currQuestion = nil

		removetimer(self._refreshCurrQuestionTime, self)
		AnswerSceneController.instance:startNextQuestion()
	else
		if not self._questionCountTime.gameObject.activeSelf then
			self._questionCountTime.gameObject:SetActive(true)
		end

		self._questionCountTime:SetNum(math.floor(math.max(remainTime, 0)))
	end
end

function AnswerSceneView:_refreshQuestions()
	local questMo = self._currQuestion

	self._currSelAnswerIndex = 0
	self._txtQuestion.text = questMo.question

	local answers = questMo.answers
	local answerCount = #answers
	local nodeCount = #self._questionAnswers
	local transform = self._questionAnswersNode.transform

	while nodeCount < answerCount do
		local go = transform:GetChild(0).gameObject
		local child = UGUIToolHelper.AddChild(self._questionAnswersNode.gameObject, go)

		nodeCount = nodeCount + 1

		table.insert(self._questionAnswers, self:_buildQuestAnswerNode(child))
	end

	self:_refreshAllAnswers()
	self:_refreshHelpers()
end

function AnswerSceneView:_refreshAllAnswers()
	if not self._currQuestion then
		return
	end

	local answerMo = AnswerSceneController.instance:getAnswerSceneInfo()
	local questMo = self._currQuestion
	local answers = questMo.answers
	local answerCount = #answers
	local nodeCount = #self._questionAnswers
	local posx = 0
	local posy = 0

	for i = 1, answerCount do
		local data = answers[i]
		local answerNode = self._questionAnswers[i]

		answerNode.answer.text = data.text

		answerNode.errorGo:SetActive(answerMo:isSignedErrAnswer(data.index))
		answerNode.rightGo:SetActive(false)
		answerNode.btnSel:RemoveClickListener()

		if answerMo.endbaledClickAnswer or AnswerSceneModel.instance.testQuestions then
			answerNode.btnSel:AddClickListener(function()
				if AnswerSceneModel.instance.testQuestions then
					self:_testQuestions()
				else
					self:_selectAnswer(i)
				end
			end)
		end

		local isSelected = self._currSelAnswerIndex == i

		answerNode.color:SetState(i)
		answerNode.go:SetActive(true)
		answerNode.selectGo:SetActive(isSelected)

		local width = answerNode.answer.preferredWidth + 60
		local tfSelected = answerNode.selectGo.transform
		local sizeDelta = tfSelected.sizeDelta

		sizeDelta.x = width
		tfSelected.sizeDelta = sizeDelta

		local lx = -8 + width * 0.5

		Framework.TransformUtil.SetLocalPos(answerNode.selectGo.transform, lx, 0, 0)

		local posDelta = math.max(190, answerNode.answer.preferredWidth + 35 + 30)
		local nextposx = posx + posDelta

		if posx + answerNode.answer.preferredWidth + 35 > 745 then
			nextposx = posDelta
			posx = 0
			posy = posy - 40
		end

		Framework.TransformUtil.SetLocalPos(answerNode.go.transform, posx, posy, 0)

		posx = nextposx
	end

	for i = answerCount + 1, nodeCount do
		local answerNode = self._questionAnswers[i]

		answerNode.go:SetActive(false)
	end

	self:_adapteQuestionBgs(posy)
end

function AnswerSceneView:_adapteQuestionBgs(posy)
	local bg1SizeY = 126 - posy
	local bg2SizY = 118 - posy
	local sizeDelta = self._questionBg1.sizeDelta

	sizeDelta.y = bg1SizeY
	self._questionBg1.sizeDelta = sizeDelta
	sizeDelta = self._questionBg2.sizeDelta
	sizeDelta.y = bg2SizY
	self._questionBg2.sizeDelta = sizeDelta

	Framework.TransformUtil.SetLocalPos(self._imgDowncount.transform, 0, -103 + posy, 0)

	local bg1PosY = 64 - math.floor(bg1SizeY * 0.5)
	local bg2PosY = 60 - math.floor(bg2SizY * 0.5)

	Framework.TransformUtil.SetLocalPos(self._questionBg1, 0, bg1PosY, 0)
	Framework.TransformUtil.SetLocalPos(self._questionBg2, 0, bg2PosY, 0)
end

function AnswerSceneView:_selectAnswer(idx)
	if AnswerSceneModel.instance:isAllQuestionFinish() then
		return
	end

	if self._currQuestion and not self._currQuestion:isPassed() and self._currSelAnswerIndex ~= idx then
		self._currSelAnswerIndex = idx

		local answerMo = AnswerSceneController.instance:getAnswerSceneInfo()

		AnswerSceneController.instance:answerQuestion(self._currQuestion.questionId, (self._currQuestion.answers[idx] or nil) and (self._currQuestion.answers[idx].index or 0))
		self:_refreshAllAnswers()
	end
end

function AnswerSceneView:_refreshHelpers()
	local answerMo = AnswerSceneController.instance:getAnswerSceneInfo()
	local helpers = answerMo.helpers

	for i = 1, #helpers do
		local node = self._helpersNode[i]

		node.go:SetActive(true)

		if node.tipsNode then
			node.tipsNode:SetActive(false)
		end

		self:_refreshHelperNode(node, helpers[i])
	end

	for i = #helpers + 1, #self._helpersNode do
		local node = self._helpersNode[i]

		node.go:SetActive(false)
	end
end

function AnswerSceneView:_refreshHelperNode(node, helperData)
	local answerMo = AnswerSceneController.instance:getAnswerSceneInfo()

	node.txtName.text = helperData.helperName
	node.txtDesc.text = helperData.helperDesc
	node.helpNum.text = tostring(helperData.helpTimes)

	node.btn:RemoveClickListener()
	node.btn:AddClickListener(function()
		if not self._currQuestion or self._currQuestion:isPassed() then
			return
		end

		if AnswerSceneModel.instance:isAllQuestionFinish() then
			return
		end

		if helperData.helpType == AnswerSceneMO.HelpType_ExceptError and self._currQuestion.hasUseExceptError then
			FloatWordMgr.instance:show(lang("answerscene_help_excep_error"))

			return
		end

		if helperData.helpType == AnswerSceneMO.HelpType_Tips and self._currQuestion.hasUseTips then
			FloatWordMgr.instance:show(lang("answerscene_help_tips_used"))

			return
		end

		if helperData.helpTimes <= 0 then
			FloatWordMgr.instance:show(lang(AnswerSceneHelpTimesTips[helperData.helpType]))

			return
		end

		if answerMo:isAllErrAnswerSigned() then
			FloatWordMgr.instance:show(lang("answerscene_help_noneed"))

			return
		end

		AnswerSceneController.instance:askForHelper(helperData.helpType)
	end)
end

function AnswerSceneView:_onAnswerAskForHelp(type)
	if not self._currQuestion then
		return
	end

	local answerMo = AnswerSceneController.instance:getAnswerSceneInfo()
	local helpers = answerMo.helpers

	for i = 1, #helpers do
		if helpers[i].helpType == type then
			local node = self._helpersNode[i]

			self:_refreshHelperNode(node, helpers[i])

			if node.tipsNode then
				node.tipsNode:SetActive(true)

				local questCo = AnswerSceneConfig.instance:getQuestionCo(self._currQuestion.questionId)

				node.tipsText.text = questCo.helpTips
			end
		end
	end

	if type == AnswerSceneMO.HelpType_ExceptError then
		self:_refreshAllAnswers()
	else
		self._currQuestion.hasUseTips = true
	end
end

function AnswerSceneView:_clearHelperIcons()
	return
end

function AnswerSceneView:_onAnswerNextQuestion()
	self._currQuestion = nil

	self:_onDoingQuesition()
end

function AnswerSceneView:_onAnswerQuestionRespond()
	if self._isPlayingResultAnim then
		return
	end

	local resultMo = AnswerSceneModel.instance:popAnswerResult()

	if not resultMo then
		self:_showResultView()

		return
	end

	if resultMo.isFinish then
		self:_showResultView(resultMo)

		return
	end

	self:_refreshScoresAndCombo()

	if not resultMo.isRight then
		self:_playAnswerWrongAnim(resultMo)
	else
		self:_playAnswerRightAnim(resultMo)
	end
end

function AnswerSceneView:_showResultView(resultMo)
	if AnswerSceneModel.instance:isAllQuestionFinish() then
		if AnswerSceneModel.instance:hadGainPrize() then
			ViewMgr.instance:close(ViewName.chat)

			if not ViewMgr.instance:isOpen(ViewName.AnswerSceneResult) then
				ViewMgr.instance:open(ViewName.AnswerSceneResult, resultMo)
			end
		else
			SceneAnswerAgent.instance:sendPM_SceneAnswerGainScorePrizeReq()
		end
	else
		local endStamp = AnswerSceneModel.instance:getQuestionEndTimestamp()
		local now = ServerTime.now()

		if endStamp <= now then
			if AnswerSceneModel.instance:hadGainPrize() then
				ViewMgr.instance:close(ViewName.chat)

				if not ViewMgr.instance:isOpen(ViewName.AnswerSceneResult) then
					TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("answerscene_closed"), function()
						AnswerSceneController.instance:exitAnswerScene()
					end, lang("confirm"))
				end
			else
				SceneAnswerAgent.instance:sendPM_SceneAnswerGainScorePrizeReq()
			end
		end
	end
end

function AnswerSceneView:_onAnswerNewQuestion()
	if self._currQuestion and self._currQuestion:isPassed() then
		self._currQuestion = nil
	end

	self:_onDoingQuesition()
end

function AnswerSceneView:_playAnswerWrongAnim(resultMo)
	self._answerWrong:SetActive(true)
	self._answerRight:SetActive(false)

	local questionCo = AnswerSceneConfig.instance:getQuestionCo(resultMo.questionId)

	self._rightAnswerTxt.text = questionCo and string.format(lang("answerscene_rightanswer"), questionCo["option" .. questionCo.correctOptionId]) or ""

	self:_startWaitingResultAnim()
end

function AnswerSceneView:_playAnswerRightAnim(resultMo)
	self._answerWrong:SetActive(false)
	self._answerRight:SetActive(true)

	self._resultRightScores.text = string.format(lang("answerscene_scores_add"), resultMo.addScores)

	self:_startWaitingResultAnim()
end

function AnswerSceneView:_startWaitingResultAnim()
	self._isPlayingResultAnim = true
	self._waitingResAnimTime = self._currQuestion and self._currQuestion:getStartDeltaTime() or AnswerSceneModel.instance.nextQuestionStartTime

	removetimer(self._refreshWaitingResultTime, self)
	settimer(0, self._refreshWaitingResultTime, self)
	self:_refreshWaitingResultTime()
end

function AnswerSceneView:_refreshWaitingResultTime()
	local remainTime = self._waitingResAnimTime - ServerTime.now()

	if remainTime <= 0 then
		self._isPlayingResultAnim = false

		removetimer(self._refreshWaitingResultTime, self)
		self._answerWrong:SetActive(false)
		self._answerRight:SetActive(false)
		self:_onAnswerQuestionRespond()
	end
end

function AnswerSceneView:_onClickClose()
	local tipsContent = "是否确认退出答题，退出后将直接结算？"

	local function okFunc()
		AnswerSceneController.instance:exitAnswerScene()
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

function AnswerSceneView:_onClickChat()
	ViewMgr.instance:open(ViewName.chat, GameEnum.ChatChannel.Nearby)
end

function AnswerSceneView:_testQuestions()
	local allQuestions = AnswerSceneConfig.instance:getAllQuestions()

	self._testQuestionIndex = self._testQuestionIndex or 0
	self._testQuestionIndex = self._testQuestionIndex + 1

	if self._testQuestionIndex > #allQuestions then
		FloatWordMgr.instance:show("题目已经查看完了，请重新打开界面")

		return
	end

	local answerMo = AnswerSceneModel.instance:getData()
	local questionId = allQuestions[self._testQuestionIndex].questionId
	local question = answerMo:createQuestion(questionId)

	question.questionId = questionId
	question.questStartStamp = ServerTime.now() - 1
	question.questEndStamp = question.questStartStamp + AnswerSceneModel.instance:getQuestionContinuedTime()
	AnswerSceneModel.instance.nextQuestionStartTime = question.questStartStamp + AnswerSceneModel.instance:getQuestionIntervalTime()
	self._currQuestion = question

	self:_refreshQuestionNode()
end

return AnswerSceneView
