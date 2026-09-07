local AgoraSystemTheme = class("AgoraSystemTheme", import(".AgoraBaseTheme"))

function AgoraSystemTheme:Ctor(arg_1_1)
	AgoraSystemTheme.super.Ctor(self, arg_1_1)
	self:Flush(arg_1_1)

	return
end

function AgoraSystemTheme:Owned(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(self.placedlist) do
		if not arg_2_1[iter_2_1.id] then
			return false
		end
	end

	for iter_2_2, iter_2_3 in ipairs(self.floorData) do
		if not arg_2_1[iter_2_3.id] then
			return false
		end
	end

	for iter_2_4, iter_2_5 in ipairs(self.tileData) do
		if not arg_2_1[iter_2_5.id] then
			return false
		end
	end

	return true
end

function AgoraSystemTheme:Flush(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1:GetPlacedList()) do
		local var_3_0 = AgoraFurniture.New({
			id = iter_3_1.id,
			configId = iter_3_1.configId
		})

		var_3_0:FlushDataFromPlacementData(iter_3_1)
		table.insert(self.placedlist, var_3_0)
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_1:GetFloorLayer()) do
		local var_3_1 = AgoraLayerCell.New(iter_3_3.position)

		var_3_1:Fill(iter_3_3.id, iter_3_3.shapeId)
		table.insert(self.floorData, var_3_1)
	end

	for iter_3_4, iter_3_5 in ipairs(arg_3_1:GetTileLayer()) do
		local var_3_2 = AgoraLayerCell.New(iter_3_5.position)

		var_3_2:Fill(iter_3_5.id, iter_3_5.shapeId)
		table.insert(self.tileData, var_3_2)
	end

	return
end

function AgoraSystemTheme:Belong(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(type(pg.island_furniture_theme[self.id].furniture) == "table" and pg.island_furniture_theme[self.id].furniture or {}) do
		if iter_4_1 == arg_4_1.configId then
			return true
		end
	end

	return false
end

return AgoraSystemTheme
