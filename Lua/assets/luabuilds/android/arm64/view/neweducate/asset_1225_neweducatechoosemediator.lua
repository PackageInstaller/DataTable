local NewEducateChooseMediator = class("NewEducateChooseMediator", import("view.newEducate.base.NewEducateContextMediator"))

NewEducateChooseMediator.ON_REFRESH_CHOICE = "NewEducateChooseMediator.ON_REFRESH_CHOICE"
NewEducateChooseMediator.ON_MAKE_CHOICE = "NewEducateChooseMediator.ON_MAKE_CHOICE"
NewEducateChooseMediator.ON_GIVE_UP_CHOICE = "NewEducateChooseMediator.ON_GIVE_UP_CHOICE"

function NewEducateChooseMediator:register()
	self:bind(NewEducateChooseMediator.ON_REFRESH_CHOICE, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.NEW_EDUCATE_REFRESH_CHOICE, {
			id = self.contextData.char.id,
			idx = arg_2_1
		})

		return
	end)
	self:bind(NewEducateChooseMediator.ON_MAKE_CHOICE, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.NEW_EDUCATE_MAKE_CHOICE, {
			id = self.contextData.char.id,
			idx = arg_3_1
		})

		return
	end)
	self:bind(NewEducateChooseMediator.ON_GIVE_UP_CHOICE, function(arg_4_0)
		self:sendNotification(GAME.NEW_EDUCATE_GIVE_UP_CHOICE, {
			id = self.contextData.char.id
		})

		return
	end)

	return
end

function NewEducateChooseMediator:listNotificationInterests()
	return {
		GAME.NEW_EDUCATE_REFRESH_CHOICE_DONE,
		GAME.NEW_EDUCATE_MAKE_CHOICE_DONE,
		GAME.NEW_EDUCATE_GIVE_UP_CHOICE_DONE
	}
end

function NewEducateChooseMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == GAME.NEW_EDUCATE_REFRESH_CHOICE_DONE then
		self.viewComponent:OnRefreshDone(var_6_1)
	elseif var_6_0 == GAME.NEW_EDUCATE_MAKE_CHOICE_DONE then
		self.viewComponent:OnMakeChoiceDone(var_6_1)
	elseif var_6_0 == GAME.NEW_EDUCATE_GIVE_UP_CHOICE_DONE then
		self.viewComponent:OnGiveUpDone(var_6_1)
	end

	return
end

return NewEducateChooseMediator
