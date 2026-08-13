class = var_0_10000

local var_0_0 = "CourtYardPlaceableArea"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...CourtYardDispatcher"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.sizeX = arg_1_2.x
	arg_1_0.sizeY = arg_1_2.y
	arg_1_0.minSizeX = arg_1_2.z
	arg_1_0.minSizeY = arg_1_2.w
	arg_1_0.map = {}
	arg_1_0.mats = {}
	arg_1_0.chars = {}

	for iter_1_0 = 0, arg_1_0.sizeX do
		arg_1_0.map[iter_1_0] = {}

		for iter_1_1 = 0, arg_1_0.sizeY do
			arg_1_0.map[iter_1_0][iter_1_1] = false
		end
	end

	CourtYardDepthMap = var_3
	arg_1_0.depthMap = var_3.New(arg_1_0.sizeX + 1, arg_1_0.sizeY + 1)

	return
end

function var_0_1.GetRange(arg_2_0)
	Vector4 = var_1_10001

	return var_1_10001(arg_2_0.sizeX, arg_2_0.sizeY, arg_2_0.minSizeX, arg_2_0.minSizeY)
end

function var_0_1.GetRangeWithoutWall(arg_3_0)
	Vector4 = var_1_10001

	return var_1_10001(arg_3_0.sizeX - 1, arg_3_0.sizeY - 1, arg_3_0.minSizeX, arg_3_0.minSizeY)
end

function var_0_1.UpdateMinRange(arg_4_0, arg_4_1)
	arg_4_0.minSizeX = arg_4_1.x
	arg_4_0.minSizeY = arg_4_1.y

	return
end

function var_0_1.LockPosition(arg_5_0, arg_5_1)
	arg_5_0.map[arg_5_1.x][arg_5_1.y] = true

	return
end

function var_0_1._ClearLockPosition(arg_6_0, arg_6_1)
	if arg_6_1:GetMarkPosition() then
		arg_6_0:ClearLockPosition(var_2)
		arg_6_1:ClearMarkPosition()
	end

	return
end

function var_0_1.ClearLockPosition(arg_7_0, arg_7_1)
	arg_7_0.map[arg_7_1.x][arg_7_1.y] = false

	return
end

function var_0_1.AddItem(arg_8_0, arg_8_1)
	assert = var_1_10002
	isa = var_1_10003

	local var_8_0 = arg_8_1

	CourtYardDepthItem = var_1_10005

	var_1_10002(var_1_10003(var_8_0, var_1_10005))

	local var_8_1 = arg_8_1
	local var_8_2 = arg_8_1.GetDeathType(var_8_1)

	CourtYardConst = var_8_1

	local var_8_4

	if var_8_2 == var_8_1.DEPTH_TYPE_MAT then
		table = var_8_4

		var_8_4.insert(arg_8_0.mats, arg_8_1)

		local var_8_3 = arg_8_0

		var_8_4 = arg_8_0.DispatchEvent
		CourtYardEvent = var_5

		var_8_4(var_8_3, var_5.ADD_MAT_ITEM, arg_8_1)

		return
	end

	CourtYardConst = var_8_4

	if var_8_2 == var_8_4.DEPTH_TYPE_SHIP then
		local var_8_5 = arg_8_0.depthMap

		var_3.InsertChar(var_8_5, arg_8_1)

		table = var_3

		var_3.insert(arg_8_0.chars, arg_8_1)
	else
		local var_8_6 = arg_8_0.depthMap

		var_3.PlaceItem(var_8_6, arg_8_1)
	end

	local var_8_7 = arg_8_1
	local var_8_8 = arg_8_1.GetArea(var_8_7)

	ipairs = var_8_7

	for iter_8_0, iter_8_1 in var_8_7(var_8_8) do
		if arg_8_0.map[iter_8_1.x] then
			arg_8_0.map[iter_8_1.x][iter_8_1.y] = true
		end
	end

	local var_8_9 = arg_8_0
	local var_8_10 = arg_8_0.DispatchEvent

	CourtYardEvent = var_6

	var_8_10(var_8_9, var_6.ADD_ITEM, arg_8_1)

	return
