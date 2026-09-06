-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroMatchView.lua

module("logic.extensions.aoqihero.view.AoqiHeroMatchView", package.seeall)

local AoqiHeroMatchView = class("AoqiHeroMatchView", ViewComponent)

function AoqiHeroMatchView:ctor()
	AoqiHeroMatchView.super.ctor(self)
end

function AoqiHeroMatchView:unbindEvents()
	AoqiHeroMatchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
end

function AoqiHeroMatchView:bindEvents()
	AoqiHeroMatchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
end

function AoqiHeroMatchView:buildUI()
	AoqiHeroMatchView.super.buildUI(self)

	self._matching = self:getGo("matching")
	self._txtTime = self:getTxt("matching/txtTime")
	self._btnCancel = self:getGo("matching/btnCancel")
end

function AoqiHeroMatchView:onExit()
	AoqiHeroMatchView.super.onExit(self)
	removetimer(self._updateTimer, self)
end

function AoqiHeroMatchView:onEnter()
	AoqiHeroMatchView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_NotifyAoQiHeroPvpGameStartRes, self.close, self)
	self.addGEvent(self, GlobalNotify.PM_NotifyAoQiHeroPvPMailFailRes, self._PM_NotifyAoQiHeroPvPMailFailRes, self)
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroPvPCancelMatchRes, self.close, self)

	self._activityId = checknumber(self:getFirstParam())

	self:_startMatch()
end

function AoqiHeroMatchView:_startMatch()
	goutil.setActive(self._suc, false)
	goutil.setActive(self._matching, true)

	self._timer = 0
	self._txtTime.text = GameUtil.FormatTimeSymbol(self._timer)
	self._startTime = ServerTime.now()

	settimer(1, self._updateTimer, self, true)
	AoQiHeroAgent.instance:sendPM_AoQiHeroPvPMatchReq(self._activityId)
end

function AoqiHeroMatchView:_updateTimer()
	self._timer = ServerTime.now() - self._startTime
	self._txtTime.text = GameUtil.FormatTimeSymbol(self._timer)
end

function AoqiHeroMatchView:_PM_NotifyAoQiHeroPvPMailFailRes()
	FloatWordMgr.instance:show(lang("匹配超时"))
	self:close()
end

function AoqiHeroMatchView:_onClickCancel()
	AoQiHeroAgent.instance:sendPM_AoQiHeroPvPCancelMatchReq()
end

return AoqiHeroMatchView
