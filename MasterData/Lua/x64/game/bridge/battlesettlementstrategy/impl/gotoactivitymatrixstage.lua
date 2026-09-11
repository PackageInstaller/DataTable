local GotoActivityMatrixStage = class("GotoActivityMatrixStage", BattleSettlementStrategyBase)

function GotoActivityMatrixStage:OnGotoSettlement(arg_1_1)
	self:GotoActivityMatrix(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function GotoActivityMatrixStage:GotoActivityMatrix(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
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
				if StrategyMatrixTierTemplateCfg[arg_2_2.tier or 0].level == 10 then
					local var_3_1 = StrategyMatrixCfg[var_2_2].tier_story_list[StrategyMatrixTierTemplateCfg[arg_2_2.tier or 0].tier] or nil

					if var_3_1 and not manager.story:IsStoryPlayed(var_3_1) then
						PlayerAction.ChangeStoryList(var_3_1)
						manager.story:StartStoryById(var_3_1, function(arg_4_0)
							gameContext:Go("/battleMatrixResultNew", {
								multiple = 1,
								stageData = arg_2_2,
								rewardList = var_2_0,
								battleResult = arg_2_4
							})
						end)

						goto label_3_0
					end
				end

				gameContext:Go("/battleMatrixResultNew", {
					multiple = 1,
					stageData = arg_2_2,
					rewardList = var_2_0,
					battleResult = arg_2_4
				})
			else
				gameContext:Go("/battleMatrixResultNew", {
					multiple = 1,
					stageData = arg_2_2,
					rewardList = var_2_0,
					battleResult = arg_2_4
				})
			end

			::label_3_0::

			EndBattleLogic(arg_2_1)
		end
	else
		self:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	end
end

return GotoActivityMatrixStage
