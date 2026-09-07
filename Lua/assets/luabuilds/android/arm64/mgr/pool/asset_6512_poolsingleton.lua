local PoolUtil = require("Mgr/Pool/PoolUtil")
local PoolSingleton = class("PoolSingleton")

function PoolSingleton:Ctor(arg_1_1)
	self.prefab = arg_1_1
	self.index = 0

	return
end

function PoolSingleton:Clear()
	PoolUtil.Destroy(self.prefab)

	self.prefab = nil
	self.index = 0

	return
end

return PoolSingleton
