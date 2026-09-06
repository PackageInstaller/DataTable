-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/axiu/AxiuDifficultyView.lua

module("logic.extensions.timelimitedchallenge.view.axiu.AxiuDifficultyView", package.seeall)

local AxiuDifficultyView = class("AxiuDifficultyView", PerfectRuleModeDifficultyView)

function AxiuDifficultyView:ctor()
	AxiuDifficultyView.super.ctor(self)
end

function AxiuDifficultyView:unbindEvents()
	AxiuDifficultyView.super.unbindEvents(self)
end

function AxiuDifficultyView:bindEvents()
	AxiuDifficultyView.super.bindEvents(self)
end

function AxiuDifficultyView:onExit()
	AxiuDifficultyView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PerfectRuleModeProgressUpdate, self._infoUpdate, self)
end

function AxiuDifficultyView:buildUI()
	AxiuDifficultyView.super.buildUI(self)

	self._txtTotal = self:getTxt("txtTotal")
	self._times = self:getTxt("times")
	self._goldBarCon = self:getGo("goldBarCon")
end

function AxiuDifficultyView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.PerfectRuleModeProgressUpdate, self._infoUpdate, self)

	self._challengeId = checkint(self:getFirstParam())

	local cfg = PerfectRuleModeConfig.instance:getCommonCfg(self._challengeId)

	self._planId = cfg.progressPrizePlanId

	AxiuDifficultyView.super.onEnter(self)

	local progress = PerfectRuleModeModel.instance:getInfo(self._challengeId)
	local commonCfg = PerfectRuleModeConfig.instance:getCommonCfg(self._challengeId)
	local allTimes = commonCfg.dailyTimes + progress.hasBuyTimes
	local leftTimes = commonCfg.dailyTimes + progress.hasBuyTimes - progress.hasUseTimes

	self._txtTotal.text = progress.score or 0
	self._times.text = string.format("今日次数：%s/%s", leftTimes, allTimes)

	self:_firstOpenActivity()
end

function AxiuDifficultyView:_refreshRule()
	AxiuDifficultyView.super._refreshRule(self)

	local progress = PerfectRuleModeModel.instance:getInfo(self._challengeId) or {}

	self._txtTotal.text = checknumber(progress.score)
end

function AxiuDifficultyView:_infoUpdate()
	PerfectRuleFightAgent.instance:sendPM_PerfectRuleFightGetInfoReq(self._challengeId)
end

function AxiuDifficultyView:_firstOpenActivity()
	local plotId = 4290009

	if not GameUtil.getUserData("AxiuRuleMainView" .. plotId) then
		GlobalDispatcher:dispatch(GlobalNotify.PushStory, plotId, StoryModel.StoryType.SCCopy)
		GameUtil.saveUserData("AxiuRuleMainView" .. plotId, "1")
	end
end

return AxiuDifficultyView
