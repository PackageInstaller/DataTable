class = var_0_10000

local var_0_0 = var_0_10000("DecodeGameModel")

function var_0_0.SetData(arg_1_0, arg_1_1)
	arg_1_0.data = arg_1_1
	arg_1_0.mapId = arg_1_1.mapId
	arg_1_0.unlocks = arg_1_1.unlocks
	arg_1_0.canUseCnt = arg_1_1.canUseCnt
	arg_1_0.passwords = arg_1_1.passwords
	arg_1_0.isFinished = arg_1_1.isFinished
	arg_1_0.mapIndexs = {}

	if arg_1_0.isFinished then
		arg_1_0:BuildMapIndexs()
	else
		local var_1_0 = 1

		DecodeGameConst = var_1_10003

		for iter_1_0 = var_1_0, #var_1_10003.PASSWORD do
			table = var_1_10006

			var_1_10006.insert(arg_1_0.mapIndexs, false)
		end
	end

	arg_1_0.maps = {}

	local var_1_1 = 1

	DecodeGameConst = var_1_10003

	for iter_1_1 = var_1_1, var_1_10003.MAX_MAP_COUNT do
		table = var_1_10006

		var_1_10006.insert(arg_1_0.maps, arg_1_0:InitMap(iter_1_1))
	end

	arg_1_0:SwitchMap(arg_1_1.mapId)

	return
end

function var_0_0.BuildMapIndexs(arg_2_0)
	DecodeGameConst = var_1_10001

	local var_2_0 = var_1_10001.PASSWORD

	local function var_2_1(arg_3_0)
		ipairs = var_2_10001
		DecodeGameConst = var_2_10003

		for iter_3_0, iter_3_1 in var_2_10001(var_2_10003.MAPS_PASSWORD) do
			_ = var_2_10006

			if var_2_10006.any(iter_3_1, function(arg_4_0)
				return arg_4_0[1] == arg_3_0[1] and arg_4_0[2] == arg_3_0[2]
			end) then
				return iter_3_0
			end
		end

		return
	end

	for iter_2_0 = 1, #var_2_0 do
		local var_2_2 = var_2_0[iter_2_0]
		local var_2_3 = var_2_1(var_2_2)

		DecodeGameConst = var_1_10009

		local var_2_4 = var_1_10009.Vect2Index(var_2_2[1], var_2_2[2])

		var_1_10009 = var_2_3 - 1
		DecodeGameConst = var_10

		local var_2_5 = var_10.MAP_ROW

		DecodeGameConst = var_11

		local var_2_6 = var_2_4 + var_1_10009 * (var_2_5 * var_11.MAP_COLUMN)

		table = var_1_10009

		var_1_10009.insert(arg_2_0.mapIndexs, var_2_6)
	end

	return
end

function var_0_0.InitMap(arg_5_0, arg_5_1)
	local function var_5_0(arg_6_0, arg_6_1, arg_6_2)
		DecodeGameConst = var_2_10003

		local var_6_0 = var_2_10003.START_POS[1]
		local var_6_1 = arg_6_1 - 1

		DecodeGameConst = var_2_10005

		local var_6_2 = var_6_0 + var_6_1 * var_2_10005.BLOCK_SIZE[1]

		DecodeGameConst = var_4

		local var_6_3 = var_4.START_POS[2]
		local var_6_4 = arg_6_0 - 1

		DecodeGameConst = var_2_10006

		local var_6_5 = var_6_3 - var_6_4 * var_2_10006.BLOCK_SIZE[2]

		table = var_5

		local var_6_6 = var_5.contains(arg_5_0.unlocks, arg_6_2)
		local var_6_7 = {
			isUsed = false,
			index = arg_6_2,
			i = arg_6_0,
			j = arg_6_1
		}

		Vector3 = var_7
		var_6_7.position = var_7(var_6_2, var_6_5, 0)
		var_6_7.isUnlock = var_6_6

		return var_6_7
	end

	local var_5_1 = {}
	local var_5_2 = arg_5_1 - 1

	DecodeGameConst = var_1_10005

	local var_5_3 = var_1_10005.MAP_ROW

	DecodeGameConst = var_1_10006

	local var_5_4 = var_5_2 * (var_5_3 * var_1_10006.MAP_COLUMN)
	local var_5_5 = 1

	DecodeGameConst = var_1_10007

	for iter_5_0 = var_5_5, var_1_10007.MAP_ROW do
		local var_5_6 = 1

		DecodeGameConst = var_1_10011

		for iter_5_1 = var_5_6, var_1_10011.MAP_COLUMN do
			local var_5_7 = var_5_7 + 1

			var_1_10014 = var_5_0(iter_5_0, iter_5_1, var_5_7)
			table = var_1_10015

			var_1_10015.insert(var_5_1, var_1_10014)
		end
	end

	local var_5_8 = arg_5_0:IsUnlockMap(arg_5_1)
	local var_5_9 = arg_5_0.passwords[arg_5_1]
	local var_5_10 = {}

	for iter_5_2 = 1, #var_5_9 do
		local var_5_11 = var_5_9[iter_5_2]

		DecodeGameConst = var_1_10014

		local var_5_12 = var_5_4 + var_1_10014.Vect2Index(var_5_11[1], var_5_11[2])

		table = var_16

		var_16.insert(var_5_10, var_5_12)
	end

	return {
		id = arg_5_1,
		items = var_5_1,
		isUnlock = var_5_8,
		password = var_5_9,
		passwordIndexs = var_5_10
	}
