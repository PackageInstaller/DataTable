-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarymarket/view/AnniversaryMarketFriendView.lua

module("logic.extensions.anniversarymarket.view.AnniversaryMarketFriendView", package.seeall)

local AnniversaryMarketFriendView = class("AnniversaryMarketFriendView", ViewComponent)

function AnniversaryMarketFriendView:ctor()
	AnniversaryMarketFriendView.super.ctor(self)
end

function AnniversaryMarketFriendView:unbindEvents()
	AnniversaryMarketFriendView.super.unbindEvents(self)
	self._inputComp:RemoveOnValueChanged()
	GameUtil.rmClickHandler(self._btnSold)
	GameUtil.rmClickHandler(self._btnClose)
end

function AnniversaryMarketFriendView:bindEvents()
	AnniversaryMarketFriendView.super.bindEvents(self)
	self._inputComp:AddOnValueChanged(self._inputValueChanged, self)
	GameUtil.addClickHandler(self._btnSold, self._onClickBtnSold, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AnniversaryMarketFriendView:buildUI()
	AnniversaryMarketFriendView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._inputComp = self:getInput("InputC_Search")
	self._btnSold = self:getGo("btnSold")
end

function AnniversaryMarketFriendView:onExit()
	AnniversaryMarketFriendView.super.onExit(self)
end

function AnniversaryMarketFriendView:onEnter()
	AnniversaryMarketFriendView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AnniversaryMarketGetOtherInfoRes, self._getOtherInfoRes, self)

	self._lastInputTxt = ""

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
end

function AnniversaryMarketFriendView:_inputValueChanged(text)
	local subStr = string.sub(text, 1, 150)

	if self._inputComp:GetText() == self._lastInputTxt then
		return
	end

	self._lastInputTxt = subStr

	self._inputComp:SetText(subStr)
end

function AnniversaryMarketFriendView:_onClickBtnSold()
	local result = string.match(self._lastInputTxt, "%【(.-)%】")

	if result then
		self._lastInputTxt = result
	end

	if string.nilorempty(self._lastInputTxt) then
		FloatWordMgr.instance:show("分享码不存在，再仔细检查下~")

		return
	end

	AnniversaryMarketController.instance:sendPM_AnniversaryMarketGetOtherInfoReq(self._activityId, self._lastInputTxt)
end

function AnniversaryMarketFriendView:_getOtherInfoRes(msg, isCorrectShareCode)
	if isCorrectShareCode then
		local isFriend = true

		UIStateManager.instance:push(ViewName.AnniversaryMarketSoldView, self._activityId, isFriend, self._lastInputTxt)
	end
end

return AnniversaryMarketFriendView
