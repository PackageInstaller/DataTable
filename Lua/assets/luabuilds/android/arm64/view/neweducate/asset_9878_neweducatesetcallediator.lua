local NewEducateSetCallediator = class("NewEducateSetCallediator", import("view.newEducate.base.NewEducateContextMediator"))

NewEducateSetCallediator.ON_SET_CALL = "NewEducateSetCallediator:ON_SET_CALL"

function NewEducateSetCallediator:register()
	self:bind(NewEducateSetCallediator.ON_SET_CALL, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.NEW_EDUCATE_SET_CALL, {
			id = self.contextData.char.id,
			name = arg_2_1
		})

		return
	end)

	return
end

function NewEducateSetCallediator:listNotificationInterests()
	return {
		GAME.NEW_EDUCATE_SET_CALL_DONE
	}
end

function NewEducateSetCallediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.NEW_EDUCATE_SET_CALL_DONE then
		self.viewComponent:closeView()
	end

	return
end

return NewEducateSetCallediator
