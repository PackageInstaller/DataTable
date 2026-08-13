class = var_0_10000

local var_0_0 = "IslandGatherUnitVO"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandUnitVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.nowIslandId = arg_1_0.index
	arg_1_0.gatherType = arg_1_0:GetType()

	arg_1_0:BindGatherData()

	return
end

function var_0_1.BindGatherData(arg_2_0)
	local var_2_0 = arg_2_0.nowIslandId

	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_2_1 = var_1_10002(var_1_10004)

	if var_2_0 == var_2.GetIsland(var_2_1).id then
		getProxy = var_2_3
		IslandProxy = var_2_1
		var_2_1 = var_2_3(var_2_1)

		local var_2_3

		if not var_2_3.GetIsland(var_2_1) then
			getProxy = var_2_3
			IslandProxy = var_2_1

			local var_2_2 = var_2_3(var_2_1)

			var_2_3 = var_2_3.GetSharedIsland(var_2_2)
		end

		local var_2_4 = var_2_3
		local var_2_5 = var_2_3.GetWildCollectAgency(var_2_4)
		local var_2_6 = arg_2_0.gatherType

		IslandConst = var_2_4

		if var_2_6 == var_2_4.UNIT_TYPE_ITEM_GATHER_ITEM then
			arg_2_0.gatherData = var_2_5:GetGatherDataByUnitId(arg_2_0.id)
		else
			arg_2_0.gatherData = var_2_5:GetCollectDataByUnitId(arg_2_0.id)
		end

		return
	end
end

function var_0_1.GetGatherData(arg_3_0)
	return arg_3_0.gatherData
end

return var_0_1
