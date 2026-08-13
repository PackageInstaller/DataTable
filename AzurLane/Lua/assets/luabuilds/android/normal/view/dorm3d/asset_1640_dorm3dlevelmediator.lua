class = var_0_10000

local var_0_0 = "Dorm3dLevelMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.CHANGE_SKIN = "Dorm3dLevelMediator.CHANGE_SKIN"
var_0_1.CHAMGE_TIME = "Dorm3dLevelMediator.CHAMGE_TIME"
var_0_1.ON_DROP_CLIENT = "Dorm3dLevelMediator.ON_DROP_CLIENT"
var_0_1.RENAME = "Dorm3dLevelMediator.RENAME"
var_0_1.RENAME_RESET = "Dorm3dLevelMediator.RENAME_RESET"
var_0_1.UPDATE_FAVOR_DISPLAY = "UpdateFavorDisplay"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.CHANGE_SKIN, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.APARTMENT_CHANGE_SKIN, {
			groupId = arg_2_1,
			skinId = arg_2_2
		})

		local var_2_2 = arg_1_0.viewComponent

		var_3.closeView(var_2_2)

		return
	end)
	arg_1_0:bind(var_0_1.CHAMGE_TIME, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		Dorm3dRoomMediator = var_2_10004

		var_3_1(var_3_0, var_2_10004.CHAMGE_TIME_RELOAD_SCENE, {
			timeIndex = arg_3_1
		})

		local var_3_2 = arg_1_0.viewComponent

		var_2.closeView(var_3_2)

		return
	end)
	arg_1_0:bind(var_0_1.ON_DROP_CLIENT, function(arg_4_0, arg_4_1)
		pg = var_2_10002

		local var_4_0 = var_2_10002.NewStyleMsgboxMgr.GetInstance()
		local var_4_1 = var_2.Show

		pg = var_2_10004

		var_4_1(var_4_0, var_2_10004.NewStyleMsgboxMgr.TYPE_DROP_CLIENT, arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_1.RENAME, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.DORM_SET_CALL, {
			groupId = arg_5_1,
			callName = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.RENAME_RESET, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		var_6_1(var_6_0, var_2_10004.DORM_SET_CALL, {
			callName = "",
			groupId = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.UPDATE_FAVOR_DISPLAY, function(arg_7_0)
		local var_7_0 = arg_1_0
		local var_7_1 = var_1.sendNotification

		Dorm3dRoomMediator = var_2_10003

		var_7_1(var_7_0, var_2_10003.UPDATE_FAVOR_DISPLAY)

		return
	end)

	local var_1_0 = arg_1_0.viewComponent

	var_1.SetApartment(var_1_0, arg_1_0.contextData.apartment)

	return
end

function var_0_1.initNotificationHandleDic(arg_8_0)
	local var_8_0 = {}

	GAME = var_1_10002
	var_8_0[var_1_10002.DORM_SET_CALL_DONE] = function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_1:getBody()
		local var_9_1 = arg_9_0.viewComponent

		var_3.SetApartment(var_9_1, var_9_0.apartment)

		local var_9_2 = arg_9_0.viewComponent

		var_3.CloseRenameWindow(var_9_2)

		return
	end
	arg_8_0.handleDic = var_8_0

	return
end

function var_0_1.remove(arg_10_0)
	return
end

return var_0_1
