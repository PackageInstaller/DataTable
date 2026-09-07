local CommanderSkillMediator = class("CommanderSkillMediator", import("..base.ContextMediator"))

function CommanderSkillMediator:register()
	if self.contextData.isWorld then
		self.contextData.commonFlag = false
	end

	return
end

function CommanderSkillMediator:listNotificationInterests()
	return {}
end

function CommanderSkillMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return CommanderSkillMediator
