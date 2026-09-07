local NewSkinShowMediator = class("NewSkinShowMediator", import("...base.ContextMediator"))

function NewSkinShowMediator:register()
	return
end

function NewSkinShowMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED
	}
end

function NewSkinShowMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getBody()

	if arg_3_1:getName() == PlayerProxy.UPDATED then
		self.viewComponent:SetResource()
	end

	return
end

return NewSkinShowMediator
