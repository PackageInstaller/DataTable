local var_0_0 = {
	CONST = {
		FREE = 1,
		BUY = 2
	}
}

manager.net:Bind(42001, function(arg_1_0)
	BattleEnchantAction.InitEnchantment(arg_1_0)
end)

function var_0_0.InitEnchantment(arg_2_0)
	BattleEnchantmentData:InitEnchantment(arg_2_0)
	manager.notify:CallUpdateFunc(ENCHANTMENT_INIT, arg_2_0)
end

function var_0_0.EnchantmentInit()
	manager.net:Push(42002, {})
end

function var_0_0.EnchantmentRefresh(arg_4_0, arg_4_1)
	var_0_0.cost = arg_4_1

	manager.net:SendWithLoadingNew(42004, {
		refresh_type = arg_4_0
	}, 42005, var_0_0.OnEnchantmentRefresh)
end

function var_0_0.OnEnchantmentRefresh(arg_5_0, arg_5_1)
	if isSuccess(arg_5_0.result) then
		if arg_5_1.refresh_type == 1 then
			BattleEnchantmentData:EnchantmentFreeRefresh(arg_5_0)
		elseif arg_5_1.refresh_type == 2 then
			BattleEnchantmentData:EnchantmentBuyRefresh(arg_5_0)
		end

		manager.notify:CallUpdateFunc(ENCHANTMENT_REFRESH, arg_5_0, arg_5_1)
	else
		ShowTips(arg_5_0.result)
		var_0_0.EnchantmentInit()
	end
end

function var_0_0.SetSelectLevel(arg_6_0)
	BattleEnchantmentData:SetSelectLevel(arg_6_0)
end

function var_0_0.GetSelectLevel()
	return BattleEnchantmentData:GetData().selectLevel
end

function var_0_0.checkMaxLevel()
	return
end

return var_0_0
