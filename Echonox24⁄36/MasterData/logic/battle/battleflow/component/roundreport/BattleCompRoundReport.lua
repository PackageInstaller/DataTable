-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/roundreport/BattleCompRoundReport.lua

module("logic.battle.battleflow.component.roundreport.BattleCompRoundReport", package.seeall)

local BattleCompRoundReport = class("BattleCompRoundReport", IBattleFlowComp, IBattleRoundReport)

function BattleCompRoundReport:onStart()
	self._model = self.flow.model or false
end

function BattleCompRoundReport:onClear()
	self._model = false
end

function BattleCompRoundReport:playRoundStartedReport(round, callback, callbackSelf)
	BattleRoundReportViewFacade.instance:playOperateCampStartReport(callback, callbackSelf)
end

function BattleCompRoundReport:playPlayerStartedReport(campId, callback, callbackSelf)
	local operateCampId = self._model:getOperateCampId()

	if campId == operateCampId then
		BattleRoundReportViewFacade.instance:hideOtherCampStartReport()
		Handler:executeCallback(callback, callbackSelf)
	else
		BattleRoundReportViewFacade.instance:playOtherCampStartReport(campId, callback, callbackSelf)
	end
end

return BattleCompRoundReport
