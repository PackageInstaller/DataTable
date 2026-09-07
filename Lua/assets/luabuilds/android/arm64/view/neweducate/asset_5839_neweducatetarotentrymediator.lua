local NewEducateTarotEntryMediator = class("NewEducateTarotEntryMediator", import("view.newEducate.base.NewEducateContextMediator"))

NewEducateTarotEntryMediator.ON_UPGRADE_ENTRY = "NewEducateTarotEntryMediator.ON_UPGRADE_ENTRY"
NewEducateTarotEntryMediator.ON_GIVE_UP_ENTRY_UP = "NewEducateTarotEntryMediator.ON_GIVE_UP_ENTRY_UP"
NewEducateTarotEntryMediator.ON_SHOPPING = "NewEducateTarotEntryMediator.ON_SHOPPING"

function NewEducateTarotEntryMediator:register()
	self:bind(NewEducateTarotEntryMediator.ON_UPGRADE_ENTRY, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.NEW_EDUCATE_UPGRADE_ENTRY, {
			id = self.contextData.char.id,
			entryId = arg_2_1
		})

		return
	end)
	self:bind(NewEducateTarotEntryMediator.ON_GIVE_UP_ENTRY_UP, function(arg_3_0)
		self:sendNotification(GAME.NEW_EDUCATE_GIVE_UP_ENTRY_UP, {
			id = self.contextData.char.id
		})

		return
	end)
	self:bind(NewEducateTarotEntryMediator.ON_SHOPPING, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.NEW_EDUCATE_SHOPPING, {
			isUpgradeEntry = true,
			num = 1,
			id = self.contextData.char.id,
			goodId = arg_4_1,
			callback = arg_4_2
		})

		return
	end)

	return
end

function NewEducateTarotEntryMediator:listNotificationInterests()
	return {
		GAME.NEW_EDUCATE_GIVE_UP_ENTRY_UP_DONE,
		GAME.NEW_EDUCATE_UPGRADE_ENTRY_DONE
	}
end

function NewEducateTarotEntryMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()

	if var_6_0 == GAME.NEW_EDUCATE_GIVE_UP_ENTRY_UP_DONE then
		self.viewComponent:closeView()
	elseif var_6_0 == GAME.NEW_EDUCATE_UPGRADE_ENTRY_DONE then
		self.viewComponent:OnUpgradeDone((arg_6_1:getBody()))
	end

	return
end

return NewEducateTarotEntryMediator
