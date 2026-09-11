local BattleLittleGameResultView = class("BattleLittleGameResultView", (import("game.views.battleResult.BattleResultBaseView")))

function BattleLittleGameResultView:UIName()
	return "UI/BattleResult/SummerBattleSettlementUI"
end

function BattleLittleGameResultView:RefreshUI()
	self:SetLevelTitle()
	self:RefreshMyExpS()
	self:RefreshHeroS()
	self:RefreshCommonUI()
	self:RefreshSummer()
	self:RefreshBattleTime()
end

function BattleLittleGameResultView:RefreshSummer()
	local var_3_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua
	local var_3_1 = 0
	local var_3_2 = var_3_0.recordDatas:GetEnumerator()

	while var_3_2:MoveNext() do
		var_3_1 = var_3_1 + var_3_2.Current.Value
	end

	self.missionText1.text = var_3_1

	if var_3_0.items:TryGetValue(60010, nil) then
		self.missionText2.text = var_3_0.items[60010] or 0
	end
end

return BattleLittleGameResultView
