local GotoWhackMoleStage = class("GotoWhackMoleStage", BattleSettlementStrategyBase)

function GotoWhackMoleStage:OnGotoSettlement(arg_1_1)
	self:GotoWhackMole(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function GotoWhackMoleStage:GotoWhackMole(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_4.errorCode == 12000 then
		arg_2_2:SetBattleResult(false)
		arg_2_2:SetScore(0)

		function BattleCallLuaCallBack()
			manager.story:CheckBattleStory(arg_2_2:GetStageId(), manager.story.LOSE, function()
				BattleInstance.QuitBattle(arg_2_2)
			end, false)
		end
	else
		local var_2_0 = WhackMoleData:GetBattleResultData()

		arg_2_2:SetBattleResult(var_2_0.is_success)
		arg_2_2:SetScore(var_2_0.settle_score)

		if var_2_0.is_success == true then
			CheckBattleResultNeedAddHeroExp()

			function BattleCallLuaCallBack()
				manager.story:CheckBattleStory(arg_2_2:GetStageId(), manager.story.WIN, function()
					JumpTools.OpenPageByJump("battleWhackMoleResult", {
						stageData = arg_2_2
					})
					manager.story:RemovePlayer()
					EndBattleLogic(arg_2_1)
				end, false)
			end
		else
			CheckBattleResultNeedAddHeroExp()

			function BattleCallLuaCallBack()
				manager.story:CheckBattleStory(arg_2_2:GetStageId(), manager.story.LOSE, function()
					JumpTools.OpenPageByJump("battleWhackMoleResult", {
						stageData = arg_2_2
					})
					manager.story:RemovePlayer()
					EndBattleLogic(arg_2_1)
				end, false)
			end
		end
	end
end

return GotoWhackMoleStage
