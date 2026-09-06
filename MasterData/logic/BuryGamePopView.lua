-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/view/BuryGamePopView.lua

module("logic.extensions.burygame.view.BuryGamePopView", package.seeall)

local BuryGamePopView = class("BuryGamePopView", ViewComponent)

function BuryGamePopView:unbindEvents()
	BuryGamePopView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function BuryGamePopView:bindEvents()
	BuryGamePopView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickCancel, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function BuryGamePopView:onExit()
	BuryGamePopView.super.onExit(self)
end

function BuryGamePopView:buildUI()
	BuryGamePopView.super.buildUI(self)

	self._closeButton = self:getBtn("btns/btnCancel")
	self._btnSure = self:getBtn("btns/btnSure")
	self._txtScoreTip = self:getTxt("txtScoreTip")
	self._txtRightTip = self:getTxt("txtTrue")
	self._txtWrongTip = self:getTxt("txtFalse")
	self._txtRightScore = self:getTxt("txtTrue/txtScore")
	self._txtWrongScore = self:getTxt("txtFalse/txtScore")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtTip = self:getTxt("txtTip")
	self._txtBtnSure = goutil.findChildTextComponent(self._btnSure.gameObject, "Text")
end

function BuryGamePopView:onEnter()
	BuryGamePopView.super.onEnter(self)

	local param = self:getFirstParam()
	local rightScorePer = checknumber(BuryGameConfig.instance:getConstantValue("t2"))
	local wrongScorePer = checknumber(BuryGameConfig.instance:getConstantValue("t3"))
	local rightNum, wrongNum, score = 0, 0, 0
	local title, contentFmt = "", ""

	if param then
		rightNum = param.rightNum
		wrongNum = param.wrongNum
		self._sureHandler = param.sureHandler
		self._cancelHandler = param.cancelHandler
		self._handlerObj = param.handlerObj
		self._txtTitle.text = param.title
		self._txtTip.text = param.tip
		self._txtScoreTip.text = string.format(param.contentFmt, param.score)

		self._closeButton.gameObject:SetActive(self._cancelHandler ~= nil)

		self._txtBtnSure.text = string.nilorempty(param.sureBtnText) and "退出游戏" or param.sureBtnText
	end

	self._txtRightScore.text = string.format("<color=#20b376>+%d</color> 积分", rightNum * rightScorePer)
	self._txtWrongScore.text = string.format("<color=#20b376>-%d</color> 积分", wrongNum * wrongScorePer)
	self._txtRightTip.text = string.format("你埋对了 <color=#20b376>%d</color> 个怪物", rightNum)
	self._txtWrongTip.text = string.format("你埋错了 <color=#20b376>%d</color> 个小诺", wrongNum)
end

function BuryGamePopView:_onClickCancel()
	print("click cancel")
	GameUtil.callBack(self._cancelHandler, self._handlerObj)
	self:close()
end

function BuryGamePopView:_onClickSure()
	print("click sure")
	self:close()
	GameUtil.callBack(self._sureHandler, self._handlerObj)
end

return BuryGamePopView
