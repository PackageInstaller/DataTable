local GetCanBePutFurnituresForThemeCommand = class("GetCanBePutFurnituresForThemeCommand", pm.SimpleCommand)

function GetCanBePutFurnituresForThemeCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(DormProxy).floor
	local var_1_2 = GetCanBePutFurnituresForThemeCommand.GetAllFloorFurnitures()

	if var_1_0.theme:IsOccupyed(var_1_2, var_1_1) then
		local var_1_3 = var_1_0.theme:GetUsableFurnituresForFloor(var_1_2, var_1_1)

		GetCanBePutFurnituresForThemeCommand.SortListForPut(var_1_3)

		if var_1_0.callback then
			var_1_0.callback(false, var_1_3)
		end
	else
		local var_1_4 = {}

		for iter_1_0, iter_1_1 in pairs(Clone((var_1_0.theme:GetAllFurniture()))) do
			table.insert(var_1_4, iter_1_1)
		end

		GetCanBePutFurnituresForThemeCommand.SortListForPut(var_1_4)

		if var_1_0.callback then
			var_1_0.callback(true, var_1_4)
		end
	end

	return
end

function GetCanBePutFurnituresForThemeCommand.GetAllFloorFurnitures()
	local var_2_0 = {}

	GetCanBePutFurnituresForThemeCommand.GetCurrFloorHouse(var_2_0)
	GetCanBePutFurnituresForThemeCommand.GetOtherFloorHouse(var_2_0)

	return var_2_0
end

function GetCanBePutFurnituresForThemeCommand:GetCurrFloorHouse()
	for iter_3_0, iter_3_1 in pairs((_courtyard:GetController():GetStoreyData())) do
		self[iter_3_1.id] = GetCanBePutFurnituresForThemeCommand.StoreyFurniture2ThemeFurniture(iter_3_1)
	end

	return
end

function GetCanBePutFurnituresForThemeCommand:StoreyFurniture2ThemeFurniture()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(self.child) do
		var_4_0[tonumber(iter_4_0)] = {
			x = iter_4_1.x,
			y = iter_4_1.y
		}
	end

	local var_4_1 = {
		id = tonumber(self.id)
	}

	var_4_1.configId = self.configId or tonumber(self.id)
	var_4_1.position = self.position
	var_4_1.dir = self.dir
	var_4_1.child = var_4_0
	var_4_1.parent = tonumber(self.parent) or 0
	var_4_1.floor = self.floor

	return BackyardThemeFurniture.New(var_4_1)
end

function GetCanBePutFurnituresForThemeCommand:GetOtherFloorHouse()
	for iter_5_0, iter_5_1 in pairs((GetCanBePutFurnituresForThemeCommand.GetFurnitureInOtherFloor(getProxy(DormProxy).floor))) do
		self[iter_5_1.id] = iter_5_1
	end

	return
end

function GetCanBePutFurnituresForThemeCommand:GetFurnitureInOtherFloor()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(getProxy(DormProxy):getRawData():GetThemeList()) do
		if self ~= iter_6_0 then
			for iter_6_2, iter_6_3 in pairs(iter_6_1:GetAllFurniture()) do
				var_6_0[iter_6_2] = iter_6_3
			end
		end
	end

	return var_6_0
end

function GetCanBePutFurnituresForThemeCommand:IsUsing()
	local var_7_0 = {}
	local var_7_1 = {}

	GetCanBePutFurnituresForThemeCommand.GetCurrFloorHouse(var_7_0)
	GetCanBePutFurnituresForThemeCommand.GetOtherFloorHouse(var_7_1)

	return self.id ~= "" and (self:IsUsing(var_7_0) or self:IsUsing(var_7_1))
end

function GetCanBePutFurnituresForThemeCommand:SortListForPut()
	local var_8_0 = pg.furniture_data_template

	table.sort(self, function(arg_9_0, arg_9_1)
		if (arg_9_0.parent ~= 0 and 1 or 0) == (arg_9_1.parent ~= 0 and 1 or 0) then
			local var_9_0 = var_8_0[arg_9_0.id] and var_8_0[arg_9_0.id].type == Furniture.TYPE_STAGE and 1 or 0
			local var_9_1 = var_8_0[arg_9_1.id] and var_8_0[arg_9_1.id].type == Furniture.TYPE_STAGE and 1 or 0

			if (var_8_0[arg_9_0.id] and var_8_0[arg_9_0.id].type == Furniture.TYPE_STAGE and 1 or 0) == (var_8_0[arg_9_1.id] and var_8_0[arg_9_1.id].type == Furniture.TYPE_STAGE and 1 or 0) then
				local var_9_3 = table.getCount(arg_9_0.child or {})
				local var_9_4 = table.getCount(arg_9_1.child or {})

				if var_9_3 == var_9_4 then
					return arg_9_0.id < arg_9_0.id
				else
					return var_9_4 < var_9_3
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

return GetCanBePutFurnituresForThemeCommand
