class = var_0_10000

local var_0_0 = "IslandInvitation"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandItem"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.shipId = arg_1_1
	pg = var_1_10002

	local var_1_0 = var_1_10002.island_chara_template[arg_1_1].invite_item

	var_0_1.super.Ctor(arg_1_0, {
		num = 1,
		time = 0,
		id = var_1_0
	})

	return
end

function var_0_1.GetShipName(arg_2_0)
	pg = var_1_10001

	return var_1_10001.island_chara_template[arg_2_0.shipId].name
end

return var_0_1
