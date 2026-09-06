-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantoneseopera/view/CantoneseoperapopView.lua

module("logic.extensions.cantoneseopera.view.CantoneseoperapopView", package.seeall)

local CantoneseoperapopView = class("CantoneseoperapopView", ViewComponent)

function CantoneseoperapopView:ctor()
	CantoneseoperapopView.super.ctor(self)
end

function CantoneseoperapopView:unbindEvents()
	CantoneseoperapopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
end

function CantoneseoperapopView:bindEvents()
	CantoneseoperapopView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function CantoneseoperapopView:buildUI()
	CantoneseoperapopView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.txtDesc = self:getTxt("txtDesc")
end

function CantoneseoperapopView:onExit()
	CantoneseoperapopView.super.onExit(self)
end

function CantoneseoperapopView:onEnter()
	CantoneseoperapopView.super.onEnter(self)

	self.prizeNodeId = self:getFirstParam()

	local descList = CantoneseOperaConfig.instance:getDescList(self.prizeNodeId) or {}

	if not descList[1] then
		self.txtDesc.text = CantoneseOperaController.instance.userEndNum
	end
end

return CantoneseoperapopView
