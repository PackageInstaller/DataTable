class = var_0_10000

local var_0_0 = "AgoraSystemTheme"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".AgoraBaseTheme"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)
	arg_1_0:Flush(arg_1_1)

	return
end

function var_0_1.Owned(arg_2_0, arg_2_1)
	ipairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(arg_2_0.placedlist) do
		if not arg_2_1[iter_2_1.id] then
			return false
		end
	end

	ipairs = var_2

	for iter_2_2, iter_2_3 in var_2(arg_2_0.floorData) do
		if not arg_2_1[iter_2_3.id] then
			return false
		end
	end

	ipairs = var_2

	for iter_2_4, iter_2_5 in var_2(arg_2_0.tileData) do
		if not arg_2_1[iter_2_5.id] then
			return false
		end
	end

	return true
end

function var_0_1.Flush(arg_3_0, arg_3_1)
	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_1:GetPlacedList()) do
		AgoraFurniture = var_1_10007

		local var_3_0 = var_1_10007.New({
			id = iter_3_1.id,
			configId = iter_3_1.configId
		})

		var_1_10007.FlushDataFromPlacementData(var_3_0, iter_3_1)

		table = var_8

		var_8.insert(arg_3_0.placedlist, var_1_10007)
	end

	ipairs = var_2

	for iter_3_2, iter_3_3 in var_2(arg_3_1:GetFloorLayer()) do
		AgoraLayerCell = var_1_10007

		local var_3_1 = var_1_10007.New(iter_3_3.position)

		var_1_10007.Fill(var_3_1, iter_3_3.id, iter_3_3.shapeId)

		table = var_8

		var_8.insert(arg_3_0.floorData, var_1_10007)
	end

	ipairs = var_2

	for iter_3_4, iter_3_5 in var_2(arg_3_1:GetTileLayer()) do
		AgoraLayerCell = var_1_10007

		local var_3_2 = var_1_10007.New(iter_3_5.position)

		var_1_10007.Fill(var_3_2, iter_3_5.id, iter_3_5.shapeId)

		table = var_8

		var_8.insert(arg_3_0.tileData, var_1_10007)
	end

	return
end

function var_0_1.Belong(arg_4_0, arg_4_1)
	pg = var_1_10002

	local var_4_0 = var_1_10002.island_furniture_theme[arg_4_0.id].furniture
	local var_4_1

	type = var_1_10004

	if var_1_10004(var_4_0) == "table" then
		var_4_1 = var_4_0
	else
		var_4_1 = {}
	end

	ipairs = var_4

	for iter_4_0, iter_4_1 in var_4(var_4_1) do
		if iter_4_1 == arg_4_1.configId then
			return true
		end
	end

	return false
end

return var_0_1
