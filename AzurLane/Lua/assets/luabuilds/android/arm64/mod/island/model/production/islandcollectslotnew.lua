class = var_0_10000

local var_0_0 = "IslandCollectSlotNew"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.slotType = {
	Task = 2,
	Normal = 1
}

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.id = arg_1_2
	arg_1_0.configId = arg_1_0.id
	arg_1_0.placeData = arg_1_1
	arg_1_0.slotType = arg_1_3

	return
end

function var_0_1.UpdateData(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_0.id

	return
end

function var_0_1.GetCanCollectTimeStamps(arg_3_0)
	if arg_3_0.slotType == var_0_1.slotType.Task then
		return 0
	end

	local var_3_0 = arg_3_0.placeData
	local var_3_1 = var_1.GetCanCollectTime(var_3_0)
	local var_3_2 = arg_3_0.placeData

	if var_3_1 >= var_2.GetInRecoverTimeBySlotId(var_3_2, arg_3_0.id) then
		return 0
	end

	local var_3_3 = arg_3_0.placeData

	return var_3.GetNextRecoverTimes(var_3_3)
end

function var_0_1.UpdateCollectData(arg_4_0, arg_4_1, arg_4_2)
	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_4_0 = var_1_10003(var_1_10005)
	local var_4_1 = var_3.GetIsland(var_4_0)

	if arg_4_2 == var_0_1.slotType.Task then
		local var_4_2 = var_4_1
		local var_4_3 = var_4_1.DispatchEvent

		IslandBuildingAgency = var_1_10007

		var_4_3(var_4_2, var_1_10007.COLLECT_SLOT_UNIT_REMOVE, {
			slotId = arg_4_0.configId
		})

		return
	end

	local var_4_4 = arg_4_0.placeData.placeId

	IslandProductConst = var_4_0

	if var_4_4 == var_4_0.MinePlaceId then
		local var_4_5 = var_4_1
		local var_4_6 = var_4_1.DispatchEvent

		IslandBuildingAgency = var_1_10007

		var_4_6(var_4_5, var_1_10007.COLLECT_SLOT_UNIT_REMOVE, {
			slotId = arg_4_0.configId
		})
	end

	arg_4_0:UpdateData(arg_4_1)

	return
end

function var_0_1.StartColloct(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.m02
	local var_5_1 = var_1.sendNotification

	GAME = var_1_10004

	var_5_1(var_5_0, var_1_10004.ISLAND_START_COLLECT, {
		build_id = arg_5_0.placeData.placeId,
		area_id = arg_5_0.configId,
		type = arg_5_0.slotType
	})

	return
end

return var_0_1
