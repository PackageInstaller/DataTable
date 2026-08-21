local var_0_0 = class("GotoSkadiStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoSkadiStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function var_0_0.GotoSkadiStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if isSuccess(arg_2_1) then
		function BattleCallLuaCallBack()
			gameContext:Go("/battleLittleGameResultView", {
				stageData = arg_2_2,
				rewardList = {},
				battleResult = arg_2_4
			})
			EndBattleLogic(arg_2_1)
		end
	else
		arg_2_0:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	end
end

return var_0_0
