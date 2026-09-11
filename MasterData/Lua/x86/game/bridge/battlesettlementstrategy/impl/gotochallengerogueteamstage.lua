local GotoChallengeRogueTeamStage = class("GotoChallengeRogueTeamStage", BattleSettlementStrategyBase)

function GotoChallengeRogueTeamStage:OnGotoSettlement(arg_1_1)
	self:GotoChallengeRogueTeamStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function GotoChallengeRogueTeamStage:GotoChallengeRogueTeamStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0, var_2_1 = GetResultReward()

	local function var_2_2()
		manager.story:RemovePlayer()
		;(function()
			JumpTools.OpenPageByJump("/challengeRogueTeamResult", {
				result = arg_2_1,
				rewardList = var_2_0,
				stageData = arg_2_2,
				starMissionData = arg_2_3,
				battleResult = arg_2_4
			})
			EndBattleLogic(arg_2_1)
		end)()
	end

	if isSuccess(arg_2_1) then
		function BattleCallLuaCallBack()
			var_2_2()
		end
	else
		self:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	end
end

return GotoChallengeRogueTeamStage