end

function var_0_0.SwitchMap(arg_7_0, arg_7_1)
	arg_7_0.map = arg_7_0.maps[arg_7_1]
	ipairs = var_2

	for iter_7_0, iter_7_1 in var_2(arg_7_0.map.items) do
		iter_7_1.isUsed = arg_7_0:IsUsedMapKey(iter_7_1.index)
	end

	return
end

function var_0_0.ExitMap(arg_8_0)
	arg_8_0.map = nil

	return
end

function var_0_0.UnlockMapItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.map

	ipairs = var_1_10003

	for iter_9_0, iter_9_1 in var_1_10003(var_9_0.items) do
		if iter_9_1.index == arg_9_1 then
			iter_9_1.isUnlock = true

			break
		end
	end

	table = var_3

	if not var_3.contains(arg_9_0.unlocks, arg_9_1) then
		table = var_3

		var_3.insert(arg_9_0.unlocks, arg_9_1)
	end

	arg_9_0.canUseCnt = arg_9_0.canUseCnt - 1

	return
end

function var_0_0.OnRepairMap(arg_10_0)
	arg_10_0.map.isUnlock = true

	return
end

function var_0_0.IsUnlock(arg_11_0, arg_11_1)
	_ = var_1_10002

	return var_1_10002.any(arg_11_0.map.items, function(arg_12_0)
		return arg_12_0.index == arg_11_1 and arg_12_0.isUnlock
	end)
end

function var_0_0.GetUnlockedCnt(arg_13_0)
	return #arg_13_0.unlocks
end

function var_0_0.IsUnlockMap(arg_14_0, arg_14_1)
	DecodeGameConst = var_1_10002

	local var_14_0 = var_1_10002.MAP_ROW

	DecodeGameConst = var_1_10003

	local var_14_1 = var_14_0 * var_1_10003.MAP_COLUMN
	local var_14_2 = (arg_14_1 - 1) * var_14_1 + 1 + var_14_1 - 1

	_ = var_1_10005

	local var_14_3 = var_1_10005.all

	_ = var_1_10007

	return var_14_3(var_1_10007.range(var_3, var_14_2), function(arg_15_0)
		table = var_2_10001

		return var_2_10001.contains(arg_14_0.unlocks, arg_15_0)
	end)
end

function var_0_0.GetUnlockMapCnt(arg_16_0)
	local var_16_0 = 0

	ipairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_0.maps) do
		if iter_16_1.isUnlock then
			var_16_0 = var_16_0 + 1
		end
	end

	return var_16_0
end

function var_0_0.CheckIndex(arg_17_0, arg_17_1)
	DecodeGameConst = var_1_10002

	local var_17_0 = #var_1_10002.MAPS_PASSWORD[1]
	local var_17_1 = arg_17_0:GetCurrMapKeyIndex(arg_17_1)

	math = var_1_10004

	local var_17_2 = (var_1_10004.ceil(var_17_1 / var_17_0) - 1) * var_17_0 + 1 + (var_17_0 - 1)

	if var_17_1 == var_4 then
		return true
	end

	if var_4 < var_17_1 then
		local var_17_3 = var_17_1 - 1

		if arg_17_0.mapIndexs[var_17_3] ~= false then
			return true
		end
	end

	return false
end

function var_0_0.IsUsedMapKey(arg_18_0, arg_18_1)
	table = var_1_10002

	return var_1_10002.contains(arg_18_0.mapIndexs, arg_18_1)
