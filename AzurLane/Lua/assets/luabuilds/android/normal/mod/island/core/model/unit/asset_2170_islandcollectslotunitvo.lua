class = var_0_10000

local var_0_0 = "IslandCollectSlotUnitVO"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandUnitVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.isSelfIsland = arg_1_1.isSelfIsland
	arg_1_0.slotId = arg_1_1.slotId

	arg_1_0:BindSlotData()

	return
end

function var_0_1.BindSlotData(arg_2_0)
	arg_2_0.slotData = arg_2_0:HandCollectSlotData()

	return
end

function var_0_1.HandCollectSlotData(arg_3_0)
	local var_3_0

	if arg_3_0.isSelfIsland then
		getProxy = var_2
		IslandProxy = var_1_10003
		var_1_10003 = var_2(var_1_10003)
		var_1_10003 = var_2.GetIsland(var_1_10003)
		var_3_0 = var_2.GetBuildingAgency(var_1_10003)
	else
		getProxy = var_2
		IslandProxy = var_1_10003

		local var_3_1 = var_2(var_1_10003)
		local var_3_2 = var_2.GetSharedIsland(var_3_1)

		var_3_0 = var_2.GetBuildingAgency(var_3_2)
	end

	pg = var_2

	local var_3_3 = var_2.island_production_slot[arg_3_0.slotId].place

	if not var_3_0:GetBuilding(var_3_3) then
		return nil
	end

	if var_3:GetCollectSlotData(arg_3_0.slotId) then
		return var_4
	end

	return
end

return var_0_1
