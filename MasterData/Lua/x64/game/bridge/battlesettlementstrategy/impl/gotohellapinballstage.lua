local GotoHellaPinballStage = class("GotoHellaPinballStage", BattleSettlementStrategyBase)

function GotoHellaPinballStage:OnGotoSettlement(arg_1_1)
	self:GotoHellaPinballStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function GotoHellaPinballStage:GotoHellaPinballStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0, var_2_1 = GetResultReward()

	BattleCallLuaCallBack = isSuccess(arg_2_1) and function()
		JumpTools.OpenPageByJump("pinballBattleSettlement", {
			isSuccess = true,
			stageData = arg_2_2
		})
		EndBattleLogic(arg_2_1)
	end or function()
		JumpTools.OpenPageByJump("pinballBattleSettlement", {
			isSuccess = false,
			stageData = arg_2_2
		})
		EndBattleLogic(arg_2_1)
	end
end

return GotoHellaPinballStage
