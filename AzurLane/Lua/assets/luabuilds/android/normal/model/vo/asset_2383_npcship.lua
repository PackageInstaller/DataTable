class = var_0_10000

local var_0_0 = "NpcShip"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".Ship"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	pg = var_2

	local var_1_0 = var_2.ship_data_template[arg_1_0.configId]

	for iter_1_0 = 1, 3 do
		if not arg_1_0.equipments[iter_1_0] then
			local var_1_1 = var_1_0["equip_id_" .. iter_1_0]
			local var_1_2 = arg_1_0.equipments

			if 0 < var_1_1 then
				Equipment = var_9

				local var_1_3

				if not var_9.New({
					id = var_1_1
				}) then
					var_1_3 = false
				end

				var_1_2[iter_1_0] = var_1_3
			end
		end
	end

	arg_1_0.isNpc = true

	return
end

function var_0_1.getExp(arg_2_0)
	return 0
end

function var_0_1.addExp(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0_1.getIntimacy(arg_4_0)
	pg = var_1_10001

	return var_1_10001.intimacy_template[arg_4_0:getIntimacyLevel()].lower_bound
end

function var_0_1.getIntimacyLevel(arg_5_0)
	return 2
end

function var_0_1.setIntimacy(arg_6_0, arg_6_1)
	return
end

function var_0_1.getEnergy(arg_7_0)
	pg = var_1_10001

	return var_1_10001.ship_data_template[arg_7_0.configId].energy
end

function var_0_1.setEnergy(arg_8_0, arg_8_1)
	return
end

return var_0_1
