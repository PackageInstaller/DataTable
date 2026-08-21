local var_0_0 = class("Dorm3dInsMainMediator", import("view.base.ContextMediator"))

var_0_0.OPEN_CHAT = "Dorm3dInsMainMediator:OPEN_CHAT"
var_0_0.OPEN_JUUS = "Dorm3dInsMainMediator:OPEN_JUUS"
var_0_0.CLOSE_CHAT = "Dorm3dInsMainMediator:CLOSE_CHAT"
var_0_0.CLOSE_JUUS = "Dorm3dInsMainMediator:CLOSE_JUUS"
var_0_0.CHANGE_JUUS_TIP = "Dorm3dInsMainMediator:CHANGE_JUUS_TIP"
var_0_0.CHANGE_CHAT_TIP = "Dorm3dInsMainMediator:CHANGE_CHAT_TIP"
var_0_0.NotifyDormDelete = "Dorm3dInsMainMediator.NotifyDormDelete"
var_0_0.ON_UNLOCK_DORM_ROOM = "Dorm3dInsMainMediator.ON_UNLOCK_DORM_ROOM"
var_0_0.OPEN_INVITE_LAYER = "Dorm3dInsMainMediator.OPEN_INVITE_LAYER"
var_0_0.OPEN_ROOM_UNLOCK_WINDOW = "Dorm3dInsMainMediator.OPEN_ROOM_UNLOCK_WINDOW"
var_0_0.OPEN_PHONE = "Dorm3dInsMainMediator.OPEN_PHONE"
var_0_0.CLOSE_PHONE = "Dorm3dInsMainMediator.CLOSE_PHONE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.OPEN_CHAT, function(arg_2_0, arg_2_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dChatLayer,
			mediator = Dorm3dChatMediator,
			data = {
				chatId = arg_2_1,
				groupName = arg_1_0.viewComponent:getGroupName()
			},
			onRemoved = function()
				arg_1_0.viewComponent:OpenMain()

				return
			end
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_JUUS, function(arg_4_0, arg_4_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dInstagramLayer,
			mediator = Dorm3dInstagramMediator,
			data = {
				apartmentGroupId = arg_4_1,
				groupName = arg_1_0.viewComponent:getGroupName()
			},
			onRemoved = function()
				arg_1_0.viewComponent:OpenMain()

				return
			end
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_PHONE, function(arg_6_0, arg_6_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dInsPhoneLayer,
			mediator = Dorm3dInsPhoneMediator,
			data = {
				groupId = arg_6_1,
				groupName = arg_1_0.viewComponent:getGroupName()
			},
			onRemoved = function()
				arg_1_0.viewComponent:OpenMain()

				return
			end
		}))

		return
	end)
	arg_1_0:bind(var_0_0.CLOSE_PHONE, function(arg_8_0, arg_8_1)
		arg_1_0:removeSubLayers(Dorm3dInsPhoneMediator)

		return
	end)
	arg_1_0:bind(var_0_0.CLOSE_CHAT, function(arg_9_0)
		arg_1_0:removeSubLayers(Dorm3dChatMediator)

		return
	end)
	arg_1_0:bind(var_0_0.CLOSE_JUUS, function(arg_10_0)
		arg_1_0:sendNotification(Dorm3dInstagramMediator.BACK_PRESSED)
		arg_1_0:removeSubLayers(Dorm3dInstagramMediator)

		return
	end)
	arg_1_0:bind(var_0_0.NotifyDormDelete, function(arg_11_0, arg_11_1)
		arg_1_0:sendNotification(var_0_0.NotifyDormDelete, arg_11_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_UNLOCK_DORM_ROOM, function(arg_12_0, arg_12_1)
		arg_1_0:sendNotification(GAME.APARTMENT_ROOM_UNLOCK, {
			roomId = arg_12_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_ROOM_UNLOCK_WINDOW, function(arg_13_0, arg_13_1, arg_13_2)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dRoomUnlockWindow,
			mediator = Dorm3dRoomUnlockWindowMediator,
			data = {
				roomId = arg_13_1,
				groupId = arg_13_2
			},
			onRemoved = function()
				arg_1_0.viewComponent:Flush()

				return
			end
		}))

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_15_0)
	arg_15_0.handleDic = {
		[DormGroupConst.NotifyDormDownloadStart] = function(arg_16_0, arg_16_1)
			local var_16_0 = arg_16_1:getBody()

			arg_16_0.viewComponent:DownloadUpdate(DormGroupConst.DormDownloadLock.roomId, "start")

			return
		end,
		[DormGroupConst.NotifyDormDownloadProgress] = function(arg_17_0, arg_17_1)
			local var_17_0 = arg_17_1:getBody()

			arg_17_0.viewComponent:DownloadUpdate(DormGroupConst.DormDownloadLock.roomId, "loading")

			return
		end,
		[DormGroupConst.NotifyDormDownloadFinish] = function(arg_18_0, arg_18_1)
			arg_18_0.viewComponent:DownloadUpdate(arg_18_1:getBody(), "finish")

			return
		end,
		[Dorm3dInsMainMediator.NotifyDormDelete] = function(arg_19_0, arg_19_1)
			arg_19_0.viewComponent:DownloadUpdate(arg_19_1:getBody(), "delete")

			return
		end,
		[GAME.APARTMENT_CHAT_OP_DONE] = function(arg_20_0)
			arg_20_0.viewComponent:FlushLeft()

			return
		end,
		[GAME.APARTMENT_INS_OP_DONE] = function(arg_21_0)
			arg_21_0.viewComponent:FlushLeft()

			return
		end
	}

	return
end

return var_0_0
