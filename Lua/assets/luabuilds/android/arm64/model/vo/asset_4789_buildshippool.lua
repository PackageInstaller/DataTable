local BuildShipPool = class("BuildShipPool", import(".BaseVO"))

BuildShipPool.BUILD_POOL_MARK_SPECIAL = "special"
BuildShipPool.BUILD_POOL_MARK_LIGHT = "light"
BuildShipPool.BUILD_POOL_MARK_HEAVY = "heavy"
BuildShipPool.BUILD_POOL_MARK_NEW = "new"

function BuildShipPool:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id

	assert(arg_1_1.mark)

	self.mark = arg_1_1.mark

	return
end

function BuildShipPool:bindConfigTable()
	return pg.ship_data_create_material
end

function BuildShipPool:GetPoolId()
	return self.configId
end

function BuildShipPool:GetSortCode()
	if self.mark == BuildShipPool.BUILD_POOL_MARK_SPECIAL then
		return 4
	elseif self.mark == BuildShipPool.BUILD_POOL_MARK_LIGHT then
		return 2
	elseif self.mark == BuildShipPool.BUILD_POOL_MARK_HEAVY then
		return 3
	elseif self.mark == BuildShipPool.BUILD_POOL_MARK_NEW then
		return 1
	else
		return 5
	end

	return
end

function BuildShipPool:IsActivity()
	return false
end

function BuildShipPool:GetMark()
	return self.mark
end

return BuildShipPool
