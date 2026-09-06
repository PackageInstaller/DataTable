-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/babybus/view/BabybusfragmentView.lua

module("logic.extensions.babybus.view.BabybusfragmentView", package.seeall)

local BabybusfragmentView = class("BabybusfragmentView", ViewComponent)

function BabybusfragmentView:ctor()
	BabybusfragmentView.super.ctor(self)
end

function BabybusfragmentView:unbindEvents()
	BabybusfragmentView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSet:RemoveClickListener()
end

function BabybusfragmentView:bindEvents()
	BabybusfragmentView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnSet:AddClickListener(self._onClickbtnSet, self)
end

function BabybusfragmentView:buildUI()
	BabybusfragmentView.super.buildUI(self)

	self._lockGos = {}

	for i = 1, 5 do
		self._lockGos[i] = self:getGo("paint/lock_" .. i)
	end

	self._btnClose = self:getBtn("btnClose")
	self._btnSet = self:getBtn("btnSet")
end

function BabybusfragmentView:onExit()
	BabybusfragmentView.super.onExit(self)
end

function BabybusfragmentView:onEnter()
	BabybusfragmentView.super.onEnter(self)
	self:_updateUI()
end

function BabybusfragmentView:_onClickbtnClose()
	self:close()
end

function BabybusfragmentView:_updateUI()
	local progress = BabybusModel.instance:getCurprogress()

	for i, v in ipairs(self._lockGos) do
		goutil.setActive(v, progress < i)
	end
end

function BabybusfragmentView:_onClickbtnSet()
	UIStateManager.instance:push(ViewName.SystemSetting, 5)
end

return BabybusfragmentView
