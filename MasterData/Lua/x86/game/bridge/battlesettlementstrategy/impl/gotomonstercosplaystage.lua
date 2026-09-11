local GotoMonsterCosplayStage = class("GotoMonsterCosplayStage", BattleSettlementStrategyBase)

function GotoMonsterCosplayStage:OnGotoSettlement(arg_1_1)
	self:GotoMonsterCosplayStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function GotoMonsterCosplayStage:GotoMonsterCosplayStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	BattleCallLuaCallBack = isSuccess(arg_2_1) and function()
		manager.story:CheckBattleStory(arg_2_2:GetStageId(), manager.story.WIN, function()
			saveData("monsterCosplay", "selectID", tostring(arg_2_2.monsterID))
			EndBattleLogic(arg_2_1)
			BattleInstance.QuitBattle(arg_2_2)
		end, false)
	end or function()
		manager.story:CheckBattleStory(arg_2_2:GetStageId(), manager.story.LOSE, function()
			JumpTools.OpenPageByJump("/monsterCosplayBattlefailedWithButton", {
				stageData = arg_2_2,
				battleResult = arg_2_4
			})
			manager.story:RemovePlayer()
			EndBattleLogic(arg_2_1)
		end, false)
	end
end

return GotoMonsterCosplayStage
