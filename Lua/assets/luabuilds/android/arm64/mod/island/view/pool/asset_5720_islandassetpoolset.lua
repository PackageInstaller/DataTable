local IslandAssetPoolSet = class("IslandAssetPoolSet", import(".IslandObjectPoolSet"))

function IslandAssetPoolSet:CreatePool(arg_1_1, arg_1_2)
	return IslandAssetPool.New(self.root, arg_1_1, arg_1_2, self.poolCapacity)
end

return IslandAssetPoolSet
