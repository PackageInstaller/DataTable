local AgoraPlaceableArea = class("AgoraPlaceableArea", import("...IslandDispatcher"))

function AgoraPlaceableArea:Ctor(arg_1_1)
	AgoraPlaceableArea.super.Ctor(self)

	self.size = arg_1_1
	self.placedlist = {}
	self.maps = {
		[IslandConst.AGORA_MAP_TYPE_COMMON] = AgoraMap.New(arg_1_1),
		[IslandConst.AGORA_MAP_TYPE_NEWTILE] = AgoraMap.New(arg_1_1),
		[IslandConst.AGORA_MAP_TYPE_BUILDING] = AgoraBuildingMap.New()
	}
	self.floorLayer = self:GenLayer()
	self.tileLayer = self:GenLayer()

	return
end

function AgoraPlaceableArea:GetFloorLayer()
	return self.floorLayer
end

function AgoraPlaceableArea:GetTileLayer()
	return self.tileLayer
end

function AgoraPlaceableArea:GetFloorCell(arg_4_1)
	return self.floorLayer[arg_4_1.x][arg_4_1.y]
end

function AgoraPlaceableArea:GetTileCell(arg_5_1)
	return self.tileLayer[arg_5_1.x][arg_5_1.y]
end

function AgoraPlaceableArea:GenLayer()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs((AgoraCalc.GetArea(Vector2.zero, Vector2(IslandConst.AGORA_LEVEL_2_SIZE[#IslandConst.AGORA_LEVEL_2_SIZE], IslandConst.AGORA_LEVEL_2_SIZE[#IslandConst.AGORA_LEVEL_2_SIZE])))) do
		var_6_0[iter_6_1.x] = var_6_0[iter_6_1.x] or {}
		var_6_0[iter_6_1.x][iter_6_1.y] = AgoraLayerCell.New(Vector2(iter_6_1.x, iter_6_1.y))
	end

	return var_6_0
end

function AgoraPlaceableArea:FillFloorLayer(arg_7_1, arg_7_2, arg_7_3)
	local var_7_1 = (self.floorLayer[arg_7_3.x] or {})[arg_7_3.y]

	if not (self.floorLayer[arg_7_3.x] or {})[arg_7_3.y] then
		return
	end

	var_7_1:Fill(arg_7_1, arg_7_2)

	return
end

function AgoraPlaceableArea:ClearFloorLayer(arg_8_1)
	local var_8_1 = (self.floorLayer[arg_8_1.x] or {})[arg_8_1.y]

	if not (self.floorLayer[arg_8_1.x] or {})[arg_8_1.y] then
		return
	end

	var_8_1:Clear()

	return
end

function AgoraPlaceableArea:FillTileLayer(arg_9_1, arg_9_2, arg_9_3)
	local var_9_1 = (self.tileLayer[arg_9_3.x] or {})[arg_9_3.y]

	if not (self.tileLayer[arg_9_3.x] or {})[arg_9_3.y] then
		return
	end

	var_9_1:Fill(arg_9_1, arg_9_2)

	return
end

function AgoraPlaceableArea:ClearTileLayer(arg_10_1)
	local var_10_1 = (self.tileLayer[arg_10_1.x] or {})[arg_10_1.y]

	if not (self.tileLayer[arg_10_1.x] or {})[arg_10_1.y] then
		return
	end

	var_10_1:Clear()

	return
end

function AgoraPlaceableArea:UpdateSize(arg_11_1)
	self.size = arg_11_1

	for iter_11_0, iter_11_1 in pairs(self.maps) do
		iter_11_1:UpdateSize(arg_11_1)
	end

	self:DispatchEvent(ISLAND_AGORA_EVT.MAP_SIZE_UPDATE, self.size)

	return
end

function AgoraPlaceableArea:GetSize()
	return self.size
end

function AgoraPlaceableArea:GetRangeCoord()
	return (AgoraCalc.GetSizeCoord(self.size))
end

function AgoraPlaceableArea:InRange(arg_14_1, arg_14_2)
	local var_14_0 = self:GetRangeCoord()

	return arg_14_1 >= var_14_0.x and arg_14_1 <= var_14_0.z and arg_14_2 <= var_14_0.y and arg_14_2 >= var_14_0.w
end

function AgoraPlaceableArea:_InRange(arg_15_1, arg_15_2, arg_15_3)
	return arg_15_2 >= arg_15_1.x and arg_15_2 <= arg_15_1.z and arg_15_3 <= arg_15_1.y and arg_15_3 >= arg_15_1.w
end

function AgoraPlaceableArea:ClampRange(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = AgoraCalc.GetSizeCoord((arg_16_3:GetSizeWithRotation()))
	local var_16_1 = self:GetRangeCoord()

	arg_16_1 = Mathf.Clamp(arg_16_1, var_16_1.x - var_16_0.x, var_16_1.z - var_16_0.z)
	arg_16_2 = Mathf.Clamp(arg_16_2, var_16_1.w - var_16_0.w, var_16_1.y - var_16_0.y)

	return Vector2(arg_16_1, arg_16_2)
end

function AgoraPlaceableArea:_ClampRange(arg_17_1, arg_17_2)
	if self:_InRange(arg_17_1, arg_17_2.x, arg_17_2.y) then
		return arg_17_2
	end

	return Vector2(Mathf.Clamp(arg_17_2.x, arg_17_1.x, arg_17_1.z), (Mathf.Clamp(arg_17_2.y, arg_17_1.y, arg_17_1.w)))
end

function AgoraPlaceableArea:IsUsing(arg_18_1)
	return self.placedlist[arg_18_1] ~= nil
end

function AgoraPlaceableArea:GetPlacedlist()
	return self.placedlist
end

function AgoraPlaceableArea:GetPlacedItem(arg_20_1)
	return self.placedlist[arg_20_1]
end

function AgoraPlaceableArea:GetMap(arg_21_1)
	return self.maps[arg_21_1:GetMapType()]
end

function AgoraPlaceableArea:AddItem(arg_22_1)
	local var_22_0 = self:GetMap(arg_22_1)

	for iter_22_0, iter_22_1 in ipairs((arg_22_1:GetArea())) do
		var_22_0:UpdateMapState(iter_22_1.x, iter_22_1.y, false)
	end

	self.placedlist[arg_22_1.id] = arg_22_1

	return
end

function AgoraPlaceableArea:RemoveItem(arg_23_1)
	local var_23_0 = self:GetMap(arg_23_1)

	for iter_23_0, iter_23_1 in ipairs((arg_23_1:GetArea())) do
		var_23_0:UpdateMapState(iter_23_1.x, iter_23_1.y, true)
	end

	self.placedlist[arg_23_1.id] = nil

	return
end

function AgoraPlaceableArea:IsEmptyArea(arg_24_1)
	local var_24_0 = self:GetMap(arg_24_1)
	local var_24_1 = self:GetRangeCoord()

	return _.all(arg_24_1:GetArea(), function(arg_25_0)
		return self:_InRange(var_24_1, arg_25_0.x, arg_25_0.y) and var_24_0:GetMapState(arg_25_0.x, arg_25_0.y) == true
	end)
end

function AgoraPlaceableArea:IsEmptyAreaInPoint(arg_26_1, arg_26_2)
	local var_26_0 = self:GetMap(arg_26_1)
	local var_26_1 = self:GetRangeCoord()

	return _.all(arg_26_1:GenAreaByPosition(arg_26_2), function(arg_27_0)
		return self:_InRange(var_26_1, arg_27_0.x, arg_27_0.y) and var_26_0:GetMapState(arg_27_0.x, arg_27_0.y) == true
	end)
end

function AgoraPlaceableArea:IsEmptyPoint(arg_28_1, arg_28_2)
	return self:GetMap(arg_28_1):IsEmptyPoint(arg_28_2)
end

function AgoraPlaceableArea:GetItemInArea(arg_29_1, arg_29_2)
	local var_29_0 = self.maps[arg_29_1]
	local var_29_1 = _.detect(arg_29_2, function(arg_30_0)
		return var_29_0:GetMapState(arg_30_0.x, arg_30_0.y) == false
	end)

	if var_29_1 then
		local var_29_2 = self:GetItemInPosition(arg_29_1, var_29_1)

		if var_29_2 then
			return var_29_2
		end
	end

	return nil
end

function AgoraPlaceableArea:GetAnyMapItemInPosition(arg_31_1)
	for iter_31_0, iter_31_1 in pairs(self.maps) do
		local var_31_0 = self:GetItemInPosition(iter_31_0, arg_31_1)

		if var_31_0 then
			return var_31_0
		end
	end

	return nil
end

function AgoraPlaceableArea:GetItemInPosition(arg_32_1, arg_32_2)
	if not self:InRange(arg_32_2.x, arg_32_2.y) then
		return nil
	end

	if self.maps[arg_32_1]:GetMapState(arg_32_2.x, arg_32_2.y) == false then
		return self:FindItemInPosition(arg_32_1, arg_32_2)
	end

	return nil
end

function AgoraPlaceableArea:FindItemInPosition(arg_33_1, arg_33_2)
	for iter_33_0, iter_33_1 in pairs(self.placedlist) do
		if iter_33_1:GetMapType() == arg_33_1 then
			for iter_33_2, iter_33_3 in ipairs((iter_33_1:GetArea())) do
				if iter_33_3 == arg_33_2 then
					return iter_33_1
				end
			end
		end
	end

	return nil
end

function AgoraPlaceableArea:FindEmptyArea4Item(arg_34_1, arg_34_2)
	local var_34_0 = self:GetRangeCoord()
	local var_34_1 = AgoraCalc.GetSizeCoord(arg_34_2:GetSizeWithRotation())
	local var_34_2 = var_34_0.x - var_34_1.x
	local var_34_3 = var_34_0.z - var_34_1.z
	local var_34_4 = var_34_0.w - var_34_1.w
	local var_34_5 = var_34_0.y - var_34_1.y

	if var_34_0.z - var_34_1.z < var_34_0.x - var_34_1.x or var_34_0.y - var_34_1.y < var_34_0.w - var_34_1.w then
		return nil
	end

	local var_34_6 = Mathf.Clamp(arg_34_1.x, var_34_0.x - var_34_1.x, var_34_0.z - var_34_1.z)
	local var_34_7 = Mathf.Clamp(arg_34_1.y, var_34_0.w - var_34_1.w, var_34_0.y - var_34_1.y)
	local var_34_8 = self:GetMap(arg_34_2)

	local function var_34_9(arg_35_0, arg_35_1)
		if arg_35_0 < var_34_2 or arg_35_0 > var_34_3 or arg_35_1 < var_34_4 or arg_35_1 > var_34_5 then
			return false
		end

		return _.all(arg_34_2:GenAreaByPosition(Vector2(arg_35_0, arg_35_1)), function(arg_36_0)
			return self:_InRange(var_34_0, arg_36_0.x, arg_36_0.y) and var_34_8:GetMapState(arg_36_0.x, arg_36_0.y) == true
		end)
	end

	for iter_34_0 = 0, math.max(math.abs(var_34_6 - (var_34_0.x - var_34_1.x)) + math.abs(var_34_7 - (var_34_0.w - var_34_1.w)), math.abs(var_34_6 - (var_34_0.x - var_34_1.x)) + math.abs(var_34_7 - (var_34_0.y - var_34_1.y)), math.abs(var_34_6 - (var_34_0.z - var_34_1.z)) + math.abs(var_34_7 - (var_34_0.w - var_34_1.w)), math.abs(var_34_6 - (var_34_0.z - var_34_1.z)) + math.abs(var_34_7 - (var_34_0.y - var_34_1.y))) do
		for iter_34_1 = -iter_34_0, iter_34_0 do
			local var_34_10 = iter_34_0 - math.abs(iter_34_1)

			if var_34_9(var_34_6 + iter_34_1, var_34_7 + var_34_10) then
				return Vector2(var_34_6 + iter_34_1, var_34_7 + var_34_10)
			end

			if var_34_10 ~= 0 and var_34_9(var_34_6 + iter_34_1, var_34_7 - var_34_10) then
				return Vector2(var_34_6 + iter_34_1, var_34_7 - var_34_10)
			end
		end
	end

	return nil
end

function AgoraPlaceableArea:SerializePlacementData()
	local var_37_0 = {}

	for iter_37_0, iter_37_1 in pairs(self:GetPlacedlist()) do
		table.insert(var_37_0, iter_37_1:ToPlacementData())
	end

	local var_37_1 = {}

	for iter_37_2, iter_37_3 in pairs(self:GetFloorLayer()) do
		for iter_37_4, iter_37_5 in pairs(iter_37_3) do
			if not iter_37_5:IsEmpty() then
				table.insert(var_37_1, iter_37_5:ToPlacementData())
			end
		end
	end

	local var_37_2 = {}

	for iter_37_6, iter_37_7 in pairs(self:GetTileLayer()) do
		for iter_37_8, iter_37_9 in pairs(iter_37_7) do
			if not iter_37_9:IsEmpty() then
				table.insert(var_37_2, iter_37_9:ToPlacementData())
			end
		end
	end

	return var_37_0, var_37_1, var_37_2
end

function AgoraPlaceableArea:ToString()
	local var_38_0, var_38_1, var_38_2 = self:SerializePlacementData()
	local var_38_3 = {}

	table.insert(var_38_3, "return {")
	table.insert(var_38_3, "\tid = 0,")
	table.insert(var_38_3, "\tname = '',")
	table.insert(var_38_3, "\tplaced_data = {")
	table.insert(var_38_3, "\t\tplaced_list = {")
	table.insert(var_38_3, table.concat(_.map(var_38_0, function(arg_39_0)
		return string.format("\t\t\t{id = %s,x = %s,y = %s,dir = %s,configId = %s},", arg_39_0.id, arg_39_0.x, arg_39_0.y, arg_39_0.dir, arg_39_0.configId)
	end), "\n"))
	table.insert(var_38_3, "\t\t},")
	table.insert(var_38_3, "\t\tfloor_data = {")
	table.insert(var_38_3, table.concat(_.map(AgoraCalc.EncodeLayer(var_38_1), function(arg_40_0)
		return "\t\t\t" .. tostring(arg_40_0)
	end), ",\n"))
	table.insert(var_38_3, "\t\t},")
	table.insert(var_38_3, "\t\ttile_data = {")
	table.insert(var_38_3, table.concat(_.map(AgoraCalc.EncodeLayer(var_38_2), function(arg_41_0)
		return "\t\t\t" .. tostring(arg_41_0)
	end), ",\n"))
	table.insert(var_38_3, "\t\t},")
	table.insert(var_38_3, "\t}")
	table.insert(var_38_3, "}")

	return table.concat(var_38_3, "\n")
end

return AgoraPlaceableArea
