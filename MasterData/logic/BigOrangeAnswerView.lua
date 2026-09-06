-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bigorange/view/BigOrangeAnswerView.lua

module("logic.extensions.bigorange.view.BigOrangeAnswerView", package.seeall)

local BigOrangeAnswerView = class("BigOrangeAnswerView", ViewComponent)

function BigOrangeAnswerView:ctor()
	BigOrangeAnswerView.super.ctor(self)
end

function BigOrangeAnswerView:buildUI()
	BigOrangeAnswerView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._content = self:getGo("view/Viewport/Content")
	self._user = goutil.findChildTextComponent(self._content, "user/value")
	self._questionTime = goutil.findChildTextComponent(self._content, "questionTime/value")
	self._question = goutil.findChild(self._content, "question")
	self._questionText = goutil.findChildTextComponent(self._question, "value")
	self._name = goutil.findChild(self._content, "name")
	self._nameText = goutil.findChildTextComponent(self._name, "value")
	self._answerTime = goutil.findChild(self._content, "answerTime")
	self._answerTimeText = goutil.findChildTextComponent(self._answerTime, "value")
	self._answer = goutil.findChild(self._content, "answer")
	self._answerText = goutil.findChildTextComponent(self._answer, "value")
end

function BigOrangeAnswerView:bindEvents()
	BigOrangeAnswerView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function BigOrangeAnswerView:unbindEvents()
	BigOrangeAnswerView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function BigOrangeAnswerView:destroyUI()
	BigOrangeAnswerView.super.destroyUI(self)
end

function BigOrangeAnswerView:onEnter()
	BigOrangeAnswerView.super.onEnter(self)

	local answerInfo = BigOrangeConfig.instance:getAnswerById(tonumber(self:getFirstParam()))

	self._user.text = answerInfo.user
	self._questionTime.text = answerInfo.questionTime
	self._questionText.text = answerInfo.question

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._questionText:GetComponent(goutil.Type_RectTransform))

	local vector = GameUtil.getAnchoredPos(self._name.gameObject)
	local nextY = GameUtil.getAnchoredPos(self._question.gameObject).y - GameUtil.getHeight(self._questionText.gameObject) - 58.3

	GameUtil.setAnchoredPos(self._name.gameObject, vector.x, nextY)
	GameUtil.setAnchoredPos(self._answerTime.gameObject, GameUtil.getAnchoredPos(self._answerTime.gameObject).x, nextY)
	GameUtil.setAnchoredPos(self._answer.gameObject, GameUtil.getAnchoredPos(self._answer.gameObject).x, nextY - GameUtil.getHeight(self._name.gameObject))

	self._nameText.text = answerInfo.name
	self._answerTimeText.text = answerInfo.answerTime
	self._answerText.text = answerInfo.answer

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._answerText:GetComponent(goutil.Type_RectTransform))
	GameUtil.setHeight(self._content, -1 * GameUtil.getAnchoredPos(self._answer.gameObject).y + GameUtil.getHeight(self._answerText.gameObject) + 25)
end

function BigOrangeAnswerView:onEnterFinished()
	BigOrangeAnswerView.super.onEnterFinished(self)
end

function BigOrangeAnswerView:onExit()
	BigOrangeAnswerView.super.onExit(self)
end

function BigOrangeAnswerView:onExitFinished()
	BigOrangeAnswerView.super.onExitFinished(self)
end

return BigOrangeAnswerView
