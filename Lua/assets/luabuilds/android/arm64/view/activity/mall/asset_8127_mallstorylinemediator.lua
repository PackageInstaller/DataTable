local MallStoryLineMediator = class("MallStoryLineMediator", import("view.base.ContextMediator"))

function MallStoryLineMediator:register()
	return
end

function MallStoryLineMediator:listNotificationInterests()
	return {}
end

function MallStoryLineMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

function MallStoryLineMediator:remove()
	return
end

return MallStoryLineMediator
