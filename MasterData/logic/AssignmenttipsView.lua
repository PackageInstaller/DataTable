-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assignment/view/AssignmenttipsView.lua

module("logic.extensions.assignment.view.AssignmenttipsView", package.seeall)

local AssignmenttipsView = class("AssignmenttipsView", ViewComponent)

function AssignmenttipsView:ctor()
	AssignmenttipsView.super.ctor(self)
end

function AssignmenttipsView:unbindEvents()
	AssignmenttipsView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function AssignmenttipsView:bindEvents()
	AssignmenttipsView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function AssignmenttipsView:buildUI()
	AssignmenttipsView.super.buildUI(self)

	self._txtMatDesc = self:getTxt("Nego_Main/txtMatDesc")
	self._btnSure = self:getBtn("Nego_Main/btnSure")
	self._bottomTipGo = self:getGo("Nego_Main/bottomTip")
	self._btnClose = self:getBtn("Nego_Main/btnClose")
end

function AssignmenttipsView:onExit()
	AssignmenttipsView.super.onExit(self)
end

function AssignmenttipsView:onEnter()
	AssignmenttipsView.super.onEnter(self)

	local params = self:getOpenParam()

	self._content = params[1]
	self._showBottomTip = params[2]
	self._callback = params[3]
	self._txtMatDesc.text = self._content

	goutil.setActive(self._bottomTipGo, self._showBottomTip)
end

function AssignmenttipsView:_onClickbtnSure()
	if self._callback then
		self._callback()
	end

	self:close()
end

function AssignmenttipsView:_onClickbtnClose()
	self:close()
end

return AssignmenttipsView
