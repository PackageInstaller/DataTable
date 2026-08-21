local var_0_0 = class("GotoSpKaliStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoSPHeroChallengeStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function var_0_0.GotoSPHeroChallengeStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = 1

	if isSuccess(arg_2_1) then
		function BattleCallLuaCallBack()
			local var_3_0, var_3_1 = GetResultReward()

			SPKaliChallengeData:UpdateStageData(arg_2_2, var_3_1)
			manager.notify:Invoke(ACTIVITY_KALI_INFO)
			gameContext:Go("/newSettlement", {
				stageData = arg_2_2,
				score = var_2_0,
				battleResult = arg_2_4,
				rewardList = var_3_0
			})
		end
	else
		arg_2_0:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	end
end

return var_0_0
