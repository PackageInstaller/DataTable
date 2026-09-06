-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aolaishilink/view/AoLaiShiLinkGiftView.lua

module("logic.extensions.aolaishilink.view.AoLaiShiLinkGiftView", package.seeall)

local AoLaiShiLinkGiftView = class("AoLaiShiLinkGiftView", ViewComponent)

function AoLaiShiLinkGiftView:ctor()
	AoLaiShiLinkGiftView.super.ctor(self)
end

function AoLaiShiLinkGiftView:unbindEvents()
	AoLaiShiLinkGiftView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRight)
	GameUtil.rmClickHandler(self._btnLeft)
end

function AoLaiShiLinkGiftView:bindEvents()
	AoLaiShiLinkGiftView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRight, self._onClickRight, self)
	GameUtil.addClickHandler(self._btnLeft, self._onClickLeft, self)
end

function AoLaiShiLinkGiftView:buildUI()
	AoLaiShiLinkGiftView.super.buildUI(self)

	self._btnClose = self:getGo("static/btnClose")
	self._btnRight = self:getGo("btnRight")
	self._btnLeft = self:getGo("btnLeft")
	self._imgRed = self:getGo("btnLeft/imgRed")
	self._txtTime = self:getTxt("openTime/txt")
end

function AoLaiShiLinkGiftView:onEnter()
	AoLaiShiLinkGiftView.super.onEnter(self)
	RedPointController.instance:regRedPoint(self._imgRed, RedPointModel.ID_O24)

	local activityType = GameEnum.ActivityType.Summary
	local activityId = AoLaiShiConfig.instance:getActivityCfg(ViewName.AoLaiShiMainView).activityId

	self._txtTime.text = GameUtil.getActTimeDesc(activityType, activityId)
end

function AoLaiShiLinkGiftView:onExit()
	AoLaiShiLinkGiftView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._imgRed)
end

function AoLaiShiLinkGiftView:_onClickLeft()
	GotoMgr.gotoByString("func#1007#summerholidayscheckinmainview")
end

function AoLaiShiLinkGiftView:_onClickRight()
	GotoMgr.gotoByString("func#1007#birthdaywelfaresignpagetourview")
end

return AoLaiShiLinkGiftView
