local GotoCatchDuckStage = class("GotoCatchDuckStage", BattleSettlementStrategyBase)

function GotoCatchDuckStage:OnGotoSettlement(arg_1_1)
	self:GotoCatchDuck(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function GotoCatchDuckStage:GotoCatchDuck(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	BattleCallLuaCallBack = isSuccess(arg_2_1) and function()
		manager.story:CheckBattleStory(arg_2_2:GetStageId(), manager.story.WIN, function()
			if ActivityCatchDuckCfg[ActivityCatchDuckCfg.get_id_list_by_stage_id[arg_2_2.stageID_][1]].type ~= 3 then
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
	end or function()
		manager.story:CheckBattleStory(arg_2_2:GetStageId(), manager.story.LOSE, function()
			if ActivityCatchDuckCfg[ActivityCatchDuckCfg.get_id_list_by_stage_id[arg_2_2.stageID_][1]].type ~= 3 then
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

return GotoCatchDuckStage
