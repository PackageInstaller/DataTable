local EducateExtraAttrMediator = class("EducateExtraAttrMediator", import(".base.EducateContextMediator"))

EducateExtraAttrMediator.ON_ATTR_ADD = "EducateExtraAttrMediator:ON_ATTR_ADD"

function EducateExtraAttrMediator:register()
	self:bind(EducateExtraAttrMediator.ON_ATTR_ADD, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.EDUCATE_ADD_EXTRA_ATTR, {
			id = arg_2_1.id
		})

		return
	end)

	return
end

function EducateExtraAttrMediator:listNotificationInterests()
	return {
		GAME.EDUCATE_ADD_EXTRA_ATTR_DONE
	}
end

function EducateExtraAttrMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.EDUCATE_ADD_EXTRA_ATTR_DONE then
		self.viewComponent:closeview()
	end

	return
end

return EducateExtraAttrMediator
