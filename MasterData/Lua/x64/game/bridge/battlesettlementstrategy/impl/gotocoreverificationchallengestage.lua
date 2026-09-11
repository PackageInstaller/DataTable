local GotoCoreVerificationChallengeStage = class("GotoCoreVerificationChallengeStage", BattleSettlementStrategyBase)

function GotoCoreVerificationChallengeStage:OnGotoSettlement(arg_1_1)
	self:GotoCoreVerificationChallengeStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function GotoCoreVerificationChallengeStage:GotoCoreVerificationChallengeStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	BattleCallLuaCallBack = isSuccess(arg_2_1) and not arg_2_5 and function()
		manager.story:RemovePlayer()

		local var_3_0 = CoreVerificationChallengeTools.GetModeIndex()

		if CoreVerificationChallengeTools.GetModeCfg()[arg_2_2:GetStageId()].stage_type == 1 then
			if var_3_0 == 1 then
				gameContext:Go("/coreVerificationChallengeResultWinView", {
					multiple = 1,
					stageData = arg_2_2,
					battleResult = arg_2_4
				})
			elseif var_3_0 == 2 then
				gameContext:Go("/coreVerificationChallengeResultWinViewMode2", {
					multiple = 1,
					stageData = arg_2_2,
					battleResult = arg_2_4
				})
			elseif var_3_0 == 3 then
				gameContext:Go("/coreVerificationChallengeResultWinViewMode3", {
					multiple = 1,
					stageData = arg_2_2,
					battleResult = arg_2_4
				})
			elseif var_3_0 == 4 then
				gameContext:Go("/coreVerificationChallengeResultWinViewMode4", {
					multiple = 1,
					stageData = arg_2_2,
					battleResult = arg_2_4
				})
			end
		elseif var_3_0 == 1 then
			gameContext:Go("/coreVerificationDoubleChallengeResultView", {
				multiple = 1,
				stageData = arg_2_2,
				battleResult = arg_2_4
			})
		elseif var_3_0 == 2 then
			gameContext:Go("/coreVerificationDoubleChallengeResultViewMode2", {
				multiple = 1,
				stageData = arg_2_2,
				battleResult = arg_2_4
			})
		elseif var_3_0 == 3 then
			gameContext:Go("/coreVerificationDoubleChallengeResultViewMode3", {
				multiple = 1,
				stageData = arg_2_2,
				battleResult = arg_2_4
			})
		elseif var_3_0 == 4 then
			gameContext:Go("/coreVerificationDoubleChallengeResultViewMode4", {
				multiple = 1,
				stageData = arg_2_2,
				battleResult = arg_2_4
			})
		end

		EndBattleLogic(arg_2_1)
	end or function()
		JumpTools.OpenPageByJump("/battlefailed", {
			stageData = arg_2_2,
			battleResult = arg_2_4,
			isHalfWay_ = self.tempData.isHalfWay_
		})
		EndBattleLogic(arg_2_1)
	end
end

return GotoCoreVerificationChallengeStage
