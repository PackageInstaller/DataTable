local GotoAttributeArenaStage = class("GotoAttributeArenaStage", BattleSettlementStrategyBase)

function GotoAttributeArenaStage:OnGotoSettlement(arg_1_1)
	local var_1_0 = arg_1_1.num
	local var_1_1 = arg_1_1.stageData
	local var_1_2 = arg_1_1.battleResult
	local var_1_3, var_1_4 = GetResultReward()

	local function var_1_5()
		manager.story:RemovePlayer()
		gameContext:Go("/battleScorResult", {
			noOnceMore = true,
			stageData = var_1_1,
			rewardList = var_1_4,
			battleResult = var_1_2
		})
		EndBattleLogic(var_1_0)
	end

	if isSuccess(arg_1_1.num) then
		function BattleCallLuaCallBack()
			manager.story:CheckBattleStory(var_1_1:GetStageId(), manager.story.WIN, var_1_5)
		end
	else
		self:GotoBattleFaild(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
	end
end

return GotoAttributeArenaStage
