-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/facade/FootBallReportViewFacade.lua

module("logic.extensions.football.facade.FootBallReportViewFacade", package.seeall)

local FootBallReportViewFacade = class("FootBallReportViewFacade", BaseFacade)

function FootBallReportViewFacade:ctor()
	self._roundReportView = false
end

function FootBallReportViewFacade:registerView(view)
	self._roundReportView = view
end

function FootBallReportViewFacade:unregisterView()
	self._roundReportView = false
end

function FootBallReportViewFacade:playStartReport(callback, callbackSelf)
	if not self:checkView() then
		return
	end

	self._roundReportView:playStartReport(callback, callbackSelf)
end

function FootBallReportViewFacade:playEndReport(callback, callbackSelf)
	if not self:checkView() then
		return
	end

	self._roundReportView:playEndReport(callback, callbackSelf)
end

function FootBallReportViewFacade:playOperateCampStartReport(callback, callbackSelf)
	if not self:checkView() then
		return
	end

	self._roundReportView:playOperateCampStartReport(callback, callbackSelf)
end

function FootBallReportViewFacade:playOtherCampStartReport(callback, callbackSelf)
	if not self:checkView() then
		return
	end

	self._roundReportView:playOtherCampStartReport(callback, callbackSelf)
end

function FootBallReportViewFacade:playScoreReport(callback, callbackSelf)
	if not self:checkView() then
		return
	end

	self._roundReportView:playScoreReport(callback, callbackSelf)
end

function FootBallReportViewFacade:playRoundStartReport(callback, callbackSelf)
	if not self:checkView() then
		return
	end

	self._roundReportView:playRoundStartReport(callback, callbackSelf)
end

function FootBallReportViewFacade:checkView()
	if not self._roundReportView then
		if enableErrorLog then
			printError("FootBallReportViewFacade::need to register view first!")
		end

		return false
	end

	return true
end

FootBallReportViewFacade.instance = FootBallReportViewFacade.New()

return FootBallReportViewFacade
