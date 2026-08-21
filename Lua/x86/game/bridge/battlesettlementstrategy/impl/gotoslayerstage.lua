local var_0_0 = class("GotoSlayerStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoSlayerResult(arg_1_1.num, arg_1_1.stageData, arg_1_1.battleResult)
end

function var_0_0.GotoSlayerResult(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	function BattleCallLuaCallBack()
		gameContext:Go("/battleSlayerResult", {
			stageData = arg_2_2,
			rewardList = {},
			battleResult = arg_2_3
		})
		EndBattleLogic(arg_2_1)
	end
end

return var_0_0
