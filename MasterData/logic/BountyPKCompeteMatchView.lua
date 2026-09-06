-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/view/BountyPKCompeteMatchView.lua

module("logic.extensions.bountypkcompete.view.BountyPKCompeteMatchView", package.seeall)

local BountyPKCompeteMatchView = class("BountyPKCompeteMatchView", ViewComponent)

function BountyPKCompeteMatchView:ctor()
	BountyPKCompeteMatchView.super.ctor(self)
end

function BountyPKCompeteMatchView:unbindEvents()
	BountyPKCompeteMatchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function BountyPKCompeteMatchView:bindEvents()
	BountyPKCompeteMatchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickCloseT, self)
end

function BountyPKCompeteMatchView:buildUI()
	BountyPKCompeteMatchView.super.buildUI(self)

	self._matching = self:getGo("matching")
	self._btnClose = self:getBtn("matching/btnCancel")
	self._txtTime = self:getTxt("matching/txtTime")
end

function BountyPKCompeteMatchView:onExit()
	BountyPKCompeteMatchView.super.onExit(self)
	self:removeTimer()
	GlobalDispatcher:removeListener(GlobalNotify.BPK_NotifyGameStartRes, self._onMatchingSuccessRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.BPK_CancelMatchingRes, self._onCancelMatchingRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.BPK_NotifyMatchingOverTimeRes, self._onMatchingOverTimeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.BPK_NotifyMatchFailRes, self._onMatchingFailRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.BPK_MatchingRes, self._onMatchingRes, self)
	self._matchModel:reqCancelMatch()
end

function BountyPKCompeteMatchView:onEnter()
	BountyPKCompeteMatchView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.BPK_NotifyGameStartRes, self._onMatchingSuccessRes, self)
	GlobalDispatcher:addListener(GlobalNotify.BPK_CancelMatchingRes, self._onCancelMatchingRes, self)
	GlobalDispatcher:addListener(GlobalNotify.BPK_NotifyMatchingOverTimeRes, self._onMatchingOverTimeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.BPK_NotifyMatchFailRes, self._onMatchingFailRes, self)
	GlobalDispatcher:addListener(GlobalNotify.BPK_MatchingRes, self._onMatchingRes, self)
	goutil.setActive(self._matching, true)

	self._matchModel = self:getFirstParam()
	self._maxMatchTime = self._matchModel:getMaxMatchTime()
	self._startMatchTime = UnityEngine.Time.realtimeSinceStartup

	self._matchModel:reqStartMatch()
	GameUtil.SetActive(self._btnClose, not self._matchModel:isHideCancelBtn())
	self:addTimer()
	self:_tick()
end

function BountyPKCompeteMatchView:removeTimer()
	removetimer(self._tick, self)
end

function BountyPKCompeteMatchView:addTimer()
	settimer(0.3, self._tick, self)
end

function BountyPKCompeteMatchView:_tick()
	local deltaTime = UnityEngine.Time.realtimeSinceStartup - self._startMatchTime

	self._txtTime.text = GameUtil.FormatTimeSymbol(deltaTime)

	if deltaTime >= self._maxMatchTime then
		FloatWordMgr.instance:show(lang("bountypk__4"))
		self:_applyDispose(BountyPkCompeteMatchModel.ClientOverTime)
	end
end

function BountyPKCompeteMatchView:_onMatchingSuccessRes()
	self._matchModel:setMatchingState(false)
	self:_applyDispose(BountyPkCompeteMatchModel.MatchSuccess)
end

function BountyPKCompeteMatchView:_onCancelMatchingRes()
	self:_applyDispose(BountyPkCompeteMatchModel.CancelMatch)
end

function BountyPKCompeteMatchView:_onMatchingOverTimeRes()
	FloatWordMgr.instance:show(lang("bountypk__4"))
	self:_applyDispose(BountyPkCompeteMatchModel.ServerOverTime)
end

function BountyPKCompeteMatchView:_onMatchingFailRes()
	FloatWordMgr.instance:show("匹配失败")
	self:_applyDispose(BountyPkCompeteMatchModel.MatchFail)
end

function BountyPKCompeteMatchView:_onMatchingRes(status)
	self._matchModel:setMatchingState(status == 0)

	if status ~= 0 then
		self:_onMatchingFailRes()
	end
end

function BountyPKCompeteMatchView:_applyDispose(reason)
	self:close()
	self._matchModel:disposeMatch(reason)
end

function BountyPKCompeteMatchView:_onClickCloseT()
	self._matchModel:reqCancelMatch()
end

return BountyPKCompeteMatchView
