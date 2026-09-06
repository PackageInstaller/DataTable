-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/CKAnswerQuestionView.lua

module("logic.extensions.chuangkongunion.view.CKAnswerQuestionView", package.seeall)

local CKAnswerQuestionView = class("CKAnswerQuestionView", ViewComponent)
local GameState = {
	Ready = 1,
	End = 3,
	Playing = 2
}

function CKAnswerQuestionView:ctor()
	CKAnswerQuestionView.super.ctor(self)
end

function CKAnswerQuestionView:buildUI()
	CKAnswerQuestionView.super.buildUI(self)

	self._readyCountdown = self:getGo("readyCountdown")
	self._txtReadyTitle = self:getTxt("readyCountdown/bg/txtTitle")
	self._countdown = self:getGo("readyCountdown/bg/countdown")
	self._txtReadyCountdown = self:getTxt("readyCountdown/bg/countdown/txtCountdown")
	self._animator = self:getGo("readyCountdown/bg/countdown"):GetComponent(typeof(UnityEngine.Animator))
	self._txtLeftTime = self:getTxt("txtLeftTime")
	self._txtLeftCount = self:getTxt("txtLeftCount")
	self._txtNum = self:getTxt("question/title/txtNum")
	self._txtDesc = self:getTxt("question/title/txtDesc")
	self._questionItems = {}

	for i = 1, 4 do
		local element = {}

		element.txtDesc = self:getTxt(string.format("question/answer/answer%d/txtDesc", i))
		element.yes = self:getGo(string.format("question/answer/answer%d/yes", i))
		element.no = self:getGo(string.format("question/answer/answer%d/no", i))
		element.btn = self:getBtn(string.format("question/answer/answer%d", i))
		self._questionItems[i] = element
	end

	self._questionGo = self:getGo("question")
end

function CKAnswerQuestionView:bindEvents()
	CKAnswerQuestionView.super.bindEvents(self)

	for i = 1, 4 do
		self._questionItems[i].btn:AddClickListener(function()
			self:_onClickAnswer(i)
		end)
	end
end

function CKAnswerQuestionView:unbindEvents()
	CKAnswerQuestionView.super.unbindEvents(self)

	for i = 1, 4 do
		self._questionItems[i].btn:RemoveClickListener()
	end
end

function CKAnswerQuestionView:onEnter()
	CKAnswerQuestionView.super.onEnter(self)

	self._param = self:getFirstParam()
	self._questionList = self._param:getQuestionList()
	self._totalTime = self._param:getTotalTime()
	self._isEndingGame = false

	self:_changeState(GameState.Ready)
	self:_initReadyCountdown()
	self:_initPlayingState()
end

function CKAnswerQuestionView:onExit()
	CKAnswerQuestionView.super.onExit(self)
	removetimer(self._onSecond, self)
	self._param:doOnClose()

	self._param = nil
end

function CKAnswerQuestionView:_onClickAnswer(index)
	if self._isCanClickAnswer then
		self._isCanClickAnswer = false

		table.insert(self._answerList, index)

		local isRight = index == self._questionList[self._curQuestionIndex].rightAnswer

		goutil.setActive(self._questionItems[index].yes, isRight)
		goutil.setActive(self._questionItems[index].no, not isRight)
		TweenUtil.DoDelay(1, function()
			self._curQuestionIndex = self._curQuestionIndex + 1

			self:_updatePlayingState()
		end)
	end
end

function CKAnswerQuestionView:_onSecond()
	if self._gameState == GameState.Ready then
		self:_updateReadyState()
	elseif self._gameState == GameState.Playing then
		self:_updatePlayingTime()
	end
end

function CKAnswerQuestionView:_changeState(state)
	self._gameState = state
end

function CKAnswerQuestionView:_initReadyCountdown()
	self._txtReadyTitle.text = string.format("请在<color=#FF4747FF>%d秒</color>回答<color=#FF4747FF>%d道</color>题目", self._totalTime, #self._questionList)
	self._countdownNum = 4

	self:_changeState(GameState.Ready)

	self._txtReadyCountdown.text = ""

	goutil.setActive(self._countdown, false)
	goutil.setActive(self._readyCountdown, true)
	settimer(1, self._onSecond, self)
end

function CKAnswerQuestionView:_updateReadyState()
	if self._countdownNum == 3 then
		goutil.setActive(self._countdown, true)
	end

	self._txtReadyCountdown.text = self._countdownNum
	self._countdownNum = self._countdownNum - 1

	self._animator:Play("miyacountdown", 0, 0)

	if self._countdownNum <= -1 then
		goutil.setActive(self._readyCountdown, false)
		goutil.setActive(self._questionGo, true)
		self:_updatePlayingState()
		self:_changeState(GameState.Playing)
	end
end

function CKAnswerQuestionView:_initPlayingState()
	local time = self._param:getTotalTime()

	self._answerList = {}
	self._curQuestionIndex = 1
	self._isCanClickAnswer = false
	self._txtLeftTime.text = time .. "秒"
	self._playingCountdown = time

	goutil.setActive(self._questionGo, false)
	self:_updatePlayingState(true)
end

function CKAnswerQuestionView:_updatePlayingTime()
	if self._gameState == GameState.Playing then
		if self._playingCountdown >= 0 then
			self._txtLeftTime.text = self._playingCountdown .. "秒"
			self._playingCountdown = self._playingCountdown - 1
		else
			self:_onGameOver()
		end
	end
end

function CKAnswerQuestionView:_updatePlayingState(isDefault)
	if self._curQuestionIndex > #self._questionList then
		self:_onGameOver()

		return
	end

	self._txtLeftCount.text = string.format("%d/%d", self._curQuestionIndex - 1, #self._questionList)
	self._txtNum.text = string.format("第%d/%d题", self._curQuestionIndex, #self._questionList)

	local data = self._questionList[self._curQuestionIndex]

	self._txtDesc.text = isDefault and "？？？" or data.question

	for i = 1, 4 do
		self._questionItems[i].txtDesc.text = isDefault and "？？？" or data.answerList[i]

		goutil.setActive(self._questionItems[i].yes, false)
		goutil.setActive(self._questionItems[i].no, false)
	end

	self._isCanClickAnswer = true
end

function CKAnswerQuestionView:_onGameOver()
	if self._gameState == GameState.Playing then
		self:_changeState(GameState.End)

		self._isCanClickAnswer = false

		self._param:sendAnswerReq(self._answerList)
		self:close()
	end
end

return CKAnswerQuestionView
