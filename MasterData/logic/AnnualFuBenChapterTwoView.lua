-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFuBenChapterTwoView.lua

module("logic.extensions.annualfuben.view.AnnualFuBenChapterTwoView", package.seeall)

local AnnualFuBenChapterTwoView = class("AnnualFuBenChapterTwoView", ViewComponent)

function AnnualFuBenChapterTwoView:ctor()
	AnnualFuBenChapterTwoView.super.ctor(self)
end

function AnnualFuBenChapterTwoView:unbindEvents()
	AnnualFuBenChapterTwoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnHold)
	GameUtil.rmClickHandler(self._btnBroken)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnTip)
end

function AnnualFuBenChapterTwoView:bindEvents()
	AnnualFuBenChapterTwoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnHold, self._onClickHold, self)
	GameUtil.addClickHandler(self._btnBroken, self._onClickBroken, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function AnnualFuBenChapterTwoView:buildUI()
	AnnualFuBenChapterTwoView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnHold = self:getGo("btnHold")
	self._btnBroken = self:getGo("btnBroken")
	self._btnRank = self:getGo("btnRank")
	self._txtTime = self:getTxt("worldTime/txtTime")
	self._txtBrokenStageInfo = self:getTxt("btnBroken/txtBrokenStageInfo")
	self._txtHoldStageInfo = self:getTxt("btnHold/txtHoldStageInfo")
	self._petCon = self:getGo("petCon")
end

function AnnualFuBenChapterTwoView:onExit()
	AnnualFuBenChapterTwoView.super.onExit(self)
	removetimer(self._onClock, self)
	RoleObjectPool.instance:removeRole(self._role)
end

function AnnualFuBenChapterTwoView:onEnter()
	AnnualFuBenChapterTwoView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AnnualFubenInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())
	self._activityCfg = AnnualFubenConfig.instance:getActivityCfg(self._activityId)

	self:_refreshView()

	if not AnnualFubenModel.instance:getFirstEnterChapterTwo(self._activityId) then
		AnnualFubenModel.instance:setFirstEnterChapterTwo(self._activityId)
		GlobalDispatcher:dispatch(GlobalNotify.StartStory, self._activityCfg.chapterTwoStoryId)
	end

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._activityCfg.faceId, self._petCon, 1)
end

function AnnualFuBenChapterTwoView:_refreshView()
	self:_initTimer()

	local holdStageCfgs = AnnualFubenConfig.instance:getHoldStageCfgs(self._activityId)
	local brokenStageCfgs = AnnualFubenConfig.instance:getBrokenStageCfgs(self._activityId)

	self._txtHoldStageInfo.text = langPara("关卡:%d/%d", AnnualFubenModel.instance:getHoldStageId(self._activityId), #holdStageCfgs)
	self._txtBrokenStageInfo.text = langPara("关卡:%d/%d", AnnualFubenModel.instance:getBrokenStageId(self._activityId), #brokenStageCfgs)
end

function AnnualFuBenChapterTwoView:_refreshClockInfo(curPrecent, curProgress, curShowTime)
	self._txtTime.text = GameUtil.FormatTimeSymbol(curShowTime)
end

function AnnualFuBenChapterTwoView:_initTimer()
	self._curProgressId, self._precentStart, self._startProgressTime, self._nexProgressId, self._nextProgressTime, self._precentEnd = AnnualFubenController.instance:getWorldProgressCfgInfo(self._activityId)

	removetimer(self._onClock, self)

	local curTime = ServerTime.now()

	self:_onClock()

	if self._nextProgressTime and curTime < self._nextProgressTime then
		settimer(1, self._onClock, self, true)
	end
end

function AnnualFuBenChapterTwoView:_onClock()
	local curTime = ServerTime.now()

	if not self._nextProgressTime then
		local curPrecent, curProgress, curShowTime = AnnualFubenController.instance:getWorldProgressInfo(self._activityId, self._curProgressId, self._precentStart, self._startProgressTime, self._nexProgressId, self._nextProgressTime, self._precentEnd)

		self:_refreshClockInfo(curPrecent, curProgress, curShowTime)
	elseif curTime < self._nextProgressTime then
		local curPrecent, curProgress, curShowTime = AnnualFubenController.instance:getWorldProgressInfo(self._activityId, self._curProgressId, self._precentStart, self._startProgressTime, self._nexProgressId, self._nextProgressTime, self._precentEnd)

		self:_refreshClockInfo(curPrecent, curProgress, curShowTime)
	else
		self:_initTimer()
	end
end

function AnnualFuBenChapterTwoView:_onClickHold()
	local holdStageCfgs = AnnualFubenConfig.instance:getHoldStageCfgs(self._activityId)

	if AnnualFubenModel.instance:getHoldStageId(self._activityId) < #holdStageCfgs then
		UIStateManager.instance:push(ViewName.AnnualFubenHoldStageView, self._activityId)
	else
		FloatWordMgr.instance:show(lang("已通关所有关卡"))
	end
end

function AnnualFuBenChapterTwoView:_onClickBroken()
	local brokenStageCfgs = AnnualFubenConfig.instance:getBrokenStageCfgs(self._activityId)

	if AnnualFubenModel.instance:getBrokenStageId(self._activityId) < #brokenStageCfgs then
		UIStateManager.instance:push(ViewName.AnnualFubenBrokenStageView, self._activityId)
	else
		FloatWordMgr.instance:show(lang("已通关所有关卡"))
	end
end

function AnnualFuBenChapterTwoView:_onClickRank()
	UIStateManager.instance:push(ViewName.AnnualFubenBrokenRankView, self._activityId)
end

function AnnualFuBenChapterTwoView:_onClickTip()
	TipsFacade.instance:openRulesView("annual_fuben_chapter_two_rule")
end

return AnnualFuBenChapterTwoView
