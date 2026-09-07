ys = ys or {}

local var_0_0 = ys

ys.MVC = ys.MVC or {}
ys.MVC.Mediator = class("MVC.Mediator")
ys.MVC.Mediator.__name = "MVC.Mediator"

function ys.MVC.Mediator.Ctor(arg_1_0)
	return
end

function ys.MVC.Mediator.Initialize(arg_2_0)
	var_0_0.EventDispatcher.AttachEventDispatcher(arg_2_0)
	var_0_0.EventListener.AttachEventListener(arg_2_0)

	return
end

function ys.MVC.Mediator.Update(arg_3_0)
	return
end

function ys.MVC.Mediator.UpdatePause(arg_4_0)
	return
end

function ys.MVC.Mediator.Dispose(arg_5_0)
	var_0_0.EventListener.DetachEventListener(arg_5_0)
	var_0_0.EventDispatcher.DetachEventDispatcher(arg_5_0)

	return
end

function ys.MVC.Mediator:GetState()
	return self._state
end

return
