local GotoSlayerStage = class("GotoSlayerStage", BattleSettlementStrategyBase)

function GotoSlayerStage:OnGotoSettlement(arg_1_1)
	self:GotoSlayerResult(arg_1_1.num, arg_1_1.stageData, arg_1_1.battleResult)
end

function GotoSlayerStage:GotoSlayerResult(arg_2_1, arg_2_2, arg_2_3)
	function BattleCallLuaCallBack()
		gameContext:Go("/battleSlayerResult", {
			stageData = arg_2_2,
			rewardList = {},
			battleResult = arg_2_3
		})
		EndBattleLogic(arg_2_1)
	end
end

return GotoSlayerStage
