class = var_0_10000

local var_0_0 = "IslandCommanderDressItem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.state = arg_1_1.state
	arg_1_0.color = arg_1_1.color

	local var_1_0

	if not arg_1_1.color_list then
		var_1_0 = {}
	end

	arg_1_0.color_list = var_1_0

	return
end

function var_0_1.SetReadState(arg_2_0, arg_2_1)
	arg_2_0.state = arg_2_1

	return
end

function var_0_1.ChangeColor(arg_3_0, arg_3_1)
	arg_3_0.color = arg_3_1

	return
end

function var_0_1.CheckColorIsOwned(arg_4_0, arg_4_1)
	if arg_4_1 == 0 then
		return true
	end

	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.color_list) do
		if iter_4_1 == arg_4_1 then
			return true
		end
	end

	return false
end

function var_0_1.AddDressColor(arg_5_0, arg_5_1)
	table = var_1_10002

	var_1_10002.insert(arg_5_0.color_list, arg_5_1)

	return
end

function var_0_1.bindConfigTable(arg_6_0)
	pg = var_1_10001

	return var_1_10001.island_dress_template
end

function var_0_1.GetSortValue(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = 0

	IslandShipDressUpPageNew = var_1_10004

	if arg_7_1 == var_1_10004.SORT_RARITY then
		var_7_0 = arg_7_0:GetRarity()
	else
		var_7_0 = arg_7_0.id
	end

	return arg_7_2 == 1 and var_7_0 or -1 * var_7_0
end

function var_0_1.GetRarity(arg_8_0)
	return arg_8_0:getConfig("quality")
end

return var_0_1
