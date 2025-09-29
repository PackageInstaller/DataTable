-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/facade/BattleCalculateViewFacade.lua

module("logic.extensions.battle.facade.BattleCalculateViewFacade", package.seeall)

local BattleCalculateViewFacade = class("BattleCalculateViewFacade", BaseFacade)

function BattleCalculateViewFacade:ctor()
	self._isRegistered = false
	self._battleCalculateView = false
	self._battleCalculateResultView = false
	self._battleReportView = false
end

function BattleCalculateViewFacade:registerView(view)
	local views = view._viewPresentor._views

	self._isRegistered = true
	self._battleCalculateView = views[1]
	self._battleCalculateResultView = views[2]
	self._battleReportView = views[3]
	self._battleReportDetailView = views[4]
end

function BattleCalculateViewFacade:unregisterView()
	self._isRegistered = false
	self._battleCalculateView = false
	self._battleCalculateResultView = false
	self._battleReportView = false
	self._battleReportDetailView = false
end

function BattleCalculateViewFacade:CaptureSceneForBg()
	if self._battleCalculateResultView then
		self._battleCalculateResultView:CaptureSceneForBg()
	end
end

function BattleCalculateViewFacade:preSetPageInfo()
	if self._battleReportView then
		self._battleReportView:preSetPageInfo()
	end
end

function BattleCalculateViewFacade:showEnterAnim()
	if self._battleReportView then
		self._battleReportView:showEnterAnim()
	end

	if self._battleReportDetailView then
		self._battleReportDetailView:playExpAnim()
	end
end

function BattleCalculateViewFacade:resetPosInfo()
	if self._battleReportView then
		self._battleReportView:resetPosInfo()
	end
end

function BattleCalculateViewFacade:resetUI()
	if self._battleCalculateView then
		self._battleCalculateView:resetUI()
	end
end

function BattleCalculateViewFacade:resetAllView()
	if self._battleCalculateView then
		self._battleCalculateView:resetAllView()
	end
end

function BattleCalculateViewFacade:getResultParent()
	if self._battleCalculateView then
		self._battleCalculateView:getResultParent()
	end
end

function BattleCalculateViewFacade:resetScreenView()
	if self._battleCalculateView then
		self._battleCalculateView:resetPageInfo()
	end
end

function BattleCalculateViewFacade:getPlayHead()
	if self._battleReportDetailView then
		return self._battleReportDetailView:getPlayHead()
	end

	return false
end

function BattleCalculateViewFacade:getPlayReward()
	if self._battleReportDetailView then
		return self._battleReportDetailView:getPlayReward()
	end

	return false
end

function BattleCalculateViewFacade:skipHeadAndRewardAnimation()
	if self._battleReportDetailView then
		self._battleReportDetailView:skipHeadAndRewardAnimation()
	end
end

BattleCalculateViewFacade.instance = BattleCalculateViewFacade.New()

return BattleCalculateViewFacade
