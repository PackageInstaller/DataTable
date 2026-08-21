local var_0_0 = class("IslandGatherUnitVO", import(".IslandUnitVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.nowIslandId = arg_1_0.index
	arg_1_0.gatherType = arg_1_0:GetType()

	arg_1_0:BindGatherData()

	return
end

function var_0_0.BindGatherData(arg_2_0)
	local var_2_0 = getProxy(IslandProxy)

	if arg_2_0.nowIslandId == var_2_0:GetIsland().id then
		local var_2_1 = getProxy(IslandProxy):GetIsland() or getProxy(IslandProxy):GetSharedIsland()
		local var_2_2 = var_2_1:GetWildCollectAgency()

		arg_2_0.gatherData = arg_2_0.gatherType == IslandConst.UNIT_TYPE_ITEM_GATHER_ITEM and var_2_2:GetGatherDataByUnitId(arg_2_0.id) or var_2_2:GetCollectDataByUnitId(arg_2_0.id)

		return
	end
end

function var_0_0.GetGatherData(arg_3_0)
	return arg_3_0.gatherData
end

return var_0_0
