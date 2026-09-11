return {
	GetMainUIName = function(arg_1_0)
		local var_1_0 = ActivityTools.GetActivityTheme(arg_1_0)

		if ActivitySlayerUICfg[var_1_0] then
			return ActivitySlayerUICfg[var_1_0].main_ui_path
		else
			Debug.LogError(string.format("<color=ff0000>ActivitySlayerUICfg has no theme(%d)</color>", var_1_0))

			return nil
		end
	end,
	GetSelectUIName = function(arg_2_0)
		local var_2_0 = ActivityTools.GetActivityTheme(arg_2_0)

		if ActivitySlayerUICfg[var_2_0] then
			return ActivitySlayerUICfg[var_2_0].stage_ui_path
		else
			Debug.LogError(string.format("<color=ff0000>ActivitySlayerUICfg has no theme(%d)</color>", var_2_0))

			return nil
		end
	end,
	GetRewardUIName = function(arg_3_0)
		local var_3_0 = ActivityTools.GetActivityTheme(arg_3_0)

		if ActivitySlayerUICfg[var_3_0] then
			return ActivitySlayerUICfg[var_3_0].reward_ui_path
		else
			Debug.LogError(string.format("<color=ff0000>ActivitySlayerUICfg has no theme(%d)</color>", var_3_0))

			return nil
		end
	end,
	GetRewardItemClass = function(arg_4_0)
		local var_4_0 = ActivityTools.GetActivityTheme(arg_4_0)

		if ActivitySlayerUICfg[var_4_0] then
			return _G[ActivitySlayerUICfg[var_4_0].reward_item_class]
		else
			Debug.Log(string.format("<color=ff0000>ActivitySlayerUICfg has no theme(%d)</color>", var_4_0))

			return SlayerRewardItem_1_7
		end
	end,
	GetRewardFolderItemClass = function(arg_5_0)
		local var_5_0 = ActivityTools.GetActivityTheme(arg_5_0)

		if ActivitySlayerUICfg[var_5_0] then
			return _G[ActivitySlayerUICfg[var_5_0].reward_fold_class]
		else
			Debug.Log(string.format("<color=ff0000>ActivitySlayerUICfg has no theme(%d)</color>", var_5_0))

			return SlayerFoldItem_3_6
		end
	end
}
