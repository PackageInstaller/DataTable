local var_0_0 = class("Dorm3dBaseMediator", import("view.base.ContextMediator"))

function var_0_0.GetDefaultSystemClasses()
	return DormConst.GetDefaultSystemClasses()
end

function var_0_0.handleNotification(arg_2_0, arg_2_1)
	var_0_0.super.handleNotification(arg_2_0, arg_2_1)

	if arg_2_0.viewComponent.systemManager then
		arg_2_0.viewComponent.systemManager:BroadcastNotification(arg_2_1:getName(), (arg_2_1:getBody()))
	end

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	local var_3_0 = arg_3_0.handleDic or {}
	local var_3_1 = underscore.keys(var_3_0)

	if arg_3_0.viewComponent and arg_3_0.viewComponent.systemManager then
		var_3_1 = table.mergeArray(var_3_1, arg_3_0.viewComponent.systemManager:GetAllInterests(), true)
	else
		for iter_3_0, iter_3_1 in ipairs((arg_3_0.GetDefaultSystemClasses())) do
			if iter_3_1.GetInterests then
				var_3_1 = table.mergeArray(var_3_1, iter_3_1.GetInterests())
			end
		end
	end

	return var_3_1
end

return var_0_0
