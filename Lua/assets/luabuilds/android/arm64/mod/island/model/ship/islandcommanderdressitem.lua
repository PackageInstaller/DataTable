local var_0_0 = class("IslandCommanderDressItem", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.state = arg_1_1.state
	arg_1_0.color = arg_1_1.color
	arg_1_0.color_list = arg_1_1.color_list or {}

	return
end

function var_0_0.SetReadState(arg_2_0, arg_2_1)
	arg_2_0.state = arg_2_1

	return
end

function var_0_0.ChangeColor(arg_3_0, arg_3_1)
	arg_3_0.color = arg_3_1

	return
end

function var_0_0.CheckColorIsOwned(arg_4_0, arg_4_1)
	if arg_4_1 == 0 then
		return true
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.color_list) do
		if iter_4_1 == arg_4_1 then
			return true
		end
	end

	return false
end

function var_0_0.AddDressColor(arg_5_0, arg_5_1)
	table.insert(arg_5_0.color_list, arg_5_1)

	return
end

function var_0_0.bindConfigTable(arg_6_0)
	return pg.island_dress_template
end

function var_0_0.GetSortValue(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = 0

	var_7_0 = arg_7_1 == IslandShipDressUpPageNew.SORT_RARITY and arg_7_0:GetRarity() or arg_7_0.id

	return arg_7_2 == 1 and var_7_0 or -1 * var_7_0
end

function var_0_0.GetRarity(arg_8_0)
	return arg_8_0:getConfig("quality")
end

return var_0_0
