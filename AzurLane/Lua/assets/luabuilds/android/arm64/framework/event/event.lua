ys = ys or {}
ys.Event = class("Event")
ys.Event.__name = "Event"

function ys.Event.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.ID = arg_1_1
	arg_1_0.Data = arg_1_2
	arg_1_0.Dispatcher = arg_1_3

	return
end

return ys.Event
