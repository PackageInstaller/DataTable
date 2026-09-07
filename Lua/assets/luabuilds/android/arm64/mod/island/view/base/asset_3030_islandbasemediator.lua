local IslandBaseMediator = class("IslandBaseMediator", import("view.base.ContextMediator"))

IslandBaseMediator.SET_UP = "IslandBaseScene:SET_UP"
IslandBaseMediator.SWITCH_MAP = "IslandBaseMediator:SWITCH_MAP"
IslandBaseMediator.RECORD_PLAYER_POS = "IslandBaseMediator:RECORD_PLAYER_POS"
IslandBaseMediator.ANIMATION_OP = "IslandBaseMediator:ANIMATION_OP"
IslandBaseMediator.SEND_CHAT = "IslandBaseMediator:SEND_CHAT"
IslandBaseMediator.CHANGE_CHAT_ROOM = "IslandBaseMediator:CHANGE_CHAT_ROOM"
IslandBaseMediator.OPEN_FRIEND_INFO = "IslandBaseMediator:OPEN_FRIEND_INFO"
IslandBaseMediator.GO_FISHING = "IslandBaseMediator:GO_FISHING"
IslandBaseMediator.FISHING_RESULT = "IslandBaseMediator:FISHING_RESULT"
IslandBaseMediator.EXCHANGE_LURE = "IslandBaseMediator:EXCHANGE_LURE"
IslandBaseMediator.TRADE_OP = "IslandBaseMediator:TRADE_OP"
IslandBaseMediator.REQ_TRADE_RANK = "IslandBaseMediator:REQ_TRADE_RANK"
IslandBaseMediator.TRADE_INVITATION = "IslandBaseMediator:TRADE_INVITATION"
IslandBaseMediator.ENTER_ISLAND = "IslandBaseMediator:ENTER_ISLAND"

