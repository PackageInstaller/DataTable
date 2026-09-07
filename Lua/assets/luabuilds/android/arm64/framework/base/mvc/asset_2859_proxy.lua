ys = ys or {}

local var_0_0 = ys

ys.MVC = ys.MVC or {}
ys.MVC.Proxy = singletonClass("MVC.Proxy")
ys.MVC.Proxy.__name = "MVC.Proxy"

function ys.MVC.Proxy.Ctor(arg_1_0)
	return
end

function ys.MVC.Proxy.ActiveProxy(arg_2_0)
	var_0_0.EventDispatcher.AttachEventDispatcher(arg_2_0)

	return
end

function ys.MVC.Proxy.DeactiveProxy(arg_3_0)
	var_0_0.EventDispatcher.DetachEventDispatcher(arg_3_0)

	return
end

return
