local var_0_0 = class("NewEducateTarotEntryMediator", import("view.newEducate.base.NewEducateContextMediator"))

var_0_0.ON_UPGRADE_ENTRY = "NewEducateTarotEntryMediator.ON_UPGRADE_ENTRY"
var_0_0.ON_GIVE_UP_ENTRY_UP = "NewEducateTarotEntryMediator.ON_GIVE_UP_ENTRY_UP"
var_0_0.ON_SHOPPING = "NewEducateTarotEntryMediator.ON_SHOPPING"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_UPGRADE_ENTRY, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_UPGRADE_ENTRY, {
			id = arg_1_0.contextData.char.id,
			entryId = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_GIVE_UP_ENTRY_UP, function(arg_3_0)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_GIVE_UP_ENTRY_UP, {
			id = arg_1_0.contextData.char.id
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SHOPPING, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_SHOPPING, {
			isUpgradeEntry = true,
			num = 1,
			id = arg_1_0.contextData.char.id,
			goodId = arg_4_1,
			callback = arg_4_2
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		GAME.NEW_EDUCATE_GIVE_UP_ENTRY_UP_DONE,
		GAME.NEW_EDUCATE_UPGRADE_ENTRY_DONE
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()

	if var_6_0 == GAME.NEW_EDUCATE_GIVE_UP_ENTRY_UP_DONE then
		arg_6_0.viewComponent:closeView()
	elseif var_6_0 == GAME.NEW_EDUCATE_UPGRADE_ENTRY_DONE then
		arg_6_0.viewComponent:OnUpgradeDone((arg_6_1:getBody()))
	end

	return
end

return var_0_0
