local GotoDodgeBarrageStage = class("GotoDodgeBarrageStage", BattleSettlementStrategyBase)

function GotoDodgeBarrageStage:OnGotoSettlement(arg_1_1)
	self:GotoDodgeBarrageStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function GotoDodgeBarrageStage:GotoDodgeBarrageStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = DodgeBarrageData:GetCurrentScore()

	function BattleCallLuaCallBack()
		gameContext:Go("/battleScorResult", {
			stageData = arg_2_2,
			score = var_2_0,
			battleResult = arg_2_4
		})
		EndBattleLogic(arg_2_1)
	end
end

return GotoDodgeBarrageStage
