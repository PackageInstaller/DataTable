class = var_0_10000

local var_0_0 = "CommanderBuildPool"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.commander_data_create_material
end

function var_0_1.getName(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.getConfig(var_3_0, "use_item")

	Item = var_3_0

	local var_3_2 = var_3_0.New({
		id = var_3_1
	})
	local var_3_3

	if not arg_3_0:getConfig("name") and not var_3_2:getConfig("name") then
		var_3_3 = ""
	end

	return var_3_3
end

function var_0_1.getConsume(arg_4_0)
	local var_4_0 = arg_4_0:getConfig("use_item")
	local var_4_1 = arg_4_0:getConfig("number_1")

	return {
		{
			2,
			var_4_0,
			var_4_1
		}
	}
end

function var_0_1.getConsumeDesc(arg_5_0)
	local var_5_0 = arg_5_0:getConfig("use_gold")
	local var_5_1 = arg_5_0:getConfig("use_item")
	local var_5_2 = arg_5_0
	local var_5_3 = arg_5_0.getConfig(var_5_2, "number_1")

	Item = var_5_2

	local var_5_4 = var_5_2.New({
		id = var_5_1
	})

	i18n = var_5

	return var_5("commander_build_pool_tip", var_5_4:getConfig("name"), var_5_3)
end

function var_0_1.getPrint(arg_6_0)
	Commander = var_1_10001

	return var_1_10001.rarity2Print(arg_6_0.id + 2)
end

function var_0_1.getItemCount(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.getConfig(var_7_0, "use_item")

	getProxy = var_7_0
	BagProxy = var_3

	local var_7_2 = var_7_0(var_3)

	return var_2.getItemCountById(var_7_2, var_7_1)
end

function var_0_1.getRarity(arg_8_0)
	return arg_8_0.id
end

return var_0_1
