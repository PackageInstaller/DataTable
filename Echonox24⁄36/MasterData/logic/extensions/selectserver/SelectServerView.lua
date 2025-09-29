-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/selectserver/SelectServerView.lua

module("logic.extensions.selectserver.SelectServerView", package.seeall)

local M = class("SelectServerView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._btnClose = false
	self._serverListView = false
end

function M:buildUI()
	self._btnClose = self:getBtn("team_filter_tips_-1115795272")
	self._serverListView = ListBinderView.New(self:getFirstParam(), self:getGo("select_server_tips_1117486810"), self:getResInstance(ResName.Login_select_server_tab), SelectServerCell)

	self._serverListView:buildUI()
	self._serverListView:setViewPresentor(self._viewPresentor)
end

function M:destroyUI()
	self._serverListView:destroyUI()
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self._serverListView:onEnter()
end

function M:onExit()
	GlobalDispatcher:dispatchEvent(EventType.LOGIN_SELECT_SERVER_CLOSE_EVENT)
end

function M:_onClickClose()
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_window_close, nil, nil, nil)
	ViewMgr.instance:destroy(ViewName.SelectServer)
end

return M
