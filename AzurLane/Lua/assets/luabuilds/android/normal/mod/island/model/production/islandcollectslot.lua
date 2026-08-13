class = var_0_10000

local var_0_0 = "IslandCollectSlot"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

var_0_1.slotType = {
	Task = 2,
	Normal = 1
}

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.placeId = arg_1_1

	arg_1_0:UpdateData(arg_1_2)

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.island_production_slot
end

function var_0_1.UpdateData(arg_3_0, arg_3_1)
	arg_3_0.configId = arg_3_1.id
	arg_3_0.pos = arg_3_1.pos
	arg_3_0.get_num = arg_3_1.get_num
	arg_3_0.refresh_time = arg_3_1.refresh_time
	pg = var_2

	local var_3_0 = var_2.island_set.mining_recovery_time.key_value_varchar

	pg = var_1_10003

	local var_3_1 = var_1_10003.island_set.mission_gather_point.key_value_varchar

	arg_3_0.type = var_0_1.slotType.Normal
	ipairs = var_4

	for iter_3_0, iter_3_1 in var_4(var_3_1) do
		if arg_3_0.configId == iter_3_1[1] then
			arg_3_0.type = var_0_1.slotType.Task
			arg_3_0.pos = iter_3_1[2]
		end
	end

	if arg_3_0.type == var_0_1.slotType.Normal then
		ipairs = var_4

		for iter_3_2, iter_3_3 in var_4(var_3_0) do
			if iter_3_3[1] == arg_3_0.configId then
				arg_3_0.cd = iter_3_3[2]
				arg_3_0.maxTimes = iter_3_3[3]
			end
		end
	end

	return
end

function var_0_1.UpdateCollectData(arg_4_0, arg_4_1, arg_4_2)
	getProxy = var_1_10003
	IslandProxy = var_1_10004

	local var_4_0 = var_1_10003(var_1_10004)
	local var_4_1 = var_3.GetIsland(var_4_0)

	if arg_4_2 == var_0_1.slotType.Task then
		local var_4_2 = var_4_1
		local var_4_3 = var_4_1.DispatchEvent

		IslandBuildingAgency = var_1_10006

		var_4_3(var_4_2, var_1_10006.COLLECT_SLOT_UNIT_REMOVE, {
			unitId = arg_4_0.pos
		})

		return
	end

	local var_4_4

	if arg_4_1.pos ~= arg_4_0.pos then
		local var_4_5 = var_4_1
		local var_4_6 = var_4_1.DispatchEvent

		IslandBuildingAgency = var_1_10007

		var_4_6(var_4_5, var_1_10007.COLLECT_SLOT_UNIT_REMOVE, {
			unitId = arg_4_0.pos
		})

		var_4_4 = true
	end

	arg_4_0:UpdateData(arg_4_1)

	if var_4_4 then
		arg_4_0:NotifyToLoadCollectSlotModel()
	end

	return
end

function var_0_1.StartColloct(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.m02
	local var_5_1 = var_1.sendNotification

	GAME = var_1_10003

	var_5_1(var_5_0, var_1_10003.ISLAND_START_COLLECT, {
		build_id = arg_5_0.placeId,
		area_id = arg_5_0.configId
	})

	return
end

function var_0_1.GetRecoverCD(arg_6_0)
	return arg_6_0.cd
end

function var_0_1.GetRecoverTime(arg_7_0)
	math = var_1_10001

	local var_7_0 = var_1_10001.floor

	math = var_1_10002

	local var_7_1 = var_1_10002.max

	pg = var_1_10003

	local var_7_2 = var_1_10003.TimeMgr.GetInstance()

	return (var_7_0(var_7_1(var_3.GetServerTime(var_7_2) - arg_7_0.refresh_time, 0) / arg_7_0:GetRecoverCD()))
end

function var_0_1.GetNextRecoverTimes(arg_8_0)
	return arg_8_0.refresh_time + (arg_8_0:GetRecoverTime() + 1) * arg_8_0:GetRecoverCD()
end

function var_0_1.GetCanCollectTime(arg_9_0)
	if arg_9_0.type == var_0_1.slotType.Task then
		return 1
	end

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.GetRecoverTime(var_9_0)

	math = var_9_0

	return var_9_0.min(arg_9_0.maxTimes, var_9_1 - arg_9_0.get_num + arg_9_0.maxTimes)
end

function var_0_1.GetCollectMaxTime(arg_10_0)
	if arg_10_0.type == var_0_1.slotType.Task then
		return 1
	end

	return arg_10_0.maxTimes
end

function var_0_1.NotifyToLoadCollectSlotModel(arg_11_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_11_0 = var_1_10001(var_1_10002)
	local var_11_1 = var_1.GetIsland(var_11_0)
	local var_11_2 = var_1.DispatchEvent

	IslandBuildingAgency = var_1_10004

	var_11_2(var_11_1, var_1_10004.COLLECT_SlOT_UNIT_INIT, {
		slotId = arg_11_0.configId
	})

	return
end

return var_0_1
