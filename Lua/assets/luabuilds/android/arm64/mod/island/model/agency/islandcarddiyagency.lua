local var_0_0 = class("IslandCardDiyAgency", import(".IslandBaseAgency"))

function var_0_0.OnInit(arg_1_0, arg_1_1)
	arg_1_0.data = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.image_list) do
		arg_1_0.data[iter_1_1.id] = IslandCardDiy.New(iter_1_1)
	end

	arg_1_0.data[pg.island_set.island_card_photo_default.key_value_int] = arg_1_0.data[pg.island_set.island_card_photo_default.key_value_int] or IslandCardDiy.New({
		num = 1,
		id = pg.island_set.island_card_photo_default.key_value_int
	})

	return
end

function var_0_0.GetData(arg_2_0)
	return arg_2_0.data
end

function var_0_0.GetIds(arg_3_0)
	return underscore.keys(arg_3_0.data)
end

function var_0_0.GetIdCount(arg_4_0, arg_4_1)
	if arg_4_0.data[arg_4_1] then
		return arg_4_0.data[arg_4_1].count or 0
	end
end

function var_0_0.AddCardDiy(arg_5_0, arg_5_1)
	if arg_5_0.data[arg_5_1.id] then
		arg_5_0.data[arg_5_1.id]:AddCount(arg_5_1.num)
	else
		arg_5_0.data[arg_5_1.id] = IslandCardDiy.New(arg_5_1)
	end

	return
end

return var_0_0
