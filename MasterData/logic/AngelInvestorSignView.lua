-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelinvestor/view/AngelInvestorSignView.lua

module("logic.extensions.angelinvestor.view.AngelInvestorSignView", package.seeall)

local AngelInvestorSignView = class("AngelInvestorSignView", ViewComponent)

function AngelInvestorSignView:ctor()
	AngelInvestorSignView.super.ctor(self)
end

function AngelInvestorSignView:unbindEvents()
	AngelInvestorSignView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSign)
	GameUtil.rmClickHandler(self._btnTip)
end

function AngelInvestorSignView:bindEvents()
	AngelInvestorSignView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSign, self._onClickBtnSign, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function AngelInvestorSignView:buildUI()
	AngelInvestorSignView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnSign = self:getGo("btnSign")
	self._eff = self:getGo("eff")
end

function AngelInvestorSignView:onExit()
	AngelInvestorSignView.super.onExit(self)
	self:stopViewEffectUniGo(self._eff)
end

function AngelInvestorSignView:onEnter()
	AngelInvestorSignView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.EndStory, self._onEndStory, self)
	self.addGEvent(self, GlobalNotify.PM_AngelInvestorSignContractRes, self._onSignContractRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 588001
	end

	self._hasPlayEff = false
	self._actCfg = AngelInvestorConfig.instance:getActivityCfg(self._activityId)
end

function AngelInvestorSignView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function AngelInvestorSignView:_onClickBtnSign()
	if self._hasPlayEff then
		return
	end

	self._hasPlayEff = true

	local storyId = self._actCfg.storyId

	local function finishFunc()
		GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
	end

	self:playViewEffectUniGo("20241220/zhongyanzhizhan/fx_ui_bianbai.prefab", self._eff, self.mainGO.transform, false, finishFunc)
end

function AngelInvestorSignView:_onEndStory()
	AngelInvestorController.instance:sendPM_AngelInvestorSignContractReq(self._activityId)
end

function AngelInvestorSignView:_onSignContractRes()
	UIStateManager.instance:popByName(ViewName.AngelInvestorSignView)
	UIStateManager.instance:push(ViewName.AngelInvestorHangView, self._activityId)
end

return AngelInvestorSignView
