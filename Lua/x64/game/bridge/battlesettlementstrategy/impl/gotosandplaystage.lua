local var_0_0 = class("GotoSandPlayStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	function BattleCallLuaCallBack()
		manager.story:RemovePlayer()
		EndBattleLogic(num)
		BattleInstance.QuitBattle(arg_1_1.stageData)
	end
end

return var_0_0
