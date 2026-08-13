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

class = var_0_10002
var_0_2.Mediator = var_0_10002("MVC.Mediator")
var_0.MVC.Mediator.__name = "MVC.Mediator"

function var_0.MVC.Mediator.Ctor(arg_1_0)
	return
end

function var_0.MVC.Mediator.Initialize(arg_2_0)
	var_0.EventDispatcher.AttachEventDispatcher(arg_2_0)
	var_0.EventListener.AttachEventListener(arg_2_0)

	return
end

function var_0.MVC.Mediator.Update(arg_3_0)
	return
end

function var_0.MVC.Mediator.UpdatePause(arg_4_0)
	return
end

function var_0.MVC.Mediator.Dispose(arg_5_0)
	var_0.EventListener.DetachEventListener(arg_5_0)
	var_0.EventDispatcher.DetachEventDispatcher(arg_5_0)

	return
end

function var_0.MVC.Mediator.GetState(arg_6_0)
	return arg_6_0._state
end

return
