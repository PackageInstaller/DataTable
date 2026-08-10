local var_0_0 = class("GotoActivityWorldBossStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoActivityWorldBossStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function var_0_0.GotoActivityWorldBossStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0, var_2_1 = GetResultReward()
	local var_2_2 = arg_2_2:GetActivityID()
	local var_2_3 = ActivityWorldBossCfg[var_2_2]

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if var_2_3 and var_2_3.coin_id == iter_2_1[1] then
			ActivityWorldBossData:UpdateCoinCount(var_2_2, iter_2_1[2])
		end
	end

	if not arg_2_5 then
		CheckBattleResultNeedAddHeroExp()

		function BattleCallLuaCallBack()
			local var_3_0 = arg_2_2:GetActivityID()
			local var_3_1 = var_2_3.end_story_id

			if ActivityWorldBossData:GetLeftHealthPoint(var_3_0) == 0 and not manager.story:IsStoryPlayed(var_3_1) then
				manager.story:StartStoryById(var_3_1, function(arg_4_0)
					gameContext:Go("/battleActivityWorldBossResult", {
						stageData = arg_2_2,
						rewardList = var_2_0,
						battleResult = arg_2_4
					})
				end)
			else
				gameContext:Go("/battleActivityWorldBossResult", {
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
