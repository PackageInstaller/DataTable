class = var_0_10000

local var_0_0 = "NewEducateTarotEntryMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.newEducate.base.NewEducateContextMediator"))

var_0_1.ON_UPGRADE_ENTRY = "NewEducateTarotEntryMediator.ON_UPGRADE_ENTRY"
var_0_1.ON_GIVE_UP_ENTRY_UP = "NewEducateTarotEntryMediator.ON_GIVE_UP_ENTRY_UP"
var_0_1.ON_SHOPPING = "NewEducateTarotEntryMediator.ON_SHOPPING"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_UPGRADE_ENTRY, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.NEW_EDUCATE_UPGRADE_ENTRY, {
			id = arg_1_0.contextData.char.id,
			entryId = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_GIVE_UP_ENTRY_UP, function(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.sendNotification

		GAME = var_2_10003

		var_3_1(var_3_0, var_2_10003.NEW_EDUCATE_GIVE_UP_ENTRY_UP, {
			id = arg_1_0.contextData.char.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SHOPPING, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.NEW_EDUCATE_SHOPPING, {
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

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.NEW_EDUCATE_GIVE_UP_ENTRY_UP_DONE
	GAME = var_2
	var_5_0[2] = var_2.NEW_EDUCATE_UPGRADE_ENTRY_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1
	local var_6_2 = arg_6_1.getBody(var_6_1)

	GAME = var_6_1

	if var_6_0 == var_6_1.NEW_EDUCATE_GIVE_UP_ENTRY_UP_DONE then
		local var_6_3 = arg_6_0.viewComponent

		var_4.closeView(var_6_3)
	else
		GAME = var_4

		if var_6_0 == var_4.NEW_EDUCATE_UPGRADE_ENTRY_DONE then
			local var_6_4 = arg_6_0.viewComponent

			var_4.OnUpgradeDone(var_6_4, var_6_2)
		end
	end

	return
end

return var_0_1
