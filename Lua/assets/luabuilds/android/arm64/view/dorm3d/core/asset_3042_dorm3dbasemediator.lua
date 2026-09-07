local Dorm3dBaseMediator = class("Dorm3dBaseMediator", import("view.base.ContextMediator"))

function Dorm3dBaseMediator.GetDefaultSystemClasses()
	return DormConst.GetDefaultSystemClasses()
end

function Dorm3dBaseMediator:handleNotification(arg_2_1)
	Dorm3dBaseMediator.super.handleNotification(self, arg_2_1)

	if self.viewComponent.systemManager then
		self.viewComponent.systemManager:BroadcastNotification(arg_2_1:getName(), (arg_2_1:getBody()))
	end

	return
end

function Dorm3dBaseMediator:listNotificationInterests()
	local var_3_1 = underscore.keys(self.handleDic or {})

	if self.viewComponent and self.viewComponent.systemManager then
		var_3_1 = table.mergeArray(var_3_1, self.viewComponent.systemManager:GetAllInterests(), true)
	else
		for iter_3_0, iter_3_1 in ipairs((self.GetDefaultSystemClasses())) do
			if iter_3_1.GetInterests then
				var_3_1 = table.mergeArray(var_3_1, iter_3_1.GetInterests())
			end
		end
	end

	return var_3_1
end

return Dorm3dBaseMediator
