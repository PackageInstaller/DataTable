local var_0_0 = class("GotoCoreVerificationChallengeStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoCoreVerificationChallengeStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function var_0_0.GotoCoreVerificationChallengeStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	if isSuccess(arg_2_1) and not arg_2_5 then
		function BattleCallLuaCallBack()
			manager.story:RemovePlayer()

			local var_3_0 = arg_2_2:GetStageId()
			local var_3_1 = CoreVerificationChallengeTools.GetModeCfg()[var_3_0]
			local var_3_2 = CoreVerificationChallengeTools.GetModeIndex()

			if var_3_1.stage_type == 1 then
				if var_3_2 == 1 then
					gameContext:Go("/coreVerificationChallengeResultWinView", {
						multiple = 1,
						stageData = arg_2_2,
						battleResult = arg_2_4
					})
				elseif var_3_2 == 2 then
					gameContext:Go("/coreVerificationChallengeResultWinViewMode2", {
						multiple = 1,
						stageData = arg_2_2,
						battleResult = arg_2_4
					})
				elseif var_3_2 == 3 then
					gameContext:Go("/coreVerificationChallengeResultWinViewMode3", {
						multiple = 1,
						stageData = arg_2_2,
						battleResult = arg_2_4
					})
				elseif var_3_2 == 4 then
					gameContext:Go("/coreVerificationChallengeResultWinViewMode4", {
						multiple = 1,
						stageData = arg_2_2,
						battleResult = arg_2_4
					})
				end
			elseif var_3_2 == 1 then
				gameContext:Go("/coreVerificationDoubleChallengeResultView", {
					multiple = 1,
					stageData = arg_2_2,
					battleResult = arg_2_4
				})
			elseif var_3_2 == 2 then
				gameContext:Go("/coreVerificationDoubleChallengeResultViewMode2", {
					multiple = 1,
					stageData = arg_2_2,
					battleResult = arg_2_4
				})
			elseif var_3_2 == 3 then
				gameContext:Go("/coreVerificationDoubleChallengeResultViewMode3", {
					multiple = 1,
					stageData = arg_2_2,
					battleResult = arg_2_4
				})
			elseif var_3_2 == 4 then
				gameContext:Go("/coreVerificationDoubleChallengeResultViewMode4", {
					multiple = 1,
					stageData = arg_2_2,
					battleResult = arg_2_4
				})
			end

			EndBattleLogic(arg_2_1)
		end
	else
		function BattleCallLuaCallBack()
			JumpTools.OpenPageByJump("/battlefailed", {
				stageData = arg_2_2,
				battleResult = arg_2_4,
				isHalfWay_ = arg_2_0.tempData.isHalfWay_
			})
			EndBattleLogic(arg_2_1)
		end
	end
end

return var_0_0
