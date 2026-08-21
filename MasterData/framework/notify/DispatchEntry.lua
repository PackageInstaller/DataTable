module("framework.notify.DispatchEntry", package.seeall)

local var_0_0 = class("DispatchEntry")

function var_0_0._poolCreateFunc()
	return var_0_0.New()
end

function var_0_0._poolDisposeFunc(arg_2_0)
	return
end

function var_0_0._poolResetFunc(arg_3_0)
	arg_3_0:reset()
end

function var_0_0.initPool()
	var_0_0._pool = ObjectPool.New(10, var_0_0._poolCreateFunc, var_0_0._poolDisposeFunc, var_0_0._poolResetFunc)
end

function var_0_0.getPool()
	return var_0_0._pool
end

function var_0_0.ctor(arg_6_0)
	arg_6_0:reset()
end

function var_0_0.reset(arg_7_0)
	arg_7_0.name = 0
	arg_7_0.message = nil
end

return var_0_0
