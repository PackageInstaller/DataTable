class = var_0_10000

local var_0_0 = "EducateCharDockMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.GO_PROFILE = "EducateCharDockMediator:GO_PROFILE"
var_0_1.ON_SELECTED = "EducateCharDockMediator:ON_SELECTED"
var_0_1.ON_SKIN_SHOP = "EducateCharDockMediator.ON_SKIN_SHOP"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_SELECTED, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.CHANGE_EDUCATE, {
			id = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.GO_PROFILE, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_3_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_3_1(var_3_0, var_3_2, var_2_10005.EDUCATE_PROFILE, {
			selectedCharacterId = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SKIN_SHOP, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.sendNotification

		GAME = var_2_10003

		local var_4_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_4_1(var_4_0, var_4_2, var_2_10004.SKINSHOP, {
			skinId = arg_4_0
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.CLEAR_EDUCATE_TIP

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1
	local var_6_2 = arg_6_1.getBody(var_6_1)

	GAME = var_6_1

	if var_6_0 == var_6_1.CLEAR_EDUCATE_TIP then
		local var_6_3 = arg_6_0.viewComponent
		local var_6_4 = var_4.emit

		EducateCharDockScene = var_1_10006

		var_6_4(var_6_3, var_1_10006.MSG_CLEAR_TIP, var_6_2.id)
	end

	return
end

return var_0_1
