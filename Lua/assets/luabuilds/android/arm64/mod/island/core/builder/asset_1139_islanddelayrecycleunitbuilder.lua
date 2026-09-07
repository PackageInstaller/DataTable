local IslandDelayRecycleUnitBuilder = class("IslandDelayRecycleUnitBuilder", import(".IslandBaseBuilder"))

IslandDelayRecycleUnitBuilder.RecycleType = {
	NormalSceneItem = 1,
	ProductEffect = 2
}

function IslandDelayRecycleUnitBuilder:GetModule(arg_1_1, arg_1_2)
	return IslandDelayRecycleUnit.New(arg_1_1, arg_1_2)
end

function IslandDelayRecycleUnitBuilder:Load(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1:GetAssetPath()

	if arg_2_1.recycleAssetType == IslandDelayRecycleUnitBuilder.RecycleType.NormalSceneItem then
		self:GetPoolMgr():GetSceneProductItem(var_2_0, arg_2_2)
	elseif arg_2_1.recycleAssetType == IslandDelayRecycleUnitBuilder.RecycleType.ProductEffect then
		self:GetPoolMgr():GetSceneProductEffect(var_2_0, arg_2_2)
	end

	return
end

function IslandDelayRecycleUnitBuilder:Recycle(arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1:GetAssetPath()

	if arg_3_1.recycleAssetType == IslandDelayRecycleUnitBuilder.RecycleType.NormalSceneItem then
		self:GetPoolMgr():ReturnSceneProductItem(var_3_0, arg_3_2)
	elseif arg_3_1.recycleAssetType == IslandDelayRecycleUnitBuilder.RecycleType.ProductEffect then
		self:GetPoolMgr():ReturnSceneProductEffect(var_3_0, arg_3_2)
	end

	return
end

return IslandDelayRecycleUnitBuilder