function IslandBaseMediator:register()
	self:bind(IslandBaseMediator.EXCHANGE_LURE, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:sendNotification(GAME.ISLAND_EXCHANGE_LURE, {
			lureId = arg_2_1,
			fishPointId = arg_2_2,
			callback = arg_2_3
		})

		return
	end)
	self:bind(IslandBaseMediator.FISHING_RESULT, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
		self:sendNotification(GAME.ISLAND_FISHING_REUSLT, {
			fishId = arg_3_3,
			fishPointId = arg_3_2,
			weight = arg_3_4,
			cupType = arg_3_5,
			islandId = self.viewComponent:GetIsland().id,
			op = arg_3_1,
			callback = arg_3_6
		})

		return
	end)
	self:bind(IslandBaseMediator.GO_FISHING, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		self:sendNotification(GAME.ISLAND_GO_FISHING, {
			poolId = arg_4_1,
			baitId = arg_4_2,
			islandId = self.viewComponent:GetIsland().id,
			callback = arg_4_3
		})

		return
	end)
	self:bind(IslandBaseMediator.ENTER_ISLAND, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.ISLAND_ENTER, {
			id = arg_5_1
		})

		return
	end)
	self:bind(IslandBaseMediator.TRADE_INVITATION, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		self:sendNotification(GAME.ISLAND_INVITE_TRADE, {
			list = arg_6_1,
			mapId = arg_6_2,
			price = arg_6_3
		})

		return
	end)
	self:bind(IslandBaseMediator.REQ_TRADE_RANK, function(arg_7_0, arg_7_1)
		self:sendNotification(GAME.ISLAND_GET_FRIEND_TRADE_RANK, {
			callback = arg_7_1
		})

		return
	end)
	self:bind(IslandBaseMediator.TRADE_OP, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = self.viewComponent:GetIsland()

		if not var_8_0:GetTradeAgency():CanPurchase() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_trade_price_unrefresh"))

			return
		end

		self:sendNotification(GAME.ISLAND_TRADE, {
			islandId = var_8_0.id,
			op = arg_8_1,
			num = arg_8_2,
			price = arg_8_3
		})

		return
	end)
	self:bind(IslandBaseMediator.OPEN_FRIEND_INFO, function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		self.friendInfoPosition = arg_9_2
		self.friendInfoMsg = arg_9_3

		self:sendNotification(GAME.FRIEND_SEARCH, {
			type = SearchFriendCommand.SEARCH_TYPE_RESUME,
			keyword = arg_9_1
		})

		return
	end)
	self:bind(IslandBaseMediator.CHANGE_CHAT_ROOM, function(arg_10_0, arg_10_1)
		if not arg_10_1 then
			return
		end

		if arg_10_1 <= 0 or arg_10_1 == "" then
			return
		end

		self:sendNotification(GAME.CHANGE_CHAT_ROOM, arg_10_1)

		return
	end)
	self:bind(IslandBaseMediator.SEND_CHAT, function(arg_11_0, arg_11_1, arg_11_2)
		self:sendNotification(GAME.ISLAND_SEND_CHAT, {
			channel = arg_11_1,
			islandId = self.viewComponent:GetIsland().id,
			msg = arg_11_2
		})

		return
	end)
	self:bind(IslandBaseMediator.ANIMATION_OP, function(arg_12_0, arg_12_1, arg_12_2)
		self:sendNotification(GAME.ISLAND_ANIMATION_OP, {
			islandId = self.viewComponent:GetIsland().id,
			targetId = arg_12_1,
			actionId = arg_12_2
		})

		return
	end)
	self:bind(IslandBaseMediator.SET_UP, function(arg_13_0)
		self:SetUp()

		return
	end)
	self:bind(IslandBaseMediator.SWITCH_MAP, function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = self.viewComponent:GetIsland()

		if not var_14_0:GetAblityAgency():IsUnlockMap(arg_14_1) and arg_14_1 ~= IslandConst.CheaterTavernMapId then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_lock_map_tip"))

			return
		end

		self:sendNotification(GAME.ISLAND_ENTER_MAP, {
			islandId = var_14_0.id,
			mapId = arg_14_1,
			callback = function()
				if pg.island_world_objects[arg_14_2] then
					self:RecordPlayerPosition(arg_14_1, BuildVector3(pg.island_world_objects[arg_14_2].param.position), (BuildVector3(pg.island_world_objects[arg_14_2].param.rotation)))
				end

				self:SwitchScene(arg_14_1, arg_14_2)

				return
			end
		})

		return
	end)
	self:bind(IslandBaseMediator.RECORD_PLAYER_POS, function(arg_16_0)
		if not _IslandCore then
			return
		end

		local var_16_0 = _IslandCore:GetController().mapId
		local var_16_1 = _IslandCore:GetView().player

		if not var_16_1 or not var_16_1._tf then
			return
		end

		local var_16_2, var_16_3 = var_16_1:LastGroundedPosition()

		self:RecordPlayerPosition(var_16_0, var_16_2, var_16_3)

		return
	end)
	self:_register()

	return
end

function IslandBaseMediator:RecordPlayerPosition(arg_17_1, arg_17_2, arg_17_3)
	if not _IslandCore then
		return
	end

	if not _IslandCore:GetController():IsSelfIsland() then
		return
	end

	self:sendNotification(GAME.ISLAND_RECORD_LAST_EXIT_POS, {
		islandId = self.viewComponent:GetIsland().id,
		mapId = arg_17_1,
		position = arg_17_2,
		rotation = arg_17_3
	})

	return
end

