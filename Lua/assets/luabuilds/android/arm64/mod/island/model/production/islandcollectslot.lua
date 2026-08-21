local var_0_0 = class("IslandCollectSlot", import("model.vo.BaseVO"))

var_0_0.slotType = {
	Task = 2,
	Normal = 1
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.placeId = arg_1_1

	arg_1_0:UpdateData(arg_1_2)

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.island_production_slot
end

function var_0_0.UpdateData(arg_3_0, arg_3_1)
	arg_3_0.configId = arg_3_1.id
	arg_3_0.pos = arg_3_1.pos
	arg_3_0.get_num = arg_3_1.get_num
	arg_3_0.refresh_time = arg_3_1.refresh_time
	arg_3_0.type = var_0_0.slotType.Normal

	for iter_3_0, iter_3_1 in ipairs(pg.island_set.mission_gather_point.key_value_varchar) do
		if arg_3_0.configId == iter_3_1[1] then
			arg_3_0.type = var_0_0.slotType.Task
			arg_3_0.pos = iter_3_1[2]
		end
	end

	if arg_3_0.type == var_0_0.slotType.Normal then
		for iter_3_2, iter_3_3 in ipairs(pg.island_set.mining_recovery_time.key_value_varchar) do
			if iter_3_3[1] == arg_3_0.configId then
				arg_3_0.cd = iter_3_3[2]
				arg_3_0.maxTimes = iter_3_3[3]
			end
		end
	end

	return
end

function var_0_0.UpdateCollectData(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = getProxy(IslandProxy):GetIsland()

	if arg_4_2 == var_0_0.slotType.Task then
		var_4_0:DispatchEvent(IslandBuildingAgency.COLLECT_SLOT_UNIT_REMOVE, {
			unitId = arg_4_0.pos
		})

		return
	end

	local var_4_1

	if arg_4_1.pos ~= arg_4_0.pos then
		var_4_0:DispatchEvent(IslandBuildingAgency.COLLECT_SLOT_UNIT_REMOVE, {
			unitId = arg_4_0.pos
		})

		var_4_1 = true
	end

	arg_4_0:UpdateData(arg_4_1)

	if var_4_1 then
		arg_4_0:NotifyToLoadCollectSlotModel()
	end

	return
end

function var_0_0.StartColloct(arg_5_0)
	pg.m02:sendNotification(GAME.ISLAND_START_COLLECT, {
		build_id = arg_5_0.placeId,
		area_id = arg_5_0.configId
	})

	return
end

function var_0_0.GetRecoverCD(arg_6_0)
	return arg_6_0.cd
end

function var_0_0.GetRecoverTime(arg_7_0)
	return (math.floor(math.max(pg.TimeMgr.GetInstance():GetServerTime() - arg_7_0.refresh_time, 0) / arg_7_0:GetRecoverCD()))
end

function var_0_0.GetNextRecoverTimes(arg_8_0)
	return arg_8_0.refresh_time + (arg_8_0:GetRecoverTime() + 1) * arg_8_0:GetRecoverCD()
end

function var_0_0.GetCanCollectTime(arg_9_0)
	if arg_9_0.type == var_0_0.slotType.Task then
		return 1
	end

	return math.min(arg_9_0.maxTimes, arg_9_0:GetRecoverTime() - arg_9_0.get_num + arg_9_0.maxTimes)
end

function var_0_0.GetCollectMaxTime(arg_10_0)
	if arg_10_0.type == var_0_0.slotType.Task then
		return 1
	end

	return arg_10_0.maxTimes
end

function var_0_0.NotifyToLoadCollectSlotModel(arg_11_0)
	getProxy(IslandProxy):GetIsland():DispatchEvent(IslandBuildingAgency.COLLECT_SlOT_UNIT_INIT, {
		slotId = arg_11_0.configId
	})

	return
end

return var_0_0