end

function var_0_1.RemoveItem(arg_9_0, arg_9_1)
	assert = var_1_10002
	isa = var_1_10003

	local var_9_0 = arg_9_1

	CourtYardDepthItem = var_1_10005

	var_1_10002(var_1_10003(var_9_0, var_1_10005))

	local var_9_1 = arg_9_1
	local var_9_2 = arg_9_1.GetDeathType(var_9_1)

	CourtYardConst = var_9_1

	if var_9_2 == var_9_1.DEPTH_TYPE_MAT then
		table = var_3

		var_3.removebyvalue(arg_9_0.mats, arg_9_1)

		var_9_0 = arg_9_0

		local var_9_3 = arg_9_0.DispatchEvent

		CourtYardEvent = var_5

		var_9_3(var_9_0, var_5.REMOVE_MAT_ITEM, arg_9_1)

		return
	end

	local var_9_4 = 1

	CourtYardConst = var_9_0

	if var_9_2 == var_9_0.DEPTH_TYPE_SHIP then
		local var_9_5 = arg_9_0.depthMap

		var_4.RemoveChar(var_9_5, arg_9_1)

		table = var_4
		var_9_4 = var_4.removebyvalue(arg_9_0.chars, arg_9_1)
	else
		local var_9_6 = arg_9_0.depthMap

		var_4.RemoveItem(var_9_6, arg_9_1)
	end

	if var_9_4 > 0 then
		local var_9_7 = arg_9_1
		local var_9_8 = arg_9_1.GetArea(var_9_7)

		ipairs = var_9_7

		for iter_9_0, iter_9_1 in var_9_7(var_9_8) do
			if arg_9_0.map[iter_9_1.x] then
				arg_9_0.map[iter_9_1.x][iter_9_1.y] = false
			end
		end

		local var_9_9 = arg_9_0
		local var_9_10 = arg_9_0.DispatchEvent

		CourtYardEvent = var_7

		var_9_10(var_9_9, var_7.REMOVE_ITEM, arg_9_1)
	end

	return
end

function var_0_1.RemoveItemAndRefresh(arg_10_0, arg_10_1)
	_ = var_1_10002

	local var_10_0 = var_1_10002.map(arg_10_0.chars, function(arg_11_0)
		return arg_11_0
	end)

	arg_10_0:RemoveItem(arg_10_1)

	_ = var_3

	var_3.each(var_10_0, function(arg_12_0)
		local var_12_0 = arg_10_0

		var_1.RemoveItem(var_12_0, arg_12_0)

		local var_12_1 = arg_10_0

		var_1.AddItem(var_12_1, arg_12_0)

		return
	end)

	return
end

function var_0_1.AddItemAndRefresh(arg_13_0, arg_13_1)
	_ = var_1_10002

	local var_13_0 = var_1_10002.map(arg_13_0.chars, function(arg_14_0)
		return arg_14_0
	end)

	arg_13_0:AddItem(arg_13_1)

	_ = var_3

	var_3.each(var_13_0, function(arg_15_0)
		local var_15_0 = arg_13_0

		var_1.RemoveItem(var_15_0, arg_15_0)

		local var_15_1 = arg_13_0

		var_1.AddItem(var_15_1, arg_15_0)

		return
	end)

	return
end

function var_0_1.GetPositions(arg_16_0)
	local var_16_0 = {}

	pairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_0.map) do
		pairs = var_1_10007

		for iter_16_2, iter_16_3 in var_1_10007(iter_16_1) do
			table = var_1_10012
			var_1_10012 = var_1_10012.insert

			local var_16_1 = var_16_0

			Vector2 = var_1_10014

			var_1_10012(var_16_1, var_1_10014(iter_16_0, iter_16_2))
		end
	end

	return var_16_0
end

function var_0_1.IsEmptyPosition(arg_17_0, arg_17_1)
	if not arg_17_0.map[arg_17_1.x] then
		return false
	end

	return arg_17_0.map[arg_17_1.x][arg_17_1.y] == false
end

