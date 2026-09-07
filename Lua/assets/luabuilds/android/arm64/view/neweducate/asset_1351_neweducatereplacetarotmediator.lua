local NewEducateReplaceTarotMediator = class("NewEducateReplaceTarotMediator", import("view.newEducate.base.NewEducateContextMediator"))

NewEducateReplaceTarotMediator.ON_REPLACE_TAROT = "NewEducateReplaceTarotMediator.ON_REPLACE_TAROT"

function NewEducateReplaceTarotMediator:register()
	self:bind(NewEducateReplaceTarotMediator.ON_REPLACE_TAROT, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.NEW_EDUCATE_REPLACE_TAROT, {
			id = self.contextData.char.id,
			tarotId = arg_2_1
		})

		return
	end)

	return
end

function NewEducateReplaceTarotMediator:listNotificationInterests()
	return {
		GAME.NEW_EDUCATE_REPLACE_TAROT_DONE
	}
end

function NewEducateReplaceTarotMediator:handleNotification(arg_4_1)
	if arg_4_1:getName() == GAME.NEW_EDUCATE_REPLACE_TAROT_DONE then
		self.viewComponent:OnReplaceDone((arg_4_1:getBody()))
	end

	return
end

return NewEducateReplaceTarotMediator
