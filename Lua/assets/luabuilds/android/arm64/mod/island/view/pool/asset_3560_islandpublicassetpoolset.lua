local IslandPublicAssetPoolSet = class("IslandPublicAssetPoolSet", import(".IslandObjectPoolSet"))

function IslandPublicAssetPoolSet:CreatePool(arg_1_1, arg_1_2)
	return IslandPublicAssetPool.New(self.root, arg_1_1, arg_1_2, self.poolCapacity)
end

function IslandPublicAssetPoolSet:ReturnObject(arg_2_1, arg_2_2)
	local var_2_0 = self:RawGetPool(arg_2_1)

	if not var_2_0 then
		return
	end

	var_2_0:Enqueue(arg_2_2)

	return
end

return IslandPublicAssetPoolSet
