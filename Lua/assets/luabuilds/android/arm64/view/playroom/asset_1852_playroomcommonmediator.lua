local PlayRoomCommonMediator = class("PlayRoomCommonMediator", import("view.base.ContextMediator"))

PlayRoomCommonMediator.ON_CLICK_MATCH = "PlayRoomCommonMediator::ON_CLICK_MATCH"
PlayRoomCommonMediator.REFRESH_ROOM_INFO = "PlayRoomCommonMediator::REFRESH_ROOM_INFO"
PlayRoomCommonMediator.PLAY_ROOM_MATCH_STOP = "PlayRoomCommonMediator::PLAY_ROOM_MATCH_STOP"
PlayRoomCommonMediator.ON_CLICK_READY = "PlayRoomCommonMediator::ON_CLICK_READY"
PlayRoomCommonMediator.ON_MATCH_CLICK_READY = "PlayRoomCommonMediator::ON_MATCH_CLICK_READY"
PlayRoomCommonMediator.ON_CLICK_QUICK_MATCH = "PlayRoomCommonMediator::ON_CLICK_QUICK_MATCH"

function PlayRoomCommonMediator:Ctor(...)
	PlayRoomCommonMediator.super.Ctor(self, ...)
	self:AppendPlayRoomNotificationHandleDic()

	return
end

function PlayRoomCommonMediator:onRegister()
	PlayRoomCommonMediator.super.onRegister(self)
	self:registerPlayRoom()

	return
end

function PlayRoomCommonMediator:AppendPlayRoomNotificationHandleDic()
	if self.handleDic == nil then
		return
	end

	for iter_3_0, iter_3_1 in pairs((self:initNotificationHandleDicPlayRoom())) do
		if self.handleDic[iter_3_0] == nil then
			self.handleDic[iter_3_0] = iter_3_1
		end
	end

	return
end

function PlayRoomCommonMediator:registerPlayRoom()
	self:bind(PlayRoomCommonMediator.ON_CLICK_MATCH, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.PLAY_ROOM_CREATE_ROOM, arg_5_1)

		return
	end)
	self:bind(PlayRoomCommonMediator.REFRESH_ROOM_INFO, function(arg_6_0)
		self:sendNotification(GAME.PLAY_ROOM_REFRESH_ROOM_INFO)

		return
	end)
	self:bind(PlayRoomCommonMediator.PLAY_ROOM_MATCH_STOP, function(arg_7_0)
		self:sendNotification(GAME.PLAY_ROOM_EXIT_ROOM, {
			arg = 0
		})

		return
	end)
	self:bind(PlayRoomCommonMediator.ON_CLICK_READY, function(arg_8_0, arg_8_1)
		self:sendNotification(GAME.PLAY_ROOM_READY, arg_8_1)

		return
	end)
	self:bind(PlayRoomCommonMediator.ON_MATCH_CLICK_READY, function(arg_9_0, arg_9_1)
		self:sendNotification(GAME.PLAY_ROOM_MATCH_READY, arg_9_1)

		return
	end)
	self:bind(PlayRoomCommonMediator.ON_CLICK_QUICK_MATCH, function(arg_10_0, arg_10_1)
		self:sendNotification(GAME.PLAY_ROOM_QUICK_MATCH, arg_10_1)

		return
	end)

	return
end

function PlayRoomCommonMediator:initNotificationHandleDicPlayRoom()
	return {
		[GAME.PLAY_ROOM_CREATE_ROOM_DONE] = function()
			if getProxy(PlayRoomProxy):GetRoomData().roomType == PlayRoomConst.PLAY_ROOM_TYPE.MATCH then
				self:sendNotification(GAME.PLAY_ROOM_START_GAME)
				existCall(self.viewComponent.OnStartMatch, self.viewComponent)
			end

			return
		end,
		[GAME.PLAY_ROOM_START_GAME_DONE] = function()
			return
		end,
		[GAME.PLAY_ROOM_EXIT_MATCH_READY_ROOM] = function()
			return
		end,
		[GAME.PLAY_ROOM_READY_DONE] = function(arg_15_0, arg_15_1)
			existCall(arg_15_0.viewComponent.RefreshUI, arg_15_0.viewComponent)

			return
		end,
		[GAME.PLAY_ROOM_MATCH_READY_DONE] = function(arg_16_0, arg_16_1)
			return
		end,
		[GAME.PLAY_ROOM_KICK_DONE] = function(arg_17_0, arg_17_1)
			existCall(arg_17_0.viewComponent.RefreshUI, arg_17_0.viewComponent)

			return
		end,
		[GAME.PLAY_ROOM_EXIT_MATCH_READY_ROOM] = function(arg_18_0, arg_18_1)
			arg_18_0:sendNotification(GAME.PLAY_ROOM_EXIT_ROOM)

			return
		end,
		[GAME.PLAY_ROOM_REFRESH_ROOM_INFO_DONE] = function()
			local var_19_0 = getProxy(PlayRoomProxy):GetRoomData()

			if var_19_0 then
				if var_19_0.roomState == PlayRoomConst.PLAY_ROOM_STATE.PLAYING then
					IslandCheaterTavernRecordTools.StartGame()
					self:sendNotification(GAME.PLAY_ROOM_LOAD_MINIGAME_SCENE, {
						isReconecting = true,
						mapId = IslandConst.CheaterTavernMapId
					})
				elseif var_19_0.roomType ~= PlayRoomConst.PLAY_ROOM_TYPE.MATCH then
					self:sendNotification(CheaterTavernEvent.PLAY_ROOM_LOAD_ROOM_SCENE, IslandCheaterTavernConst.SceneRoomType.CustomRoom)
				end
			end

			return
		end,
		[GAME.PLAY_ROOM_EXIT_ROOM_DONE] = function()
			existCall(self.viewComponent.OnStopMatch, self.viewComponent)

			return
		end,
		[GAME.PLAY_ROOM_QUICK_MATCH_DONE] = function()
			existCall(self.viewComponent.OnQuickMatch, self.viewComponent)

			return
		end,
		[GAME.PLAY_ROOM_QUICK_MATCH_SUCCESS] = function()
			existCall(self.viewComponent.OnQuickMatchSuccess, self.viewComponent)

			return
		end
	}
end

return PlayRoomCommonMediator
