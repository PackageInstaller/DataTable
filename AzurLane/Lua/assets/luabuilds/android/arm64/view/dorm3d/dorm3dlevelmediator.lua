local var_0_0 = class("Dorm3dLevelMediator", import("view.base.ContextMediator"))

var_0_0.CHANGE_SKIN = "Dorm3dLevelMediator.CHANGE_SKIN"
var_0_0.CHAMGE_TIME = "Dorm3dLevelMediator.CHAMGE_TIME"
var_0_0.ON_DROP_CLIENT = "Dorm3dLevelMediator.ON_DROP_CLIENT"
var_0_0.RENAME = "Dorm3dLevelMediator.RENAME"
var_0_0.RENAME_RESET = "Dorm3dLevelMediator.RENAME_RESET"
var_0_0.UPDATE_FAVOR_DISPLAY = "UpdateFavorDisplay"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.CHANGE_SKIN, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.APARTMENT_CHANGE_SKIN, {
			groupId = arg_2_1,
			skinId = arg_2_2
		})
		arg_1_0.viewComponent:closeView()

		return
	end)
	arg_1_0:bind(var_0_0.CHAMGE_TIME, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(Dorm3dRoomMediator.CHAMGE_TIME_RELOAD_SCENE, {
			timeIndex = arg_3_1
		})
		arg_1_0.viewComponent:closeView()

		return
	end)
	arg_1_0:bind(var_0_0.ON_DROP_CLIENT, function(arg_4_0, arg_4_1)
		pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_DROP_CLIENT, arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_0.RENAME, function(arg_5_0, arg_5_1, arg_5_2)
		arg_1_0:sendNotification(GAME.DORM_SET_CALL, {
			groupId = arg_5_1,
			callName = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.RENAME_RESET, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.DORM_SET_CALL, {
			callName = "",
			groupId = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.UPDATE_FAVOR_DISPLAY, function(arg_7_0)
		arg_1_0:sendNotification(Dorm3dRoomMediator.UPDATE_FAVOR_DISPLAY)

		return
	end)
	arg_1_0.viewComponent:SetApartment(arg_1_0.contextData.apartment)

	return
end

function var_0_0.initNotificationHandleDic(arg_8_0)
	arg_8_0.handleDic = {
		[GAME.DORM_SET_CALL_DONE] = function(arg_9_0, arg_9_1)
			arg_9_0.viewComponent:SetApartment(arg_9_1:getBody().apartment)
			arg_9_0.viewComponent:CloseRenameWindow()

			return
		end
	}

	return
end

function var_0_0.remove(arg_10_0)
	return
end

return var_0_0
