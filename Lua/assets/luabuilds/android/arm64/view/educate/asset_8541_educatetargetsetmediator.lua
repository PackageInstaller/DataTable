local EducateTargetSetMediator = class("EducateTargetSetMediator", import(".base.EducateContextMediator"))

EducateTargetSetMediator.ON_TARGET_SET = "EducateTargetSetMediator:ON_TARGET_SET"

function EducateTargetSetMediator:register()
	self:bind(EducateTargetSetMediator.ON_TARGET_SET, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.EDUCATE_SET_TARGET, {
			id = arg_2_1.id
		})

		return
	end)

	return
end

function EducateTargetSetMediator:listNotificationInterests()
	return {}
end

function EducateTargetSetMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return EducateTargetSetMediator
