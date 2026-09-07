local IslandRootTplPool = class("IslandRootTplPool", import(".IslandPoolBase"))

function IslandRootTplPool:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.root = arg_1_1
	self.pool = IslandObjectPool.New(self.root, arg_1_2, typeof(GameObject), arg_1_4)

	return
end

function IslandRootTplPool:Init(arg_2_1)
	if self.pool:Isloaded() then
		arg_2_1()

		return
	end

	self.pool:Load(arg_2_1)

	return
end

function IslandRootTplPool:GetObject()
	return self.pool:Dequeue()
end

function IslandRootTplPool:ReturnObject(arg_4_1)
	self.pool:Enqueue(arg_4_1)

	return
end

function IslandRootTplPool:Clear()
	self.pool:Clear()

	return
end

function IslandRootTplPool:Dispose()
	self.pool:Dispose()

	return
end

return IslandRootTplPool
