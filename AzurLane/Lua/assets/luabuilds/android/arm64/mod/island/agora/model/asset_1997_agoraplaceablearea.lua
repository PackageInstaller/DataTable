class = var_0_10000

local var_0_0 = "AgoraPlaceableArea"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...IslandDispatcher"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.size = arg_1_1
	arg_1_0.placedlist = {}

	local var_1_0 = {}

	IslandConst = var_1_10003

	local var_1_1 = var_1_10003.AGORA_MAP_TYPE_COMMON

	AgoraMap = var_4
	var_1_0[var_1_1] = var_4.New(arg_1_1)
	IslandConst = var_1_1

	local var_1_2 = var_1_1.AGORA_MAP_TYPE_NEWTILE

	AgoraMap = var_4
	var_1_0[var_1_2] = var_4.New(arg_1_1)
	IslandConst = var_1_2

	local var_1_3 = var_1_2.AGORA_MAP_TYPE_BUILDING

	AgoraBuildingMap = var_4
	var_1_0[var_1_3] = var_4.New()
	arg_1_0.maps = var_1_0
	arg_1_0.floorLayer = arg_1_0:GenLayer()
	arg_1_0.tileLayer = arg_1_0:GenLayer()

	return
end

function var_0_1.GetFloorLayer(arg_2_0)
	return arg_2_0.floorLayer
end

function var_0_1.GetTileLayer(arg_3_0)
	return arg_3_0.tileLayer
end

function var_0_1.GetFloorCell(arg_4_0, arg_4_1)
	return arg_4_0.floorLayer[arg_4_1.x][arg_4_1.y]
end

function var_0_1.GetTileCell(arg_5_0, arg_5_1)
	return arg_5_0.tileLayer[arg_5_1.x][arg_5_1.y]
end

