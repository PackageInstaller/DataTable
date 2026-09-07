local NewEducateSelEndingMediator = class("NewEducateSelEndingMediator", import("view.newEducate.base.NewEducateContextMediator"))

NewEducateSelEndingMediator.ON_SELECT_ENDING = "NewEducateSelEndingMediator:ON_SELECT_ENDING"

function NewEducateSelEndingMediator:register()
	self:bind(NewEducateSelEndingMediator.ON_SELECT_ENDING, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.NEW_EDUCATE_SEL_ENDING, {
			id = self.contextData.char.id,
			endingId = arg_2_1
		})

		return
	end)

	return
end

function NewEducateSelEndingMediator:listNotificationInterests()
	return {
		GAME.NEW_EDUCATE_SEL_ENDING_DONE
	}
end

function NewEducateSelEndingMediator:handleNotification(arg_4_1)
	if arg_4_1:getName() == GAME.NEW_EDUCATE_SEL_ENDING_DONE then
		self.viewComponent:OnSelDone(arg_4_1:getBody().id)
	end

	return
end

return NewEducateSelEndingMediator
