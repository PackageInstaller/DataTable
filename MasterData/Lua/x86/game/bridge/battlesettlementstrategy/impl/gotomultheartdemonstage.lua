local GotoMultHeartDemonStage = class("GotoMultHeartDemonStage", BattleSettlementStrategyBase)

function GotoMultHeartDemonStage:OnGotoSettlement(arg_1_1)
	self:GotoMultHeartDemon(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function GotoMultHeartDemonStage:GotoMultHeartDemon(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0, var_2_1 = GetResultReward()

	BattleCallLuaCallBack = isSuccess(arg_2_1) and function()
		JumpTools.OpenPageByJump("/MultHeartDemonResultView", {
			result = arg_2_1,
			rewardList = var_2_0,
			stageData = arg_2_2,
			starMissionData = arg_2_3,
			battleResult = arg_2_4
		})
		EndBattleLogic(arg_2_1)
	end or function()
		JumpTools.OpenPageByJump("/MultHeartDemonFailView", {
			stageData = arg_2_2,
			starMissionData = arg_2_3,
			battleResult = arg_2_4
		})
		manager.story:RemovePlayer()
		EndBattleLogic(arg_2_1)
	end
end

return GotoMultHeartDemonStage
