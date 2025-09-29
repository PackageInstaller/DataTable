-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/battleflow/FootBallCompRoundReport.lua

module("logic.extensions.football.battleflow.FootBallCompRoundReport", package.seeall)

local FootBallCompRoundReport = class("FootBallCompRoundReport", IBattleFlowComp, IBattleRoundReport)

function FootBallCompRoundReport:onStart()
	self._model = self.flow.model or false
end

function FootBallCompRoundReport:onClear()
	self._model = false
end

function FootBallCompRoundReport:playStartReport(callback, callbackSelf)
	FootBallReportViewFacade.instance:playStartReport(callback, callbackSelf)
end

function FootBallCompRoundReport:playEndReport(callback, callbackSelf)
	FootBallReportViewFacade.instance:playEndReport(callback, callbackSelf)
end

function FootBallCompRoundReport:playRoundStartedReport(round, callback, callbackSelf)
	FootBallReportViewFacade.instance:playRoundStartReport(callback, callbackSelf)
end

function FootBallCompRoundReport:playPlayerStartedReport(campId, callback, callbackSelf)
	local operateCampId = self._model:getOperateCampId()

	if operateCampId == campId then
		FootBallReportViewFacade.instance:playOperateCampStartReport(callback, callbackSelf)
	else
		FootBallReportViewFacade.instance:playOtherCampStartReport(callback, callbackSelf)
	end
end

function FootBallCompRoundReport:playPlayerEndedReport(campId, callback, callbackSelf)
	if FootballModel.instance:getAndResetScoreUpdated() then
		FootBallReportViewFacade.instance:playScoreReport(callback, callbackSelf)
	else
		Handler:executeCallback(callback, callbackSelf)
	end
end

return FootBallCompRoundReport
