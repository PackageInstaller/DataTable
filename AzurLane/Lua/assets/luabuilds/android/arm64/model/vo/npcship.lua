local var_0_0 = class("NpcShip", import(".Ship"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	for iter_1_0 = 1, 3 do
		if not arg_1_0.equipments[iter_1_0] then
			local var_1_0 = arg_1_0.equipments

			var_1_0[iter_1_0] = pg.ship_data_template[arg_1_0.configId]["equip_id_" .. iter_1_0] > 0 and Equipment.New({
				id = pg.ship_data_template[arg_1_0.configId]["equip_id_" .. iter_1_0]
			}) or false
		end
	end

	arg_1_0.isNpc = true

	return
end

function var_0_0.getExp(arg_2_0)
	return 0
end

function var_0_0.addExp(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0_0.getIntimacy(arg_4_0)
	return pg.intimacy_template[arg_4_0:getIntimacyLevel()].lower_bound
end

function var_0_0.getIntimacyLevel(arg_5_0)
	return 2
end

function var_0_0.setIntimacy(arg_6_0, arg_6_1)
	return
end

function var_0_0.getEnergy(arg_7_0)
	return pg.ship_data_template[arg_7_0.configId].energy
end

function var_0_0.setEnergy(arg_8_0, arg_8_1)
	return
end

return var_0_0
