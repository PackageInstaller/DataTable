local IslandAssetPool = class("IslandAssetPool", import(".IslandObjectPool"))

function IslandAssetPool:CanDelete()
	return self:Isloaded()
end

function IslandAssetPool:Dequeue()
	return self:NewItem()
end

function IslandAssetPool:DequeueAsyn(arg_3_1)
	arg_3_1(self:NewItem())

	return
end

function IslandAssetPool:Enqueue(arg_4_1)
	Object.Destroy(arg_4_1)

	return
end

return IslandAssetPool
