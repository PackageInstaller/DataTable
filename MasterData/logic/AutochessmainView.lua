-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessmainView.lua

module("logic.extensions.autochess.view.AutochessmainView", package.seeall)

local AutochessmainView = class("AutochessmainView", ViewComponent)

function AutochessmainView:ctor()
	AutochessmainView.super.ctor(self)
end

function AutochessmainView:unbindEvents()
	AutochessmainView.super.unbindEvents(self)
	self._btnReward:RemoveClickListener()
	self._btnReport:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
end

function AutochessmainView:bindEvents()
	AutochessmainView.super.bindEvents(self)
	self._btnReward:AddClickListener(self._onClickbtnReward, self)
	self._btnReport:AddClickListener(self._onClickbtnReport, self)
	self._btnStart:AddClickListener(self._onClickbtnStart, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnRank:AddClickListener(self._onClickbtnRank, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnExchange:AddClickListener(self._onClickbtnExchange, self)
end

function AutochessmainView:buildUI()
	AutochessmainView.super.buildUI(self)

	self._btnReward = self:getBtn("btns/btnReward")
	self._btnReport = self:getBtn("btns/btnReport")
	self._btnStart = self:getBtn("btnStart")
	self._btnClose = self:getBtn("btnClose")
	self._btnRank = self:getBtn("btns/btnRank")
	self._btnTip = self:getBtn("btnTip")
	self._goldbarGo = self:getGo("goldbar")
	self._txtOpenTime = self:getTxt("btnStart/txtOpenTime")
	self._txtTime = self:getTxt("time/txt")
	self._effectGo = self:getGo("effect")
	self._redPointBtnTaskGo = self:getGo("btns/btnReward/redPoint")
	self._btnExchange = self:getBtn("btns/btnExchange")
end

function AutochessmainView:onExit()
	AutochessmainView.super.onExit(self)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)
	end

	self._effectHandler = nil

	RedPointController.instance:unregRedPoint(self._redPointBtnTaskGo)
end

function AutochessmainView:onEnter()
	AutochessmainView.super.onEnter(self)
	self.addGEvent(self, AutoChessAgent.ACInfoRes, self.onACInfoRes, self)

	self._activityType = GameEnum.ActivityType.AutoChess
	self._activityId = ActivityDefineController.instance:getActivityIdByType(self._activityType)

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开启")
		self:close()

		return
	end

	local str = AutochessConfig.instance:getCommonValue("mainviewgoldstr")

	self:_setTopGoldBar(self._goldbarGo, str)
	AutoChessAgent.instance:sendPM_ACInfoReq(self._activityId)

	self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	self:_setOpenTime()
	self:_setEffect()
	RedPointController.instance:regRedPoint(self._redPointBtnTaskGo, 506)
end

function AutochessmainView:_onClickbtnReward()
	UIStateManager.instance:push(ViewName.AutochesstaskView)
end

function AutochessmainView:_onClickbtnReport()
	UIStateManager.instance:push(ViewName.AutochessreportView)
end

function AutochessmainView:_onClickbtnRank()
	UIStateManager.instance:push(ViewName.AutochessrankView)
end

function AutochessmainView:_onClickbtnStart()
	local isActActive = ActivityDefineController.instance:isInActivityTimeById(self._activityType, self._activityId)

	if not isActActive then
		FloatWordMgr.instance:show("当前未在开启时间段内")

		return
	end

	local isOpen = AutochessController.instance:isOpenTime(self._activityId)

	if not isOpen then
		FloatWordMgr.instance:show("当前未在开启时间段内")

		return
	end

	AutochessController.instance:startMatch(self._activityId)
end

function AutochessmainView:_onClickbtnClose()
	self:close()
end

function AutochessmainView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("autochessmainview")
end

function AutochessmainView:onACInfoRes()
	return
end

function AutochessmainView:_setOpenTime()
	local str = AutochessController.instance:getOpenTimeDesc(self._activityId)

	self._txtOpenTime.text = string.format("开启时间：%s", str)
end

function AutochessmainView:_setEffect()
	local effName = "20230728/zizouqi/fx_ui_zizouqi_fenwei.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(0, 0, 0)
end

function AutochessmainView:_onClickbtnExchange()
	FuncOpenController.instance:openFunc(191, self._activityType, self._activityId)
end

return AutochessmainView
