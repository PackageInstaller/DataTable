-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/axiu/AxiuResultView.lua

module("logic.extensions.timelimitedchallenge.view.axiu.AxiuResultView", package.seeall)

local AxiuResultView = class("AxiuResultView", PerfectRuleModeResultView)

function AxiuResultView:ctor()
	AxiuResultView.super.ctor(self)
end

function AxiuResultView:unbindEvents()
	AxiuResultView.super.unbindEvents(self)
end

function AxiuResultView:bindEvents()
	AxiuResultView.super.bindEvents(self)
end

function AxiuResultView:onExit()
	AxiuResultView.super.onExit(self)
end

function AxiuResultView:buildUI()
	AxiuResultView.super.buildUI(self)

	self._scoreTxt = goutil.findChildComponent(self._rewards, "score", "UIImgNumeralText")
end

function AxiuResultView:onEnter()
	AxiuResultView.super.onEnter(self)
end

function AxiuResultView:refreshView()
	self._isWin = self._curInfo.isWin
	self._isPerfectWin = self._curInfo.isPerfectWin

	self._failure:SetActive(not self._isWin)
	self._rewards:SetActive(self._isWin)
	self._winTrue:SetActive(self._isWin)
	self._winFalse:SetActive(not self._isWin)
	self._perfectTrue:SetActive(self._isPerfectWin)
	self._perfectFalse:SetActive(not self._isPerfectWin)

	local ruleId = self._curInfo.curRuleId
	local ruleCfg = PerfectRuleModeConfig.instance:getRuleCfgById(self._challengeId, ruleId)
	local modeId = self._curInfo.curModeId
	local modeCfg = PerfectRuleModeConfig.instance:getModeCfgs(self._challengeId, modeId)

	self._txtPerfect.text = ruleCfg.missionDesc
	self._txtTips.text = ""

	self._btnCancel.gameObject:SetActive(false)
	self._btnOk.gameObject:SetActive(false)
	self._btnReGame.gameObject:SetActive(false)

	if not self._isWin then
		self._txtTitle.text = lang("战斗失败")

		self._btnCancel.gameObject:SetActive(true)
	else
		self._txtTitle.text = lang("战斗胜利")

		self._btnOk.gameObject:SetActive(true)

		if self._isPerfectWin then
			self._scoreTxt:SetNum(modeCfg.perfectPassScore)
		else
			self._txtTips.text = "未达到完美通关可重新挑战不消耗次数"

			self._btnReGame.gameObject:SetActive(true)
			self._scoreTxt:SetNum(modeCfg.normalPassScore)
		end
	end
end

return AxiuResultView
