-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/view/BountyPKCompetePopView.lua

module("logic.extensions.bountypkcompete.view.BountyPKCompetePopView", package.seeall)

local BountyPKCompetePopView = class("BountyPKCompetePopView", ViewComponent)

function BountyPKCompetePopView:ctor()
	BountyPKCompetePopView.super.ctor(self)
end

function BountyPKCompetePopView:ctor()
	BountyPKCompetePopView.super.ctor(self)
end

function BountyPKCompetePopView:unbindEvents()
	BountyPKCompetePopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function BountyPKCompetePopView:bindEvents()
	BountyPKCompetePopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
end

function BountyPKCompetePopView:buildUI()
	BountyPKCompetePopView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._txtCost = self:getTxt("txtCost")
	self._txtTip = self:getTxt("txtTip")
end

function BountyPKCompetePopView:onExit()
	BountyPKCompetePopView.super.onExit(self)
end

function BountyPKCompetePopView:onEnter()
	BountyPKCompetePopView.super.onEnter(self)

	local params = self:getFirstParam()

	self._callback = params.callback

	local cost = params.cost
	local total = params.total

	self._txtCost.text = langPara("bountypk__18", total)
	self._txtTip.text = langPara("bountypk__13", cost)
end

function BountyPKCompetePopView:_onClickSure()
	self:close()
	GameUtil.callBack(self._callback)
end

return BountyPKCompetePopView
