local var_0_0 = class("GotoSoloHeartDemonStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoSoloHeartDemonStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function var_0_0.GotoSoloHeartDemonStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = 1

	if isSuccess(arg_2_1) then
		local var_2_1 = 10

		arg_2_0:GotoSoloHeartDemonSuccess(arg_2_5, var_2_1, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	else
		function BattleCallLuaCallBack()
			local var_3_0 = arg_2_2:GetStageId()

			manager.story:CheckBattleStory(var_3_0, manager.story.LOSE, function()
				JumpTools.OpenPageByJump("/SoloHeartDemonFail", {
					stageData = arg_2_2,
					battleResult = arg_2_4
				})
				manager.story:RemovePlayer()
				EndBattleLogic(arg_2_1)
			end)
		end
	end
end

function var_0_0.GotoSoloHeartDemonSuccess(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7)
	if arg_5_1 == true then
		arg_5_3 = 3
	end

	if isSuccess(arg_5_3) then
		function BattleCallLuaCallBack()
			gameContext:Go("/soloHeartDemonResult", {
				stageData = arg_5_4,
				score = arg_5_2,
				battleResult = arg_5_6
			})
			EndBattleLogic(arg_5_3)
		end
	end
end

return var_0_0
