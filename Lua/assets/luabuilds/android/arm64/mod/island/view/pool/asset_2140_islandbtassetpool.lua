local IslandBtAssetPool = class("IslandBtAssetPool", import(".IslandObjectPool"))

function IslandBtAssetPool:CanDelete()
	return self:Isloaded()
end

function IslandBtAssetPool:Dequeue()
	return self:NewItem()
end

function IslandBtAssetPool:DequeueAsyn(arg_3_1)
	assert(self:Isloaded(), "call load first")
	arg_3_1(Object.Instantiate(self.asset))

	return
end

function IslandBtAssetPool:Enqueue(arg_4_1)
	return
end

return IslandBtAssetPool
