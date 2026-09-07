local Dorm3dInsMainMediator = class("Dorm3dInsMainMediator", import("view.base.ContextMediator"))

Dorm3dInsMainMediator.OPEN_CHAT = "Dorm3dInsMainMediator:OPEN_CHAT"
Dorm3dInsMainMediator.OPEN_JUUS = "Dorm3dInsMainMediator:OPEN_JUUS"
Dorm3dInsMainMediator.CLOSE_CHAT = "Dorm3dInsMainMediator:CLOSE_CHAT"
Dorm3dInsMainMediator.CLOSE_JUUS = "Dorm3dInsMainMediator:CLOSE_JUUS"
Dorm3dInsMainMediator.CHANGE_JUUS_TIP = "Dorm3dInsMainMediator:CHANGE_JUUS_TIP"
Dorm3dInsMainMediator.CHANGE_CHAT_TIP = "Dorm3dInsMainMediator:CHANGE_CHAT_TIP"
Dorm3dInsMainMediator.NotifyDormDelete = "Dorm3dInsMainMediator.NotifyDormDelete"
Dorm3dInsMainMediator.ON_UNLOCK_DORM_ROOM = "Dorm3dInsMainMediator.ON_UNLOCK_DORM_ROOM"
Dorm3dInsMainMediator.OPEN_INVITE_LAYER = "Dorm3dInsMainMediator.OPEN_INVITE_LAYER"
Dorm3dInsMainMediator.OPEN_ROOM_UNLOCK_WINDOW = "Dorm3dInsMainMediator.OPEN_ROOM_UNLOCK_WINDOW"
Dorm3dInsMainMediator.OPEN_PHONE = "Dorm3dInsMainMediator.OPEN_PHONE"
Dorm3dInsMainMediator.CLOSE_PHONE = "Dorm3dInsMainMediator.CLOSE_PHONE"

function Dorm3dInsMainMediator:register()
	self:bind(Dorm3dInsMainMediator.OPEN_CHAT, function(arg_2_0, arg_2_1)
		self:addSubLayers(Context.New({
			viewComponent = Dorm3dChatLayer,
			mediator = Dorm3dChatMediator,
			data = {
				chatId = arg_2_1,
				groupName = self.viewComponent:getGroupName()
			},
			onRemoved = function()
				self.viewComponent:OpenMain()

				return
			end
		}))

		return
	end)
	self:bind(Dorm3dInsMainMediator.OPEN_JUUS, function(arg_4_0, arg_4_1)
		self:addSubLayers(Context.New({
			viewComponent = Dorm3dInstagramLayer,
			mediator = Dorm3dInstagramMediator,
			data = {
				apartmentGroupId = arg_4_1,
				groupName = self.viewComponent:getGroupName()
			},
			onRemoved = function()
				self.viewComponent:OpenMain()

				return
			end
		}))

		return
	end)
	self:bind(Dorm3dInsMainMediator.OPEN_PHONE, function(arg_6_0, arg_6_1)
		self:addSubLayers(Context.New({
			viewComponent = Dorm3dInsPhoneLayer,
			mediator = Dorm3dInsPhoneMediator,
			data = {
				groupId = arg_6_1,
				groupName = self.viewComponent:getGroupName()
			},
			onRemoved = function()
				self.viewComponent:OpenMain()

				return
			end
		}))

		return
	end)
	self:bind(Dorm3dInsMainMediator.CLOSE_PHONE, function(arg_8_0, arg_8_1)
		self:removeSubLayers(Dorm3dInsPhoneMediator)

		return
	end)
	self:bind(Dorm3dInsMainMediator.CLOSE_CHAT, function(arg_9_0)
		self:removeSubLayers(Dorm3dChatMediator)

		return
	end)
	self:bind(Dorm3dInsMainMediator.CLOSE_JUUS, function(arg_10_0)
		self:sendNotification(Dorm3dInstagramMediator.BACK_PRESSED)
		self:removeSubLayers(Dorm3dInstagramMediator)

		return
	end)
	self:bind(Dorm3dInsMainMediator.NotifyDormDelete, function(arg_11_0, arg_11_1)
		self:sendNotification(Dorm3dInsMainMediator.NotifyDormDelete, arg_11_1)

		return
	end)
	self:bind(Dorm3dInsMainMediator.ON_UNLOCK_DORM_ROOM, function(arg_12_0, arg_12_1)
		self:sendNotification(GAME.APARTMENT_ROOM_UNLOCK, {
			roomId = arg_12_1
		})

		return
	end)
	self:bind(Dorm3dInsMainMediator.OPEN_ROOM_UNLOCK_WINDOW, function(arg_13_0, arg_13_1, arg_13_2)
		self:addSubLayers(Context.New({
			viewComponent = Dorm3dRoomUnlockWindow,
			mediator = Dorm3dRoomUnlockWindowMediator,
			data = {
				roomId = arg_13_1,
				groupId = arg_13_2
			},
			onRemoved = function()
				self.viewComponent:Flush()

				return
			end
		}))

		return
	end)

	return
end

function Dorm3dInsMainMediator:initNotificationHandleDic()
	self.handleDic = {
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

return Dorm3dInsMainMediator
