class = var_0_10000

local var_0_0 = "Dorm3dInviteMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_DORM = "Dorm3dInviteMediator.ON_DORM"
var_0_1.ON_UNLOCK_DORM_ROOM = "Dorm3dInviteMediator.ON_UNLOCK_DORM_ROOM"
var_0_1.OPEN_ROOM_UNLOCK_WINDOW = "Dorm3dInviteMediator.OPEN_ROOM_UNLOCK_WINDOW"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_DORM, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		Dorm3dInviteMediator = var_2_10004

		var_2_1(var_2_0, var_2_10004.ON_DORM, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_ROOM_UNLOCK_WINDOW, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.addSubLayers

		Context = var_2_10005

		local var_3_2 = var_2_10005.New
		local var_3_3 = {}

		Dorm3dRoomUnlockWindow = var_2_10007
		var_3_3.viewComponent = var_2_10007
		Dorm3dRoomUnlockWindowMediator = var_2_10007
		var_3_3.mediator = var_2_10007
		var_3_3.data = {
			roomId = arg_3_1,
			groupId = arg_3_2
		}

		function var_3_3.onRemoved()
			local var_4_0 = arg_1_0.viewComponent

			var_0.ShowSelectPanel(var_4_0)

			return
		end

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)

	local var_1_0 = arg_1_0.viewComponent
	local var_1_1 = var_1.UpdateRoom

	getProxy = var_3
	ApartmentProxy = var_4

	local var_1_2 = var_3(var_4)

	var_1_1(var_1_0, var_3.getRoom(var_1_2, arg_1_0.contextData.roomId))

	return
end

function var_0_1.initNotificationHandleDic(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[var_1_10002.APARTMENT_ROOM_INVITE_UNLOCK_DONE] = function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_1:getBody()

		return
	end
	ApartmentProxy = var_2
	var_5_0[var_2.UPDATE_ROOM] = function(arg_7_0, arg_7_1)
		if arg_7_1:getBody().id == arg_7_0.contextData.roomId then
			local var_7_0 = arg_7_0.viewComponent

			var_3.UpdateRoom(var_7_0, var_2)
		end

		return
	end
	arg_5_0.handleDic = var_5_0

	return
end

return var_0_1
