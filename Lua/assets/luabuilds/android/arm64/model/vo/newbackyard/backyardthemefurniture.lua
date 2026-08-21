local var_0_0 = class("BackyardThemeFurniture")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = tonumber(arg_1_1.id)
	arg_1_0.configId = arg_1_1.configId or tonumber(arg_1_1.id)
	arg_1_0.position = arg_1_1.position
	arg_1_0.dir = arg_1_1.dir or 1
	arg_1_0.parent = tonumber(arg_1_1.parent) or 0
	arg_1_0.child = arg_1_1.child or {}
	arg_1_0.date = arg_1_1.date or 0
	arg_1_0.floor = arg_1_1.floor
	arg_1_0.isNewStyle = arg_1_1.isNewStyle

	return
end

function var_0_0.GetUniqueId(arg_2_0, arg_2_1)
	return arg_2_0 * 100 + arg_2_1
end

function var_0_0.GetAllUniqueId(arg_3_0)
	for iter_3_0 = 0, pg.furniture_data_template[arg_3_0.configId].count - 1 do
		table.insert({}, var_0_0.GetUniqueId(arg_3_0.configId, iter_3_0))
	end

	return {}
end

function var_0_0.SetUniqueId(arg_4_0, arg_4_1)
	arg_4_0.id = arg_4_1

	return
end

function var_0_0.SetParent(arg_5_0, arg_5_1)
	arg_5_0.parent = arg_5_1

	return
end

function var_0_0.SetChildList(arg_6_0, arg_6_1)
	arg_6_0.child = arg_6_1

	return
end

function var_0_0.HasParent(arg_7_0)
	return arg_7_0.parent ~= 0
end

function var_0_0.AnyChild(arg_8_0)
	return table.getCount(arg_8_0.child) > 0
end

function var_0_0.GetChildIdList(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.child) do
		table.insert({}, ids)
	end

	return {}
end

function var_0_0.GetChildList(arg_10_0)
	return arg_10_0.child
end

function var_0_0.GetPosition(arg_11_0)
	return arg_11_0.position
end

function var_0_0.SameParent(arg_12_0, arg_12_1)
	return arg_12_0.parent == arg_12_1
end

function var_0_0.GetDir(arg_13_0)
	return arg_13_0.dir
end

function var_0_0.UpdateParent(arg_14_0, arg_14_1)
	arg_14_0.parent = arg_14_1

	return
end

function var_0_0.UpdateChildList(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in pairs(arg_15_1) do
		({})[iter_15_0] = iter_15_1
	end

	arg_15_0:SetChildList({})

	return
end

function var_0_0.UpdateFloor(arg_16_0, arg_16_1)
	arg_16_0.floor = arg_16_1

	return
end

function var_0_0.SameChildPosition(arg_17_0, arg_17_1, arg_17_2)
	return arg_17_0:GetPosition() == arg_17_1 + arg_17_2
end

function var_0_0.isPaper(arg_18_0)
	local var_18_0 = arg_18_0:getConfig("type")

	if var_18_0 == Furniture.TYPE_WALLPAPER or var_18_0 == Furniture.TYPE_FLOORPAPER then
		return true
	end

	return false
end

function var_0_0.getConfig(arg_19_0, arg_19_1)
	if pg.furniture_data_template[arg_19_0.configId][arg_19_1] then
		return pg.furniture_data_template[arg_19_0.configId][arg_19_1]
	else
		local var_19_0 = pg.furniture_shop_template[arg_19_0.configId]

		if pg.furniture_shop_template[arg_19_0.configId] then
			return var_19_0[arg_19_1]
		end
	end

	return
end

function var_0_0.IsWall(arg_20_0)
	local var_20_0 = arg_20_0:getConfig("type")

	return var_20_0 == Furniture.TYPE_WALL or var_20_0 == Furniture.TYPE_WALL_MAT
end

function var_0_0.isSame(arg_21_0, arg_21_1)
	if arg_21_0.position.x == arg_21_1.position.x and arg_21_0.position.y == arg_21_1.position.y and (arg_21_0.dir == arg_21_1.dir or arg_21_0:IsWall()) and arg_21_0.parent == arg_21_1.parent then
		return true
	end

	return false
end

function var_0_0.IsSameConfig(arg_22_0, arg_22_1)
	return arg_22_0.configId == arg_22_1
end

function var_0_0.UpdatePosition(arg_23_0, arg_23_1)
	arg_23_0.position = arg_23_1

	return
end

function var_0_0.UpdateDir(arg_24_0, arg_24_1)
	arg_24_0.dir = arg_24_1

	return
end

function var_0_0._GetWeight(arg_25_0)
	local var_25_0 = 3

	if pg.furniture_data_template[arg_25_0.configId].type == Furniture.TYPE_FLOORPAPER then
		var_25_0 = 0
	elseif pg.furniture_data_template[arg_25_0.configId].type == Furniture.TYPE_WALLPAPER then
		var_25_0 = 1
	elseif arg_25_0.parent ~= 0 and table.getCount(arg_25_0.child) > 0 then
		var_25_0 = 4
	elseif arg_25_0.parent ~= 0 then
		var_25_0 = 5
	elseif pg.furniture_data_template[arg_25_0.configId].type == Furniture.TYPE_STAGE then
		var_25_0 = 2
	end

	return var_25_0
end

function var_0_0._LoadWeight(arg_26_0, arg_26_1)
	local var_26_0 = var_0_0._GetWeight(arg_26_0)
	local var_26_1 = var_0_0._GetWeight(arg_26_1)

	if var_26_0 == var_26_1 then
		return arg_26_0.id < arg_26_1.id
	else
		return var_26_0 < var_26_1
	end

	return
end

function var_0_0.ToSaveData(arg_27_0)
	return {
		id = arg_27_0.id,
		configId = arg_27_0.configId,
		position = arg_27_0.position,
		x = arg_27_0.position.x,
		y = arg_27_0.position.y,
		dir = arg_27_0.dir,
		child = arg_27_0.child,
		parent = arg_27_0.parent,
		floor = arg_27_0.floor
	}
end

return var_0_0
