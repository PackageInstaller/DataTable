local var_0_0 = class("IslandInvitation", import(".IslandItem"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.shipId = arg_1_1

	var_0_0.super.Ctor(arg_1_0, {
		num = 1,
		time = 0,
		id = pg.island_chara_template[arg_1_1].invite_item
	})

	return
end

function var_0_0.GetShipName(arg_2_0)
	return pg.island_chara_template[arg_2_0.shipId].name
end

return var_0_0
