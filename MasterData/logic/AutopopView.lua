-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/AutopopView.lua

module("logic.extensions.bonus.view.AutopopView", package.seeall)

local AutopopView = class("AutopopView", ViewComponent)

function AutopopView:ctor()
	AutopopView.super.ctor(self)
end

function AutopopView:buildUI()
	AutopopView.super.buildUI(self)

	self._closeButton = self:getBtn("Close")
	self.container = self:getGo("container")
end

function AutopopView:bindEvents()
	AutopopView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function AutopopView:unbindEvents()
	AutopopView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function AutopopView:destroyUI()
	AutopopView.super.destroyUI(self)
end

function AutopopView:onEnter()
	AutopopView.super.onEnter(self)
	GameUtil.setAnchoredPos(self.container, 0, 0)

	local str = self:getFirstParam()

	if not string.nilorempty(str) then
		local data = GameUtil.jsonToTable(str)

		if data then
			if data.viewname then
				self:showTabAt(self.container, data.viewname, data.parameter)
			end

			GameUtil.setAnchoredPos(self.container, checknumber(data.posX), checknumber(data.posY))
		end
	else
		self:close()
	end
end

function AutopopView:onEnterFinished()
	AutopopView.super.onEnterFinished(self)
end

function AutopopView:onExit()
	AutopopView.super.onExit(self)
end

function AutopopView:onExitFinished()
	AutopopView.super.onExitFinished(self)
end

function AutopopView:_onClickClose()
	self:close()
end

return AutopopView
