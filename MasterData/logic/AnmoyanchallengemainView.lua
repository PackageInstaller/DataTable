-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/view/anmoyanchallenge/AnmoyanchallengemainView.lua

module("logic.extensions.wuwenchallenge.view.anmoyanchallenge.AnmoyanchallengemainView", package.seeall)

local AnmoyanchallengemainView = class("AnmoyanchallengemainView", WuWenChallengeMainView)

function AnmoyanchallengemainView:unbindEvents()
	AnmoyanchallengemainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnShop)
end

function AnmoyanchallengemainView:bindEvents()
	AnmoyanchallengemainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
end

function AnmoyanchallengemainView:onEnter()
	AnmoyanchallengemainView.super.onEnter(self)
	SignInBuffController.instance:addCommonSignInBuffView(self._buffRoot, self._viewPresentor, self._activityId)
end

function AnmoyanchallengemainView:buildUI()
	AnmoyanchallengemainView.super.buildUI(self)

	self._buffRoot = self:getGo("buffRoot")
	self._btnShop = self:getGo("btnShop")
end

function AnmoyanchallengemainView:_onClickShop()
	GotoMgr.gotoByString(self._actCfg.jumpTo[4])
end

function AnmoyanchallengemainView:_onClickRule()
	TipsFacade.instance:openRulesView("anmoyanchallengemainview_rule")
end

function AnmoyanchallengemainView:_onClickChallenge()
	local levelCfgs = WuWenChallengeConfig.instance:getPhaseCfgs(self._activityId)

	if WuWenChallengeModel.instance:getCurLevel(self._activityId) > #levelCfgs then
		FloatWordMgr.instance:show(lang("您已通关"))

		return
	else
		UIStateManager.instance:push(ViewName.AnmoyanchallengelevelView, self._activityId)
	end
end

return AnmoyanchallengemainView
