local var_0_0 = class("CourtYardPaper")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_2.id
	arg_1_0.configId = arg_1_2.configId or arg_1_0.id
	arg_1_0.config = pg.furniture_data_template[arg_1_0.configId]

	return
end

function var_0_0.IsDirty(arg_2_0)
	return true
end

function var_0_0.UnDirty(arg_3_0)
	return
end

function var_0_0.GetObjType(arg_4_0)
	if arg_4_0.config.spine ~= nil then
		return CourtYardConst.OBJ_TYPE_SPINE
	else
		return CourtYardConst.OBJ_TYPE_COMMOM
	end

	return
end

function var_0_0.GetPicture(arg_5_0)
	return arg_5_0.config.picture
end

function var_0_0.GetSpineNameAndAction(arg_6_0)
	return arg_6_0.config.spine[1][1], arg_6_0.config.spine[1][2]
end

function var_0_0.GetType(arg_7_0)
	return arg_7_0.config.type
end

function var_0_0.ToTable(arg_8_0)
	return {
		parent = 0,
		y = 0,
		dir = 1,
		x = 0,
		id = arg_8_0.id,
		configId = arg_8_0.configId,
		position = Vector2(0, 0),
		child = {}
	}
end

return var_0_0
