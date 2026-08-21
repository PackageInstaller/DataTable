local var_0_0 = class("AgoraSystemTheme", import(".AgoraBaseTheme"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)
	arg_1_0:Flush(arg_1_1)

	return
end

function var_0_0.Owned(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.placedlist) do
		if not arg_2_1[iter_2_1.id] then
			return false
		end
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_0.floorData) do
		if not arg_2_1[iter_2_3.id] then
			return false
		end
	end

	for iter_2_4, iter_2_5 in ipairs(arg_2_0.tileData) do
		if not arg_2_1[iter_2_5.id] then
			return false
		end
	end

	return true
end

function var_0_0.Flush(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1:GetPlacedList()) do
		local var_3_0 = AgoraFurniture.New({
			id = iter_3_1.id,
			configId = iter_3_1.configId
		})

		var_3_0:FlushDataFromPlacementData(iter_3_1)
		table.insert(arg_3_0.placedlist, var_3_0)
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_1:GetFloorLayer()) do
		local var_3_1 = AgoraLayerCell.New(iter_3_3.position)

		var_3_1:Fill(iter_3_3.id, iter_3_3.shapeId)
		table.insert(arg_3_0.floorData, var_3_1)
	end

	for iter_3_4, iter_3_5 in ipairs(arg_3_1:GetTileLayer()) do
		local var_3_2 = AgoraLayerCell.New(iter_3_5.position)

		var_3_2:Fill(iter_3_5.id, iter_3_5.shapeId)
		table.insert(arg_3_0.tileData, var_3_2)
	end

	return
end

function var_0_0.Belong(arg_4_0, arg_4_1)
	local var_4_0 = type(pg.island_furniture_theme[arg_4_0.id].furniture) == "table" and pg.island_furniture_theme[arg_4_0.id].furniture or {}

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if iter_4_1 == arg_4_1.configId then
			return true
		end
	end

	return false
end

return var_0_0
