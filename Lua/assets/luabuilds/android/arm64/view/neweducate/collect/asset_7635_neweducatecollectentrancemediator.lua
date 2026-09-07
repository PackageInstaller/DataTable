local NewEducateCollectEntranceMediator = class("NewEducateCollectEntranceMediator", import("view.base.ContextMediator"))

NewEducateCollectEntranceMediator.GO_SUBLAYER = "NewEducateCollectEntranceMediator.GO_SUBLAYER"

function NewEducateCollectEntranceMediator:register()
	self:bind(NewEducateCollectEntranceMediator.GO_SUBLAYER, function(arg_2_0, arg_2_1, arg_2_2)
		self:addSubLayers(arg_2_1, nil, arg_2_2)

		return
	end)

	return
end

function NewEducateCollectEntranceMediator:listNotificationInterests()
	return {
		EducateProxy.CLEAR_NEW_TIP
	}
end

function NewEducateCollectEntranceMediator:handleNotification(arg_4_1)
	if arg_4_1:getName() == EducateProxy.CLEAR_NEW_TIP and arg_4_1:getBody().index == EducateTipHelper.NEW_MEMORY then
		self.viewComponent:UpdateMemoryTip()
	end

	return
end

return NewEducateCollectEntranceMediator
