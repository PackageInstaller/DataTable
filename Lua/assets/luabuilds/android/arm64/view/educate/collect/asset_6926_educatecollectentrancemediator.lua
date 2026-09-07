local EducateCollectEntranceMediator = class("EducateCollectEntranceMediator", import("..base.EducateContextMediator"))

function EducateCollectEntranceMediator:register()
	return
end

function EducateCollectEntranceMediator:listNotificationInterests()
	return {
		EducateProxy.CLEAR_NEW_TIP
	}
end

function EducateCollectEntranceMediator:handleNotification(arg_3_1)
	if arg_3_1:getName() == EducateProxy.CLEAR_NEW_TIP and arg_3_1:getBody().index == EducateTipHelper.NEW_MEMORY then
		self.viewComponent:updateMemoryTip()
	end

	return
end

return EducateCollectEntranceMediator
