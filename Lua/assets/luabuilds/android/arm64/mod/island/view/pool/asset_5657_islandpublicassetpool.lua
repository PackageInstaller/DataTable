local IslandPublicAssetPool = class("IslandPublicAssetPool", import(".IslandObjectPool"))

function IslandPublicAssetPool:CanDelete()
	return self:Isloaded()
end

function IslandPublicAssetPool:Dequeue()
	return self:NewItem()
end

function IslandPublicAssetPool:DequeueAsyn(arg_3_1)
	arg_3_1(self:NewItem())

	return
end

function IslandPublicAssetPool:NewItem()
	assert(self:Isloaded(), "call load first")

	return self.asset
end

function IslandPublicAssetPool:Enqueue(arg_5_1)
	return
end

return IslandPublicAssetPool
