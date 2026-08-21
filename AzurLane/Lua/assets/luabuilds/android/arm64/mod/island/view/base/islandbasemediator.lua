local var_0_0 = class("IslandBaseMediator", import("view.base.ContextMediator"))

var_0_0.SET_UP = "IslandBaseScene:SET_UP"
var_0_0.SWITCH_MAP = "IslandBaseMediator:SWITCH_MAP"
var_0_0.RECORD_PLAYER_POS = "IslandBaseMediator:RECORD_PLAYER_POS"
var_0_0.ANIMATION_OP = "IslandBaseMediator:ANIMATION_OP"
var_0_0.SEND_CHAT = "IslandBaseMediator:SEND_CHAT"
var_0_0.CHANGE_CHAT_ROOM = "IslandBaseMediator:CHANGE_CHAT_ROOM"
var_0_0.OPEN_FRIEND_INFO = "IslandBaseMediator:OPEN_FRIEND_INFO"
var_0_0.GO_FISHING = "IslandBaseMediator:GO_FISHING"
var_0_0.FISHING_RESULT = "IslandBaseMediator:FISHING_RESULT"
var_0_0.EXCHANGE_LURE = "IslandBaseMediator:EXCHANGE_LURE"
var_0_0.TRADE_OP = "IslandBaseMediator:TRADE_OP"
var_0_0.REQ_TRADE_RANK = "IslandBaseMediator:REQ_TRADE_RANK"
var_0_0.TRADE_INVITATION = "IslandBaseMediator:TRADE_INVITATION"
var_0_0.ENTER_ISLAND = "IslandBaseMediator:ENTER_ISLAND"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.EXCHANGE_LURE, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0:sendNotification(GAME.ISLAND_EXCHANGE_LURE, {
			lureId = arg_2_1,
			fishPointId = arg_2_2,
			callback = arg_2_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.FISHING_RESULT, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
		arg_1_0:sendNotification(GAME.ISLAND_FISHING_REUSLT, {
			fishId = arg_3_3,
			fishPointId = arg_3_2,
			weight = arg_3_4,
			cupType = arg_3_5,
			islandId = arg_1_0.viewComponent:GetIsland().id,
			op = arg_3_1,
			callback = arg_3_6
		})

		return
	end)
	arg_1_0:bind(var_0_0.GO_FISHING, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		arg_1_0:sendNotification(GAME.ISLAND_GO_FISHING, {
			poolId = arg_4_1,
			baitId = arg_4_2,
			islandId = arg_1_0.viewComponent:GetIsland().id,
			callback = arg_4_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.ENTER_ISLAND, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.ISLAND_ENTER, {
			id = arg_5_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.TRADE_INVITATION, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		arg_1_0:sendNotification(GAME.ISLAND_INVITE_TRADE, {
			list = arg_6_1,
			mapId = arg_6_2,
			price = arg_6_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.REQ_TRADE_RANK, function(arg_7_0, arg_7_1)
		arg_1_0:sendNotification(GAME.ISLAND_GET_FRIEND_TRADE_RANK, {
			callback = arg_7_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.TRADE_OP, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = arg_1_0.viewComponent:GetIsland()

		if not var_8_0:GetTradeAgency():CanPurchase() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_trade_price_unrefresh"))

			return
		end

		arg_1_0:sendNotification(GAME.ISLAND_TRADE, {
			islandId = var_8_0.id,
			op = arg_8_1,
			num = arg_8_2,
			price = arg_8_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_FRIEND_INFO, function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		arg_1_0.friendInfoPosition = arg_9_2
		arg_1_0.friendInfoMsg = arg_9_3

		arg_1_0:sendNotification(GAME.FRIEND_SEARCH, {
			type = SearchFriendCommand.SEARCH_TYPE_RESUME,
			keyword = arg_9_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.CHANGE_CHAT_ROOM, function(arg_10_0, arg_10_1)
		if not arg_10_1 then
			return
		end

		if arg_10_1 <= 0 or arg_10_1 == "" then
			return
		end

		arg_1_0:sendNotification(GAME.CHANGE_CHAT_ROOM, arg_10_1)

		return
	end)
	arg_1_0:bind(var_0_0.SEND_CHAT, function(arg_11_0, arg_11_1, arg_11_2)
		arg_1_0:sendNotification(GAME.ISLAND_SEND_CHAT, {
			channel = arg_11_1,
			islandId = arg_1_0.viewComponent:GetIsland().id,
			msg = arg_11_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ANIMATION_OP, function(arg_12_0, arg_12_1, arg_12_2)
		arg_1_0:sendNotification(GAME.ISLAND_ANIMATION_OP, {
			islandId = arg_1_0.viewComponent:GetIsland().id,
			targetId = arg_12_1,
			actionId = arg_12_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.SET_UP, function(arg_13_0)
		arg_1_0:SetUp()

		return
	end)
	arg_1_0:bind(var_0_0.SWITCH_MAP, function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_1_0.viewComponent:GetIsland()

		if not var_14_0:GetAblityAgency():IsUnlockMap(arg_14_1) and arg_14_1 ~= IslandConst.CheaterTavernMapId then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_lock_map_tip"))

			return
		end

		arg_1_0:sendNotification(GAME.ISLAND_ENTER_MAP, {
			islandId = var_14_0.id,
			mapId = arg_14_1,
			callback = function()
				if pg.island_world_objects[arg_14_2] then
					arg_1_0:RecordPlayerPosition(arg_14_1, BuildVector3(pg.island_world_objects[arg_14_2].param.position), (BuildVector3(pg.island_world_objects[arg_14_2].param.rotation)))
				end

				arg_1_0:SwitchScene(arg_14_1, arg_14_2)

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_0.RECORD_PLAYER_POS, function(arg_16_0)
		if not _IslandCore then
			return
		end

		local var_16_0 = _IslandCore:GetController().mapId
		local var_16_1 = _IslandCore:GetView().player

		if not var_16_1 or not var_16_1._tf then
			return
		end

		local var_16_2, var_16_3 = var_16_1:LastGroundedPosition()

		arg_1_0:RecordPlayerPosition(var_16_0, var_16_2, var_16_3)

		return
	end)
	arg_1_0:_register()

	return
end

function var_0_0.RecordPlayerPosition(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if not _IslandCore then
		return
	end

	local var_17_0 = _IslandCore:GetController()

	if not var_17_0:IsSelfIsland() then
		return
	end

	arg_17_0:sendNotification(GAME.ISLAND_RECORD_LAST_EXIT_POS, {
		islandId = arg_17_0.viewComponent:GetIsland().id,
		mapId = arg_17_1,
		position = arg_17_2,
		rotation = arg_17_3
	})

	return
end

function var_0_0.listNotificationInterests(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs((arg_18_0:_listNotificationInterests())) do
		if not table.contains({
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
		}, iter_18_1) then
			table.insert({
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
			}, iter_18_1)
		end
	end

	return {
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
end

function var_0_0.handleNotification(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1:getName()
	local var_19_1 = arg_19_1:getBody()

	if var_19_0 == ChatProxy.NEW_MSG or var_19_0 == FriendProxy.FRIEND_NEW_MSG or var_19_0 == GuildProxy.NEW_MSG_ADDED or var_19_0 == IslandProxy.CHAT_MSG_UPDATE then
		arg_19_0.viewComponent:emitCore(ISLAND_EVT.CHAT_MSG_UPDATE)

		if var_19_0 == IslandProxy.CHAT_MSG_UPDATE and var_19_1.islandId == arg_19_0.viewComponent:GetIsland().id then
			arg_19_0.viewComponent:emitCore(ISLAND_EVT.SHOW_CHAT_MSG, var_19_1.msg)
		end
	elseif var_19_0 == GAME.CHANGE_CHAT_ROOM_DONE then
		arg_19_0.viewComponent:emitCore(ISLAND_EVT.CHAT_ROOM_UPDATE)
	elseif var_19_0 == GAME.OPEN_FRIEND_INFO_DONE then
		arg_19_0.friendInfoPosition = var_19_1
	elseif var_19_0 == GAME.FRIEND_SEARCH_DONE and var_19_1.list[1] and var_19_1.type == SearchFriendCommand.SEARCH_TYPE_RESUME then
		arg_19_0:addSubLayers(Context.New({
			viewComponent = IslandFriendInfoLayer,
			mediator = FriendInfoMediator,
			data = {
				friend = var_19_1.list[1],
				msg = arg_19_0.friendInfoMsg,
				pos = arg_19_0.friendInfoPosition
			}
		}))

		arg_19_0.friendInfoPosition = nil
		arg_19_0.friendInfoMsg = nil
	elseif var_19_0 == GAME.ON_APPLICATION_PAUSE then
		if not var_19_1 and _IslandCore and not arg_19_0.exitProcessing then
			({}).islandId = _IslandCore:GetController():GetIsland().id

			arg_19_0:sendNotification(GAME.ISLAND_RECONNECT, {})
		end
	elseif var_19_0 == GAME.ISLAND_ON_HOME then
		arg_19_0.viewComponent:emit(BaseUI.ON_HOME)
	elseif var_19_0 == GAME.ISLAND_ON_RECONNECT then
		if arg_19_0.exitProcessing then
			return
		end

		local function var_19_2()
			arg_19_0.exitProcessing = true
			var_19_1.id = _IslandCore:GetController():GetIsland().id

			arg_19_0.viewComponent:ExitProcess("", function()
				arg_19_0.exitProcessing = false

				arg_19_0:sendNotification(GAME.ISLAND_CHANGE_ENTER, var_19_1)

				return
			end)

			return
		end

		if _IslandCore and _IslandCore.state == IslandCore.STATE_INIT_FINISH then
			if isa(_IslandCore, IslandMinigameCore) then
				arg_19_0.viewComponent:GetIsland():GetCheaterTavernAgency():SetIsConnecting(false)
			end

			var_19_2()
		else
			arg_19_0.coreInitCallback = var_19_2
		end
	elseif var_19_0 == GAME.ISLAND_SELECT_GIFT_DONE then
		arg_19_0.viewComponent:HandleAwardDisplay(var_19_1.dropData, var_19_1.callback, IslandAwardDisplayPage.TYPE_SIGN_GIFT)
	elseif var_19_0 == GAME.ISLAND_CORE_STATE_CHANGED then
		if var_19_1 == IslandCore.STATE_INIT_FINISH and arg_19_0.coreInitCallback then
			arg_19_0.coreInitCallback()

			arg_19_0.coreInitCallback = nil
		end
	elseif var_19_0 == GAME.ISLAND_TRADE_DONE then
		arg_19_0.viewComponent:HandleAwardDisplay(var_19_1.dropData, var_19_1.callback)
	elseif var_19_0 == GAME.PLAY_ROOM_LOAD_MINIGAME_SCENE then
		arg_19_0.isReconected = var_19_1.isReconecting

		if arg_19_0.viewComponent:GetIsland():GetMapId() ~= var_19_1.mapId then
			arg_19_0:LoadMiniGameScene(var_19_1.mapId)

			arg_19_0.needChangeMap = true
		else
			arg_19_0.needChangeMap = false

			Timer.New(function()
				pg.m02:sendNotification(GAME.PLAY_ROOM_LOAD_SCENE_COMPLETE)

				return
			end, 2, 0):Start()
		end
	elseif var_19_0 == GAME.PLAY_ROOM_ALL_LOAD_OVER then
		arg_19_0:ChangeMiniGameScene()
	end

	arg_19_0:_handleNotification(arg_19_1)
	arg_19_0.viewComponent:emit(var_19_0, var_19_1)

	return
end

function var_0_0.LoadMiniGameScene(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.viewComponent:GetIsland()

	var_23_0:SetMapId(arg_23_1)

	local var_23_1 = _IslandCore:GetView():GetSubView(IslandOpView)

	if var_23_1 then
		local var_23_2 = var_23_1.showBalance or 0

		arg_23_0.miniGameCore = IslandMinigameCore.New(arg_23_0.viewComponent:GetPoolMgr(), var_23_0, var_23_2)

		arg_23_0.miniGameCore:SetIslandViewCoponent(arg_23_0.viewComponent)
		arg_23_0.miniGameCore:SetIsReconected(arg_23_0.isReconected)

		return
	end
end

function var_0_0.ChangeMiniGameScene(arg_24_0)
	pg.SceneAnimMgr.GetInstance():CommonSceneChange("Dorm3DLoading", function(arg_25_0)
		if arg_24_0.needChangeMap then
			arg_24_0:UnloadScene()

			_IslandCore = arg_24_0.miniGameCore
		end

		_IslandCore:OnChangeMiniGameScene(arg_24_0.needChangeMap, arg_24_0.isReConnected)
		arg_25_0()

		return
	end)

	return
end

function var_0_0.SetUp(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.viewComponent:GetIsland()

	_IslandCore = IslandCore.New(arg_26_0.viewComponent:GetPoolMgr(), var_26_0, arg_26_1)

	arg_26_0.viewComponent:OnSetUpCore(var_26_0.mapID, var_26_0.spawnPointId)

	return
end

function var_0_0.SwitchScene(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0.viewComponent:GetIsland()

	var_27_0:SetMapId(arg_27_1)

	if arg_27_2 then
		var_27_0:SetSpawnPointId(arg_27_2)
	end

	arg_27_0:SetUp((arg_27_0:UnloadScene()))

	return
end

function var_0_0.UnloadScene(arg_28_0, arg_28_1)
	arg_28_0.viewComponent:OnUnloadScene()

	if _IslandCore then
		local var_28_0 = _IslandCore:GetView():GetSubView(IslandOpView)

		if isa(_IslandCore, IslandMinigameCore) then
			_IslandCore:Dispose(arg_28_1)

			_IslandCore = nil

			do return _IslandCore.showBalance end

			goto label_28_0
		end

		::label_28_0::

		if var_28_0 then
			do
				local var_28_1 = var_28_0.showBalance or 1

				_IslandCore:Dispose(arg_28_1)

				_IslandCore = nil

				return var_28_1
			end

			return 1
		end
	end
end

function var_0_0.remove(arg_29_0)
	arg_29_0:UnloadScene(true)
	arg_29_0:_remove()
	IslandHelper.RunGC(true)

	return
end

function var_0_0._register(arg_30_0)
	return
end

function var_0_0._listNotificationInterests(arg_31_0)
	return {}
end

function var_0_0._handleNotification(arg_32_0, arg_32_1)
	return
end

function var_0_0._remove(arg_33_0)
	return
end

return var_0_0
