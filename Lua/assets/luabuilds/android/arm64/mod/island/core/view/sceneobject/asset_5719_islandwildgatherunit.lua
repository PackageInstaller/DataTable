local IslandWildGatherUnit = class("IslandWildGatherUnit", import(".IslandSceneUnit"))

function IslandWildGatherUnit:Ctor(arg_1_1, arg_1_2)
	IslandWildGatherUnit.super.Ctor(self, arg_1_1, arg_1_2)

	return
end

function IslandWildGatherUnit:GetHudInfo()
	local var_2_0 = {}

	var_2_0.needShowHud = true

	if self.data.gatherType == IslandConst.UNIT_TYPE_ITEM_GATHER_ITEM then
		var_2_0.name = pg.island_wild_gather[self.data.gatherData.configId].name
		var_2_0.itemIcon = "island/" .. pg.island_wild_gather[self.data.gatherData.configId].icon
	else
		var_2_0.name = pg.island_collect_fragment[self.data.gatherData.configId].name
		var_2_0.itemIcon = "island/" .. pg.island_collect_fragment[self.data.gatherData.configId].icon
	end

	return var_2_0
end

function IslandWildGatherUnit:StartGather(arg_3_1)
	local var_3_0 = self.data:GetGatherData()

	if not var_3_0 then
		return
	end

	if self.data.gatherType == IslandConst.UNIT_TYPE_ITEM_GATHER_ITEM then
		var_3_0:StartGaher(self.id, arg_3_1)
	else
		var_3_0:StartCollect(self.id, arg_3_1)
	end

	return
end

function IslandWildGatherUnit:StartGaherSign(arg_4_1)
	local var_4_0 = self.data:GetGatherData()

	if not var_4_0 then
		return
	end

	if self.data.gatherType == IslandConst.UNIT_TYPE_ITEM_GATHER_ITEM then
		var_4_0:StartGaherSign(self.id, arg_4_1)
	else
		var_4_0:StartCollectSign(self.id, arg_4_1)
	end

	return
end

function IslandWildGatherUnit:CheckGatherCanSign()
	local var_5_0 = self.data:GetGatherData()

	if not var_5_0 then
		return false
	end

	if self.data.gatherType == IslandConst.UNIT_TYPE_ITEM_GATHER_ITEM then
		return var_5_0:CheckGatherCanSign()
	else
		return var_5_0:StartCollectSign()
	end

	return
end

return IslandWildGatherUnit
