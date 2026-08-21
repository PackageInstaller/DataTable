local var_0_0 = class("VirtualEducateCharShip", import("model.vo.Ship"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.educateCharId = arg_1_1
	arg_1_0.templateConfig = pg.secretary_special_ship[arg_1_1]

	local var_1_0

	if arg_1_0.templateConfig.unlock_type == EducateConst.SECRETARY_UNLCOK_TYPE_SHOP then
		var_1_0 = arg_1_0.templateConfig.unlock[1]
	end

	var_0_0.super.Ctor(arg_1_0, {
		configId = 999024,
		id = var_1_0 or 99999999
	})

	arg_1_0.skinId = var_1_0 or arg_1_0.skinId
	arg_1_0.name = arg_1_0.templateConfig.name

	return
end

function var_0_0.getPainting(arg_2_0)
	return arg_2_0.templateConfig.prefab or "tbniang"
end

function var_0_0.getName(arg_3_0)
	return arg_3_0.templateConfig.name or ""
end

function var_0_0.getPrefab(arg_4_0)
	return arg_4_0.templateConfig.head
end

function var_0_0.GetRecordPosKey(arg_5_0)
	return arg_5_0.educateCharId .. "" .. arg_5_0.id
end

function var_0_0.getSkinId(arg_6_0)
	return arg_6_0.skinId
end

return var_0_0
