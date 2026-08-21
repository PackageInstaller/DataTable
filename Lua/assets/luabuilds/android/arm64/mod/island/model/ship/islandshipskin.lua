local var_0_0 = class("IslandShipSkin", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.color_id = arg_1_1.color_id
	arg_1_0.color_list = {}

	local var_1_0 = arg_1_1.color_list or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		table.insert(arg_1_0.color_list, iter_1_1)
	end

	return
end

function var_0_0.CheckColorOwned(arg_2_0, arg_2_1)
	if arg_2_1 == 0 then
		return true
	end

	local var_2_1 = arg_2_0.color_list or {}

	for iter_2_0, iter_2_1 in var_2_0(var_2_1) do
		if iter_2_1 == arg_2_1 then
			return true
		end
	end

	return false
end

function var_0_0.SetCurrentColor(arg_3_0, arg_3_1)
	arg_3_0.color_id = arg_3_1

	return
end

function var_0_0.GetCurrentColor(arg_4_0, arg_4_1)
	return arg_4_0.color_id or 0
end

function var_0_0.AddSkinColor(arg_5_0, arg_5_1)
	table.insert(arg_5_0.color_list, arg_5_1)

	return
end

function var_0_0.IsOwnAllColor(arg_6_0)
	return #arg_6_0.color_list == #pg.island_skin_colordiff_template.get_id_list_by_skin_group[arg_6_0.id]
end

return var_0_0
