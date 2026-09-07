local AgoraDataComparator = class("AgoraDataComparator")

AgoraDataComparator.CHANGE_TYPE_PLACED = 2
AgoraDataComparator.CHANGE_TYPE_FLOOR = 4
AgoraDataComparator.CHANGE_TYPE_TILE = 8

function AgoraDataComparator:Ctor(arg_1_1)
	self.agora = arg_1_1
	self.isTake = false
	self.allCode = IndexConst.BitAll({
		AgoraDataComparator.CHANGE_TYPE_PLACED,
		AgoraDataComparator.CHANGE_TYPE_FLOOR,
		AgoraDataComparator.CHANGE_TYPE_TILE
	})

	return
end

function AgoraDataComparator:TakeSample()
	self.placedData = Clone(self.agora:GetPlacedlist())
	self.floorData = Clone(self.agora:GetFloorLayer())
	self.tileData = Clone(self.agora:GetTileLayer())
	self.isTake = true

	return
end

function AgoraDataComparator:GetSample()
	return self.placedData, self.floorData, self.tileData
end

function AgoraDataComparator:AnyChanged()
	local var_4_0

	if not self.isTake then
		do return false end

		var_4_0 = 0
	end

	if self:ComparePlacedData(self.agora:GetPlacedlist(), self.placedData) then
		var_4_0 = bit.bor(var_4_0, AgoraDataComparator.CHANGE_TYPE_PLACED)
	end

	if self:CompareLayer(self.agora:GetFloorLayer(), self.floorData) then
		var_4_0 = bit.bor(var_4_0, AgoraDataComparator.CHANGE_TYPE_FLOOR)
	end

	if self:CompareLayer(self.agora:GetTileLayer(), self.tileData) then
		var_4_0 = bit.bor(var_4_0, AgoraDataComparator.CHANGE_TYPE_TILE)
	end

	return bit.band(var_4_0, self.allCode) > 0, var_4_0
end

function AgoraDataComparator:ComparePlacedData(arg_5_1, arg_5_2)
	if table.getCount(arg_5_1) ~= table.getCount(arg_5_2) then
		return true
	end

	for iter_5_0, iter_5_1 in pairs(arg_5_2) do
		if not arg_5_1[iter_5_0] or not arg_5_1[iter_5_0]:IsSame(iter_5_1) then
			return true
		end
	end

	for iter_5_2, iter_5_3 in pairs(arg_5_1) do
		if not arg_5_2[iter_5_2] or not arg_5_2[iter_5_2]:IsSame(iter_5_3) then
			return true
		end
	end

	return false
end

function AgoraDataComparator:CompareLayer(arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			if not arg_6_2[iter_6_0][iter_6_2] or not arg_6_2[iter_6_0][iter_6_2]:IsSame(iter_6_3) then
				return true
			end
		end
	end

	return false
end

function AgoraDataComparator:Abort()
	self.placedData = nil
	self.floorData = nil
	self.tileData = nil
	self.isTake = false

	return
end

function AgoraDataComparator:Dispose()
	self:Abort()

	return
end

return AgoraDataComparator
