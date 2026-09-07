local MailTipsWindowMediator = class("MailTipsWindowMediator", import("view.base.ContextMediator"))

function MailTipsWindowMediator:register()
	return
end

function MailTipsWindowMediator:listNotificationInterests()
	return {}
end

function MailTipsWindowMediator:remove()
	if self.contextData.onClose then
		self.contextData.onClose()
	end

	return
end

function MailTipsWindowMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return MailTipsWindowMediator
