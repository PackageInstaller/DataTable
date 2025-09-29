module("frameworkext.unit.component.mover.NavWayPoint", package.seeall)

local var_0_0 = class("NavWayPoint")

function var_0_0._poolCreateFunc()
	return {}
end

function var_0_0.initPool()
	var_0_0._pool = ObjectPool.New(100, var_0_0._poolCreateFunc, nil, nil)
end

function var_0_0.getPool()
	return var_0_0._pool
end

return var_0_0
