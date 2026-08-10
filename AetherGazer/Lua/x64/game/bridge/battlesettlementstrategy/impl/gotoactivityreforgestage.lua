local var_0_0 = class("GotoActivityReforgeStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoActivityReforgeStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function var_0_0.GotoActivityReforgeStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	if isSuccess(arg_2_1) and not arg_2_5 then
		function BattleCallLuaCallBack()
			manager.story:RemovePlayer()

			local var_3_0 = arg_2_2:GetMainActivityID()
			local var_3_1 = arg_2_2:GetChapterActivityID()
			local var_3_2 = arg_2_2:GetLevelID()
			local var_3_3 = arg_2_2:GetWaveID()
			local var_3_4 = ActivityReforgeLevelCfg[var_3_2].wave_list

			if var_3_4[#var_3_4] == var_3_3 then
				gameContext:Go("/activityReforgeBattleInfoView", {
					IsBattleBack = true,
					activityID = var_3_0,
					chapterActivityID = var_3_1,
					levelID = var_3_2,
					waveID = var_3_3,
					stageData = arg_2_2
				})
			else
				ActivityReforgeData:SetCachePopBattleInfoView(true)
				gameContext:Go("/activityReforgeTrimView", {
					IsBattleBack = true,
					activityID = var_3_0,
					chapterActivityID = var_3_1,
					levelID = var_3_2,
					stageData = arg_2_2
				})
			end

			EndBattleLogic(arg_2_1)
		end
	else
		arg_2_0:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	end

	local var_2_0 = RedPointConst.ACTIVITY_REFORGE_NEW_CHPATER .. arg_2_2:GetChapterActivityID()

	manager.redPoint:setTip(var_2_0, 0)
end

return var_0_0
