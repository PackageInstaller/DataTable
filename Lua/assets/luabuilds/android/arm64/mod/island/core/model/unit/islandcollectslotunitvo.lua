local var_0_0 = class("IslandCollectSlotUnitVO", import(".IslandUnitVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.isSelfIsland = arg_1_1.isSelfIsland
	arg_1_0.slotId = arg_1_1.slotId

	arg_1_0:BindSlotData()

	return
end

function var_0_0.BindSlotData(arg_2_0)
	arg_2_0.slotData = arg_2_0:HandCollectSlotData()

	return
end

function var_0_0.HandCollectSlotData(arg_3_0)
	local var_3_0 = arg_3_0.isSelfIsland and getProxy(IslandProxy):GetIsland():GetBuildingAgency() or getProxy(IslandProxy):GetSharedIsland():GetBuildingAgency()
	local var_3_1 = var_3_0:GetBuilding(pg.island_production_slot[arg_3_0.slotId].place)

	if not var_3_1 then
		return nil
	end

	local var_3_2 = var_3_1:GetCollectSlotData(arg_3_0.slotId)

	if var_3_2 then
		return var_3_2
	end

	return
end

return var_0_0
