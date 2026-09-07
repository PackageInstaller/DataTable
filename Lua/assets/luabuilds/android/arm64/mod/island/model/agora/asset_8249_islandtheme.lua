local IslandTheme = class("IslandTheme")

function IslandTheme:Ctor(arg_1_1)
	self.id = arg_1_1.id or -1
	self.name = arg_1_1.name or ""
	self.placedList = {}
	self.floorLayer = {}
	self.tileLayer = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.placed_data.placed_list or {}) do
		table.insert(self.placedList, {
			id = iter_1_1.id,
			position = Vector2(iter_1_1.x, iter_1_1.y),
			rotation = Vector3(0, iter_1_1.dir * 90, 0),
			configId = iter_1_1.configId
		})
	end

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.placed_data.floor_data or {}) do
		local var_1_0, var_1_1, var_1_2, var_1_3 = AgoraCalc.DecodeLayer(iter_1_3)

		table.insert(self.floorLayer, {
			position = Vector2(var_1_2, var_1_3),
			id = var_1_0,
			shapeId = var_1_1
		})
	end

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.placed_data.tile_data or {}) do
		local var_1_4, var_1_5, var_1_6, var_1_7 = AgoraCalc.DecodeLayer(iter_1_5)

		table.insert(self.tileLayer, {
			position = Vector2(var_1_6, var_1_7),
			id = var_1_4,
			shapeId = var_1_5
		})
	end

	return
end

function IslandTheme:GetID()
	return self.id
end

function IslandTheme:SetName(arg_3_1)
	self.name = arg_3_1

	return
end

function IslandTheme:GetName()
	return self.name
end

function IslandTheme:GetPlacedList()
	return self.placedList
end

function IslandTheme:GetFloorLayer()
	return self.floorLayer
end

function IslandTheme:GetTileLayer()
	return self.tileLayer
end

return IslandTheme
