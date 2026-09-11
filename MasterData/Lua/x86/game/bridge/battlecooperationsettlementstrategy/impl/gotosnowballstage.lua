local GotoSnowBallStage = class("GotoSnowBallStage", BattleCooperationSettlementStrategyBase)

function GotoSnowBallStage:OnGotoSettlement(arg_1_1)
	local var_1_1 = arg_1_1.stageData:GetType()

	if BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_BOSS == var_1_1 then
		self:GotoPushSnowBallTeamBossBattleResult(arg_1_1.num, PushSnowBallData:GetTeamBattleResultInfo(), arg_1_1.stageData, arg_1_1.battleResult)
	elseif BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_SURVIVAL == var_1_1 then
		self:GotoPushSnowBallTeamSurvivalBattleResult(arg_1_1.num, PushSnowBallData:GetTeamBattleResultInfo(), arg_1_1.stageData, arg_1_1.battleResult)
	end
end

function GotoSnowBallStage:GotoPushSnowBallSingleBattleResult(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
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

function GotoSnowBallStage:GotoPushSnowBallTeamSurvivalBattleResult(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
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

function GotoSnowBallStage:GotoPushSnowBallTeamBossBattleResult(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
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

return GotoSnowBallStage