function IslandBaseMediator:listNotificationInterests()
	local var_18_0 = {
		ChatProxy.NEW_MSG,
		FriendProxy.FRIEND_NEW_MSG,
		GuildProxy.NEW_MSG_ADDED,
		IslandProxy.CHAT_MSG_UPDATE,
		GAME.CHANGE_CHAT_ROOM_DONE,
		GAME.FRIEND_SEARCH_DONE,
		GAME.ON_APPLICATION_PAUSE,
		GAME.ISLAND_ON_HOME,
		GAME.ISLAND_ON_RECONNECT,
		GAME.ISLAND_CORE_STATE_CHANGED,
		GAME.ISLAND_TRADE_DONE,
		IslandTradegency.WEEK_NUM_UPDATE,
		IslandTradegency.INVITE_LIST_UPDATE,
		GAME.ISLAND_SELECT_GIFT_DONE,
		GAME.PLAY_ROOM_LOAD_MINIGAME_SCENE,
		GAME.PLAY_ROOM_ALL_LOAD_OVER,
		GAME.PLAY_ROOM_ENTER_LOAD,
		PlayRoomProxy.CHAT_MSG_UPDATE,
		GAME.OPEN_FRIEND_INFO_DONE
	}

	for iter_18_0, iter_18_1 in ipairs((self:_listNotificationInterests())) do
		if not table.contains(var_18_0, iter_18_1) then
			table.insert(var_18_0, iter_18_1)
		end
	end

	return var_18_0
end

function IslandBaseMediator:handleNotification(arg_19_1)
	local var_19_0 = arg_19_1:getName()
	local var_19_1 = arg_19_1:getBody()

	if var_19_0 == ChatProxy.NEW_MSG or var_19_0 == FriendProxy.FRIEND_NEW_MSG or var_19_0 == GuildProxy.NEW_MSG_ADDED or var_19_0 == IslandProxy.CHAT_MSG_UPDATE then
		self.viewComponent:emitCore(ISLAND_EVT.CHAT_MSG_UPDATE)

		if var_19_0 == IslandProxy.CHAT_MSG_UPDATE and var_19_1.islandId == self.viewComponent:GetIsland().id then
			self.viewComponent:emitCore(ISLAND_EVT.SHOW_CHAT_MSG, var_19_1.msg)
		end
	elseif var_19_0 == GAME.CHANGE_CHAT_ROOM_DONE then
		self.viewComponent:emitCore(ISLAND_EVT.CHAT_ROOM_UPDATE)
	elseif var_19_0 == GAME.OPEN_FRIEND_INFO_DONE then
		self.friendInfoPosition = var_19_1
	elseif var_19_0 == GAME.FRIEND_SEARCH_DONE and var_19_1.list[1] and var_19_1.type == SearchFriendCommand.SEARCH_TYPE_RESUME then
		self:addSubLayers(Context.New({
			viewComponent = IslandFriendInfoLayer,
			mediator = FriendInfoMediator,
			data = {
				friend = var_19_1.list[1],
				msg = self.friendInfoMsg,
				pos = self.friendInfoPosition
			}
		}))

		self.friendInfoPosition = nil
		self.friendInfoMsg = nil
	elseif var_19_0 == GAME.ON_APPLICATION_PAUSE then
		if not var_19_1 and _IslandCore and not self.exitProcessing then
			local var_19_2 = {}

			var_19_2.islandId = _IslandCore:GetController():GetIsland().id

			self:sendNotification(GAME.ISLAND_RECONNECT, var_19_2)
		end
	elseif var_19_0 == GAME.ISLAND_ON_HOME then
		self.viewComponent:emit(BaseUI.ON_HOME)
	elseif var_19_0 == GAME.ISLAND_ON_RECONNECT then
		if self.exitProcessing then
			return
		end

		local function var_19_3()
			self.exitProcessing = true
			var_19_1.id = _IslandCore:GetController():GetIsland().id

			self.viewComponent:ExitProcess("", function()
				self.exitProcessing = false

				self:sendNotification(GAME.ISLAND_CHANGE_ENTER, var_19_1)

				return
			end)

			return
		end

		if _IslandCore and _IslandCore.state == IslandCore.STATE_INIT_FINISH then
			if isa(_IslandCore, IslandMinigameCore) then
				self.viewComponent:GetIsland():GetCheaterTavernAgency():SetIsConnecting(false)
			end

			var_19_3()
		else
			self.coreInitCallback = var_19_3
		end
	elseif var_19_0 == GAME.ISLAND_SELECT_GIFT_DONE then
		self.viewComponent:HandleAwardDisplay(var_19_1.dropData, var_19_1.callback, IslandAwardDisplayPage.TYPE_SIGN_GIFT)
	elseif var_19_0 == GAME.ISLAND_CORE_STATE_CHANGED then
		if var_19_1 == IslandCore.STATE_INIT_FINISH and self.coreInitCallback then
			self.coreInitCallback()

			self.coreInitCallback = nil
		end
	elseif var_19_0 == GAME.ISLAND_TRADE_DONE then
		self.viewComponent:HandleAwardDisplay(var_19_1.dropData, var_19_1.callback)
	elseif var_19_0 == GAME.PLAY_ROOM_LOAD_MINIGAME_SCENE then
		self.isReconected = var_19_1.isReconecting

		if self.viewComponent:GetIsland():GetMapId() ~= var_19_1.mapId then
			self:LoadMiniGameScene(var_19_1.mapId)

			self.needChangeMap = true
		else
			self.needChangeMap = false

			Timer.New(function()
				pg.m02:sendNotification(GAME.PLAY_ROOM_LOAD_SCENE_COMPLETE)

				return
			end, 2, 0):Start()
		end
	elseif var_19_0 == GAME.PLAY_ROOM_ALL_LOAD_OVER then
		self:ChangeMiniGameScene()
	end

	self:_handleNotification(arg_19_1)
	self.viewComponent:emit(var_19_0, var_19_1)

	return
