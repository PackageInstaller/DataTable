local var_0_0 = class("IslandCollectSlotPlace", import("model.vo.BaseVO"))

var_0_0.slotType = {
	Task = 2,
	Normal = 1
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.placeId = arg_1_1
	arg_1_0.get_num = arg_1_2.get_num
	arg_1_0.refresh_time = arg_1_2.refresh_time

	if pg.TimeMgr.GetInstance():GetServerTime() > arg_1_0.refresh_time then
		arg_1_0.get_num = 0
	end

	if arg_1_0.get_num > 0 then
		arg_1_0.needRefresh = true
	end

	arg_1_0.recoverQueue = {}
	arg_1_0.collectionSlotData = {}
	arg_1_0.taskPointDic = {}

	for iter_1_0, iter_1_1 in ipairs(pg.island_set.mission_gather_point.key_value_varchar) do
		arg_1_0.taskPointDic[iter_1_1[1]] = true
	end

	local var_1_0 = arg_1_2.collect_list or {}

	for iter_1_2, iter_1_3 in ipairs(var_1_0) do
		if arg_1_0.taskPointDic[iter_1_3] then
			local var_1_1 = var_0_0.slotType.Task or var_0_0.slotType.Normal

			if var_1_1 == var_0_0.slotType.Normal then
				table.insert(arg_1_0.recoverQueue, iter_1_3)
			end

			arg_1_0.collectionSlotData[iter_1_3] = IslandCollectSlotNew.New(arg_1_0, iter_1_3, var_1_1)
		end
	end

	return
end

function var_0_0.GetCollectSlotDatasDic(arg_2_0)
	return arg_2_0.collectionSlotData
end

function var_0_0.GetRecoverQueue(arg_3_0)
	return arg_3_0.recoverQueue
end

function var_0_0.GetCanCollectTime(arg_4_0)
	return math.min(#arg_4_0.recoverQueue, #arg_4_0.recoverQueue - arg_4_0.get_num)
end

function var_0_0.GetInRecoverTimeBySlotId(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.recoverQueue) do
		if iter_5_1 == arg_5_1 then
			return iter_5_0
		end
	end

	return
end

function var_0_0.GetNextRecoverTimes(arg_6_0)
	return arg_6_0.refresh_time
end

function var_0_0.UpdateCollectRefreshtTime(arg_7_0, arg_7_1)
	if arg_7_1 ~= arg_7_0.refresh_time then
		arg_7_0.refresh_time = arg_7_1
		arg_7_0.needRefresh = true
	end

	return
end

function var_0_0.UpdateGetCollectNum(arg_8_0, arg_8_1)
	if arg_8_1 == var_0_0.slotType.Normal then
		arg_8_0.get_num = arg_8_0.get_num + 1
	end

	return
end

function var_0_0.SetAllTakeColelct(arg_9_0)
	arg_9_0.get_num = #arg_9_0.recoverQueue

	return
end

function var_0_0.UpdateCollectDataBySlotId(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0.collectionSlotData[arg_10_1.id] then
		return
	end

	if arg_10_2 == var_0_0.slotType.Task then
		arg_10_0.collectionSlotData[arg_10_1.id]:UpdateCollectData(arg_10_1, arg_10_2)

		arg_10_0.collectionSlotData[arg_10_1.id] = nil
	else
		arg_10_0:RefreshRecoverQueue(arg_10_1.id)
		arg_10_0.collectionSlotData[arg_10_1.id]:UpdateCollectData(arg_10_1, arg_10_2)
	end

	return
end

function var_0_0.RefreshRecoverQueue(arg_11_0, arg_11_1)
	local var_11_0 = -1

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.recoverQueue) do
		if iter_11_1 == arg_11_1 then
			var_11_0 = iter_11_0
		end
	end

	if var_11_0 ~= -1 then
		table.remove(arg_11_0.recoverQueue, var_11_0)
	end

	table.insert(arg_11_0.recoverQueue, arg_11_1)

	return
end

function var_0_0.GetCollectSlotData(arg_12_0, arg_12_1)
	return arg_12_0.collectionSlotData[arg_12_1]
end

function var_0_0.InitHandSlotData(arg_13_0, arg_13_1)
	if arg_13_0.collectionSlotData[arg_13_1.id] then
		warning("已经存在当前槽位的信息了")

		return
	end

	if arg_13_0.taskPointDic[arg_13_1.id] then
		local var_13_0 = var_0_0.slotType.Task or var_0_0.slotType.Normal

		if var_13_0 == var_0_0.slotType.Normal then
			table.insert(arg_13_0.recoverQueue, 1, arg_13_1.id)
		end

		arg_13_0.collectionSlotData[arg_13_1.id] = IslandCollectSlotNew.New(arg_13_0.configId, arg_13_1, var_13_0)

		getProxy(IslandProxy):GetIsland():DispatchEvent(IslandBuildingAgency.COLLECT_SlOT_UNIT_INIT, {
			slotId = arg_13_1.id
		})

		return
	end
end

function var_0_0.UpdatePerSecond(arg_14_0)
	if arg_14_0.needRefresh and pg.TimeMgr.GetInstance():GetServerTime() >= arg_14_0.refresh_time then
		arg_14_0.needRefresh = false
		arg_14_0.get_num = 0

		local var_14_0 = getProxy(IslandProxy):GetIsland()

		for iter_14_0 = #arg_14_0.recoverQueue, math.max(1, #arg_14_0.recoverQueue - arg_14_0.get_num + 1), -1 do
			if arg_14_0.placeId == IslandProductConst.MinePlaceId then
				var_14_0:DispatchEvent(IslandBuildingAgency.COLLECT_SlOT_UNIT_INIT, {
					slotId = arg_14_0.recoverQueue[iter_14_0]
				})
			else
				var_14_0:DispatchEvent(IslandBuildingAgency.COLLECT_SlOT_UNIT_UPDATE, {
					slotId = arg_14_0.recoverQueue[iter_14_0]
				})
			end
		end
	end

	return
end

return var_0_0
