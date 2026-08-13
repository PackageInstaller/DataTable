class = var_0_10000

local var_0_0 = "MetaRepairEffect"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.ship_meta_repair_effect
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_0.id
	arg_2_0.progress = arg_2_1.progress
	arg_2_0.attrs = {}
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_0:getConfig("effect_attr")) do
		arg_2_0.attrs[iter_2_1[1]] = iter_2_1[2]
	end

	arg_2_0.words = arg_2_0:getConfig("effect_dialog")
	string = var_2
	arg_2_0.descs = var_2.split(arg_2_0:getConfig("effect_desc"), "|")
	arg_2_0.descs = ""

	return
end

function var_0_1.getAttrAdditionList(arg_3_0)
	return arg_3_0:getConfig("effect_attr")
end

function var_0_1.getAttrAddition(arg_4_0, arg_4_1)
	local var_4_0

	if not arg_4_0.attrs[arg_4_1] then
		var_4_0 = 0
	end

	return var_4_0
end

function var_0_1.getDescs(arg_5_0)
	return arg_5_0.descs
end

function var_0_1.getWords(arg_6_0)
	return arg_6_0.words
end

return var_0_1
