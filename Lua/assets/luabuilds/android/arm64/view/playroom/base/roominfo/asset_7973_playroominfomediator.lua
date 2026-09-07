local PlayRoomInfoMediator = class("PlayRoomInfoMediator", import("view.base.ContextMediator"))

PlayRoomInfoMediator.ON_CLICK_VIEWER = "PlayRoomInfoMediator::ON_CLICK_VIEWER"
PlayRoomInfoMediator.ON_CLICK_READY = "PlayRoomInfoMediator::ON_CLICK_READY"
PlayRoomInfoMediator.ON_CLICK_KICK = "PlayRoomInfoMediator::ON_CLICK_KICK"
PlayRoomInfoMediator.ON_CLICK_INVITE = "PlayRoomInfoMediator::ON_CLICK_INVITE"
PlayRoomInfoMediator.ON_CLICK_CLOSE = "PlayRoomInfoMediator::ON_CLICK_CLOSE"
PlayRoomInfoMediator.ON_CLICK_START_GAME = "PlayRoomInfoMediaotr::ON_CLICK_START_GAME"
PlayRoomInfoMediator.ON_CLICK_CHANGE_CHARACTER = "PlayRoomInfoMediaotr::ON_CLICK_CHANGE_CHARACTER"
PlayRoomInfoMediator.ON_SWITCH_ROOM_TYPE = "PlayRoomInfoMediator.ON_SWITCH_ROOM_TYPE"
PlayRoomInfoMediator.ON_MATCH_CLICK_READY = "PlayRoomInfoMediaotr:ON_MATCH_CLICK_READY"

function PlayRoomInfoMediator:register()
	self:bind(PlayRoomInfoMediator.ON_CLICK_VIEWER, function()
		self:addSubLayers(Context.New({
			mediator = PlayRoomInfoViewerMediator,
			viewComponent = PlayRoomInfoViewerScene
		}))

		return
	end)
	self:bind(PlayRoomInfoMediator.ON_CLICK_INVITE, function()
		self:addSubLayers(Context.New({
			mediator = PlayRoomInfoInviteMediator,
			viewComponent = PlayRoomInfoInviteScene
		}))

		return
	end)
	self:bind(PlayRoomInfoMediator.ON_CLICK_READY, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.PLAY_ROOM_READY, arg_4_1)

		return
	end)
	self:bind(PlayRoomInfoMediator.ON_CLICK_KICK, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.PLAY_ROOM_KICK, arg_5_1)

		return
	end)
	self:bind(PlayRoomInfoMediator.ON_CLICK_CLOSE, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.PLAY_ROOM_EXIT_ROOM)

		return
	end)
	self:bind(PlayRoomInfoMediator.ON_CLICK_START_GAME, function(arg_7_0, arg_7_1)
		self:sendNotification(GAME.PLAY_ROOM_START_GAME)

		return
	end)
	self:bind(PlayRoomInfoMediator.ON_CLICK_CHANGE_CHARACTER, function(arg_8_0, arg_8_1)
		self:sendNotification(CheaterTavernEvent.OPEN_SELECT_SHIP, IslandCheaterTavernConst.ChangeDressType.InRoom)

		return
	end)
	self:bind(PlayRoomInfoMediator.ON_SWITCH_ROOM_TYPE, function(arg_9_0)
		self:sendNotification(GAME.PLAY_ROOM_SWITCH_ROOM_TYPE)

		return
	end)
	self:bind(PlayRoomInfoMediator.ON_MATCH_CLICK_READY, function(arg_10_0, arg_10_1)
		self:sendNotification(GAME.PLAY_ROOM_MATCH_READY, arg_10_1)

		return
	end)

	return
end

function PlayRoomInfoMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.PLAY_ROOM_READY_DONE] = function(arg_12_0, arg_12_1)
			arg_12_0.viewComponent:RefreshUI()

			return
		end,
		[GAME.PLAY_ROOM_SWITCH_VIEWER_DONE] = function(arg_13_0, arg_13_1)
			arg_13_0.viewComponent:RefreshUI()

			return
		end,
		[GAME.PLAY_ROOM_KICK_DONE] = function(arg_14_0, arg_14_1)
			arg_14_0.viewComponent:RefreshUI()

			return
		end,
		[GAME.PLAY_ROOM_EXIT_ROOM_DONE] = function(arg_15_0, arg_15_1)
			arg_15_0.viewComponent:closeView()

			return
		end,
		[GAME.PLAY_ROOM_START_GAME_DONE] = function(arg_16_0, arg_16_1)
			return
		end,
		[GAME.PLAY_ROOM_REDAY_ROOM_REFRESH] = function(arg_17_0, arg_17_1)
			arg_17_0.viewComponent:RefreshUI()

			return
		end,
		[GAME.PLAY_ROOM_MATCH_READY_DONE] = function(arg_18_0, arg_18_1)
			return
		end,
		[GAME.PLAY_ROOM_MATCH_REDAY_ROOM_REFRESH] = function(arg_19_0, arg_19_1)
			arg_19_0.viewComponent:RefreshMatchInfoUI()

			return
		end,
		[GAME.PLAY_ROOM_EXIT_MATCH_READY_ROOM] = function(arg_20_0, arg_20_1)
			arg_20_0:sendNotification(GAME.PLAY_ROOM_EXIT_ROOM)

			return
		end,
		[GAME.PLAY_ROOM_CLOSE_MATCH_READY] = function(arg_21_0, arg_21_1)
			arg_21_0:sendNotification(GAME.PLAY_ROOM_LOAD_MINIGAME_SCENE, {
				mapId = IslandConst.CheaterTavernMapId
			})
			arg_21_0.viewComponent:EnterLoadInfoUI()

			return
		end,
		[GAME.PLAY_ROOM_ALL_LOAD_OVER] = function(arg_22_0, arg_22_1)
			return
		end,
		[GAME.PLAY_ROOM_SWITCH_ROOM_TYPE_DONE] = function(arg_23_0, arg_23_1)
			arg_23_0.viewComponent:RefreshUI()

			return
		end,
		[ChatProxy.NEW_MSG] = function(arg_24_0, arg_24_1)
			arg_24_0.viewComponent:RefreshMessage()

			return
		end,
		[FriendProxy.FRIEND_NEW_MSG] = function(arg_25_0, arg_25_1)
			arg_25_0.viewComponent:RefreshMessage()

			return
		end,
		[GuildProxy.NEW_MSG_ADDED] = function(arg_26_0, arg_26_1)
			arg_26_0.viewComponent:RefreshMessage()

			return
		end,
		[PlayRoomProxy.CHAT_MSG_UPDATE] = function(arg_27_0, arg_27_1)
			arg_27_0.viewComponent:RefreshMessage()

			return
		end,
		[GAME.CHANGE_CHAT_ROOM_DONE] = function(arg_28_0, arg_28_1)
			arg_28_0.viewComponent:RefreshMessage()

			return
		end
	}

	return
end

function PlayRoomInfoMediator:remove()
	return
end

return PlayRoomInfoMediator
