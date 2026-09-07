local MsgboxMediator = class("MsgboxMediator", import("view.base.ContextMediator"))

function MsgboxMediator:register()
	return
end

function MsgboxMediator:listNotificationInterests()
	return {}
end

function MsgboxMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getBody()

	if arg_3_1:getName() == nil then
		-- block empty
	end

	return
end

function MsgboxMediator:remove()
	return
end

function MsgboxMediator:ShowMsgBox()
	LoadContextCommand.LoadLayerOnTopContext(Context.New({
		mediator = MsgboxMediator,
		viewComponent = MsgboxLayer,
		data = self
	}))

	return
end

return MsgboxMediator
