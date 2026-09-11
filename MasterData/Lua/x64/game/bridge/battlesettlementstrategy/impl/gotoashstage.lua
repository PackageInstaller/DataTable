local GotoAshStage = class("GotoAshStage", BattleSettlementStrategyBase)

function GotoAshStage:OnGotoSettlement(arg_1_1)
	self:GotoAshBattleStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function GotoAshStage:GotoAshBattleStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	LuaHidTools.ForceSelectKeyboard(nil)

	if isSuccess(arg_2_1) then
		self:GotoAshBattleSuccess(arg_2_4, arg_2_1, arg_2_2, arg_2_3)
	else
		self:GotoAshBattleFailed(arg_2_1, arg_2_2)
	end
end

function GotoAshStage:GotoAshBattleSuccess(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	if arg_3_1 == true then
		arg_3_2 = 3
	end

	if isSuccess(arg_3_2) then
		function BattleCallLuaCallBack()
			JumpTools.OpenPageByJump("/ashBattleResultView", {
				stageData = arg_3_3,
				rewardList = GetResultReward(),
				battleResult = arg_3_4,
				score = AshSystemData:GetCacheStagePoint(AshShootStageCfg.get_id_list_by_stage_id[arg_3_3:GetStageId()][1])
			})
			EndBattleLogic(arg_3_2)
		end
	end
end

function GotoAshStage:GotoAshBattleFailed(arg_5_1, arg_5_2)
	function BattleCallLuaCallBack()
		JumpTools.OpenPageByJump("/ashBattleFailedView", {
			stageData = arg_5_2,
			scroe = AshSystemData:GetCacheStagePoint(AshShootStageCfg.get_id_list_by_stage_id[arg_5_2:GetStageId()][1])
		})
		EndBattleLogic(arg_5_1)
	end
end

return GotoAshStage
