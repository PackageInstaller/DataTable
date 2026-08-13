class = var_0_10000

local var_0_0 = "AgoraTheme"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".AgoraBaseTheme"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)
	arg_1_0:Flush(arg_1_1, arg_1_2)

	return
end

function var_0_1.Flush(arg_2_0, arg_2_1, arg_2_2)
	ipairs = var_1_10003

	for iter_2_0, iter_2_1 in var_1_10003(arg_2_1:GetPlacedList()) do
		if arg_2_2[iter_2_1.id] then
			Clone = var_1_10009

			local var_2_0 = var_1_10009(var_1_10008)

			var_1_10009.FlushDataFromPlacementData(var_2_0, iter_2_1)

			table = var_10

			var_10.insert(arg_2_0.placedlist, var_1_10009)
		end
	end

	ipairs = var_3

	for iter_2_2, iter_2_3 in var_3(arg_2_1:GetFloorLayer()) do
		AgoraLayerCell = var_1_10008

		local var_2_1 = var_1_10008.New(iter_2_3.position)

		var_1_10008.Fill(var_2_1, iter_2_3.id, iter_2_3.shapeId)

		table = var_9

		var_9.insert(arg_2_0.floorData, var_1_10008)
	end

	ipairs = var_3

	for iter_2_4, iter_2_5 in var_3(arg_2_1:GetTileLayer()) do
		AgoraLayerCell = var_1_10008

		local var_2_2 = var_1_10008.New(iter_2_5.position)

		var_1_10008.Fill(var_2_2, iter_2_5.id, iter_2_5.shapeId)

		table = var_9

		var_9.insert(arg_2_0.tileData, var_1_10008)
	end

	return
end

return var_0_1
