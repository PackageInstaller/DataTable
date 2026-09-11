local GotoSandPlayStage = class("GotoSandPlayStage", BattleSettlementStrategyBase)

function GotoSandPlayStage:OnGotoSettlement(arg_1_1)
	function BattleCallLuaCallBack()
		manager.story:RemovePlayer()
		EndBattleLogic(num)
		BattleInstance.QuitBattle(arg_1_1.stageData)
	end
end

return GotoSandPlayStage
