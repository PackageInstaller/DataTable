local EducateCollectMediatorTemplate = class("EducateCollectMediatorTemplate", import("..base.EducateContextMediator"))

EducateCollectMediatorTemplate.UNLOCK = "EducateCollectMediatorTemplate.UNLOCK"

function EducateCollectMediatorTemplate:register()
	self:bind(EducateCollectMediatorTemplate.UNLOCK, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.EDUCATE_BUY_COLLECT, {
			type = arg_2_1.type,
			id = arg_2_1.id,
			cost = arg_2_1.cost
		})

		return
	end)

	return
end

function EducateCollectMediatorTemplate:listNotificationInterests()
	return {
		EducateProxy.CLEAR_NEW_TIP,
		GAME.EDUCATE_BUY_COLLECT_DONE
	}
end

function EducateCollectMediatorTemplate:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == EducateProxy.CLEAR_NEW_TIP then
		if var_4_1.index == EducateTipHelper.NEW_MEMORY or var_4_1.index == EducateTipHelper.NEW_POLAROID then
			self.viewComponent:Flush()
		end
	elseif var_4_0 == GAME.EDUCATE_BUY_COLLECT_DONE then
		self.viewComponent:Flush()
	end

	return
end

return EducateCollectMediatorTemplate
