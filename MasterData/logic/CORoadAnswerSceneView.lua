-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/copy/answer/CORoadAnswerSceneView.lua

module("logic.extensions.cantonoperaroad.view.copy.answer.CORoadAnswerSceneView", package.seeall)

local CORoadAnswerSceneView = class("CORoadAnswerSceneView", AnswerSceneView)

function CORoadAnswerSceneView:onEnter()
	CORoadAnswerSceneView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.CantonOperaRoad)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		AnswerSceneController.instance:exitAnswerScene()

		return
	end

	CantonOperaRoadModel.instance:clearAnswerRecord()

	self._isExitReason = 0

	GlobalDispatcher:addListener(GlobalNotify.CORAnswerSceneExitRes, self._handleAnswerSceneExitRes, self)
end

function CORoadAnswerSceneView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.CORAnswerSceneExitRes, self._handleAnswerSceneExitRes, self)
	CORoadAnswerSceneView.super.onExit(self)
end

function CORoadAnswerSceneView:onExitFinished()
	CORoadAnswerSceneView.super.onExitFinished(self)
end

function CORoadAnswerSceneView:_playAnswerWrongAnim(resultMo)
	CORoadAnswerSceneView.super._playAnswerWrongAnim(self, resultMo)
	CantonOperaRoadModel.instance:saveAnswerRecord(0, 1)
end

function CORoadAnswerSceneView:_playAnswerRightAnim(resultMo)
	CORoadAnswerSceneView.super._playAnswerRightAnim(self, resultMo)
	CantonOperaRoadModel.instance:saveAnswerRecord(1, 0)

	self._resultRightScores.text = string.format("考核分数：%s分", self:_getAddProgressNum(CantonOperaRoadModel.instance:getRightAnswerRecord()))
end

function CORoadAnswerSceneView:_refreshScoresAndCombo()
	CORoadAnswerSceneView.super._refreshScoresAndCombo(self)

	self._nextAddScore.text = string.format("下一题加考核进度<color=#eb4642>%s</color>分", self:_getAddProgressNum(1))
end

function CORoadAnswerSceneView:_getAddProgressNum(rightNum)
	local progressNum = 0
	local corAnswerData = CantonOperaRoadConfig.instance:getCorAnswerDataById(self._activityId) or {}

	if not string.nilorempty(corAnswerData.prize) then
		local matType, matId, matNum = MaterialMgr.getMatParams(corAnswerData.prize)

		progressNum = rightNum * matNum
	end

	return progressNum
end

function CORoadAnswerSceneView:_onAnswerQuestionRespond()
	CORoadAnswerSceneView.super._onAnswerQuestionRespond(self)

	if self._isExitReason ~= 0 then
		self:_onClickClose()

		self._isExitReason = 0

		return
	end
end

function CORoadAnswerSceneView:_handleAnswerSceneExitRes(msg)
	if msg == nil then
		return
	end

	self._isExitReason = msg.reason
end

function CORoadAnswerSceneView:_doExitResult()
	if self._isExitReason == 0 then
		local tipsContent = "是否确认退出答题，退出后将直接结算？"

		local function okFunc()
			AnswerSceneController.instance:exitAnswerScene()
			self:_popExitResult()
		end

		local function cencelFunc()
			return
		end

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
	else
		AnswerSceneController.instance:exitAnswerScene()
		self:_popExitReason(self._isExitReason)
	end
end

function CORoadAnswerSceneView:_popExitReason(reason)
	reason = checknumber(reason)

	if checknumber(reason) == 0 then
		return
	end

	local text = ""

	if reason == GameEnum.ExitReasonAsCORAnswer.NoEnergy then
		text = "体力不足，无法继续答题"
	elseif reason == GameEnum.ExitReasonAsCORAnswer.ExLimit then
		text = "答题已达上限，无法继续答题"
	elseif reason == GameEnum.ExitReasonAsCORAnswer.ExProgress then
		text = "进度已满，无需继续答题"
	end

	local function func()
		self:_popExitResult()
	end

	local btnText = "确定"
	local alignment = UnityEngine.TextAnchor.MiddleCenter

	TipsFacade.instance:openTipWindowNoX("提示", text, func, btnText, alignment)
end

function CORoadAnswerSceneView:_popExitResult()
	return
end

function CORoadAnswerSceneView:_onClickClose()
	self:_doExitResult()
end

return CORoadAnswerSceneView