end

function var_0_0.IsMapKey(arg_19_0, arg_19_1)
	_ = var_1_10002

	return var_1_10002.any(arg_19_0.map.passwordIndexs, function(arg_20_0)
		return arg_20_0 == arg_19_1
	end)
end

function var_0_0.InsertMapKey(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:GetCurrMapKeyIndex(arg_21_1)

	arg_21_0.mapIndexs[var_21_0] = arg_21_1

	return
end

function var_0_0.GetMapKeyStr(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.map.id - 1

	DecodeGameConst = var_1_10003

	local var_22_1 = var_1_10003.MAP_ROW

	DecodeGameConst = var_1_10004
	arg_22_1 = arg_22_1 - var_22_0 * (var_22_1 * var_1_10004.MAP_COLUMN)
	DecodeGameConst = var_3

	return var_3.PASSWORDS[arg_22_1]
end

function var_0_0.ClearMapKeys(arg_23_0)
	if arg_23_0.isFinished then
		return
	end

	_ = var_1
	arg_23_0.mapIndexs = var_1.map(arg_23_0.mapIndexs, function(arg_24_0)
		return false
	end)

	return
end

function var_0_0.GetCurrMapKeyIndex(arg_25_0, arg_25_1)
	DecodeGameConst = var_1_10002

	local var_25_0 = var_1_10002.MAP_ROW

	DecodeGameConst = var_1_10003

	local var_25_1 = arg_25_1 % (var_25_0 * var_1_10003.MAP_COLUMN)

	DecodeGameConst = var_3

	local var_25_2, var_25_3 = var_3.Index2Vect(var_25_1)
	local var_25_4

	ipairs = var_1_10006
	DecodeGameConst = var_1_10008

	for iter_25_0, iter_25_1 in var_1_10006(var_1_10008.PASSWORD) do
		if iter_25_1[1] == var_25_2 and iter_25_1[2] == var_25_3 then
			var_25_4 = iter_25_0

			break
		end
	end

	assert = var_6

	var_6(var_25_4)

	return var_25_4
end

function var_0_0.IsSuccess(arg_26_0)
	_ = var_1_10001

	return var_1_10001.all(arg_26_0.mapIndexs, function(arg_27_0)
		return arg_27_0 ~= false
	end)
end

function var_0_0.GetMapKeyStrs(arg_28_0)
	_ = var_1_10001

	return var_1_10001.map(arg_28_0.mapIndexs, function(arg_29_0)
		if arg_29_0 == false then
			return false
		end

		DecodeGameConst = var_2_10001

		local var_29_0 = var_2_10001.MAP_ROW

		DecodeGameConst = var_2_10002

		local var_29_1 = arg_29_0 % (var_29_0 * var_2_10002.MAP_COLUMN)

		DecodeGameConst = var_2

		return var_2.PASSWORDS[var_29_1]
	end)
end

function var_0_0.GetPassWordProgress(arg_30_0)
	local var_30_0 = 1
	local var_30_1 = {}
	local var_30_2 = 0
	local var_30_3 = 1

	DecodeGameConst = var_1_10005

	local var_30_4 = #var_1_10005.PASSWORD

	DecodeGameConst = var_1_10006

	for iter_30_0 = var_30_3, var_30_4, var_1_10006.MAX_MAP_COUNT do
		_ = var_1_10008
		var_1_10008 = var_1_10008.all
		_ = var_1_10010

		if var_1_10008(var_1_10010.slice(arg_30_0.mapIndexs, iter_30_0, 3), function(arg_31_0)
			return arg_31_0 ~= false
		end) == true then
			var_30_2 = var_30_2 + 1
		end

		table = var_1_10009

		var_1_10009.insert(var_30_1, var_1_10008)
	end

	return var_30_1, var_30_2
end

function var_0_0.Finish(arg_32_0)
	arg_32_0.isFinished = true

	return
end

function var_0_0.CanUnlockAward(arg_33_0)
	DecodeGameConst = var_1_10001

	local var_33_0 = var_1_10001.MAX_MAP_COUNT

	DecodeGameConst = var_1_10002

	local var_33_1 = var_33_0 * var_1_10002.MAP_ROW

	DecodeGameConst = var_2

	local var_33_2 = var_33_1 * var_2.MAP_COLUMN

	return not arg_33_0.isFinished and var_33_2 <= arg_33_0:GetUnlockedCnt()
end

function var_0_0.Dispose(arg_34_0)
	return
end

return var_0_0
