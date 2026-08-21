local var_0_0 = class("GotoActivityMatrixStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoActivityMatrix(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function var_0_0.GotoActivityMatrix(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0, var_2_1 = GetResultReward()
	local var_2_2 = arg_2_2:GetActivityID()
	local var_2_3 = ActivityTools.GetActivityType(var_2_2)

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if iter_2_1[1] == 26 then
			if var_2_3 == ActivityTemplateConst.SUB_SINGLE_MATRIX then
				iter_2_1[1] = ActivityMatrixTools.GetCoinItem(var_2_2)
			elseif var_2_3 == ActivityTemplateConst.STRATEGY_MATRIX then
				iter_2_1[1] = StrategyMatrixTools.GetCoinItem(var_2_2)
			end
		end

		if iter_2_1[2] == 0 then
			var_2_0[iter_2_0] = nil
		end
	end

	if isSuccess(arg_2_1) then
		function BattleCallLuaCallBack()
			if var_2_3 == ActivityTemplateConst.STRATEGY_MATRIX then
				local var_3_0 = arg_2_2.tier or 0
				local var_3_1 = StrategyMatrixCfg[var_2_2]
				local var_3_2 = StrategyMatrixTierTemplateCfg[var_3_0]
				local var_3_3 = var_3_2.level == 10 and var_3_1.tier_story_list[var_3_2.tier] or nil

				if var_3_3 and not manager.story:IsStoryPlayed(var_3_3) then
					PlayerAction.ChangeStoryList(var_3_3)
					manager.story:StartStoryById(var_3_3, function(arg_4_0)
						gameContext:Go("/battleMatrixResultNew", {
							multiple = 1,
							stageData = arg_2_2,
							rewardList = var_2_0,
							battleResult = arg_2_4
						})
					end)
				else
					gameContext:Go("/battleMatrixResultNew", {
						multiple = 1,
						stageData = arg_2_2,
						rewardList = var_2_0,
						battleResult = arg_2_4
					})
				end
			else
				gameContext:Go("/battleMatrixResultNew", {
					multiple = 1,
					stageData = arg_2_2,
					rewardList = var_2_0,
					battleResult = arg_2_4
				})
			end

			EndBattleLogic(arg_2_1)
		end
	else
		arg_2_0:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	end
end

return var_0_0
