-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/newyear/BaseupdatetipView.lua

module("logic.extensions.bonus.view.newyear.BaseupdatetipView", package.seeall)

local BaseupdatetipView = class("BaseupdatetipView", ViewComponent)

function BaseupdatetipView:ctor()
	BaseupdatetipView.super.ctor(self)
end

function BaseupdatetipView:unbindEvents()
	GameUtil.rmClickHandler(self.btnSure)
	GameUtil.rmClickHandler(self.btnClose)
	BaseupdatetipView.super.unbindEvents(self)
end

function BaseupdatetipView:bindEvents()
	BaseupdatetipView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnSure, self.close, self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function BaseupdatetipView:buildUI()
	BaseupdatetipView.super.buildUI(self)

	self.tab = {}

	for i = 1, 4 do
		self.tab[i] = self:getGo("tab" .. i)
	end

	self.btnSure = self:getGo("btnSure")
	self.btnClose = self:getGo("btnClose")
end

function BaseupdatetipView:onExit()
	BaseupdatetipView.super.onExit(self)
end

function BaseupdatetipView:onEnter()
	BaseupdatetipView.super.onEnter(self)

	local id = checknumber(self:getFirstParam())

	for i = 1, 4 do
		goutil.setActive(self.tab[i], i == id)
	end
end

return BaseupdatetipView
