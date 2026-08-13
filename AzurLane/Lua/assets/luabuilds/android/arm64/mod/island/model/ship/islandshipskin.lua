class = var_0_10000

local var_0_0 = "IslandShipSkin"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.color_id = arg_1_1.color_id
	arg_1_0.color_list = {}
	ipairs = var_2

	local var_1_0

	if not arg_1_1.color_list then
		var_1_0 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_0) do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.color_list, iter_1_1)
	end

	return
end

function var_0_1.CheckColorOwned(arg_2_0, arg_2_1)
	if arg_2_1 == 0 then
		return true
	end

	ipairs = var_1_10002

	local var_2_0

	if not arg_2_0.color_list then
		var_2_0 = {}
	end

	for iter_2_0, iter_2_1 in var_1_10002(var_2_0) do
		if iter_2_1 == arg_2_1 then
			return true
		end
	end

	return false
end

function var_0_1.SetCurrentColor(arg_3_0, arg_3_1)
	arg_3_0.color_id = arg_3_1

	return
end

function var_0_1.GetCurrentColor(arg_4_0, arg_4_1)
	local var_4_0

	if not arg_4_0.color_id then
		var_4_0 = 0
	end

	return var_4_0
end

function var_0_1.AddSkinColor(arg_5_0, arg_5_1)
	table = var_1_10002

	var_1_10002.insert(arg_5_0.color_list, arg_5_1)

	return
end

function var_0_1.IsOwnAllColor(arg_6_0)
	local var_6_0 = #arg_6_0.color_list

	pg = var_1_10002

	return var_6_0 == #var_1_10002.island_skin_colordiff_template.get_id_list_by_skin_group[arg_6_0.id]
end

return var_0_1
