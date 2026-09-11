local GotoSoloChallengeStage = class("GotoSoloChallengeStage", BattleSettlementStrategyBase)

function GotoSoloChallengeStage:OnGotoSettlement(arg_1_1)
	self:GotoSoloChanllenge(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function GotoSoloChallengeStage:GotoSoloChanllenge(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0, var_2_1 = GetResultReward()

	BattleCallLuaCallBack = isSuccess(arg_2_1) and function()
		JumpTools.OpenPageByJump("/newSettlement", {
			result = arg_2_1,
			rewardList = var_2_0,
			stageData = arg_2_2,
			starMissionData = arg_2_3,
			battleResult = arg_2_4
		})
		EndBattleLogic(arg_2_1)
	end or function()
		gameContext:Go("/battleMatrixFailed", {
			stageData = arg_2_2,
			starMissionData = arg_2_3,
			battleResult = arg_2_4
		})
		manager.story:RemovePlayer()
		EndBattleLogic(arg_2_1)
	end
end

return GotoSoloChallengeStage
