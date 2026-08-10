local var_0_0 = class("GotoMonsterCosplayStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoMonsterCosplayStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function var_0_0.GotoMonsterCosplayStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	if isSuccess(arg_2_1) then
		function BattleCallLuaCallBack()
			local var_3_0 = arg_2_2:GetStageId()

			manager.story:CheckBattleStory(var_3_0, manager.story.WIN, function()
				saveData("monsterCosplay", "selectID", tostring(arg_2_2.monsterID))
				EndBattleLogic(arg_2_1)
				BattleInstance.QuitBattle(arg_2_2)
			end, false)
		end
	else
		function BattleCallLuaCallBack()
			local var_5_0 = arg_2_2:GetStageId()

			manager.story:CheckBattleStory(var_5_0, manager.story.LOSE, function()
				JumpTools.OpenPageByJump("/monsterCosplayBattlefailedWithButton", {
					stageData = arg_2_2,
					battleResult = arg_2_4
				})
				manager.story:RemovePlayer()
				EndBattleLogic(arg_2_1)
			end, false)
		end
	end
end

return var_0_0
