local MallStaffMediator = class("MallStaffMediator", import("view.base.ContextMediator"))

function MallStaffMediator:register()
	return
end

function MallStaffMediator:listNotificationInterests()
	return {
		GAME.ACTIVITY_MALL_OP_DONE
	}
end

function MallStaffMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getBody()

	if arg_3_1:getName() == GAME.ACTIVITY_MALL_OP_DONE then
		self.viewComponent:UpdateData()
		self.viewComponent:UpdateView()
	end

	return
end

return MallStaffMediator
