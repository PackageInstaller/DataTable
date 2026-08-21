local var_0_0 = class("GotoPushSnowBallSingleBattleStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.num
	local var_1_1 = arg_1_1.stageData
	local var_1_2 = arg_1_1.starMissionData
	local var_1_3 = arg_1_1.battleResult
	local var_1_4 = PushSnowBallData:GetBattleResultScore()
	local var_1_5 = PushSnowBallData:GetBattleResultSecond()

	function BattleCallLuaCallBack()
		if isSuccess(var_1_0) then
			JumpTools.OpenPageByJump("/battlePushSnowBallSingleResult", {
				score = var_1_4,
				useSecond = var_1_5,
				stageData = var_1_1,
				battleResult = var_1_3
			})
		else
			gameContext:Go("/battlePushSnowBallFail", {
				stageData = var_1_1,
				battleResult = var_1_3
			})
		end

		EndBattleLogic(var_1_0)
	end
end

return var_0_0
