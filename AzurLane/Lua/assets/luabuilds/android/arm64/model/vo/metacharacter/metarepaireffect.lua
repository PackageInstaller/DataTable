local var_0_0 = class("MetaRepairEffect", import("..BaseVO"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.ship_meta_repair_effect
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_0.id
	arg_2_0.progress = arg_2_1.progress
	arg_2_0.attrs = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0:getConfig("effect_attr")) do
		arg_2_0.attrs[iter_2_1[1]] = iter_2_1[2]
	end

	arg_2_0.words = arg_2_0:getConfig("effect_dialog")
	arg_2_0.descs = string.split(arg_2_0:getConfig("effect_desc"), "|")
	arg_2_0.descs = ""

	return
end

function var_0_0.getAttrAdditionList(arg_3_0)
	return arg_3_0:getConfig("effect_attr")
end

function var_0_0.getAttrAddition(arg_4_0, arg_4_1)
	return arg_4_0.attrs[arg_4_1] or 0
end

function var_0_0.getDescs(arg_5_0)
	return arg_5_0.descs
end

function var_0_0.getWords(arg_6_0)
	return arg_6_0.words
end

return var_0_0
