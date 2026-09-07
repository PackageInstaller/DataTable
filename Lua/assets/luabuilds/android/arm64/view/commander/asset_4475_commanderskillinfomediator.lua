local CommanderSkillInfoMediator = class("CommanderSkillInfoMediator", import("..base.ContextMediator"))

function CommanderSkillInfoMediator:register()
	return
end

function CommanderSkillInfoMediator:listNotificationInterests()
	return {}
end

function CommanderSkillInfoMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return CommanderSkillInfoMediator
