class = var_0_10000

local var_0_0 = "Dorm3dInsMainMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.OPEN_CHAT = "Dorm3dInsMainMediator:OPEN_CHAT"
var_0_1.OPEN_JUUS = "Dorm3dInsMainMediator:OPEN_JUUS"
var_0_1.CLOSE_CHAT = "Dorm3dInsMainMediator:CLOSE_CHAT"
var_0_1.CLOSE_JUUS = "Dorm3dInsMainMediator:CLOSE_JUUS"
var_0_1.CHANGE_JUUS_TIP = "Dorm3dInsMainMediator:CHANGE_JUUS_TIP"
var_0_1.CHANGE_CHAT_TIP = "Dorm3dInsMainMediator:CHANGE_CHAT_TIP"
var_0_1.NotifyDormDelete = "Dorm3dInsMainMediator.NotifyDormDelete"
var_0_1.ON_UNLOCK_DORM_ROOM = "Dorm3dInsMainMediator.ON_UNLOCK_DORM_ROOM"
var_0_1.OPEN_INVITE_LAYER = "Dorm3dInsMainMediator.OPEN_INVITE_LAYER"
var_0_1.OPEN_ROOM_UNLOCK_WINDOW = "Dorm3dInsMainMediator.OPEN_ROOM_UNLOCK_WINDOW"
var_0_1.OPEN_PHONE = "Dorm3dInsMainMediator.OPEN_PHONE"
var_0_1.CLOSE_PHONE = "Dorm3dInsMainMediator.CLOSE_PHONE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OPEN_CHAT, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_2_2 = var_2_10004.New
		local var_2_3 = {}

		Dorm3dChatLayer = var_2_10006
		var_2_3.viewComponent = var_2_10006
		Dorm3dChatMediator = var_2_10006
		var_2_3.mediator = var_2_10006

		local var_2_4 = {
			chatId = arg_2_1
		}
		local var_2_5 = arg_1_0.viewComponent

		var_2_4.groupName = var_7.getGroupName(var_2_5)
		var_2_3.data = var_2_4

		function var_2_3.onRemoved()
			local var_3_0 = arg_1_0.viewComponent

			var_0.OpenMain(var_3_0)

			return
		end

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_JUUS, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_4_2 = var_2_10004.New
		local var_4_3 = {}

		Dorm3dInstagramLayer = var_2_10006
		var_4_3.viewComponent = var_2_10006
		Dorm3dInstagramMediator = var_2_10006
		var_4_3.mediator = var_2_10006

		local var_4_4 = {
			apartmentGroupId = arg_4_1
		}
		local var_4_5 = arg_1_0.viewComponent

		var_4_4.groupName = var_7.getGroupName(var_4_5)
		var_4_3.data = var_4_4

		function var_4_3.onRemoved()
			local var_5_0 = arg_1_0.viewComponent

			var_0.OpenMain(var_5_0)

			return
		end

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_PHONE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_6_2 = var_2_10004.New
		local var_6_3 = {}

		Dorm3dInsPhoneLayer = var_2_10006
		var_6_3.viewComponent = var_2_10006
		Dorm3dInsPhoneMediator = var_2_10006
		var_6_3.mediator = var_2_10006

		local var_6_4 = {
			groupId = arg_6_1
		}
		local var_6_5 = arg_1_0.viewComponent

		var_6_4.groupName = var_7.getGroupName(var_6_5)
		var_6_3.data = var_6_4

		function var_6_3.onRemoved()
			local var_7_0 = arg_1_0.viewComponent

			var_0.OpenMain(var_7_0)

			return
		end

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)
	arg_1_0:bind(var_0_1.CLOSE_PHONE, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.removeSubLayers

		Dorm3dInsPhoneMediator = var_2_10004

		var_8_1(var_8_0, var_2_10004)

		return
	end)
	arg_1_0:bind(var_0_1.CLOSE_CHAT, function(arg_9_0)
		local var_9_0 = arg_1_0
		local var_9_1 = var_1.removeSubLayers

		Dorm3dChatMediator = var_2_10003

		var_9_1(var_9_0, var_2_10003)

		return
	end)
	arg_1_0:bind(var_0_1.CLOSE_JUUS, function(arg_10_0)
		local var_10_0 = arg_1_0
		local var_10_1 = var_1.sendNotification

		Dorm3dInstagramMediator = var_2_10003

		var_10_1(var_10_0, var_2_10003.BACK_PRESSED)

		local var_10_2 = arg_1_0
		local var_10_3 = var_1.removeSubLayers

		Dorm3dInstagramMediator = var_3

		var_10_3(var_10_2, var_3)

		return
	end)
	arg_1_0:bind(var_0_1.NotifyDormDelete, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_1_0

		var_2.sendNotification(var_11_0, var_0_1.NotifyDormDelete, arg_11_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_UNLOCK_DORM_ROOM, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_1_0
		local var_12_1 = var_2.sendNotification

		GAME = var_2_10004

		var_12_1(var_12_0, var_2_10004.APARTMENT_ROOM_UNLOCK, {
			roomId = arg_12_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_ROOM_UNLOCK_WINDOW, function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = arg_1_0
		local var_13_1 = var_3.addSubLayers

		Context = var_2_10005

		local var_13_2 = var_2_10005.New
		local var_13_3 = {}

		Dorm3dRoomUnlockWindow = var_2_10007
		var_13_3.viewComponent = var_2_10007
		Dorm3dRoomUnlockWindowMediator = var_2_10007
		var_13_3.mediator = var_2_10007
		var_13_3.data = {
			roomId = arg_13_1,
			groupId = arg_13_2
		}

		function var_13_3.onRemoved()
			local var_14_0 = arg_1_0.viewComponent

			var_0.Flush(var_14_0)

			return
		end

		var_13_1(var_13_0, var_13_2(var_13_3))

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_15_0)
	local var_15_0 = {}

	DormGroupConst = var_1_10002
	var_15_0[var_1_10002.NotifyDormDownloadStart] = function(arg_16_0, arg_16_1)
		local var_16_0 = arg_16_1:getBody()
		local var_16_1 = arg_16_0.viewComponent
		local var_16_2 = var_3.DownloadUpdate

		DormGroupConst = var_2_10005

		var_16_2(var_16_1, var_2_10005.DormDownloadLock.roomId, "start")

		return
	end
	DormGroupConst = var_2
	var_15_0[var_2.NotifyDormDownloadProgress] = function(arg_17_0, arg_17_1)
		local var_17_0 = arg_17_1:getBody()
		local var_17_1 = arg_17_0.viewComponent
		local var_17_2 = var_3.DownloadUpdate

		DormGroupConst = var_2_10005

		var_17_2(var_17_1, var_2_10005.DormDownloadLock.roomId, "loading")

		return
	end
	DormGroupConst = var_2
	var_15_0[var_2.NotifyDormDownloadFinish] = function(arg_18_0, arg_18_1)
		local var_18_0 = arg_18_0.viewComponent

		var_2.DownloadUpdate(var_18_0, arg_18_1:getBody(), "finish")

		return
	end
	Dorm3dInsMainMediator = var_2
	var_15_0[var_2.NotifyDormDelete] = function(arg_19_0, arg_19_1)
		local var_19_0 = arg_19_0.viewComponent

		var_2.DownloadUpdate(var_19_0, arg_19_1:getBody(), "delete")

		return
	end
	GAME = var_2
	var_15_0[var_2.APARTMENT_CHAT_OP_DONE] = function(arg_20_0)
		local var_20_0 = arg_20_0.viewComponent

		var_1.FlushLeft(var_20_0)

		return
	end
	GAME = var_2
	var_15_0[var_2.APARTMENT_INS_OP_DONE] = function(arg_21_0)
		local var_21_0 = arg_21_0.viewComponent

		var_1.FlushLeft(var_21_0)

		return
	end
	arg_15_0.handleDic = var_15_0

	return
end

return var_0_1
