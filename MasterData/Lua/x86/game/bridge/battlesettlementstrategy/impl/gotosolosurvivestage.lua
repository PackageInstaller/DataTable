local GotoSoloSurviveStage = class("GotoSoloSurviveStage", BattleSettlementStrategyBase)

function GotoSoloSurviveStage:OnGotoSettlement(arg_1_1)
	self:GotoSoloSurviveStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function GotoSoloSurviveStage:GotoSoloSurviveStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	CheckBattleResultNeedAddHeroExp()

	function BattleCallLuaCallBack()
		local var_3_0 = arg_2_2:GetStageId()
		local var_3_1 = ActivityTools.GetActivityTheme((arg_2_2:GetActivityID()))

		gameContext:Go("/battleScorResult", {
			stageData = arg_2_2,
			battleResult = arg_2_4,
			title = GetTips("ACTIVITY_SOLO_SLAYER_FINISH")
		})
		EndBattleLogic(arg_2_1)
	end
end

return GotoSoloSurviveStage
