class = var_0_10000

local var_0_0 = "ChapterTransportFleet"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".ChapterFleet"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.line = {
		row = arg_1_1.pos.row,
		column = arg_1_1.pos.column
	}
	arg_1_0.id = arg_1_2
	arg_1_0.configId = arg_1_1.item_id
	arg_1_0.restHp = arg_1_1.item_data
	Quaternion = var_3
	arg_1_0.rotation = var_3.identity

	arg_1_0:updateShips({})

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.friendly_data_template
end

function var_0_1.getFleetType(arg_3_0)
	FleetType = var_1_10001

	return var_1_10001.Transport
end

function var_0_1.getPrefab(arg_4_0)
	local var_4_0 = {
		{
			20,
			16
		},
		{
			15,
			11
		},
		{
			10,
			1
		},
		{
			0,
			0
		}
	}
	local var_4_1 = ({
		"merchant",
		"merchant_1",
		"merchant_2",
		"merchant_d"
	})[1]

	ipairs = var_1_10004

	for iter_4_0, iter_4_1 in var_1_10004(var_4_0) do
		if arg_4_0:getRestHp() >= iter_4_1[2] and arg_4_0:getRestHp() <= iter_4_1[1] then
			var_4_1 = var_2[iter_4_0]

			break
		end
	end

	return var_4_1
end

function var_0_1.getRestHp(arg_5_0)
	return arg_5_0.restHp
end

function var_0_1.setRestHp(arg_6_0, arg_6_1)
	arg_6_0.restHp = arg_6_1

	return
end

function var_0_1.getTotalHp(arg_7_0)
	return arg_7_0:getConfig("hp")
end

function var_0_1.isValid(arg_8_0)
	return arg_8_0.restHp > 0
end

return var_0_1
