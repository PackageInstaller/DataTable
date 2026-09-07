local CourtYardPlaceableArea = class("CourtYardPlaceableArea", import("...CourtYardDispatcher"))

function CourtYardPlaceableArea:Ctor(arg_1_1, arg_1_2)
	CourtYardPlaceableArea.super.Ctor(self, arg_1_1)

	self.sizeX = arg_1_2.x
	self.sizeY = arg_1_2.y
	self.minSizeX = arg_1_2.z
	self.minSizeY = arg_1_2.w
	self.map = {}
	self.mats = {}
	self.chars = {}

	for iter_1_0 = 0, self.sizeX do
		self.map[iter_1_0] = {}

		for iter_1_1 = 0, self.sizeY do
			self.map[iter_1_0][iter_1_1] = false
		end
	end

	self.depthMap = CourtYardDepthMap.New(self.sizeX + 1, self.sizeY + 1)

	return
end

function CourtYardPlaceableArea:GetRange()
	return Vector4(self.sizeX, self.sizeY, self.minSizeX, self.minSizeY)
end

function CourtYardPlaceableArea:GetRangeWithoutWall()
	return Vector4(self.sizeX - 1, self.sizeY - 1, self.minSizeX, self.minSizeY)
end

function CourtYardPlaceableArea:UpdateMinRange(arg_4_1)
	self.minSizeX = arg_4_1.x
	self.minSizeY = arg_4_1.y

	return
end

function CourtYardPlaceableArea:LockPosition(arg_5_1)
	self.map[arg_5_1.x][arg_5_1.y] = true

	return
end

function CourtYardPlaceableArea:_ClearLockPosition(arg_6_1)
	local var_6_0 = arg_6_1:GetMarkPosition()

	if var_6_0 then
		self:ClearLockPosition(var_6_0)
		arg_6_1:ClearMarkPosition()
	end

	return
end

function CourtYardPlaceableArea:ClearLockPosition(arg_7_1)
	self.map[arg_7_1.x][arg_7_1.y] = false

	return
end

function CourtYardPlaceableArea:AddItem(arg_8_1)
	assert(isa(arg_8_1, CourtYardDepthItem))

	local var_8_0 = arg_8_1:GetDeathType()

	if var_8_0 == CourtYardConst.DEPTH_TYPE_MAT then
		table.insert(self.mats, arg_8_1)
		self:DispatchEvent(CourtYardEvent.ADD_MAT_ITEM, arg_8_1)

		return
	end

	if var_8_0 == CourtYardConst.DEPTH_TYPE_SHIP then
		self.depthMap:InsertChar(arg_8_1)
		table.insert(self.chars, arg_8_1)
	else
		self.depthMap:PlaceItem(arg_8_1)
	end

	for iter_8_0, iter_8_1 in ipairs((arg_8_1:GetArea())) do
		if self.map[iter_8_1.x] then
			self.map[iter_8_1.x][iter_8_1.y] = true
		end
	end

	self:DispatchEvent(CourtYardEvent.ADD_ITEM, arg_8_1)

	return
end

function CourtYardPlaceableArea:RemoveItem(arg_9_1)
	assert(isa(arg_9_1, CourtYardDepthItem))

	local var_9_0 = arg_9_1:GetDeathType()

	if var_9_0 == CourtYardConst.DEPTH_TYPE_MAT then
		table.removebyvalue(self.mats, arg_9_1)
		self:DispatchEvent(CourtYardEvent.REMOVE_MAT_ITEM, arg_9_1)

		return
	end

	local var_9_1 = 1

	if var_9_0 == CourtYardConst.DEPTH_TYPE_SHIP then
		self.depthMap:RemoveChar(arg_9_1)

		var_9_1 = table.removebyvalue(self.chars, arg_9_1)
	else
		self.depthMap:RemoveItem(arg_9_1)
	end

	if var_9_1 > 0 then
		for iter_9_0, iter_9_1 in ipairs((arg_9_1:GetArea())) do
			if self.map[iter_9_1.x] then
				self.map[iter_9_1.x][iter_9_1.y] = false
			end
		end

		self:DispatchEvent(CourtYardEvent.REMOVE_ITEM, arg_9_1)
	end

	return
end

function CourtYardPlaceableArea:RemoveItemAndRefresh(arg_10_1)
	self:RemoveItem(arg_10_1)
	_.each(_.map(self.chars, function(arg_11_0)
		return arg_11_0
	end), function(arg_12_0)
		self:RemoveItem(arg_12_0)
		self:AddItem(arg_12_0)

		return
	end)

	return
end

function CourtYardPlaceableArea:AddItemAndRefresh(arg_13_1)
	self:AddItem(arg_13_1)
	_.each(_.map(self.chars, function(arg_14_0)
		return arg_14_0
	end), function(arg_15_0)
		self:RemoveItem(arg_15_0)
		self:AddItem(arg_15_0)

		return
	end)

	return
