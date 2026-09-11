local GotoSPHeroChallengeStage = class("GotoSPHeroChallengeStage", BattleSettlementStrategyBase)

function GotoSPHeroChallengeStage:OnGotoSettlement(arg_1_1)
	local var_1_0 = arg_1_1.stageData:GetType()

	if arg_1_1.isHalfWay_ then
		self:GotoBattleFaild(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)

		return
	end

	self:GotoSPHeroChallengeStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function GotoSPHeroChallengeStage:GotoSPHeroChallengeStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = 1

	if isSuccess(arg_2_1) then
		function BattleCallLuaCallBack()
			local var_3_0, var_3_1 = GetResultReward()

			gameContext:Go("/battleSPHeroChallengeResultView", {
				stageData = arg_2_2,
				score = var_2_0,
				battleResult = arg_2_4,
				rewardList = var_3_0
			})

			local var_3_2 = arg_2_2:GetStageId()

			if BattleVerthandiExclusiveCfg[var_3_2].sub_type == SpHeroChallengeConst.BattleSubType.story then
				SPHeroChallengeData:GetCurActivityInfo():FinishStoryStage(var_3_2)
			end

			if BattleVerthandiExclusiveCfg[var_3_2].sub_type == SpHeroChallengeConst.BattleSubType.train1 or BattleVerthandiExclusiveCfg[var_3_2].sub_type == SpHeroChallengeConst.BattleSubType.train2 or BattleVerthandiExclusiveCfg[var_3_2].sub_type == SpHeroChallengeConst.BattleSubType.train3 then
				local var_3_3 = SPHeroChallengeData:GetCurActivityInfo()
			end
		end
	else
		self:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	end
end

return GotoSPHeroChallengeStage
