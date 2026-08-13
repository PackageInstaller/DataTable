class = var_0_10000

local var_0_0 = "VirtualEducateCharShip"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.Ship"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.educateCharId = arg_1_1
	pg = var_1_10002
	arg_1_0.templateConfig = var_1_10002.secretary_special_ship[arg_1_1]

	local var_1_0
	local var_1_1 = arg_1_0.templateConfig.unlock_type

	EducateConst = var_1_10004

	if var_1_1 == var_1_10004.SECRETARY_UNLCOK_TYPE_SHOP then
		var_1_0 = arg_1_0.templateConfig.unlock[1]
	end

	var_0_1.super.Ctor(arg_1_0, {
		configId = 999024,
		id = var_1_0 or 99999999
	})

	arg_1_0.skinId = var_1_0 or arg_1_0.skinId
	arg_1_0.name = arg_1_0.templateConfig.name

	return
end

function var_0_1.getPainting(arg_2_0)
	local var_2_0

	if not arg_2_0.templateConfig.prefab then
		var_2_0 = "tbniang"
	end

	return var_2_0
end

function var_0_1.getName(arg_3_0)
	local var_3_0

	if not arg_3_0.templateConfig.name then
		var_3_0 = ""
	end

	return var_3_0
end

function var_0_1.getPrefab(arg_4_0)
	return arg_4_0.templateConfig.head
end

function var_0_1.GetRecordPosKey(arg_5_0)
	return arg_5_0.educateCharId .. "" .. arg_5_0.id
end

function var_0_1.getSkinId(arg_6_0)
	return arg_6_0.skinId
end

return var_0_1
