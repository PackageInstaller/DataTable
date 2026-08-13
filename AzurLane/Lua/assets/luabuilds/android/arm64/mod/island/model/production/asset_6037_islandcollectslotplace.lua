class = var_0_10000

local var_0_0 = "IslandCollectSlotPlace"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.slotType = {
	Task = 2,
	Normal = 1
}

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.placeId = arg_1_1
	pg = var_1_10003

	local var_1_0 = var_1_10003.TimeMgr.GetInstance()
	local var_1_1 = var_3.GetServerTime(var_1_0)

	arg_1_0.get_num = arg_1_2.get_num
	arg_1_0.refresh_time = arg_1_2.refresh_time

	if var_1_1 > arg_1_0.refresh_time then
		arg_1_0.get_num = 0
	end

	if arg_1_0.get_num > 0 then
		arg_1_0.needRefresh = true
	end

	arg_1_0.recoverQueue = {}
	arg_1_0.collectionSlotData = {}
	pg = var_4

	local var_1_2 = var_4.island_set.mission_gather_point.key_value_varchar

	arg_1_0.taskPointDic = {}
	ipairs = var_5

	for iter_1_0, iter_1_1 in var_5(var_1_2) do
		arg_1_0.taskPointDic[iter_1_1[1]] = true
	end

	ipairs = var_5

	local var_1_3

	if not arg_1_2.collect_list then
		var_1_3 = {}
	end

	for iter_1_2, iter_1_3 in var_5(var_1_3) do
		local var_1_4

		if not arg_1_0.taskPointDic[iter_1_3] or not var_0_1.slotType.Task then
			var_1_4 = var_0_1.slotType.Normal
		end

		if var_1_4 == var_0_1.slotType.Normal then
			table = var_11

			var_11.insert(arg_1_0.recoverQueue, iter_1_3)
		end

		local var_1_5 = arg_1_0.collectionSlotData

		IslandCollectSlotNew = var_1_10012
		var_1_5[iter_1_3] = var_1_10012.New(arg_1_0, iter_1_3, var_1_4)
	end

	return
end

function var_0_1.GetCollectSlotDatasDic(arg_2_0)
	return arg_2_0.collectionSlotData
end

function var_0_1.GetRecoverQueue(arg_3_0)
	return arg_3_0.recoverQueue
end

function var_0_1.GetCanCollectTime(arg_4_0)
	math = var_1_10001

	return var_1_10001.min(#arg_4_0.recoverQueue, #arg_4_0.recoverQueue - arg_4_0.get_num)
end

function var_0_1.GetInRecoverTimeBySlotId(arg_5_0, arg_5_1)
	ipairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_0.recoverQueue) do
		if iter_5_1 == arg_5_1 then
			return iter_5_0
		end
	end

	return
end

function var_0_1.GetNextRecoverTimes(arg_6_0)
	return arg_6_0.refresh_time
end

function var_0_1.UpdateCollectRefreshtTime(arg_7_0, arg_7_1)
	if arg_7_1 ~= arg_7_0.refresh_time then
		arg_7_0.refresh_time = arg_7_1
		arg_7_0.needRefresh = true
	end

	return
end

function var_0_1.UpdateGetCollectNum(arg_8_0, arg_8_1)
	if arg_8_1 == var_0_1.slotType.Normal then
		arg_8_0.get_num = arg_8_0.get_num + 1
	end

	return
end

function var_0_1.SetAllTakeColelct(arg_9_0)
	arg_9_0.get_num = #arg_9_0.recoverQueue

	return
end

function var_0_1.UpdateCollectDataBySlotId(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1.id

	if not arg_10_0.collectionSlotData[var_10_0] then
		return
	end

	if arg_10_2 == var_0_1.slotType.Task then
		var_4:UpdateCollectData(arg_10_1, arg_10_2)

		arg_10_0.collectionSlotData[var_10_0] = nil
	else
		arg_10_0:RefreshRecoverQueue(var_10_0)
		var_4:UpdateCollectData(arg_10_1, arg_10_2)
	end

	return
end

function var_0_1.RefreshRecoverQueue(arg_11_0, arg_11_1)
	local var_11_0 = -1

	ipairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(arg_11_0.recoverQueue) do
		if iter_11_1 == arg_11_1 then
			var_11_0 = iter_11_0
		end
	end

	if var_11_0 ~= -1 then
		table = var_3

		var_3.remove(arg_11_0.recoverQueue, var_11_0)
	end

	table = var_3

	var_3.insert(arg_11_0.recoverQueue, arg_11_1)

	return
end

function var_0_1.GetCollectSlotData(arg_12_0, arg_12_1)
	return arg_12_0.collectionSlotData[arg_12_1]
end

function var_0_1.InitHandSlotData(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.id

	if arg_13_0.collectionSlotData[var_13_0] then
		warning = var_3

		var_3("已经存在当前槽位的信息了")

		return
	end

	local var_13_1

	if not arg_13_0.taskPointDic[var_13_0] or not var_0_1.slotType.Task then
		var_13_1 = var_0_1.slotType.Normal
	end

	if var_13_1 == var_0_1.slotType.Normal then
		table = var_4

		var_4.insert(arg_13_0.recoverQueue, 1, var_13_0)
	end

	IslandCollectSlotNew = var_4

	local var_13_2 = var_4.New(arg_13_0.configId, arg_13_1, var_13_1)
	local var_13_3 = arg_13_0.collectionSlotData

	var_13_3[arg_13_1.id] = var_13_2
	getProxy = var_13_3
	IslandProxy = var_7

	local var_13_4 = var_13_3(var_7)
	local var_13_5 = var_5.GetIsland(var_13_4)
	local var_13_6 = var_5.DispatchEvent

	IslandBuildingAgency = var_1_10009

	var_13_6(var_13_5, var_1_10009.COLLECT_SlOT_UNIT_INIT, {
		slotId = arg_13_1.id
	})

	return
end

function var_0_1.UpdatePerSecond(arg_14_0)
	pg = var_1_10001

	local var_14_0 = var_1_10001.TimeMgr.GetInstance()
	local var_14_1 = var_1.GetServerTime(var_14_0)

	if arg_14_0.needRefresh and var_14_1 >= arg_14_0.refresh_time then
		arg_14_0.needRefresh = false

		local var_14_2 = #arg_14_0.recoverQueue - arg_14_0.get_num + 1

		arg_14_0.get_num = 0
		getProxy = var_3
		IslandProxy = var_1_10005

		local var_14_3 = var_3(var_1_10005)
		local var_14_4 = var_3.GetIsland(var_14_3)

		math = var_1_10004

		local var_14_5 = var_1_10004.max(1, var_14_2)

		for iter_14_0 = #arg_14_0.recoverQueue, var_14_5, -1 do
			local var_14_6 = arg_14_0.recoverQueue[iter_14_0]
			local var_14_7 = arg_14_0.placeId

			IslandProductConst = var_1_10010

			if var_14_7 == var_1_10010.MinePlaceId then
				local var_14_8 = var_14_4
				local var_14_9 = var_14_4.DispatchEvent

				IslandBuildingAgency = var_1_10012

				var_14_9(var_14_8, var_1_10012.COLLECT_SlOT_UNIT_INIT, {
					slotId = var_14_6
				})
			else
				local var_14_10 = var_14_4
				local var_14_11 = var_14_4.DispatchEvent

				IslandBuildingAgency = var_1_10012

				var_14_11(var_14_10, var_1_10012.COLLECT_SlOT_UNIT_UPDATE, {
					slotId = var_14_6
				})
			end
		end
	end

	return
end

return var_0_1