function var_0_1.InSide(arg_18_0, arg_18_1)
	return arg_18_1.x >= arg_18_0.minSizeX and arg_18_1.y >= arg_18_0.minSizeY and arg_18_1.x <= arg_18_0.sizeX and arg_18_1.y <= arg_18_0.sizeY
end

function var_0_1.LegalPosition(arg_19_0, arg_19_1, arg_19_2)
	local var_19_1

	if arg_19_0:InSide(arg_19_1) and not arg_19_0:IsEmptyPosition(arg_19_1) then
		local var_19_0 = arg_19_2

		var_19_1 = arg_19_2.GetDeathType(var_19_0)
		CourtYardConst = var_19_0
		var_19_1 = var_19_1 == var_19_0.DEPTH_TYPE_MAT
	end

	return var_19_1
end

function var_0_1.GetItems(arg_20_0)
	return arg_20_0.depthMap.sortedItems
end

function var_0_1.GetMatItems(arg_21_0)
	table = var_1_10001

	var_1_10001.sort(arg_21_0.mats, function(arg_22_0, arg_22_1)
		if arg_22_0:GetInitSizeCnt() == arg_22_1:GetInitSizeCnt() then
			local var_22_0 = arg_22_0:GetPosition()
			local var_22_1 = arg_22_1:GetPosition()

			return var_22_0.x + var_22_0.y > var_22_1.x + var_22_1.y
		else
			return var_3 < var_2
		end

		return
	end)

	return arg_21_0.mats
end

