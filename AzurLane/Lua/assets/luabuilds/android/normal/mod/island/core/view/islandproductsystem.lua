class = var_0_10000

local var_0_0 = "IslandProductSystem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.Core.View.SceneObject.IslandSceneUnit"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.scheduleList = {}

	return
end

function var_0_1.OnStart(arg_2_0)
	local var_2_0 = arg_2_0.data
	local var_2_1 = var_1.GetDelegateSlotUnits(var_2_0)

	pairs = var_2_0

	for iter_2_0, iter_2_1 in var_2_0(var_2_1) do
		local var_2_2 = {
			commissionSlotId = iter_2_0,
			unitIds = iter_2_1
		}

		arg_2_0:StartDelegation(var_2_2)
	end

	return
end

function var_0_1.StartDelegation(arg_3_0, arg_3_1)
	table = var_1_10002

	var_1_10002.insert(arg_3_0.scheduleList, arg_3_1)

	return
end

function var_0_1.ExecuteDelegation(arg_4_0, arg_4_1)
	switch = var_1_10002

	local var_4_0 = arg_4_0.data.productPlaceId
	local var_4_1 = {}

	IslandProductConst = var_1_10005
	var_4_1[var_1_10005.FisheryPlaceId] = function()
		local var_5_0 = arg_4_0

		var_0.ExecuteDelegateFish(var_5_0, arg_4_1)

		return
	end

	var_1_10002(var_4_0, var_4_1)

	return
end

function var_0_1.ExecuteDelegateFish(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.commissionSlotId

	pg = var_1_10003

	local var_6_1 = var_1_10003.island_production_commission[var_6_0].performanceObjid
	local var_6_2 = arg_6_1.unitIds

	ipairs = var_1_10005

	for iter_6_0, iter_6_1 in var_1_10005(var_6_2) do
		local var_6_3 = arg_6_0:GetView()
		local var_6_4 = var_10.GetUnitModuleWithType

		IslandConst = var_1_10012

		if var_6_4(var_6_3, var_1_10012.UNIT_LIST_DELEGATE_UNIT, iter_6_1) then
			var_1_10012 = var_10

			var_10.SetFishPonds(var_1_10012, var_6_1)

			var_1_10012 = var_10

			var_10.StartFishing(var_1_10012)
		end
	end

	return
end

function var_0_1.EndDelegation(arg_7_0, arg_7_1)
	return
end

function var_0_1.OnUpdate(arg_8_0)
	if #arg_8_0.scheduleList <= 0 then
		return
	end

	local var_8_0 = arg_8_0:GetView()

	if not var_1.IsLoaded(var_8_0) then
		return
	end

	table = var_1

	local var_8_1 = var_1.remove(arg_8_0.scheduleList, 1)

	arg_8_0:ExecuteDelegation(var_8_1)

	return
end

function var_0_1.OnDestroy(arg_9_0)
	table = var_1_10001

	var_1_10001.clear(arg_9_0.scheduleList)

	return
end

return var_0_1