end

function CourtYardPlaceableArea:GetPositions()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(self.map) do
		for iter_16_2, iter_16_3 in pairs(iter_16_1) do
			table.insert(var_16_0, Vector2(iter_16_0, iter_16_2))
		end
	end

	return var_16_0
end

function CourtYardPlaceableArea:IsEmptyPosition(arg_17_1)
	if not self.map[arg_17_1.x] then
		return false
	end

	return self.map[arg_17_1.x][arg_17_1.y] == false
end

function CourtYardPlaceableArea:InSide(arg_18_1)
	return arg_18_1.x >= self.minSizeX and arg_18_1.y >= self.minSizeY and arg_18_1.x <= self.sizeX and arg_18_1.y <= self.sizeY
end

function CourtYardPlaceableArea:LegalPosition(arg_19_1, arg_19_2)
	return self:InSide(arg_19_1) and (self:IsEmptyPosition(arg_19_1) or arg_19_2:GetDeathType() == CourtYardConst.DEPTH_TYPE_MAT)
end

function CourtYardPlaceableArea:GetItems()
	return self.depthMap.sortedItems
end

function CourtYardPlaceableArea:GetMatItems()
	table.sort(self.mats, function(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_0:GetInitSizeCnt()
		local var_22_1 = arg_22_1:GetInitSizeCnt()

		if var_22_0 == var_22_1 then
			local var_22_2 = arg_22_0:GetPosition()
			local var_22_3 = arg_22_1:GetPosition()

			return var_22_2.x + var_22_2.y > var_22_3.x + var_22_3.y
		else
			return var_22_1 < var_22_0
		end

		return
	end)

	return self.mats
end

function CourtYardPlaceableArea:GetEmptyPositions(arg_23_1)
	return (_.select(self:GetPositions(), function(arg_24_0)
		return self:LegalPosition(arg_24_0, arg_23_1)
	end))
end

function CourtYardPlaceableArea:GetRandomPosition(arg_25_1)
	local var_25_0 = self:GetEmptyPositions(arg_25_1)

	if #var_25_0 > 0 then
		return var_25_0[math.random(1, #var_25_0)]
	end

	return nil
end

function CourtYardPlaceableArea:GetEmptyArea(arg_26_1)
	for iter_26_0, iter_26_1 in ipairs((arg_26_1:GetInitSize())) do
		local var_26_0 = self:_GetEmptyArea(arg_26_1, iter_26_1[1], iter_26_1[2])

		if var_26_0 then
			return var_26_0
		end
	end

	return nil
end

function CourtYardPlaceableArea:_GetEmptyArea(arg_27_1, arg_27_2, arg_27_3)
	local function var_27_0(arg_28_0)
		local var_28_0 = {}

		for iter_28_0 = arg_28_0.x, arg_28_0.x + arg_27_2 - 1 do
			for iter_28_1 = arg_28_0.y, arg_28_0.y + arg_27_3 - 1 do
				table.insert(var_28_0, Vector2(iter_28_0, iter_28_1))
			end
		end

		return var_28_0
	end

	for iter_27_0 = self.sizeX, self.minSizeX, -1 do
		for iter_27_1 = self.sizeY, self.minSizeY, -1 do
			if _.all(var_27_0(Vector2(iter_27_0, iter_27_1)), function(arg_29_0)
				return self:LegalPosition(arg_29_0, arg_27_1)
			end) then
				return Vector2(iter_27_0, iter_27_1)
			end
		end
	end

	return nil
end

function CourtYardPlaceableArea:_GetNextPositionForMove(arg_30_1)
	local var_30_0 = _.select(arg_30_1:GetAroundPositions(), function(arg_31_0)
		return self:LegalPosition(arg_31_0, arg_30_1)
	end)

	if #var_30_0 > 0 then
		return var_30_0[math.random(1, #var_30_0)]
	end

	return nil
end

function CourtYardPlaceableArea:GetMapNotIncludeItem(arg_32_1)
	local var_32_0 = arg_32_1:GetAreaByPosition(arg_32_1:GetPosition())
	local var_32_1 = {}

	for iter_32_0, iter_32_1 in pairs(self.map) do
		var_32_1[iter_32_0] = {}

		for iter_32_2, iter_32_3 in pairs(iter_32_1) do
			if table.contains(var_32_0, Vector2(iter_32_0, iter_32_2)) then
				var_32_1[iter_32_0][iter_32_2] = false
			else
				var_32_1[iter_32_0][iter_32_2] = iter_32_3
			end
		end
	end

	return var_32_1
end

function CourtYardPlaceableArea:__GetNextPositionForMove(arg_33_1)
	local var_33_0 = self:GetMapNotIncludeItem(arg_33_1)
	local var_33_1 = _.select(arg_33_1:GetAroundPositions(), function(arg_34_0)
		return _.all(arg_33_1:IsDifferentDirection(arg_34_0) and self:CanRotateItem(arg_33_1) and arg_33_1:_GetRotatePositions(arg_34_0) or arg_33_1:GetAreaByPosition(arg_34_0), function(arg_35_0)
			local var_35_0 = var_33_0[arg_35_0.x]

			if var_33_0[arg_35_0.x] then
				if var_33_0[arg_35_0.x][arg_35_0.y] == false then
					var_35_0 = self:InSide(arg_35_0)

					if var_35_0 then
						var_35_0 = arg_33_1:InActivityRange(arg_35_0)
					end
				else
					var_35_0 = false
				end
			end

			return var_35_0
		end)
	end)

	if #var_33_1 > 0 then
		return var_33_1[math.random(1, #var_33_1)]
	end

	return nil
end

function CourtYardPlaceableArea:GetNextPositionForMove(arg_36_1)
	if arg_36_1:GetInitSizeCnt() == 1 then
		return self:_GetNextPositionForMove(arg_36_1)
	else
		return self:__GetNextPositionForMove(arg_36_1)
	end

	return
end

function CourtYardPlaceableArea:AreaWithInfo(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	return (_.map(arg_37_1:GetAreaByPosition(arg_37_2), function(arg_38_0)
		local var_38_0 = arg_37_4 or self:LegalPosition(arg_38_0, arg_37_1)

		return {
			flag = var_38_0 and 1 or 2,
			position = arg_38_0,
			offset = arg_37_3
		}
	end))
end

function CourtYardPlaceableArea:CanRotateItem(arg_39_1)
	if arg_39_1:HasParent() then
		return arg_39_1:GetParent():CanRotateChild(arg_39_1)
	elseif isa(arg_39_1, CourtYardCanPutFurniture) and arg_39_1:AnyNotRotateChilds() then
		return false
	else
		local var_39_0 = self:GetMapNotIncludeItem(arg_39_1)

		return _.all(arg_39_1:GetRotatePositions(), function(arg_40_0)
			local var_40_0 = var_39_0[arg_40_0.x]

			if var_39_0[arg_40_0.x] then
				if var_39_0[arg_40_0.x][arg_40_0.y] == false then
					var_40_0 = self:InSide(arg_40_0)

					if var_40_0 then
						var_40_0 = arg_39_1:InActivityRange(arg_40_0)
					end
				else
					var_40_0 = false
				end
			end

			return var_40_0
		end)
	end

	return
end

function CourtYardPlaceableArea:GetAroundEmptyPosition(arg_41_1)
	local var_41_0 = {}
	local var_41_1 = {}
	local var_41_2 = arg_41_1:GetPosition()

	table.insert(var_41_0, Vector2(var_41_2.x, var_41_2.y - 1))

	while #var_41_0 > 0 do
		local var_41_3 = table.remove(var_41_0, 1)

		if self:IsEmptyPosition(var_41_3) then
			return var_41_3
		end

		table.insert(var_41_1, var_41_3)

		for iter_41_0, iter_41_1 in ipairs({
			Vector2(var_41_3.x, var_41_3.y - 1),
			Vector2(var_41_3.x - 1, var_41_3.y),
			Vector2(var_41_3.x + 1, var_41_3.y),
			Vector2(var_41_3.x, var_41_3.y + 1)
		}) do
			if not table.contains(var_41_1, iter_41_1) and self:InSide(iter_41_1) then
				table.insert(var_41_0, iter_41_1)
			end
		end
	end

	assert(false)

	return
end

function CourtYardPlaceableArea:GetAroundEmptyArea(arg_42_1, arg_42_2)
	local var_42_0 = arg_42_1:GetInitSize()

	local function var_42_3(arg_43_0, arg_43_1)
		return math.abs(arg_43_0.x + arg_43_0.y - (arg_43_1.x + arg_43_1.y))
	end

	local var_42_4 = _.map(self:GetPositions(), function(arg_44_0)
		return {
			cost = var_42_3(arg_44_0, arg_42_2),
			value = arg_44_0
		}
	end)

	table.sort(var_42_4, function(arg_45_0, arg_45_1)
		return arg_45_0.cost < arg_45_1.cost
	end)

	for iter_42_0, iter_42_1 in ipairs(var_42_4) do
		if _.all(arg_42_1:GetAreaByPosition(iter_42_1.value), function(arg_46_0)
			return self:LegalPosition(arg_46_0, arg_42_1)
		end) then
			return iter_42_1.value
		end
	end

	return nil
end

function CourtYardPlaceableArea:Dispose()
	self:ClearListeners()

	return
end

return CourtYardPlaceableArea
