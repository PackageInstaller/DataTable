local NewEducateScheduleResultMediator = class("NewEducateScheduleResultMediator", import("view.newEducate.base.NewEducateContextMediator"))

function NewEducateScheduleResultMediator:register()
	return
end

function NewEducateScheduleResultMediator:listNotificationInterests()
	return {}
end

function NewEducateScheduleResultMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return NewEducateScheduleResultMediator
