class = var_0_10000

local var_0_0 = "IslandWildGatherUnit"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandSceneUnit"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_1.GetHudInfo(arg_2_0)
	local var_2_0 = {}

	var_2_0.needShowHud = true

	local var_2_1 = arg_2_0.data.gatherType

	IslandConst = var_1_10003

	if var_2_1 == var_1_10003.UNIT_TYPE_ITEM_GATHER_ITEM then
		pg = var_2_1
		var_2_0.name = var_2_1.island_wild_gather[arg_2_0.data.gatherData.configId].name
		var_2_0.itemIcon = "island/" .. var_2_1.icon
	else
		pg = var_2_1
		var_2_0.name = var_2_1.island_collect_fragment[arg_2_0.data.gatherData.configId].name
		var_2_0.itemIcon = "island/" .. var_2.icon
	end

	return var_2_0
end

function var_0_1.StartGather(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.data

	if not var_2.GetGatherData(var_3_0) then
		return
	end

	local var_3_1 = arg_3_0.data.gatherType

	IslandConst = var_3_0

	if var_3_1 == var_3_0.UNIT_TYPE_ITEM_GATHER_ITEM then
		var_2:StartGaher(arg_3_0.id, arg_3_1)
	else
		var_2:StartCollect(arg_3_0.id, arg_3_1)
	end

	return
end

function var_0_1.StartGaherSign(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.data

	if not var_2.GetGatherData(var_4_0) then
		return
	end

	local var_4_1 = arg_4_0.data.gatherType

	IslandConst = var_4_0

	if var_4_1 == var_4_0.UNIT_TYPE_ITEM_GATHER_ITEM then
		var_2:StartGaherSign(arg_4_0.id, arg_4_1)
	else
		var_2:StartCollectSign(arg_4_0.id, arg_4_1)
	end

	return
end

function var_0_1.CheckGatherCanSign(arg_5_0)
	local var_5_0 = arg_5_0.data

	if not var_1.GetGatherData(var_5_0) then
		return false
	end

	local var_5_1 = arg_5_0.data.gatherType

	IslandConst = var_5_0

	if var_5_1 == var_5_0.UNIT_TYPE_ITEM_GATHER_ITEM then
		return var_1:CheckGatherCanSign()
	else
		return var_1:StartCollectSign()
	end

	return
end

return var_0_1