function var_0_1.GetEmptyPositions(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0
	local var_23_1 = arg_23_0.GetPositions(var_23_0)

	_ = var_23_0

	return (var_23_0.select(var_23_1, function(arg_24_0)
		local var_24_0 = arg_23_0

		return var_1.LegalPosition(var_24_0, arg_24_0, arg_23_1)
	end))
end

function var_0_1.GetRandomPosition(arg_25_0, arg_25_1)
	if #arg_25_0:GetEmptyPositions(arg_25_1) > 0 then
		math = var_3

		return var_2[var_3.random(1, #var_2)]
	end

	return nil
end

function var_0_1.GetEmptyArea(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1
	local var_26_1 = arg_26_1.GetInitSize(var_26_0)

	ipairs = var_26_0

	for iter_26_0, iter_26_1 in var_26_0(var_26_1) do
		if arg_26_0:_GetEmptyArea(arg_26_1, iter_26_1[1], iter_26_1[2]) then
			return var_8
		end
	end

	return nil
end

function var_0_1._GetEmptyArea(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local function var_27_0(arg_28_0)
		local var_28_0 = {}

		for iter_28_0 = arg_28_0.x, arg_28_0.x + arg_27_2 - 1 do
			for iter_28_1 = arg_28_0.y, arg_28_0.y + arg_27_3 - 1 do
				table = var_2_10010
				var_2_10010 = var_2_10010.insert

				local var_28_1 = var_28_0

				Vector2 = var_2_10012

				var_2_10010(var_28_1, var_2_10012(iter_28_0, iter_28_1))
			end
		end

		return var_28_0
	end

	for iter_27_0 = arg_27_0.sizeX, arg_27_0.minSizeX, -1 do
		for iter_27_1 = arg_27_0.sizeY, arg_27_0.minSizeY, -1 do
			local var_27_1 = var_27_0

			Vector2 = var_1_10014

			local var_27_2 = var_27_1(var_1_10014(iter_27_0, iter_27_1))

			_ = var_1_10014

			if var_1_10014.all(var_27_2, function(arg_29_0)
				local var_29_0 = arg_27_0

				return var_1.LegalPosition(var_29_0, arg_29_0, arg_27_1)
			end) then
				Vector2 = var_1_10014

				return var_1_10014(iter_27_0, iter_27_1)
			end
		end
	end

	return nil
end

function var_0_1._GetNextPositionForMove(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1
	local var_30_1 = arg_30_1.GetAroundPositions(var_30_0)

	_ = var_30_0

	if #var_30_0.select(var_30_1, function(arg_31_0)
		local var_31_0 = arg_30_0

		return var_1.LegalPosition(var_31_0, arg_31_0, arg_30_1)
	end) > 0 then
		math = var_4

		return var_3[var_4.random(1, #var_3)]
	end

	return nil
end

function var_0_1.GetMapNotIncludeItem(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1:GetAreaByPosition(arg_32_1:GetPosition())
	local var_32_1 = {}

	pairs = var_4

	for iter_32_0, iter_32_1 in var_4(arg_32_0.map) do
		var_32_1[iter_32_0] = {}
		pairs = var_9

		for iter_32_2, iter_32_3 in var_9(iter_32_1) do
			table = var_1_10014
			var_1_10014 = var_1_10014.contains

			local var_32_2 = var_32_0

			Vector2 = var_1_10016

			if var_1_10014(var_32_2, var_1_10016(iter_32_0, iter_32_2)) then
				var_1_10014 = var_32_1[iter_32_0]
				var_1_10014[iter_32_2] = false
			else
				var_1_10014 = var_32_1[iter_32_0]
				var_1_10014[iter_32_2] = iter_32_3
			end
		end
	end

	return var_32_1
end

function var_0_1.__GetNextPositionForMove(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:GetMapNotIncludeItem(arg_33_1)

	local function var_33_1(arg_34_0)
		local var_34_0 = arg_33_1
		local var_34_1 = var_1.IsDifferentDirection(var_34_0, arg_34_0)
		local var_34_2

		if var_34_1 then
			local var_34_3 = arg_33_0

			if var_3.CanRotateItem(var_34_3, arg_33_1) then
				local var_34_4 = arg_33_1

				var_34_2 = var_3._GetRotatePositions(var_34_4, arg_34_0)

				goto label_34_0
			end
		end

		do
			local var_34_5 = arg_33_1

			var_34_2 = var_3.GetAreaByPosition(var_34_5, arg_34_0)
		end

		::label_34_0::

		_ = var_3

		return var_3.all(var_34_2, function(arg_35_0)
			if var_33_0[arg_35_0.x] then
				local var_35_2

				if var_33_0[arg_35_0.x][arg_35_0.y] == false then
					local var_35_0 = arg_33_0

					if var_1.InSide(var_35_0, arg_35_0) then
						local var_35_1 = arg_33_1

						var_35_2 = var_1.InActivityRange(var_35_1, arg_35_0)
					end
				else
					var_35_2 = false
				end
			end

			if false then
				var_35_2 = true
			end

			return var_35_2
		end)
	end

	local var_33_2 = arg_33_1
	local var_33_3 = arg_33_1.GetAroundPositions(var_33_2)

	_ = var_33_2

	if #var_33_2.select(var_33_3, var_33_1) > 0 then
		math = var_6

		return var_5[var_6.random(1, #var_5)]
	end

	return nil
end

function var_0_1.GetNextPositionForMove(arg_36_0, arg_36_1)
	if arg_36_1:GetInitSizeCnt() == 1 then
		return arg_36_0:_GetNextPositionForMove(arg_36_1)
	else
		return arg_36_0:__GetNextPositionForMove(arg_36_1)
	end

	return
end

function var_0_1.AreaWithInfo(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	_ = var_1_10005

	return (var_1_10005.map(arg_37_1:GetAreaByPosition(arg_37_2), function(arg_38_0)
		local var_38_1

		if not arg_37_4 then
			local var_38_0 = arg_37_0

			var_38_1 = var_1.LegalPosition(var_38_0, arg_38_0, arg_37_1)
		end

		return {
			flag = var_38_1 and 1 or 2,
			position = arg_38_0,
			offset = arg_37_3
		}
	end))
end

function var_0_1.CanRotateItem(arg_39_0, arg_39_1)
	if arg_39_1:HasParent() then
		var_1_10004 = arg_39_1:GetParent()

		return var_2.CanRotateChild(var_1_10004, arg_39_1)
	else
		isa = var_2

		local var_39_0 = arg_39_1

		CourtYardCanPutFurniture = var_1_10004

		if var_2(var_39_0, var_1_10004) and arg_39_1:AnyNotRotateChilds() then
			return false
		else
			local var_39_1 = arg_39_0
			local var_39_2 = arg_39_0.GetMapNotIncludeItem(var_39_1, arg_39_1)

			_ = var_39_1

			return var_39_1.all(arg_39_1:GetRotatePositions(), function(arg_40_0)
				if var_39_2[arg_40_0.x] then
					local var_40_2

					if var_39_2[arg_40_0.x][arg_40_0.y] == false then
						local var_40_0 = arg_39_0

						if var_1.InSide(var_40_0, arg_40_0) then
							local var_40_1 = arg_39_1

							var_40_2 = var_1.InActivityRange(var_40_1, arg_40_0)
						end
					else
						var_40_2 = false
					end
				end

				if false then
					var_40_2 = true
				end

				return var_40_2
			end)
		end
	end

	return
end

function var_0_1.GetAroundEmptyPosition(arg_41_0, arg_41_1)
	local var_41_0 = {}
	local var_41_1 = {}
	local var_41_2 = arg_41_1
	local var_41_3 = arg_41_1.GetPosition(var_41_2)

	table = var_41_2

	local var_41_4 = var_41_2.insert
	local var_41_5 = var_41_0

	Vector2 = var_1_10007

	var_41_4(var_41_5, var_1_10007(var_41_3.x, var_41_3.y - 1))

	while #var_41_0 > 0 do
		table = var_41_6

		local var_41_6 = var_41_6.remove(var_41_0, 1)

		if arg_41_0:IsEmptyPosition(var_41_6) then
			return var_41_6
		end

		table = var_6

		var_6.insert(var_41_1, var_41_6)

		ipairs = var_6

		local var_41_7 = {}

		Vector2 = var_8
		var_41_7[1] = var_8(var_41_6.x, var_41_6.y - 1)
		Vector2 = var_8
		var_41_7[2] = var_8(var_41_6.x - 1, var_41_6.y)
		Vector2 = var_8
		var_41_7[3] = var_8(var_41_6.x + 1, var_41_6.y)
		Vector2 = var_8
		var_41_7[4] = var_8(var_41_6.x, var_41_6.y + 1)

		for iter_41_0, iter_41_1 in var_6(var_41_7) do
			table = var_1_10011

			if not var_1_10011.contains(var_41_1, iter_41_1) and arg_41_0:InSide(iter_41_1) then
				table = var_1_10011

				var_1_10011.insert(var_41_0, iter_41_1)
			end
		end
	end

	assert = var_41_6

	var_41_6(false)

	return
end

function var_0_1.GetAroundEmptyArea(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_1:GetInitSize()[1][1]
	local var_42_1 = var_3[1][2]
	local var_42_2 = arg_42_0:GetPositions()

	local function var_42_3(arg_43_0, arg_43_1)
		local var_43_0 = arg_43_0.x + arg_43_0.y - (arg_43_1.x + arg_43_1.y)

		math = var_3

		return var_3.abs(var_43_0)
	end

	_ = var_1_10008

	local var_42_4 = var_1_10008.map(var_42_2, function(arg_44_0)
		return {
			cost = var_42_3(arg_44_0, arg_42_2),
			value = arg_44_0
		}
	end)

	table = var_9

	var_9.sort(var_42_4, function(arg_45_0, arg_45_1)
		return arg_45_0.cost < arg_45_1.cost
	end)

	ipairs = var_9

	for iter_42_0, iter_42_1 in var_9(var_42_4) do
		local var_42_5 = iter_42_1.value
		local var_42_6 = arg_42_1
		local var_42_7 = arg_42_1.GetAreaByPosition(var_42_6, var_42_5)

		_ = var_42_6

		if var_42_6.all(var_42_7, function(arg_46_0)
			local var_46_0 = arg_42_0

			return var_1.LegalPosition(var_46_0, arg_46_0, arg_42_1)
		end) then
			return var_42_5
		end
	end

	return nil
end

function var_0_1.Dispose(arg_47_0)
	arg_47_0:ClearListeners()

	return
end

return var_0_1
