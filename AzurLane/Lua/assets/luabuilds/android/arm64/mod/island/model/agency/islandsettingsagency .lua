class = var_0_10000

local var_0_0 = "IslandSettingsAgency "

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseAgency"))

var_0_1.FLAG_TYPES = {
	SHOW_CARD_LABEL = 2,
	SHOW_CARD_SOCIAL = 1
}

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0.settingsFlags = {}

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.SetFlags
	local var_1_2

	if not arg_1_1.flag_list then
		var_1_2 = {}
	end

	var_1_1(var_1_0, var_1_2)

	return
end

function var_0_1.GetFlagByType(arg_2_0, arg_2_1)
	return arg_2_0.settingsFlags[arg_2_1]
end

function var_0_1.SetFlags(arg_3_0, arg_3_1)
	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_1 or {}) do
		arg_3_0.settingsFlags[iter_3_1.type] = iter_3_1.flag
	end

	return
end

return var_0_1
