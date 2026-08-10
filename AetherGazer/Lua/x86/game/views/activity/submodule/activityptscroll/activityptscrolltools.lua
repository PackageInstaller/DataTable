local var_0_0 = {
	GetPTScrollCfg = function(arg_1_0)
		local var_1_0 = ActivityPTScrollCfg.get_id_list_by_activity_id[arg_1_0]

		if var_1_0 == nil then
			-- block empty
		end

		local var_1_1 = var_1_0[1]

		return ActivityPTScrollCfg[var_1_1]
	end
}

function var_0_0.GetCurrencyID(arg_2_0)
	return var_0_0.GetPTScrollCfg(arg_2_0).currency_id
end

function var_0_0.GetChallengeCurrencyID(arg_3_0)
	return var_0_0.GetPTScrollCfg(arg_3_0).cost_id
end

function var_0_0.GetHelpKey(arg_4_0)
	return var_0_0.GetPTScrollCfg(arg_4_0).play_desc
end

function var_0_0.GetDesc(arg_5_0)
	return var_0_0.GetPTScrollCfg(arg_5_0).activity_desc
end

function var_0_0.GetEnterUIName(arg_6_0)
	return var_0_0.GetPTScrollCfg(arg_6_0).entrace_prefab_path
end

function var_0_0.GetMainUIName(arg_7_0)
	return var_0_0.GetPTScrollCfg(arg_7_0).main_prefab_path
end

function var_0_0.GetBuffPopUIName(arg_8_0)
	return var_0_0.GetPTScrollCfg(arg_8_0).buff_pop_prefab_path
end

function var_0_0.GetLevelActivityID(arg_9_0)
	return var_0_0.GetPTScrollCfg(arg_9_0).stage_activity_id
end

function var_0_0.GetTaskActivityID(arg_10_0)
	return var_0_0.GetPTScrollCfg(arg_10_0).task_activity_id
end

function var_0_0.GetShopActivityID(arg_11_0)
	return var_0_0.GetPTScrollCfg(arg_11_0).shop_activity_id
end

return var_0_0
