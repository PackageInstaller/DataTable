class = var_0_10000

local var_0_0 = "NewEducateChooseMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.newEducate.base.NewEducateContextMediator"))

var_0_1.ON_REFRESH_CHOICE = "NewEducateChooseMediator.ON_REFRESH_CHOICE"
var_0_1.ON_MAKE_CHOICE = "NewEducateChooseMediator.ON_MAKE_CHOICE"
var_0_1.ON_GIVE_UP_CHOICE = "NewEducateChooseMediator.ON_GIVE_UP_CHOICE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_REFRESH_CHOICE, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.NEW_EDUCATE_REFRESH_CHOICE, {
			id = arg_1_0.contextData.char.id,
			idx = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_MAKE_CHOICE, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.NEW_EDUCATE_MAKE_CHOICE, {
			id = arg_1_0.contextData.char.id,
			idx = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_GIVE_UP_CHOICE, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.sendNotification

		GAME = var_2_10003

		var_4_1(var_4_0, var_2_10003.NEW_EDUCATE_GIVE_UP_CHOICE, {
			id = arg_1_0.contextData.char.id
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.NEW_EDUCATE_REFRESH_CHOICE_DONE
	GAME = var_2
	var_5_0[2] = var_2.NEW_EDUCATE_MAKE_CHOICE_DONE
	GAME = var_2
	var_5_0[3] = var_2.NEW_EDUCATE_GIVE_UP_CHOICE_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1
	local var_6_2 = arg_6_1.getBody(var_6_1)

	GAME = var_6_1

	if var_6_0 == var_6_1.NEW_EDUCATE_REFRESH_CHOICE_DONE then
		local var_6_3 = arg_6_0.viewComponent

		var_4.OnRefreshDone(var_6_3, var_6_2)
	else
		GAME = var_4

		if var_6_0 == var_4.NEW_EDUCATE_MAKE_CHOICE_DONE then
			local var_6_4 = arg_6_0.viewComponent

			var_4.OnMakeChoiceDone(var_6_4, var_6_2)
		else
			GAME = var_4

			if var_6_0 == var_4.NEW_EDUCATE_GIVE_UP_CHOICE_DONE then
				local var_6_5 = arg_6_0.viewComponent

				var_4.OnGiveUpDone(var_6_5, var_6_2)
			end
		end
	end

	return
end

return var_0_1
