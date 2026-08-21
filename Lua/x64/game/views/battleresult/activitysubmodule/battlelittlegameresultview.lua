local var_0_0 = import("game.views.battleResult.BattleResultBaseView")
local var_0_1 = class("BattleLittleGameResultView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/BattleResult/SummerBattleSettlementUI"
end

function var_0_1.RefreshUI(arg_2_0)
	arg_2_0:SetLevelTitle()
	arg_2_0:RefreshMyExpS()
	arg_2_0:RefreshHeroS()
	arg_2_0:RefreshCommonUI()
	arg_2_0:RefreshSummer()
	arg_2_0:RefreshBattleTime()
end

function var_0_1.RefreshSummer(arg_3_0)
	local var_3_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua
	local var_3_1 = 0
	local var_3_2 = var_3_0.recordDatas:GetEnumerator()

	while var_3_2:MoveNext() do
		var_3_1 = var_3_1 + var_3_2.Current.Value
	end

	local var_3_3
	local var_3_4 = var_3_0.items:TryGetValue(60010, var_3_3)

	arg_3_0.missionText1.text = var_3_1
	arg_3_0.missionText2.text = var_3_4 and var_3_0.items[60010] or 0
end

return var_0_1