end

function IslandBaseMediator:LoadMiniGameScene(arg_23_1)
	local var_23_0 = self.viewComponent:GetIsland()

	var_23_0:SetMapId(arg_23_1)

	local var_23_1 = _IslandCore:GetView():GetSubView(IslandOpView)

	self.miniGameCore = IslandMinigameCore.New(self.viewComponent:GetPoolMgr(), var_23_0, (var_23_1 or nil) and (var_23_1.showBalance or 0))

	self.miniGameCore:SetIslandViewCoponent(self.viewComponent)
	self.miniGameCore:SetIsReconected(self.isReconected)

	return
end

function IslandBaseMediator:ChangeMiniGameScene()
	pg.SceneAnimMgr.GetInstance():CommonSceneChange("Dorm3DLoading", function(arg_25_0)
		if self.needChangeMap then
			self:UnloadScene()

			_IslandCore = self.miniGameCore
		end

		_IslandCore:OnChangeMiniGameScene(self.needChangeMap, self.isReConnected)
		arg_25_0()

		return
	end)

	return
end

function IslandBaseMediator:SetUp(arg_26_1)
	local var_26_0 = self.viewComponent:GetIsland()

	_IslandCore = IslandCore.New(self.viewComponent:GetPoolMgr(), var_26_0, arg_26_1)

	self.viewComponent:OnSetUpCore(var_26_0.mapID, var_26_0.spawnPointId)

	return
end

function IslandBaseMediator:SwitchScene(arg_27_1, arg_27_2)
	local var_27_0 = self.viewComponent:GetIsland()

	var_27_0:SetMapId(arg_27_1)

	if arg_27_2 then
		var_27_0:SetSpawnPointId(arg_27_2)
	end

	self:SetUp((self:UnloadScene()))

	return
end

function IslandBaseMediator:UnloadScene(arg_28_1)
	self.viewComponent:OnUnloadScene()

	if _IslandCore then
		if isa(_IslandCore, IslandMinigameCore) then
			_IslandCore:Dispose(arg_28_1)

			_IslandCore = nil

			return _IslandCore.showBalance
		else
			local var_28_0 = _IslandCore:GetView():GetSubView(IslandOpView)
			local var_28_1

			if var_28_0 then
				var_28_1 = var_28_0.showBalance or 1
			end

			_IslandCore:Dispose(arg_28_1)

			_IslandCore = nil

			return var_28_1
		end
	end

	return 1
end

function IslandBaseMediator:remove()
	self:UnloadScene(true)
	self:_remove()
	IslandHelper.RunGC(true)

	return
end

function IslandBaseMediator:_register()
	return
end

function IslandBaseMediator:_listNotificationInterests()
	return {}
end

function IslandBaseMediator:_handleNotification(arg_32_1)
	return
end

function IslandBaseMediator:_remove()
	return
end

return IslandBaseMediator
