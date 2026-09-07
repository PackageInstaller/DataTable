local PlayRoomMainMediator = class("PlayRoomMainMediator", import("view.base.ContextMediator"))

PlayRoomMainMediator.REFRESH_ROOM_LIST = "PlayRoomMainMediator:REFRESH_ROOM_LIST"
PlayRoomMainMediator.CREATE_ROOM = "PlayRoomMainMediator:CREATE_ROOM"
PlayRoomMainMediator.JOIN_ROOM = "PlayRoomMainMediator:JOIN_ROOM"

function PlayRoomMainMediator:register()
	self:bind(PlayRoomMainMediator.REFRESH_ROOM_LIST, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.PLAY_ROOM_REFRESH_ROOM)

		return
	end)
	self:bind(PlayRoomMainMediator.CREATE_ROOM, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.PLAY_ROOM_CREATE_ROOM, arg_3_1)

		return
	end)
	self:bind(PlayRoomMainMediator.JOIN_ROOM, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.PLAY_ROOM_JOIN_ROOM, arg_4_1)

		return
	end)

	return
end

function PlayRoomMainMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.PLAY_ROOM_REFRESH_ROOM_DONE] = function(arg_6_0, arg_6_1)
			local var_6_0 = arg_6_1:getName()
			local var_6_1 = arg_6_1:getBody()

			arg_6_0.viewComponent:RefreshUI()

			return
		end,
		[GAME.PLAY_ROOM_CREATE_ROOM_DONE] = function(arg_7_0, arg_7_1)
			arg_7_0.viewComponent:OnCreateRoomOver()
			arg_7_0:sendNotification(CheaterTavernEvent.PLAY_ROOM_LOAD_ROOM_SCENE, IslandCheaterTavernConst.SceneRoomType.CustomRoom)

			return
		end,
		[GAME.PLAY_ROOM_JOIN_ROOM_DONE] = function(arg_8_0, arg_8_1)
			arg_8_0:sendNotification(CheaterTavernEvent.PLAY_ROOM_LOAD_ROOM_SCENE, IslandCheaterTavernConst.SceneRoomType.CustomRoom)

			return
		end,
		[GAME.PLAY_ROOM_JOIN_ROOM_QUICK_FAIL] = function(arg_9_0, arg_9_1)
			arg_9_0.viewComponent:OnQuickRoomFail()

			return
		end,
		[GAME.PLAY_ROOM_ALL_LOAD_OVER] = function(arg_10_0, arg_10_1)
			arg_10_0.viewComponent:closeView()

			return
		end
	}

	return
end

function PlayRoomMainMediator:remove()
	return
end

return PlayRoomMainMediator
