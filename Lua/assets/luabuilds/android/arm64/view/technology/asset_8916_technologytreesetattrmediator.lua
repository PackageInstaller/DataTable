local TechnologyTreeSetAttrMediator = class("TechnologyTreeSetAttrMediator", import("..base.ContextMediator"))

function TechnologyTreeSetAttrMediator:register()
	return
end

function TechnologyTreeSetAttrMediator:listNotificationInterests()
	return {
		TechnologyConst.SET_TEC_ATTR_ADDITION_FINISH
	}
end

function TechnologyTreeSetAttrMediator:handleNotification(arg_3_1)
	if arg_3_1:getName() == TechnologyConst.SET_TEC_ATTR_ADDITION_FINISH then
		if arg_3_1:getBody().onSuccess then
			arg_3_1:getBody().onSuccess()
		end
	end

	return
end

return TechnologyTreeSetAttrMediator
