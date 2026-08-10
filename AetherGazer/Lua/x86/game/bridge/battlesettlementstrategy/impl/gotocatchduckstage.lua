local var_0_0 = class("GotoCatchDuckStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoCatchDuck(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function var_0_0.GotoCatchDuck(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if isSuccess(arg_2_1) then
		function BattleCallLuaCallBack()
			local var_3_0 = arg_2_2:GetStageId()

			manager.story:CheckBattleStory(var_3_0, manager.story.WIN, function()
				local var_4_0 = ActivityCatchDuckCfg.get_id_list_by_stage_id[arg_2_2.stageID_][1]

				if ActivityCatchDuckCfg[var_4_0].type ~= 3 then
					JumpTools.OpenPageByJump("/battleCatchDuckResult", {
						num = arg_2_1,
						stageData = arg_2_2,
						starMissionData = arg_2_3,
						battleResult = arg_2_4
					})
					EndBattleLogic(arg_2_1)
				else
					BattleInstance.QuitBattle(arg_2_2, false)
				end
			end, false)
		end
	else
		function BattleCallLuaCallBack()
			local var_5_0 = arg_2_2:GetStageId()

			manager.story:CheckBattleStory(var_5_0, manager.story.LOSE, function()
				local var_6_0 = ActivityCatchDuckCfg.get_id_list_by_stage_id[arg_2_2.stageID_][1]

				if ActivityCatchDuckCfg[var_6_0].type ~= 3 then
					JumpTools.OpenPageByJump("/battleCatchDuckResult", {
						num = arg_2_1,
						stageData = arg_2_2,
						starMissionData = arg_2_3,
						battleResult = arg_2_4
					})
					EndBattleLogic(arg_2_1)
				else
					BattleInstance.QuitBattle(arg_2_2, true)
				end
			end, false)
		end
	end
end

return var_0_0
