local var_0_0 = class("GotoMythicFinalStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoMythicFinalStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function var_0_0.GotoMythicFinalStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	if isSuccess(arg_2_1) and not arg_2_5 then
		function BattleCallLuaCallBack()
			manager.story:RemovePlayer()
			gameContext:Go("/battleMythicFinalResultView", {
				multiple = 1,
				stageData = arg_2_2,
				battleResult = arg_2_4
			})
			EndBattleLogic(arg_2_1)
		end
	else
		function BattleCallLuaCallBack()
			JumpTools.OpenPageByJump("/battleMythicOmegaFailedView", {
				stageData = arg_2_2,
				battleResult = arg_2_4,
				isHalfWay_ = arg_2_0.tempData.isHalfWay_
			})
			EndBattleLogic(arg_2_1)
		end
	end
end

return var_0_0
