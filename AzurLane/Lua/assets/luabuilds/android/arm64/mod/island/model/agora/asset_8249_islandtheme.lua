class = var_0_10000

local var_0_0 = var_0_10000("IslandTheme")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1.id then
		var_1_0 = -1
	end

	arg_1_0.id = var_1_0

	local var_1_1

	if not arg_1_1.name then
		var_1_1 = ""
	end

	arg_1_0.name = var_1_1
	arg_1_0.placedList = {}
	arg_1_0.floorLayer = {}
	arg_1_0.tileLayer = {}
	ipairs = var_2

	local var_1_2

	if not arg_1_1.placed_data.placed_list then
		var_1_2 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_2) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_1_3 = arg_1_0.placedList
		local var_1_4 = {
			id = iter_1_1.id
		}

		Vector2 = var_1_10011
		var_1_4.position = var_1_10011(iter_1_1.x, iter_1_1.y)
		Vector3 = var_1_10011
		var_1_4.rotation = var_1_10011(0, iter_1_1.dir * 90, 0)
		var_1_4.configId = iter_1_1.configId

		var_1_10007(var_1_3, var_1_4)
	end

	ipairs = var_2

	local var_1_5

	if not arg_1_1.placed_data.floor_data then
		var_1_5 = {}
	end

	for iter_1_2, iter_1_3 in var_2(var_1_5) do
		AgoraCalc = var_1_10007

		local var_1_6, var_1_7, var_1_8

		var_1_10007, var_1_6, var_1_7, var_1_8 = var_1_10007.DecodeLayer(iter_1_3)
		table = var_1_10011
		var_1_10011 = var_1_10011.insert

		local var_1_9 = arg_1_0.floorLayer
		local var_1_10 = {}

		Vector2 = var_1_10015
		var_1_10.position = var_1_10015(var_1_7, var_1_8)
		var_1_10.id = var_1_10007
		var_1_10.shapeId = var_1_6

		var_1_10011(var_1_9, var_1_10)
	end

	ipairs = var_2

	local var_1_11

	if not arg_1_1.placed_data.tile_data then
		var_1_11 = {}
	end

	for iter_1_4, iter_1_5 in var_2(var_1_11) do
		AgoraCalc = var_1_10007

		local var_1_12, var_1_13, var_1_14

		var_1_10007, var_1_12, var_1_13, var_1_14 = var_1_10007.DecodeLayer(iter_1_5)
		table = var_1_10011
		var_1_10011 = var_1_10011.insert

		local var_1_15 = arg_1_0.tileLayer
		local var_1_16 = {}

		Vector2 = var_1_10015
		var_1_16.position = var_1_10015(var_1_13, var_1_14)
		var_1_16.id = var_1_10007
		var_1_16.shapeId = var_1_12

		var_1_10011(var_1_15, var_1_16)
	end

	return
end

function var_0_0.GetID(arg_2_0)
	return arg_2_0.id
end

function var_0_0.SetName(arg_3_0, arg_3_1)
	arg_3_0.name = arg_3_1

	return
end

function var_0_0.GetName(arg_4_0)
	return arg_4_0.name
end

function var_0_0.GetPlacedList(arg_5_0)
	return arg_5_0.placedList
end

function var_0_0.GetFloorLayer(arg_6_0)
	return arg_6_0.floorLayer
end

function var_0_0.GetTileLayer(arg_7_0)
	return arg_7_0.tileLayer
end

return var_0_0
