local var_0_0 = class("IslandCollectSlotNew", import("model.vo.BaseVO"))

var_0_0.slotType = {
	Task = 2,
	Normal = 1
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.id = arg_1_2
	arg_1_0.configId = arg_1_0.id
	arg_1_0.placeData = arg_1_1
	arg_1_0.slotType = arg_1_3

	return
end

function var_0_0.UpdateData(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_0.id

	return
end

function var_0_0.GetCanCollectTimeStamps(arg_3_0)
	if arg_3_0.slotType == var_0_0.slotType.Task then
		return 0
	end

	if arg_3_0.placeData:GetCanCollectTime() >= arg_3_0.placeData:GetInRecoverTimeBySlotId(arg_3_0.id) then
		return 0
	end

	return arg_3_0.placeData:GetNextRecoverTimes()
end

function var_0_0.UpdateCollectData(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = getProxy(IslandProxy):GetIsland()

	if arg_4_2 == var_0_0.slotType.Task then
		var_4_0:DispatchEvent(IslandBuildingAgency.COLLECT_SLOT_UNIT_REMOVE, {
			slotId = arg_4_0.configId
		})

		return
	end

	if arg_4_0.placeData.placeId == IslandProductConst.MinePlaceId then
		var_4_0:DispatchEvent(IslandBuildingAgency.COLLECT_SLOT_UNIT_REMOVE, {
			slotId = arg_4_0.configId
		})
	end

	arg_4_0:UpdateData(arg_4_1)

	return
end

function var_0_0.StartColloct(arg_5_0)
	pg.m02:sendNotification(GAME.ISLAND_START_COLLECT, {
		build_id = arg_5_0.placeData.placeId,
		area_id = arg_5_0.configId,
		type = arg_5_0.slotType
	})

	return
end

return var_0_0
