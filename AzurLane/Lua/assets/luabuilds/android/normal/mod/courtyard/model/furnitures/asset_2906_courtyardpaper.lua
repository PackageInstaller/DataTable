class = var_0_10000

local var_0_0 = var_0_10000("CourtYardPaper")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_2.id

	local var_1_0

	if not arg_1_2.configId then
		var_1_0 = arg_1_0.id
	end

	arg_1_0.configId = var_1_0
	pg = var_1_0
	arg_1_0.config = var_1_0.furniture_data_template[arg_1_0.configId]

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
		CourtYardConst = var_1

		return var_1.OBJ_TYPE_SPINE
	else
		CourtYardConst = var_1

		return var_1.OBJ_TYPE_COMMOM
	end

	return
end

function var_0_0.GetPicture(arg_5_0)
	return arg_5_0.config.picture
end

function var_0_0.GetSpineNameAndAction(arg_6_0)
	return arg_6_0.config.spine[1][1], var_1[2]
end

function var_0_0.GetType(arg_7_0)
	return arg_7_0.config.type
end

function var_0_0.ToTable(arg_8_0)
	local var_8_0 = {
		parent = 0,
		y = 0,
		dir = 1,
		x = 0,
		id = arg_8_0.id,
		configId = arg_8_0.configId
	}

	Vector2 = var_2
	var_8_0.position = var_2(0, 0)
	var_8_0.child = {}

	return var_8_0
end

return var_0_0
