local IslandBtAssetPoolSet = class("IslandBtAssetPoolSet", import(".IslandObjectPoolSet"))

function IslandBtAssetPoolSet:CreatePool(arg_1_1, arg_1_2)
	return IslandBtAssetPool.New(self.root, arg_1_1, arg_1_2, self.poolCapacity)
end

return IslandBtAssetPoolSet