function var_0_1.GenLayer(arg_6_0)
	local var_6_0 = {}

	IslandConst = var_1_10002

	local var_6_1 = var_1_10002.AGORA_LEVEL_2_SIZE

	IslandConst = var_1_10003

	local var_6_2 = var_6_1[#var_1_10003.AGORA_LEVEL_2_SIZE]

	AgoraCalc = var_3

	local var_6_3 = var_3.GetArea

	Vector2 = var_1_10005

	local var_6_4 = var_1_10005.zero

	Vector2 = var_1_10006

	local var_6_5 = var_6_3(var_6_4, var_1_10006(var_6_2, var_6_2))

	ipairs = var_1_10004

	for iter_6_0, iter_6_1 in var_1_10004(var_6_5) do
		local var_6_6 = iter_6_1.x
		local var_6_7 = iter_6_1.y

		if not var_6_0[var_6_6] then
			var_6_0[var_6_6] = {}
		end

		local var_6_8 = var_6_0[var_6_6]

		AgoraLayerCell = var_1_10012
		var_1_10012 = var_1_10012.New
		Vector2 = var_1_10014
		var_6_8[var_6_7] = var_1_10012(var_1_10014(var_6_6, var_6_7))
	end

	return var_6_0
end

function var_0_1.FillFloorLayer(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0

	if not arg_7_0.floorLayer[arg_7_3.x] then
		var_7_0 = {}
	end

	if not var_7_0[arg_7_3.y] then
		return
	end

	var_5:Fill(arg_7_1, arg_7_2)

	return
end

function var_0_1.ClearFloorLayer(arg_8_0, arg_8_1)
	local var_8_0

	if not arg_8_0.floorLayer[arg_8_1.x] then
		var_8_0 = {}
	end

	if not var_8_0[arg_8_1.y] then
		return
	end

	var_3:Clear()

	return
end

function var_0_1.FillTileLayer(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0

	if not arg_9_0.tileLayer[arg_9_3.x] then
		var_9_0 = {}
	end

	if not var_9_0[arg_9_3.y] then
		return
	end

	var_5:Fill(arg_9_1, arg_9_2)

	return
end

function var_0_1.ClearTileLayer(arg_10_0, arg_10_1)
	local var_10_0

	if not arg_10_0.tileLayer[arg_10_1.x] then
		var_10_0 = {}
	end

	if not var_10_0[arg_10_1.y] then
		return
	end

	var_3:Clear()

	return
end

function var_0_1.UpdateSize(arg_11_0, arg_11_1)
	arg_11_0.size = arg_11_1
	pairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_0.maps) do
		iter_11_1:UpdateSize(arg_11_1)
	end

	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.DispatchEvent

	ISLAND_AGORA_EVT = iter_11_0

	var_11_1(var_11_0, iter_11_0.MAP_SIZE_UPDATE, arg_11_0.size)

	return
end

function var_0_1.GetSize(arg_12_0)
	return arg_12_0.size
end

function var_0_1.GetRangeCoord(arg_13_0)
	AgoraCalc = var_1_10001

	return (var_1_10001.GetSizeCoord(arg_13_0.size))
end

function var_0_1.InRange(arg_14_0, arg_14_1, arg_14_2)
	return arg_14_1 >= arg_14_0:GetRangeCoord().x and arg_14_1 <= var_3.z and arg_14_2 <= var_3.y and arg_14_2 >= var_3.w
end

function var_0_1._InRange(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	return arg_15_2 >= arg_15_1.x and arg_15_2 <= arg_15_1.z and arg_15_3 <= arg_15_1.y and arg_15_3 >= arg_15_1.w
end

function var_0_1.ClampRange(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_3:GetSizeWithRotation()

	AgoraCalc = var_1_10005

	local var_16_1 = var_1_10005.GetSizeCoord(var_16_0)
	local var_16_2 = arg_16_0:GetRangeCoord().x - var_16_1.x
	local var_16_3 = var_6.z - var_16_1.z
	local var_16_4 = var_6.w - var_16_1.w
	local var_16_5 = var_6.y - var_16_1.y

	Mathf = var_11
	arg_16_1 = var_11.Clamp(arg_16_1, var_16_2, var_16_3)
	Mathf = var_11
	arg_16_2 = var_11.Clamp(arg_16_2, var_16_4, var_16_5)
	Vector2 = var_11

	return var_11(arg_16_1, arg_16_2)
end

function var_0_1._ClampRange(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0:_InRange(arg_17_1, arg_17_2.x, arg_17_2.y) then
		return arg_17_2
	end

	Mathf = var_3

	local var_17_0 = var_3.Clamp(arg_17_2.x, arg_17_1.x, arg_17_1.z)

	Mathf = var_1_10004

	local var_17_1 = var_1_10004.Clamp(arg_17_2.y, arg_17_1.y, arg_17_1.w)

	Vector2 = var_5

	return var_5(var_17_0, var_17_1)
end

function var_0_1.IsUsing(arg_18_0, arg_18_1)
	return arg_18_0.placedlist[arg_18_1] ~= nil
end

function var_0_1.GetPlacedlist(arg_19_0)
	return arg_19_0.placedlist
end

function var_0_1.GetPlacedItem(arg_20_0, arg_20_1)
	return arg_20_0.placedlist[arg_20_1]
end

function var_0_1.GetMap(arg_21_0, arg_21_1)
	return arg_21_0.maps[arg_21_1:GetMapType()]
end

function var_0_1.AddItem(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1
	local var_22_1 = arg_22_1.GetArea(var_22_0)
	local var_22_2 = arg_22_0:GetMap(arg_22_1)

	ipairs = var_22_0

	for iter_22_0, iter_22_1 in var_22_0(var_22_1) do
		var_22_2:UpdateMapState(iter_22_1.x, iter_22_1.y, false)
	end

	arg_22_0.placedlist[arg_22_1.id] = arg_22_1

	return
end

function var_0_1.RemoveItem(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1
	local var_23_1 = arg_23_1.GetArea(var_23_0)
	local var_23_2 = arg_23_0:GetMap(arg_23_1)

	ipairs = var_23_0

	for iter_23_0, iter_23_1 in var_23_0(var_23_1) do
		var_23_2:UpdateMapState(iter_23_1.x, iter_23_1.y, true)
	end

	arg_23_0.placedlist[arg_23_1.id] = nil

	return
end

function var_0_1.IsEmptyArea(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1:GetArea()
	local var_24_1 = arg_24_0
	local var_24_2 = arg_24_0.GetMap(var_24_1, arg_24_1)
	local var_24_3 = arg_24_0:GetRangeCoord()

	_ = var_24_1

	return var_24_1.all(var_24_0, function(arg_25_0)
		local var_25_0 = arg_24_0
		local var_25_2

		if var_1._InRange(var_25_0, var_24_3, arg_25_0.x, arg_25_0.y) then
			local var_25_1 = var_24_2

			var_25_2 = var_1.GetMapState(var_25_1, arg_25_0.x, arg_25_0.y) == true
		end

		return var_25_2
	end)
end

function var_0_1.IsEmptyAreaInPoint(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_1:GenAreaByPosition(arg_26_2)
	local var_26_1 = arg_26_0
	local var_26_2 = arg_26_0.GetMap(var_26_1, arg_26_1)
	local var_26_3 = arg_26_0:GetRangeCoord()

	_ = var_26_1

	return var_26_1.all(var_26_0, function(arg_27_0)
		local var_27_0 = arg_26_0
		local var_27_2

		if var_1._InRange(var_27_0, var_26_3, arg_27_0.x, arg_27_0.y) then
			local var_27_1 = var_26_2

			var_27_2 = var_1.GetMapState(var_27_1, arg_27_0.x, arg_27_0.y) == true
		end

		return var_27_2
	end)
end

function var_0_1.IsEmptyPoint(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0:GetMap(arg_28_1)

	return var_3.IsEmptyPoint(var_28_0, arg_28_2)
end

function var_0_1.GetItemInArea(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0.maps[arg_29_1]

	_ = var_1_10004

	if var_1_10004.detect(arg_29_2, function(arg_30_0)
		local var_30_0 = var_29_0

		return var_1.GetMapState(var_30_0, arg_30_0.x, arg_30_0.y) == false
	end) and arg_29_0:GetItemInPosition(arg_29_1, var_4) then
		return var_5
	end

	return nil
end

function var_0_1.GetAnyMapItemInPosition(arg_31_0, arg_31_1)
	pairs = var_1_10002

	for iter_31_0, iter_31_1 in var_1_10002(arg_31_0.maps) do
		if arg_31_0:GetItemInPosition(iter_31_0, arg_31_1) then
			return var_7
		end
	end

	return nil
end

function var_0_1.GetItemInPosition(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_0:InRange(arg_32_2.x, arg_32_2.y) then
		return nil
	end

	local var_32_0 = arg_32_0.maps[arg_32_1]

	if var_3.GetMapState(var_32_0, arg_32_2.x, arg_32_2.y) == false then
		return arg_32_0:FindItemInPosition(arg_32_1, arg_32_2)
	end

	return nil
end

function var_0_1.FindItemInPosition(arg_33_0, arg_33_1, arg_33_2)
	pairs = var_1_10003

	for iter_33_0, iter_33_1 in var_1_10003(arg_33_0.placedlist) do
		if iter_33_1:GetMapType() == arg_33_1 then
			local var_33_0 = iter_33_1:GetArea()

			ipairs = var_1_10009

			for iter_33_2, iter_33_3 in var_1_10009(var_33_0) do
				if iter_33_3 == arg_33_2 then
					return iter_33_1
				end
			end
		end
	end

	return nil
end

function var_0_1.FindEmptyArea4Item(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0:GetRangeCoord()

	AgoraCalc = var_1_10004

	local var_34_1 = var_1_10004.GetSizeCoord(arg_34_2:GetSizeWithRotation())
	local var_34_2 = var_34_0.x - var_34_1.x
	local var_34_3 = var_34_0.z - var_34_1.z
	local var_34_4 = var_34_0.w - var_34_1.w
	local var_34_5 = var_34_0.y - var_34_1.y

	if var_34_3 < var_34_2 or var_34_5 < var_34_4 then
		return nil
	end

	Mathf = var_9

	local var_34_6 = var_9.Clamp(arg_34_1.x, var_34_2, var_34_3)

	Mathf = var_1_10010

	local var_34_7 = var_1_10010.Clamp(arg_34_1.y, var_34_4, var_34_5)
	local var_34_8 = arg_34_0:GetMap(arg_34_2)

	math = var_12

	local var_34_9 = var_12.max

	math = var_14

	local var_34_10 = var_14.abs(var_34_6 - var_34_2)

	math = var_1_10015

	local var_34_11 = var_34_10 + var_1_10015.abs(var_34_7 - var_34_4)

	math = var_15

	local var_34_12 = var_15.abs(var_34_6 - var_34_2)

	math = var_16

	local var_34_13 = var_34_12 + var_16.abs(var_34_7 - var_34_5)

	math = var_16

	local var_34_14 = var_16.abs(var_34_6 - var_34_3)

	math = var_17

	local var_34_15 = var_34_14 + var_17.abs(var_34_7 - var_34_4)

	math = var_17

	local var_34_16 = var_17.abs(var_34_6 - var_34_3)

	math = var_18

	local var_34_17 = var_34_9(var_34_11, var_34_13, var_34_15, var_34_16 + var_18.abs(var_34_7 - var_34_5))

	local function var_34_18(arg_35_0, arg_35_1)
		if arg_35_0 < var_34_2 or var_34_3 < arg_35_0 or arg_35_1 < var_34_4 or var_34_5 < arg_35_1 then
			return false
		end

		_ = var_2

		local var_35_0 = var_2.all
		local var_35_1 = arg_34_2
		local var_35_2 = var_4.GenAreaByPosition

		Vector2 = var_2_10007

		return var_35_0(var_35_2(var_35_1, var_2_10007(arg_35_0, arg_35_1)), function(arg_36_0)
			local var_36_0 = arg_34_0
			local var_36_2

			if var_1._InRange(var_36_0, var_34_0, arg_36_0.x, arg_36_0.y) then
				local var_36_1 = var_34_8

				var_36_2 = var_1.GetMapState(var_36_1, arg_36_0.x, arg_36_0.y) == true
			end

			return var_36_2
		end)
	end

	for iter_34_0 = 0, var_34_17 do
		for iter_34_1 = -iter_34_0, iter_34_0 do
			math = var_1_10022
			var_1_10022 = iter_34_0 - var_1_10022.abs(iter_34_1)

			local var_34_19 = var_34_6 + iter_34_1

			if var_34_18(var_34_19, var_34_7 + var_1_10022) then
				Vector2 = var_24

				return var_24(var_34_19, var_34_7 + var_1_10022)
			end

			if var_1_10022 ~= 0 and var_34_18(var_34_19, var_34_7 - var_1_10022) then
				Vector2 = var_24

				return var_24(var_34_19, var_34_7 - var_1_10022)
			end
		end
	end

	return nil
end

function var_0_1.SerializePlacementData(arg_37_0)
	local var_37_0 = {}

	pairs = var_1_10002

	for iter_37_0, iter_37_1 in var_1_10002(arg_37_0:GetPlacedlist()) do
		table = var_1_10007

		var_1_10007.insert(var_37_0, iter_37_1:ToPlacementData())
	end

	local var_37_1 = {}

	pairs = var_3

	for iter_37_2, iter_37_3 in var_3(arg_37_0:GetFloorLayer()) do
		pairs = var_1_10008

		for iter_37_4, iter_37_5 in var_1_10008(iter_37_3) do
			if not iter_37_5:IsEmpty() then
				table = var_13

				var_13.insert(var_37_1, iter_37_5:ToPlacementData())
			end
		end
	end

	local var_37_2 = {}

	pairs = var_4

	for iter_37_6, iter_37_7 in var_4(arg_37_0:GetTileLayer()) do
		pairs = var_1_10009

		for iter_37_8, iter_37_9 in var_1_10009(iter_37_7) do
			if not iter_37_9:IsEmpty() then
				table = var_14

				var_14.insert(var_37_2, iter_37_9:ToPlacementData())
			end
		end
	end

	return var_37_0, var_37_1, var_37_2
end

function var_0_1.ToString(arg_38_0)
	local var_38_0, var_38_1, var_38_2 = arg_38_0:SerializePlacementData()

	AgoraCalc = var_1_10004

	local var_38_3 = var_1_10004.EncodeLayer(var_38_1)

	AgoraCalc = var_1_10005

	local var_38_4 = var_1_10005.EncodeLayer(var_38_2)

	_ = var_6

	local var_38_5 = var_6.map(var_38_0, function(arg_39_0)
		string = var_2_10001

		return var_2_10001.format("\t\t\t{id = %s,x = %s,y = %s,dir = %s,configId = %s},", arg_39_0.id, arg_39_0.x, arg_39_0.y, arg_39_0.dir, arg_39_0.configId)
	end)

	_ = var_7

	local var_38_6 = var_7.map(var_38_3, function(arg_40_0)
		local var_40_0 = "\t\t\t"

		tostring = var_2_10002

		return var_40_0 .. var_2_10002(arg_40_0)
	end)

	_ = var_8

	local var_38_7 = var_8.map(var_38_4, function(arg_41_0)
		local var_41_0 = "\t\t\t"

		tostring = var_2_10002

		return var_41_0 .. var_2_10002(arg_41_0)
	end)
	local var_38_8 = {}

	table = var_10

	var_10.insert(var_38_8, "return {")

	table = var_10

	var_10.insert(var_38_8, "\tid = 0,")

	table = var_10

	var_10.insert(var_38_8, "\tname = '',")

	table = var_10

	var_10.insert(var_38_8, "\tplaced_data = {")

	table = var_10

	var_10.insert(var_38_8, "\t\tplaced_list = {")

	table = var_10

	local var_38_9 = var_10.insert
	local var_38_10 = var_38_8

	table = var_13

	var_38_9(var_38_10, var_13.concat(var_38_5, "\n"))

	table = var_38_9

	var_38_9.insert(var_38_8, "\t\t},")

	table = var_10

	var_10.insert(var_38_8, "\t\tfloor_data = {")

	table = var_10

	local var_38_11 = var_10.insert
	local var_38_12 = var_38_8

	table = var_13

	var_38_11(var_38_12, var_13.concat(var_38_6, ",\n"))

	table = var_38_11

	var_38_11.insert(var_38_8, "\t\t},")

	table = var_10

	var_10.insert(var_38_8, "\t\ttile_data = {")

	table = var_10

	local var_38_13 = var_10.insert
	local var_38_14 = var_38_8

	table = var_13

	var_38_13(var_38_14, var_13.concat(var_38_7, ",\n"))

	table = var_38_13

	var_38_13.insert(var_38_8, "\t\t},")

	table = var_10

	var_10.insert(var_38_8, "\t}")

	table = var_10

	var_10.insert(var_38_8, "}")

	table = var_10

	return var_10.concat(var_38_8, "\n")
end

return var_0_1
