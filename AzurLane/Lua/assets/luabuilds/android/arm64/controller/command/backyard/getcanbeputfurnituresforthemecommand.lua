local var_0_0 = class("GetCanBePutFurnituresForThemeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(DormProxy).floor
	local var_1_2 = var_0_0.GetAllFloorFurnitures()

	if var_1_0.theme:IsOccupyed(var_1_2, var_1_1) then
		local var_1_3 = var_1_0.theme:GetUsableFurnituresForFloor(var_1_2, var_1_1)

		var_0_0.SortListForPut(var_1_3)

		if var_1_0.callback then
			var_1_0.callback(false, var_1_3)
		end
	else
		for iter_1_0, iter_1_1 in pairs(Clone((var_1_0.theme:GetAllFurniture()))) do
			table.insert({}, iter_1_1)
		end

		var_0_0.SortListForPut({})

		if var_1_0.callback then
			var_1_0.callback(true, {})
		end
	end

	return
end

function var_0_0.GetAllFloorFurnitures()
	var_0_0.GetCurrFloorHouse({})
	var_0_0.GetOtherFloorHouse({})

	return {}
end

function var_0_0.GetCurrFloorHouse(arg_3_0)
	for iter_3_0, iter_3_1 in pairs((_courtyard:GetController():GetStoreyData())) do
		arg_3_0[iter_3_1.id] = var_0_0.StoreyFurniture2ThemeFurniture(iter_3_1)
	end

	return
end

function var_0_0.StoreyFurniture2ThemeFurniture(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.child) do
		({})[tonumber(iter_4_0)] = {
			x = iter_4_1.x,
			y = iter_4_1.y
		}
	end

	local var_4_0 = {
		id = tonumber(arg_4_0.id)
	}

	var_4_0.configId = arg_4_0.configId or tonumber(arg_4_0.id)
	var_4_0.position = arg_4_0.position
	var_4_0.dir = arg_4_0.dir
	var_4_0.child = {}
	var_4_0.parent = tonumber(arg_4_0.parent) or 0
	var_4_0.floor = arg_4_0.floor

	return BackyardThemeFurniture.New(var_4_0)
end

function var_0_0.GetOtherFloorHouse(arg_5_0)
	for iter_5_0, iter_5_1 in pairs((var_0_0.GetFurnitureInOtherFloor(getProxy(DormProxy).floor))) do
		arg_5_0[iter_5_1.id] = iter_5_1
	end

	return
end

function var_0_0.GetFurnitureInOtherFloor(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(getProxy(DormProxy):getRawData():GetThemeList()) do
		if arg_6_0 ~= iter_6_0 then
			for iter_6_2, iter_6_3 in pairs(iter_6_1:GetAllFurniture()) do
				({})[iter_6_2] = iter_6_3
			end
		end
	end

	return {}
end

function var_0_0.IsUsing(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = {}

	var_0_0.GetCurrFloorHouse({})
	var_0_0.GetOtherFloorHouse(var_7_1)

	return arg_7_0.id ~= "" and (arg_7_0:IsUsing(var_7_0) or arg_7_0:IsUsing(var_7_1))
end

function var_0_0.SortListForPut(arg_8_0)
	local var_8_0 = pg.furniture_data_template

	table.sort(arg_8_0, function(arg_9_0, arg_9_1)
		if (arg_9_0.parent ~= 0 and 1 or 0) == (arg_9_1.parent ~= 0 and 1 or 0) then
			local var_9_0 = var_8_0[arg_9_0.id] and var_8_0[arg_9_0.id].type == Furniture.TYPE_STAGE and 1 or 0
			local var_9_1 = var_8_0[arg_9_1.id] and var_8_0[arg_9_1.id].type == Furniture.TYPE_STAGE and 1 or 0

			if (var_8_0[arg_9_0.id] and var_8_0[arg_9_0.id].type == Furniture.TYPE_STAGE and 1 or 0) == (var_8_0[arg_9_1.id] and var_8_0[arg_9_1.id].type == Furniture.TYPE_STAGE and 1 or 0) then
				local var_9_2 = arg_9_0.child or {}
				local var_9_3 = table.getCount(var_9_2)
				local var_9_4 = arg_9_1.child or {}
				local var_9_5 = table.getCount(var_9_4)

				if var_9_3 == var_9_5 then
					return arg_9_0.id < arg_9_0.id
				else
					return var_9_5 < var_9_3
				end
			else
				return var_9_1 < var_9_0
			end
		else
			return arg_9_0.parent < arg_9_1.parent
		end

		return
	end)

	return
end

return var_0_0
