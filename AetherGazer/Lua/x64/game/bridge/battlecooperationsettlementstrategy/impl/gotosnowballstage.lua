local var_0_0 = class("GotoSnowBallStage", BattleCooperationSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.num
	local var_1_1 = arg_1_1.stageData
	local var_1_2 = arg_1_1.starMissionData
	local var_1_3 = arg_1_1.battleResult
	local var_1_4 = var_1_1:GetType()

	if BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_BOSS == var_1_4 then
		local var_1_5 = PushSnowBallData:GetTeamBattleResultInfo()

		arg_1_0:GotoPushSnowBallTeamBossBattleResult(var_1_0, var_1_5, var_1_1, var_1_3)
	elseif BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_SURVIVAL == var_1_4 then
		local var_1_6 = PushSnowBallData:GetTeamBattleResultInfo()

		arg_1_0:GotoPushSnowBallTeamSurvivalBattleResult(var_1_0, var_1_6, var_1_1, var_1_3)
	end
end

function var_0_0.GotoPushSnowBallSingleBattleResult(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	function BattleCallLuaCallBack()
		if isSuccess(arg_2_1) then
			JumpTools.OpenPageByJump("/battlePushSnowBallSingleResult", {
				score = arg_2_2,
				useSecond = arg_2_3,
				stageData = arg_2_4,
				battleResult = arg_2_5
			})
		else
			JumpTools.OpenPageByJump("/battlefailedBossChallenge", {
				stageData = arg_2_4,
				battleResult = arg_2_5
			})
		end

		EndBattleLogic(arg_2_1)
	end
end

function var_0_0.GotoPushSnowBallTeamSurvivalBattleResult(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	function BattleCallLuaCallBack()
		if isSuccess(arg_4_1) then
			JumpTools.OpenPageByJump("/battlePushSnowBallTeamSurvivalResult", {
				result = arg_4_1,
				resultInfo = arg_4_2,
				stageData = arg_4_3,
				battleResult = arg_4_4
			})
		else
			JumpTools.OpenPageByJump("/battlefailedBossChallenge", {
				stageData = arg_4_3,
				battleResult = arg_4_4
			})
		end

		EndBattleLogic(arg_4_1)
	end
end

function var_0_0.GotoPushSnowBallTeamBossBattleResult(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	function BattleCallLuaCallBack()
		if isSuccess(arg_6_1) then
			JumpTools.OpenPageByJump("/battlePushSnowBallTeamBossResult", {
				result = arg_6_1,
				resultInfo = arg_6_2,
				stageData = arg_6_3,
				battleResult = arg_6_4
			})
		else
			JumpTools.OpenPageByJump("/battlefailedBossChallenge", {
				stageData = arg_6_3,
				battleResult = arg_6_4
			})
		end

		EndBattleLogic(arg_6_1)
	end
end

return var_0_0
