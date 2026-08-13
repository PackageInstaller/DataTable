ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1

if not var_0.MVC then
	var_0_1 = {}
end

var_0.MVC = var_0_1

local var_0_2 = var_0.MVC

singletonClass = var_0_10002
var_0_2.Proxy = var_0_10002("MVC.Proxy")
var_0.MVC.Proxy.__name = "MVC.Proxy"

function var_0.MVC.Proxy.Ctor(arg_1_0)
	return
end

function var_0.MVC.Proxy.ActiveProxy(arg_2_0)
	var_0.EventDispatcher.AttachEventDispatcher(arg_2_0)

	return
end

function var_0.MVC.Proxy.DeactiveProxy(arg_3_0)
	var_0.EventDispatcher.DetachEventDispatcher(arg_3_0)

	return
end

return
