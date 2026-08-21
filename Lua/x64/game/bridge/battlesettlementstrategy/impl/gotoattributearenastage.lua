local var_0_0 = class("GotoAttributeArenaStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.num
	local var_1_1 = arg_1_1.stageData
	local var_1_2 = arg_1_1.starMissionData
	local var_1_3 = arg_1_1.battleResult
	local var_1_4, var_1_5 = GetResultReward()

	local function var_1_6()
		manager.story:RemovePlayer()
		gameContext:Go("/battleScorResult", {
			noOnceMore = true,
			stageData = var_1_1,
			rewardList = var_1_5,
			battleResult = var_1_3
		})
		EndBattleLogic(var_1_0)
	end

	if isSuccess(var_1_0) then
		function BattleCallLuaCallBack()
			local var_3_0 = var_1_1:GetStageId()

			manager.story:CheckBattleStory(var_3_0, manager.story.WIN, var_1_6)
		end
	else
		arg_1_0:GotoBattleFaild(var_1_0, var_1_1, var_1_2, var_1_3)
	end
end

return var_0_0
