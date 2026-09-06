-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/op220701/ActivityOP220701VedioView.lua

module("logic.extensions.operationsummary.view.op220701.ActivityOP220701VedioView", package.seeall)

local ActivityOP220701VedioView = class("ActivityOP220701VedioView", ViewComponent)

function ActivityOP220701VedioView:ctor()
	ActivityOP220701VedioView.super.ctor(self)
end

function ActivityOP220701VedioView:unbindEvents()
	ActivityOP220701VedioView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnJump)
	GameUtil.rmClickHandler(GameUtil.asBtn(self._content))
end

function ActivityOP220701VedioView:bindEvents()
	ActivityOP220701VedioView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnJump, self._onClickCloseT, self)
	GameUtil.addClickHandler(GameUtil.asBtn(self._content), self._onClickBg, self)
end

function ActivityOP220701VedioView:buildUI()
	ActivityOP220701VedioView.super.buildUI(self)

	self._btnJumpGo = self:getGo("jump")
	self._btnJump = self:getBtn("jump")
	self._content = self:getGo("content")
end

function ActivityOP220701VedioView:_onClickBg()
	goutil.setActive(self._btnJumpGo, true)
end

function ActivityOP220701VedioView:onExit()
	ActivityOP220701VedioView.super.onExit(self)
	AudioPlayerEx.instance:pause(false)

	if self._hudRoot then
		self._hudRoot.gameObject:SetActive(true)

		self._hudRoot = nil
	end

	self._popupView = nil
end

function ActivityOP220701VedioView:onEnter()
	ActivityOP220701VedioView.super.onEnter(self)

	self._url = self:getFirstParam()
	self._hudRoot = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)

	if self._hudRoot then
		self._hudRoot.gameObject:SetActive(false)
	end

	goutil.setActive(self._btnJumpGo, false)

	self._isVideoError = false

	VideoFacade:play(self._url, false, UnityEngine.Video.VideoAspectRatio.FitVertically, self._onMoviePlayStart, self._onMoviePlayFinished, self, self._onVideoPlayError, self)
end

function ActivityOP220701VedioView:_onMoviePlayStart()
	AudioPlayerEx.instance:pause(true)
end

function ActivityOP220701VedioView:_onMoviePlayFinished()
	if self._popupView and self._popupView:isOpen() then
		self._popupView:close()
	end

	self:close()
end

function ActivityOP220701VedioView:_onVideoPlayError()
	self._isVideoError = true
end

function ActivityOP220701VedioView:onExitFinished()
	VideoFacade.instance:stopVideo(self._url)
end

function ActivityOP220701VedioView:_onClickCloseT()
	self._popupView = TipsFacade.instance:openPopupWindow(lang("tip"), lang("是否确认跳过当前视频？"), function()
		self:close()
	end, nil, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
end

return ActivityOP220701VedioView
