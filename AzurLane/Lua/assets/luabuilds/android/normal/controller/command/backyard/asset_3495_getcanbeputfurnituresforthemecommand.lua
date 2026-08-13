class = var_0_10000

local var_0_0 = "GetCanBePutFurnituresForThemeCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().theme
	local var_1_1 = var_2.callback

	getProxy = var_1_10005
	DormProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006).floor
	local var_1_3 = var_0_1.GetAllFloorFurnitures()

	if var_1_0:IsOccupyed(var_1_3, var_1_2) then
		local var_1_4 = var_1_0:GetUsableFurnituresForFloor(var_1_3, var_1_2)

		var_0_1.SortListForPut(var_1_4)

		if var_1_1 then
			var_1_1(false, var_1_4)
		end
	else
		local var_1_5 = var_1_0:GetAllFurniture()
		local var_1_6 = {}

		pairs = var_10
		Clone = var_1_10011

		for iter_1_0, iter_1_1 in var_10(var_1_10011(var_1_5)) do
			table = var_1_10015

			var_1_10015.insert(var_1_6, iter_1_1)
		end

		var_0_1.SortListForPut(var_1_6)

		if var_1_1 then
			var_1_1(true, var_1_6)
		end
	end

	return
end

function var_0_1.GetAllFloorFurnitures()
	local var_2_0 = {}

	var_0_1.GetCurrFloorHouse(var_2_0)
	var_0_1.GetOtherFloorHouse(var_2_0)

	return var_2_0
end

function var_0_1.GetCurrFloorHouse(arg_3_0)
	_courtyard = var_1_10001

	local var_3_0 = var_1_10001:GetController()
	local var_3_1 = var_1.GetStoreyData(var_3_0)

	pairs = var_3_0

	for iter_3_0, iter_3_1 in var_3_0(var_3_1) do
		arg_3_0[iter_3_1.id] = var_0_1.StoreyFurniture2ThemeFurniture(iter_3_1)
	end

	return
end

function var_0_1.StoreyFurniture2ThemeFurniture(arg_4_0)
	local var_4_0 = {}

	pairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.child) do
		tonumber = var_1_10007
		var_4_0[var_1_10007(iter_4_0)] = {
			x = iter_4_1.x,
			y = iter_4_1.y
		}
	end

	BackyardThemeFurniture = var_2

	local var_4_1 = var_2.New
	local var_4_2 = {}

	tonumber = var_4
	var_4_2.id = var_4(arg_4_0.id)

	local var_4_3

	if not arg_4_0.configId then
		tonumber = var_4_3
		var_4_3 = var_4_3(arg_4_0.id)
	end

	var_4_2.configId = var_4_3
	var_4_2.position = arg_4_0.position
	var_4_2.dir = arg_4_0.dir
	var_4_2.child = var_4_0
	tonumber = var_4

	local var_4_4

	if not var_4(arg_4_0.parent) then
		var_4_4 = 0
	end

	var_4_2.parent = var_4_4
	var_4_2.floor = arg_4_0.floor

	return var_4_1(var_4_2)
end

function var_0_1.GetOtherFloorHouse(arg_5_0)
	local var_5_0 = var_0_1.GetFurnitureInOtherFloor

	getProxy = var_1_10002
	DormProxy = var_1_10003

	local var_5_1 = var_5_0(var_1_10002(var_1_10003).floor)

	pairs = var_2

	for iter_5_0, iter_5_1 in var_2(var_5_1) do
		arg_5_0[iter_5_1.id] = iter_5_1
	end

	return
end

function var_0_1.GetFurnitureInOtherFloor(arg_6_0)
	getProxy = var_1_10001
	DormProxy = var_1_10002

	local var_6_0 = var_1_10001(var_1_10002)
	local var_6_1 = var_1.getRawData(var_6_0)
	local var_6_2 = {}

	pairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(var_6_1:GetThemeList()) do
		if arg_6_0 ~= iter_6_0 then
			pairs = var_1_10008

			for iter_6_2, iter_6_3 in var_1_10008(iter_6_1:GetAllFurniture()) do
				var_6_2[iter_6_2] = iter_6_3
			end
		end
	end

	return var_6_2
end

function var_0_1.IsUsing(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = {}

	var_0_1.GetCurrFloorHouse(var_7_0)
	var_0_1.GetOtherFloorHouse(var_7_1)

	local var_7_2

	if arg_7_0.id ~= "" then
		if not arg_7_0:IsUsing(var_7_0) then
			var_7_2 = arg_7_0:IsUsing(var_7_1)
		end
	else
		var_7_2 = false
	end

	if false then
		var_7_2 = true
	end

	return var_7_2
end

function var_0_1.SortListForPut(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.furniture_data_template

	table = var_1_10002

	var_1_10002.sort(arg_8_0, function(arg_9_0, arg_9_1)
		if (arg_9_0.parent ~= 0 and 1 or 0) == (arg_9_1.parent ~= 0 and 1 or 0) then
			local var_9_1

			if var_8_0[arg_9_0.id] then
				local var_9_0 = var_8_0[arg_9_0.id].type

				Furniture = var_5

				if var_9_0 == var_5.TYPE_STAGE then
					var_9_1 = 1

					goto label_9_0
				end
			end

			var_9_1 = 0

			do
				local var_9_3
			end

			::label_9_0::

			if var_8_0[arg_9_1.id] then
				local var_9_2 = var_8_0[arg_9_1.id].type

				Furniture = var_6

				if var_9_2 == var_6.TYPE_STAGE then
					var_9_3 = 1

					goto label_9_1
				end
			end

			var_9_3 = 0

			::label_9_1::

			if var_9_1 == var_9_3 then
				table = var_6

				local var_9_4 = var_6.getCount
				local var_9_5

				if not arg_9_0.child then
					var_9_5 = {}
				end

				local var_9_6 = var_9_4(var_9_5)

				table = var_9_5

				local var_9_7 = var_9_5.getCount
				local var_9_8

				if not arg_9_1.child then
					var_9_8 = {}
				end

				if var_9_6 == var_9_7(var_9_8) then
					return arg_9_0.id < arg_9_0.id
				else
					return var_7 < var_9_6
				end
			else
				return var_9_3 < var_9_1
			end
		else
			return arg_9_0.parent < arg_9_1.parent
		end

		return
	end)

	return
end

return var_0_1
