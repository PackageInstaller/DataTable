local PlayRoomEntranceMediator = class("PlayRoomEntranceMediator", import("view.base.ContextMediator"))

PlayRoomEntranceMediator.ON_CLICK_MATCH = "PlayRoomEntranceMediator:ON_CLICK_MATCH"
PlayRoomEntranceMediator.REFRESH_ROOM_INFO = "PlayRoomEntranceMediator:REFRESH_ROOM_INFO"
PlayRoomEntranceMediator.ON_CLICK_CHANGE_CHARACTER = "PlayRoomEntranceMediator:ON_CLICK_CHANGE_CHARACTER"

function PlayRoomEntranceMediator:register()
	self:bind(PlayRoomEntranceMediator.ON_CLICK_MATCH, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.PLAY_ROOM_CREATE_ROOM, arg_2_1)

		return
	end)
	self:bind(PlayRoomEntranceMediator.REFRESH_ROOM_INFO, function()
		self:sendNotification(GAME.PLAY_ROOM_REFRESH_ROOM_INFO)

		return
	end)
	self:bind(PlayRoomEntranceMediator.ON_CLICK_CHANGE_CHARACTER, function()
		self:sendNotification(CheaterTavernEvent.OPEN_SELECT_SHIP, IslandCheaterTavernConst.ChangeDressType.OutRoom)

		return
	end)

	return
end

function PlayRoomEntranceMediator:listNotificationInterests()
	return {
		GAME.PLAY_ROOM_CREATE_ROOM_DONE,
		GAME.PLAY_ROOM_START_GAME_DONE,
		GAME.PLAY_ROOM_EXIT_MATCH_READY_ROOM,
		GAME.PLAY_ROOM_REFRESH_ROOM_INFO_DONE,
		GAME.PLAY_ROOM_EXIT_ROOM_DONE
	}
end

function PlayRoomEntranceMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getBody()

	switch(arg_6_1:getName(), {
		[GAME.PLAY_ROOM_CREATE_ROOM_DONE] = function()
			if getProxy(PlayRoomProxy):GetRoomData().roomType == PlayRoomConst.PLAY_ROOM_TYPE.MATCH then
				self:sendNotification(GAME.PLAY_ROOM_START_GAME)
				self.viewComponent:OnStartMatch()
			end

			return
		end,
		[GAME.PLAY_ROOM_START_GAME_DONE] = function()
			return
		end,
		[GAME.PLAY_ROOM_EXIT_MATCH_READY_ROOM] = function()
			return
		end,
		[GAME.PLAY_ROOM_REFRESH_ROOM_INFO_DONE] = function()
			local var_10_0 = getProxy(PlayRoomProxy):GetRoomData()

			if var_10_0 then
				if var_10_0.roomState == PlayRoomConst.PLAY_ROOM_STATE.PLAYING then
					IslandCheaterTavernRecordTools.StartGame()
					self:sendNotification(GAME.PLAY_ROOM_LOAD_MINIGAME_SCENE, {
						isReconecting = true,
						mapId = IslandConst.CheaterTavernMapId
					})
				elseif var_10_0.roomType ~= PlayRoomConst.PLAY_ROOM_TYPE.MATCH then
					self:sendNotification(CheaterTavernEvent.PLAY_ROOM_LOAD_ROOM_SCENE, IslandCheaterTavernConst.SceneRoomType.CustomRoom)
				end
			end

			return
		end,
		[GAME.PLAY_ROOM_EXIT_ROOM_DONE] = function()
			self.viewComponent:OnStopMatch()

			return
		end
	})

	return
end

function PlayRoomEntranceMediator:remove()
	return
end

return PlayRoomEntranceMediator
