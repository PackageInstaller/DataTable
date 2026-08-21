manager.net:Bind(15005, function(arg_1_0)
	CurrencyData:InitExpiredCurrencyList(arg_1_0.invalid_item_list)
end)
manager.net:Bind(15007, function(arg_2_0)
	CurrencyAction.CurrencyBuyTimes(arg_2_0.left_time_coin, arg_2_0.left_time_fatigue)
end)
manager.net:Bind(15009, function(arg_3_0)
	CurrencyAction.CurrencyInit(arg_3_0.currency_list, arg_3_0.last_fatigue_recover_time)
end)

local var_0_0 = {
	CurrencyBuyTimes = function(arg_4_0, arg_4_1)
		CurrencyData:CurrencyBuyTimes(arg_4_0, arg_4_1)
	end,
	CurrencyInit = function(arg_5_0, arg_5_1)
		for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
			if iter_5_1.id == CurrencyConst.CURRENCY_TYPE_ACHIEVEMENT_POINT then
				AchievementData:InitAchievementPoint(iter_5_1.num)
			end
		end

		CurrencyData:CurrencyInit(arg_5_0, arg_5_1)
	end,
	SetCurrencyValue = function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == CurrencyConst.CURRENCY_TYPE_PLAYER_EXP then
			PlayerAction.EXPChange(arg_6_1)
		elseif arg_6_0 == CurrencyConst.CURRENCY_TYPE_ACHIEVEMENT_POINT then
			AchievementData:SetAchievementPoint(arg_6_1)
		else
			CurrencyData:SetCurrencyValue(arg_6_0, arg_6_1, arg_6_2)
		end
	end
}

function var_0_0.BuyCoin()
	manager.net:SendWithLoadingNew(15012, {
		id = 2
	}, 15013, var_0_0.OnBuyCoin)
end

function var_0_0.OnBuyCoin(arg_8_0, arg_8_1)
	manager.notify:CallUpdateFunc(ON_BUY_COIN, arg_8_0, arg_8_1)
end

function var_0_0.BuyFatigue()
	manager.net:SendWithLoadingNew(15016, {
		num = 1
	}, 15017, var_0_0.OnBuyFatigue)
end

function var_0_0.OnBuyFatigue(arg_10_0, arg_10_1)
	manager.notify:CallUpdateFunc(ON_BUY_FATIGUE, arg_10_0, arg_10_1)
end

function var_0_0.BuyDiamond(arg_11_0)
	manager.net:SendWithLoadingNew(15020, {
		num = arg_11_0
	}, 15021, var_0_0.OnBuyDiamond)
end

function var_0_0.OnBuyDiamond(arg_12_0, arg_12_1)
	if isSuccess(arg_12_0.result) then
		manager.notify:CallUpdateFunc(ON_BUY_DIAMOND, arg_12_0, arg_12_1)
		manager.notify:CallUpdateFunc(SHOP_BUY_CALLBACK)
	else
		ShowTips(arg_12_0.result)
	end
end

function var_0_0.VitalityFull(arg_13_0)
	CurrencyData:VitalityFull(arg_13_0)
end

function var_0_0.ExchangeItem(arg_14_0, arg_14_1, arg_14_2)
	manager.net:SendWithLoadingNew(15022, {
		exchange_id = arg_14_0,
		num = arg_14_1
	}, 15023, function(arg_15_0)
		if isSuccess(arg_15_0.result) then
			arg_14_2(arg_15_0)
		else
			ShowTips(arg_15_0.result)
		end
	end)
end

function var_0_0.ReadExpiredCurrency()
	local var_16_0 = {
		nothing = 0
	}

	manager.net:SendWithLoadingNew(15024, var_16_0, 15025, var_0_0.OnReadExpiredCurrencyCallback)
end

function var_0_0.OnReadExpiredCurrencyCallback(arg_17_0, arg_17_1)
	if isSuccess(arg_17_0.result) then
		CurrencyData:ClearExpiredCurrencyList()
	else
		ShowTips(GetTips(arg_17_0.result))
	end
end

return var_0_0
