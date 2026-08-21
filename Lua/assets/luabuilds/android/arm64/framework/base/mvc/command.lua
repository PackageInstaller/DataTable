ys = ys or {}

local var_0_0 = ys

ys.MVC = ys.MVC or {}
ys.MVC.Command = class("MVC.Command")
ys.MVC.Command.__name = "MVC.Command"

function ys.MVC.Command.Ctor(arg_1_0)
	return
end

function ys.MVC.Command.Initialize(arg_2_0)
	var_0_0.EventDispatcher.AttachEventDispatcher(arg_2_0)
	var_0_0.EventListener.AttachEventListener(arg_2_0)

	return
end

function ys.MVC.Command.Update(arg_3_0)
	return
end

function ys.MVC.Command.Dispose(arg_4_0)
	var_0_0.EventListener.DetachEventListener(arg_4_0)
	var_0_0.EventDispatcher.DetachEventDispatcher(arg_4_0)

	return
end

function ys.MVC.Command.GetState(arg_5_0)
	return arg_5_0._state
end

return
