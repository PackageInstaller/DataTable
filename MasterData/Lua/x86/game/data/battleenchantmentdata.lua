local var_0_0 = singletonClass("EnchantmentStageData")
local var_0_1 = {
	freeRefreshTimes = 0,
	allRefreshedTimes = 0,
	selectLevel = 0,
	enchantmentBattleList = {}
}

function var_0_0.Init(arg_1_0)
	var_0_1 = {
		freeRefreshTimes = 0,
		allRefreshedTimes = 0,
		selectLevel = 0,
		enchantmentBattleList = {}
	}
end

function var_0_0.GetData(arg_2_0)
	return var_0_1
end

function var_0_0.InitEnchantment(arg_3_0, arg_3_1)
	var_0_1.freeRefreshTimes = arg_3_1.free_refreshed_times
	var_0_1.allRefreshedTimes = arg_3_1.all_buy_refreshed_times

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.enchantment_battle_list) do
		var_0_1.enchantmentBattleList[iter_3_0] = iter_3_1
	end
end

function var_0_0.EnchantmentFreeRefresh(arg_4_0, arg_4_1)
	var_0_1.freeRefreshTimes = var_0_1.freeRefreshTimes <= 0 and 0 or var_0_1.freeRefreshTimes - 1

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.enchantment_battle_list) do
		var_0_1.enchantmentBattleList[iter_4_0] = iter_4_1
	end
end

function var_0_0.EnchantmentBuyRefresh(arg_5_0, arg_5_1)
	var_0_1.allRefreshedTimes = var_0_1.allRefreshedTimes + 1

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.enchantment_battle_list) do
		var_0_1.enchantmentBattleList[iter_5_0] = iter_5_1
	end
end

function var_0_0.SetSelectLevel(arg_6_0, arg_6_1)
	var_0_1.selectLevel = arg_6_1
end

return var_0_0
