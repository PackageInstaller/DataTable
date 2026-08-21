local var_0_0 = class("IslandWildGatherUnit", import(".IslandSceneUnit"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_0.GetHudInfo(arg_2_0)
	({}).needShowHud = true

	if arg_2_0.data.gatherType == IslandConst.UNIT_TYPE_ITEM_GATHER_ITEM then
		({}).name = pg.island_wild_gather[arg_2_0.data.gatherData.configId].name
		;({}).itemIcon = "island/" .. pg.island_wild_gather[arg_2_0.data.gatherData.configId].icon
	else
		local var_2_0 = pg.island_collect_fragment[arg_2_0.data.gatherData.configId]

		;({}).name = pg.island_collect_fragment[arg_2_0.data.gatherData.configId].name
		;({}).itemIcon = "island/" .. var_2_0.icon
	end

	return {}
end

function var_0_0.StartGather(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.data:GetGatherData()

	if not var_3_0 then
		return
	end

	if arg_3_0.data.gatherType == IslandConst.UNIT_TYPE_ITEM_GATHER_ITEM then
		var_3_0:StartGaher(arg_3_0.id, arg_3_1)
	else
		var_3_0:StartCollect(arg_3_0.id, arg_3_1)
	end

	return
end

function var_0_0.StartGaherSign(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.data:GetGatherData()

	if not var_4_0 then
		return
	end

	if arg_4_0.data.gatherType == IslandConst.UNIT_TYPE_ITEM_GATHER_ITEM then
		var_4_0:StartGaherSign(arg_4_0.id, arg_4_1)
	else
		var_4_0:StartCollectSign(arg_4_0.id, arg_4_1)
	end

	return
end

function var_0_0.CheckGatherCanSign(arg_5_0)
	local var_5_0 = arg_5_0.data:GetGatherData()

	if not var_5_0 then
		return false
	end

	if arg_5_0.data.gatherType == IslandConst.UNIT_TYPE_ITEM_GATHER_ITEM then
		return var_5_0:CheckGatherCanSign()
	else
		return var_5_0:StartCollectSign()
	end

	return
end

return var_0_0
