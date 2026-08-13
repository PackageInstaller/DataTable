class = var_0_10000

local var_0_0 = var_0_10000("AgoraDataComparator")

var_0_0.CHANGE_TYPE_PLACED = 2
var_0_0.CHANGE_TYPE_FLOOR = 4
var_0_0.CHANGE_TYPE_TILE = 8

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.agora = arg_1_1
	arg_1_0.isTake = false
	IndexConst = var_2
	arg_1_0.allCode = var_2.BitAll({
		var_0_0.CHANGE_TYPE_PLACED,
		var_0_0.CHANGE_TYPE_FLOOR,
		var_0_0.CHANGE_TYPE_TILE
	})

	return
end

function var_0_0.TakeSample(arg_2_0)
	Clone = var_1_10001

	local var_2_0 = arg_2_0.agora

	arg_2_0.placedData = var_1_10001(var_3.GetPlacedlist(var_2_0))
	Clone = var_1

	local var_2_1 = arg_2_0.agora

	arg_2_0.floorData = var_1(var_3.GetFloorLayer(var_2_1))
	Clone = var_1

	local var_2_2 = arg_2_0.agora

	arg_2_0.tileData = var_1(var_3.GetTileLayer(var_2_2))
	arg_2_0.isTake = true

	return
end

function var_0_0.GetSample(arg_3_0)
	return arg_3_0.placedData, arg_3_0.floorData, arg_3_0.tileData
end

function var_0_0.AnyChanged(arg_4_0)
	if not arg_4_0.isTake then
		return false
	end

	local var_4_0 = arg_4_0.agora
	local var_4_1 = var_1.GetPlacedlist(var_4_0)
	local var_4_2 = arg_4_0.agora
	local var_4_3 = var_2.GetFloorLayer(var_4_2)
	local var_4_4 = arg_4_0.agora
	local var_4_5 = var_3.GetTileLayer(var_4_4)
	local var_4_6 = 0
	local var_4_7 = arg_4_0

	if arg_4_0.ComparePlacedData(var_4_7, var_4_1, arg_4_0.placedData) then
		bit = var_1_10006
		var_4_6 = var_1_10006.bor(var_4_6, var_0_0.CHANGE_TYPE_PLACED)
	end

	local var_4_8 = arg_4_0

	if arg_4_0.CompareLayer(var_4_8, var_4_3, arg_4_0.floorData) then
		bit = var_4_7
		var_4_6 = var_4_7.bor(var_4_6, var_0_0.CHANGE_TYPE_FLOOR)
	end

	if arg_4_0:CompareLayer(var_4_5, arg_4_0.tileData) then
		bit = var_4_8
		var_4_6 = var_4_8.bor(var_4_6, var_0_0.CHANGE_TYPE_TILE)
	end

	bit = var_4_8

	return var_4_8.band(var_4_6, arg_4_0.allCode) > 0, var_4_6
end

function var_0_0.ComparePlacedData(arg_5_0, arg_5_1, arg_5_2)
	table = var_1_10003

	local var_5_0 = var_1_10003.getCount(arg_5_1)

	table = var_1_10004

	if var_5_0 ~= var_1_10004.getCount(arg_5_2) then
		return true
	end

	pairs = var_5

	for iter_5_0, iter_5_1 in var_5(arg_5_2) do
		if not arg_5_1[iter_5_0] or not var_10:IsSame(iter_5_1) then
			return true
		end
	end

	pairs = var_5

	for iter_5_2, iter_5_3 in var_5(arg_5_1) do
		if not arg_5_2[iter_5_2] or not var_10:IsSame(iter_5_3) then
			return true
		end
	end

	return false
end

function var_0_0.CompareLayer(arg_6_0, arg_6_1, arg_6_2)
	pairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(arg_6_1) do
		pairs = var_1_10008

		for iter_6_2, iter_6_3 in var_1_10008(iter_6_1) do
			if not arg_6_2[iter_6_0][iter_6_2] or not var_13:IsSame(iter_6_3) then
				return true
			end
		end
	end

	return false
end

function var_0_0.Abort(arg_7_0)
	arg_7_0.placedData = nil
	arg_7_0.floorData = nil
	arg_7_0.tileData = nil
	arg_7_0.isTake = false

	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:Abort()

	return
end

return var_0_0
