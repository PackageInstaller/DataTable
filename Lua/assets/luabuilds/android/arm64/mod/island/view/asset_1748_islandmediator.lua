local IslandMediator = class("IslandMediator", import(".base.IslandBaseMediator"))

IslandMediator.CHANGE_SCENE = "IslandMediator:CHANGE_SCENE"
IslandMediator.SHOPPING = "IslandMediator:SHOPPING"
IslandMediator.SET_NAME = "IslandMediator:SET_NAME"
IslandMediator.ON_EDIT_MANIFESTO = "IslandMediator:ON_EDIT_MANIFESTO"
IslandMediator.GET_PROSPERITY_AWARD = "IslandMediator:GET_PROSPERITY_AWARD"
IslandMediator.ON_UPGRADE_INVENTORY = "IslandMediator:ON_UPGRADE_INVENTORY"
IslandMediator.ON_REPLACE_ORDER = "IslandMediator:ON_REPLACE_ORDER"
IslandMediator.ON_SUBMIT_ORDER = "IslandMediator:ON_SUBMIT_ORDER"
IslandMediator.ON_GET_ORDER_EXP_AWARD = "IslandMediator:ON_GET_ORDER_EXP_AWARD"
IslandMediator.ON_GEN_NEW_ORDER = "IslandMediator:ON_GEN_NEW_ORDER"
IslandMediator.ON_USE_ITEM = "IslandMediator:ON_USE_ITEM"
IslandMediator.ON_ACCEPT_TASK = "IslandMediator.ON_ACCEPT_TASK"
IslandMediator.ON_SUBMIT_TASK = "IslandMediator.ON_SUBMIT_TASK"
IslandMediator.ON_SUBMIT_TASK_ONE_STEP = "IslandMediator.ON_SUBMIT_TASK_ONE_STEP"
IslandMediator.ON_CLIENT_UPDATE_TASK = "IslandMediator.ON_CLIENT_UPDATE_TASK"
IslandMediator.ON_SET_TRACE_ID = "IslandMediator.ON_SET_TRACE_ID"
IslandMediator.ON_RESET_SEASON = "IslandMediator.ON_RESET_SEASON"
IslandMediator.ON_GET_SEASON_RANK = "IslandMediator.ON_GET_SEASON_RANK"
IslandMediator.ON_CONVERT_SEASON_PT = "IslandMediator.ON_CONVERT_SEASON_PT"
IslandMediator.ON_CONVERT_SEASON_PT_4_OVERFLOW = "IslandMediator.ON_CONVERT_SEASON_PT_4_OVERFLOW"
IslandMediator.ON_GET_SEASON_PT_AWARD = "IslandMediator.ON_GET_SEASON_PT_AWARD"
IslandMediator.OPEN_RESTAURANT = "IslandMediator.OPEN_RESTAURANT"
IslandMediator.CLOSE_RESTAURANT = "IslandMediator.CLOSE_RESTAURANT"
IslandMediator.GET_ACHIEVEMENT_AWARD = "IslandMediator.GET_ACHIEVEMENT_AWARD"
IslandMediator.SET_SETTINGS_FLAG = "IslandMediator.SET_SETTINGS_FLAG"
IslandMediator.UPDATE_ILLUSTRATION = "IslandMediator.UPDATE_ILLUSTRATION"
IslandMediator.UNLOCK_ILLUSTRATION = "IslandMediator.UNLOCK_ILLUSTRATION"
IslandMediator.GET_COLLECT_POINT = "IslandMediator.GET_COLLECT_POINT"
IslandMediator.GET_POINT_AWARD = "IslandMediator.GET_POINT_AWARD"
IslandMediator.REMOVE_EXPIRED_TICKETS = "IslandMediator.REMOVE_EXPIRED_TICKETS"
IslandMediator.USE_TICKETS = "IslandMediator.USE_TICKETS"
IslandMediator.EXCHANGE_ITME = "IslandMediator.EXCHANGE_ITME"
IslandMediator.OPEN_SHIP_INDEX = "IslandMediator:OPEN_SHIP_INDEX"
IslandMediator.UPGRADE_SKILL = "IslandMediator:UPGRADE_SKILL"
IslandMediator.ON_GIVE_GIFT = "IslandMediator:ON_GIVE_GIFT"
IslandMediator.ON_KICK_PLAYER = "IslandMediator:ON_KICK_PLAYER"
IslandMediator.SAVE_AGORA = "IslandMediator:SAVE_AGORA"
IslandMediator.SAVE_AGORA_THEME = "IslandMediator:SAVE_AGORA_THEME"
IslandMediator.DEL_AGORA_THEME = "IslandMediator:DEL_AGORA_THEME"
IslandMediator.UPGRADE_AGORA = "IslandMediator:UPGRADE_AGORA"
IslandMediator.INVITE_SHIP = "IslandMediator:INVITE_SHIP"
IslandMediator.ONE_KEY = "IslandMediator:ONE_KEY"
IslandMediator.ON_UNLOCK_TECH = "IslandMediator:ON_UNLOCK_TECH"
IslandMediator.ON_FINISH_TECH_IMMD = "IslandMediator:ON_FINISH_TECH_IMMD"
IslandMediator.SET_ORDER_TENDENCY = "IslandMediator:SET_ORDER_TENDENCY"
IslandMediator.SUBMIT_SHIP_ORDER_ITME = "IslandMediator:SUBMIT_SHIP_ORDER_ITME"
IslandMediator.SUBMIT_SHIP_ORDER_ITME_ONEKEY = "IslandMediator:SUBMIT_SHIP_ORDER_ITME_ONEKEY"
IslandMediator.GET_SHIP_ORDER_AWARD = "IslandMediator:GET_SHIP_ORDER_AWARD"
IslandMediator.UNLOKC_SHIP_ORDER = "IslandMediator:UNLOKC_SHIP_ORDER"
IslandMediator.OPEN_PAGE = "IslandMediator:OPEN_PAGE"
IslandMediator.OPEN_SHOP = "IslandMediator:OPEN_SHOP"
IslandMediator.GET_SHOP_DATA = "IslandMediator:GET_SHOP_DATA"
IslandMediator.BUY_COMMODITY = "IslandMediator:BUY_COMMODITY"
IslandMediator.REFRESH_SHOP_BY_PLAYER = "IslandMediator:REFRESH_SHOP_BY_PLAYER"
IslandMediator.USE_SHIP_EXP_BOOK = "IslandMediator:USE_SHIP_EXP_BOOK"
IslandMediator.SHIP_BREAKOUT = "IslandMediator:SHIP_BREAKOUT"
IslandMediator.SHIP_ATTR_UPGRADE = "IslandMediator:SHIP_ATTR_UPGRADE"
IslandMediator.SHIP_ATTR_LIMIT_UNLOCK = "IslandMediator:SHIP_ATTR_LIMIT_UNLOCK"
IslandMediator.SHIP_SKILL_UPGRADE = "IslandMediator:SHIP_SKILL_UPGRADE"
IslandMediator.START_DELEGATION = "IslandMediator:START_DELEGATION"
IslandMediator.ADD_DELEGATION = "IslandMediator:ADD_DELEGATION"
IslandMediator.STOP_DELEGATION = "IslandMediator:STOP_DELEGATION"
IslandMediator.GET_DELEGATION_AWARD = "IslandMediator:GET_DELEGATION_AWARD"
IslandMediator.SIGNIN = "IslandMediator.SIGNIN"
IslandMediator.SELECT_GIFT = "IslandMediator.SELECT_GIFT"
IslandMediator.SIGN_IN_INVITATION = "IslandMediator.SIGN_IN_INVITATION"
IslandMediator.SHARE_SIGNIN = "IslandMediator:SHARE_SIGNIN"
IslandMediator.ENTER_ISLAND = "IslandMediator:ENTER_ISLAND"
IslandMediator.ENTER_ISLAND_BY_CODE = "IslandMediator:ENTER_ISLAND_BY_CODE"
IslandMediator.ADD_FRIEND = "IslandMediator:ADD_FRIEND"
IslandMediator.REMOVE_FRIEND = "IslandMediator:REMOVE_FRIEND"
IslandMediator.SEARCH_FRIEND = "IslandMediator:SEARCH_FRIEND"
IslandMediator.BATCH_GET_FRIEND = "IslandMediator:BATCH_GET_FRIEND"
IslandMediator.ADD_WHITE_LIST = "IslandMediator:ADD_WHITE_LIST"
IslandMediator.ADD_BLACK_LIST = "IslandMediator:ADD_BLACK_LIST"
IslandMediator.REMOVE_BLACK_LIST = "IslandMediator:REMOVE_BLACK_LIST"
IslandMediator.REMOVE_WHITE_LIST = "IslandMediator:REMOVE_WHITE_LIST"
IslandMediator.SET_ACCESS_FLAG = "IslandMediator:SET_ACCESS_FLAG"
IslandMediator.REFRESH_INVITECODE = "IslandMediator:REFRESH_INVITECODE"
IslandMediator.KICK_ALL_VISITOR = "IslandMediator:KICK_ALL_VISITOR"
IslandMediator.GET_RESUME = "IslandMediator:GET_RESUME"
IslandMediator.GET_GIFT_TAG = "IslandMediator:GET_GIFT_TAG"
IslandMediator.GET_THEMES = "IslandMediator:GET_THEMES"
IslandMediator.PREVIEW_FURNITURE = "IslandMediator:PREVIEW_FURNITURE"
IslandMediator.REFUSE_REQUEST = "IslandMediator:REFUSE_REQUEST"
IslandMediator.ACCEPT_REQUEST = "IslandMediator:ACCEPT_REQUEST"
IslandMediator.NPC_ACTION_AWARD = "IslandMediator:NPC_ACTION_AWARD"
IslandMediator.ADD_FOLLOWER = "IslandMediator:ADD_FOLLOWER"
IslandMediator.DEL_FOLLOWER = "IslandMediator:DEL_FOLLOWER"
IslandMediator.DRAW_AWARD_OPERATION = "IslandMediator.DRAW_AWARD_OPERATION"
IslandMediator.REFRESH_SHIP_ORDER = "IslandMediator:REFRESH_SHIP_ORDER"
IslandMediator.EXCHANGE_SHIP_ORDER = "IslandMediator:EXCHANGE_SHIP_ORDER"
IslandMediator.RESET_SHIP_ORDER = "IslandMediator:RESET_SHIP_ORDER"
IslandMediator.GET_AUTO_COLLECTION_DATA = "IslandMediator:GET_AUTO_COLLECTION_DATA"
IslandMediator.PLAY_ROOM_INVITE_AGREE = "IslandMediator:PLAY_ROOM_INVITE_AGREE"
IslandMediator.PLAY_ROOM_INVITE_REFUSE = "IslandMediator:PLAY_ROOM_INVITE_REFUSE"
IslandMediator.PLAY_ROOM_MATCH_STOP = "IslandMediator:PLAY_ROOM_MATCH_STOP"
IslandMediator.CHEATER_TAVERN_OPERATE = "IslandMediator:CHEATER_TAVERN_OPERATE"
IslandMediator.CHEATER_TAVERN_CANCEL_DELEGATE = "IslandMediator:CHEATER_TAVERN_CANCEL_DELEGATE"
IslandMediator.CHEATER_TAVERN_START_SOLO_GAME = "IslandMediator:CHEATER_TAVERN_START_SOLO_GAME"
IslandMediator.CHEATER_TAVERN_END_SOLO_GAME = "IslandMediator:CHEATER_TAVERN_END_SOLO_GAME"
IslandMediator.SHOW_MSG_BOX = "IslandMediator:SHOW_MSG_BOX"
IslandMediator.OPEN_MACHA_MODEL_PREVIEW = "IslandMediator:OPEN_MACHA_MODEL_PREVIEW"
IslandMediator.SKIP_MAP = "IslandMediator:SKIP_MAP"

function IslandMediator:_register()
	self:bind(IslandMediator.RESET_SHIP_ORDER, function(arg_2_0)
		self:sendNotification(GAME.ISLAND_RESET_SHIP_ORDER)

		return
	end)
	self:bind(IslandMediator.EXCHANGE_SHIP_ORDER, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.ISLAND_EXCHANGE_SHIP_ORDER, {
			id = arg_3_1,
			delegateId = arg_3_2
		})

		return
	end)
	self:bind(IslandMediator.REFRESH_SHIP_ORDER, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.ISLAND_REFRESH_SHIP_ORDER, {
			id = arg_4_1
		})

		return
	end)
	self:bind(IslandMediator.CHANGE_SCENE, function(arg_5_0, arg_5_1, ...)
		self:sendNotification(GAME.CHANGE_SCENE, arg_5_1, ...)

		return
	end)
	self:bind(IslandMediator.ADD_FOLLOWER, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.ISLAND_FOLLOWER_OP, {
			shipId = arg_6_1,
			op = IslandConst.FOLLOWER_OP_ADD
		})

		return
	end)
	self:bind(IslandMediator.DEL_FOLLOWER, function(arg_7_0, arg_7_1, arg_7_2)
		self:sendNotification(GAME.ISLAND_FOLLOWER_OP, {
			shipId = arg_7_1,
			op = IslandConst.FOLLOWER_OP_DEL,
			callback = arg_7_2
		})

		return
	end)
	self:bind(IslandMediator.NPC_ACTION_AWARD, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		self:sendNotification(GAME.ISLAND_GET_NPC_ACTION_AWARD, {
			npcId = arg_8_1,
			shipId = arg_8_2,
			actionId = arg_8_3
		})

		return
	end)
	self:bind(IslandMediator.ACCEPT_REQUEST, function(arg_9_0, arg_9_1)
		self:sendNotification(GAME.FRIEND_ACCEPT_REQUEST, arg_9_1)

		return
	end)
	self:bind(IslandMediator.REFUSE_REQUEST, function(arg_10_0, arg_10_1)
		self:sendNotification(GAME.FRIEND_REJECT_REQUEST, arg_10_1)

		return
	end)
	self:bind(IslandMediator.PREVIEW_FURNITURE, function(arg_11_0, arg_11_1)
		local var_11_0 = self.viewComponent:GetIsland()
		local var_11_1, var_11_2 = _IslandCore:GetView().player:LastGroundedPosition()

		var_11_0:SetMapId(IslandConst.AGORA_MAP_ID)
		self:UnloadScene()

		_IslandCore = IslandPreviewCore.New(self.viewComponent:GetPoolMgr(), var_11_0, true, arg_11_1, {
			mapId = var_11_0:GetMapId(),
			position = var_11_1,
			rotation = var_11_2
		})

		return
	end)
	self:bind(IslandMediator.GET_THEMES, function(arg_12_0, arg_12_1)
		self:sendNotification(GAME.ISLAND_GET_AGORA_THEME, {
			callback = arg_12_1
		})

		return
	end)
	self:bind(IslandMediator.GET_GIFT_TAG, function(arg_13_0, arg_13_1, arg_13_2)
		self:sendNotification(GAME.ISLAND_GET_GIFT_TAG, {
			list = arg_13_1,
			callback = arg_13_2
		})

		return
	end)
	self:bind(IslandMediator.GET_RESUME, function(arg_14_0, arg_14_1, arg_14_2)
		self:sendNotification(GAME.ISLAND_GET_FRIEND_RESUME, {
			id = arg_14_1,
			callback = arg_14_2
		})

		return
	end)
	self:bind(IslandMediator.KICK_ALL_VISITOR, function(arg_15_0, arg_15_1)
		self:sendNotification(GAME.ISLAND_ACCESS_OP, {
			op = IslandConst.ACCESS_OP_KICK,
			list = arg_15_1
		})

		return
	end)
	self:bind(IslandMediator.ADD_BLACK_LIST, function(arg_16_0, arg_16_1)
		self:sendNotification(GAME.ISLAND_ACCESS_OP, {
			op = IslandConst.ACCESS_OP_ADD_BLACKLIST,
			list = {
				arg_16_1
			}
		})

		return
	end)
	self:bind(IslandMediator.REMOVE_BLACK_LIST, function(arg_17_0, arg_17_1)
		self:sendNotification(GAME.ISLAND_ACCESS_OP, {
			op = IslandConst.ACCESS_OP_DEL_BLACKLIST,
			list = {
				arg_17_1
			}
		})

		return
	end)
	self:bind(IslandMediator.ADD_WHITE_LIST, function(arg_18_0, arg_18_1)
		self:sendNotification(GAME.ISLAND_ACCESS_OP, {
			op = IslandConst.ACCESS_OP_ADD_WHITELIST,
			list = {
				arg_18_1
			}
		})

		return
	end)
	self:bind(IslandMediator.REMOVE_WHITE_LIST, function(arg_19_0, arg_19_1)
		self:sendNotification(GAME.ISLAND_ACCESS_OP, {
			op = IslandConst.ACCESS_OP_DEL_WHITELIST,
			list = {
				arg_19_1
			}
		})

		return
	end)
	self:bind(IslandMediator.REFRESH_INVITECODE, function(arg_20_0, arg_20_1)
		self:sendNotification(GAME.ISLAND_REFRESH_INVITECODE, {
			auto = arg_20_1
		})

		return
	end)
	self:bind(IslandMediator.SET_ACCESS_FLAG, function(arg_21_0, arg_21_1, arg_21_2)
		self:sendNotification(GAME.ISLAND_SET_ACCESS_TYPE, {
			openList = arg_21_1,
			closeList = arg_21_2
		})

		return
	end)
	self:bind(IslandMediator.BATCH_GET_FRIEND, function(arg_22_0, arg_22_1, arg_22_2)
		self:sendNotification(GAME.BATCH_GET_FRIEND, {
			list = arg_22_1,
			callback = arg_22_2
		})

		return
	end)
	self:bind(IslandMediator.SEARCH_FRIEND, function(arg_23_0, arg_23_1, arg_23_2)
		self:sendNotification(GAME.FRIEND_SEARCH, {
			type = arg_23_1,
			keyword = arg_23_2
		})

		return
	end)
	self:bind(IslandMediator.ADD_FRIEND, function(arg_24_0, arg_24_1, arg_24_2)
		self:sendNotification(GAME.FRIEND_SEND_REQUEST, {
			id = arg_24_1,
			msg = arg_24_2
		})

		return
	end)
	self:bind(IslandMediator.REMOVE_FRIEND, function(arg_25_0, arg_25_1)
		self:sendNotification(GAME.FRIEND_DELETE, arg_25_1)

		return
	end)
	self:bind(IslandMediator.ENTER_ISLAND, function(arg_26_0, arg_26_1)
		self:sendNotification(GAME.ISLAND_ENTER, {
			id = arg_26_1
		})

		return
	end)
	self:bind(IslandMediator.ENTER_ISLAND_BY_CODE, function(arg_27_0, arg_27_1)
		self:sendNotification(GAME.ISLAND_ENTER, {
			code = arg_27_1
		})

		return
	end)
	self:bind(IslandMediator.SHARE_SIGNIN, function(arg_28_0)
		self:sendNotification(GAME.ISLAND_SIGN_SHARE_SIGNIN)

		return
	end)
	self:bind(IslandMediator.SIGN_IN_INVITATION, function(arg_29_0, arg_29_1)
		self:sendNotification(GAME.ISLAND_SIGN_IN_INVITATION, {
			list = arg_29_1
		})

		return
	end)
	self:bind(IslandMediator.SELECT_GIFT, function(arg_30_0, arg_30_1, arg_30_2)
		self:sendNotification(GAME.ISLAND_SELECT_GIFT, {
			islandId = arg_30_1,
			pos = arg_30_2
		})

		return
	end)
	self:bind(IslandMediator.SIGNIN, function(arg_31_0)
		self.viewComponent:PlayStory({
			name = "ISLANDSTORY100",
			callback = function()
				self:sendNotification(GAME.ISLAND_SIGN_IN)

				return
			end
		})

		return
	end)
	self:bind(IslandMediator.INVITE_SHIP, function(arg_33_0, arg_33_1)
		self:sendNotification(GAME.ISLAND_INVITE_SHIP, {
			id = arg_33_1
		})

		return
	end)
	self:bind(IslandMediator.SHIP_SKILL_UPGRADE, function(arg_34_0, arg_34_1)
		self:sendNotification(GAME.ISLAND_SHIP_SKILL_UPGRADE, {
			id = arg_34_1
		})

		return
	end)
	self:bind(IslandMediator.SHIP_ATTR_LIMIT_UNLOCK, function(arg_35_0, arg_35_1)
		self:sendNotification(GAME.ISLNAD_SHIP_ATTR_LIMIT_UNLOCK, {
			id = arg_35_1
		})

		return
	end)
	self:bind(IslandMediator.SHIP_ATTR_UPGRADE, function(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
		self:sendNotification(GAME.ISLNAD_SHIP_ATTR_UPGRADE, {
			id = arg_36_1,
			attrKy = arg_36_2,
			list = arg_36_3
		})

		return
	end)
	self:bind(IslandMediator.SHIP_BREAKOUT, function(arg_37_0, arg_37_1)
		self:sendNotification(GAME.ISLAND_SHIP_BREAKOUT, {
			id = arg_37_1
		})

		return
	end)
	self:bind(IslandMediator.USE_SHIP_EXP_BOOK, function(arg_38_0, arg_38_1, arg_38_2)
		self:sendNotification(GAME.ISLAND_USE_SHIP_EXP_BOOK, {
			id = arg_38_1,
			list = arg_38_2
		})

		return
	end)
	self:bind(IslandMediator.OPEN_PAGE, function(arg_39_0, arg_39_1, arg_39_2)
		self.viewComponent:OpenPage(_G[arg_39_1], unpack(arg_39_2 or {}))

		return
	end)
	self:bind(IslandMediator.UNLOKC_SHIP_ORDER, function(arg_40_0, arg_40_1)
		self:sendNotification(GAME.ISLAND_SHIP_ORDER_OP, {
			op = IslandShipOrder.OP_TYPE_UNLOCK,
			slotId = arg_40_1
		})

		return
	end)
	self:bind(IslandMediator.GET_SHIP_ORDER_AWARD, function(arg_41_0, arg_41_1)
		self:sendNotification(GAME.ISLAND_SHIP_ORDER_OP, {
			op = IslandShipOrder.OP_TYPE_GET_AWARD,
			slotId = arg_41_1
		})

		return
	end)
	self:bind(IslandMediator.SUBMIT_SHIP_ORDER_ITME, function(arg_42_0, arg_42_1, arg_42_2)
		self:sendNotification(GAME.ISLAND_SHIP_ORDER_OP, {
			op = IslandShipOrder.OP_TYPE_LOADUP,
			slotId = arg_42_1,
			index = arg_42_2
		})

		return
	end)
	self:bind(IslandMediator.SUBMIT_SHIP_ORDER_ITME_ONEKEY, function(arg_43_0, arg_43_1)
		self:sendNotification(GAME.ISLAND_SHIP_ORDER_OP, {
			op = IslandShipOrder.OP_TYPE_LOADUP_ALL,
			slotId = arg_43_1
		})

		return
	end)
	self:bind(IslandMediator.SET_ORDER_TENDENCY, function(arg_44_0, arg_44_1)
		self:sendNotification(GAME.ISLAND_SET_ORDER_TENDENCY, {
			value = arg_44_1
		})

		return
	end)
	self:bind(IslandMediator.ONE_KEY, function(arg_45_0)
		self:sendNotification(GAME.ISLAND_GET_OVERFLOW_ITEM)

		return
	end)
	self:bind(IslandMediator.UPGRADE_AGORA, function(arg_46_0)
		self:sendNotification(GAME.ISLAND_UPGRADE_AGORA)

		return
	end)
	self:bind(IslandMediator.SAVE_AGORA, function(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
		self:sendNotification(GAME.ISLAND_SAVE_AGORA, {
			list = arg_47_1,
			floorList = arg_47_2,
			tileList = arg_47_3
		})

		return
	end)
	self:bind(IslandMediator.SAVE_AGORA_THEME, function(arg_48_0, arg_48_1)
		self:sendNotification(GAME.ISLAND_SAVE_AGORA_THEME, {
			themeData = arg_48_1
		})

		return
	end)
	self:bind(IslandMediator.DEL_AGORA_THEME, function(arg_49_0, arg_49_1)
		self:sendNotification(GAME.ISLAND_DEL_AGORA_THEME, {
			id = arg_49_1
		})

		return
	end)
	self:bind(IslandMediator.ON_KICK_PLAYER, function(arg_50_0, arg_50_1, arg_50_2)
		self:sendNotification(GAME.ISLAND_ACCESS_OP, {
			op = arg_50_1,
			list = {
				arg_50_2
			}
		})

		return
	end)
	self:bind(IslandMediator.ON_GIVE_GIFT, function(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
		self:sendNotification(GAME.ISLAND_GIVE_GIFT, {
			id = arg_51_3,
			itemId = arg_51_1
		})

		return
	end)
	self:bind(IslandMediator.UPGRADE_SKILL, function(arg_52_0, arg_52_1)
		self:sendNotification(GAME.ISLAND_UPGRADE_SKILL, {
			id = arg_52_1
		})

		return
	end)
	self:bind(IslandMediator.OPEN_SHIP_INDEX, function(arg_53_0, arg_53_1)
		self:addSubLayers(Context.New({
			viewComponent = IslandShipIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_53_1
		}))

		return
	end)
	self:bind(IslandMediator.ON_USE_ITEM, function(arg_54_0, arg_54_1, arg_54_2)
		self:sendNotification(GAME.ISLAND_USE_ITEM, {
			id = arg_54_1,
			count = arg_54_2
		})

		return
	end)
	self:bind(IslandMediator.ON_GEN_NEW_ORDER, function(arg_55_0, arg_55_1)
		self:sendNotification(GAME.ISLAND_GEN_NEW_ORDER, {
			slotId = arg_55_1
		})

		return
	end)
	self:bind(IslandMediator.ON_GET_ORDER_EXP_AWARD, function(arg_56_0, arg_56_1, arg_56_2)
		self:sendNotification(GAME.ISLAND_GET_ORDER_EXP_AWARD, {
			level = arg_56_1,
			callback = arg_56_2
		})

		return
	end)
	self:bind(IslandMediator.ON_REPLACE_ORDER, function(arg_57_0, arg_57_1)
		self:sendNotification(GAME.ISLAND_REPLACE_ORDER, {
			slotId = arg_57_1
		})

		return
	end)
	self:bind(IslandMediator.ON_SUBMIT_ORDER, function(arg_58_0, arg_58_1)
		self:sendNotification(GAME.ISLAND_SUBMIT_ORDER, {
			slotId = arg_58_1
		})

		return
	end)
	self:bind(IslandMediator.ON_UPGRADE_INVENTORY, function(arg_59_0)
		self:sendNotification(GAME.ISLAND_UPGRADE_INVENTORY)

		return
	end)
	self:bind(IslandMediator.GET_PROSPERITY_AWARD, function(arg_60_0, arg_60_1)
		self:sendNotification(GAME.ISLAND_PROSPERITY_AWARD, {
			level = arg_60_1
		})

		return
	end)
	self:bind(IslandMediator.ON_EDIT_MANIFESTO, function(arg_61_0, arg_61_1)
		self:sendNotification(GAME.ISLAND_SET_MANIFESTO, {
			manifesto = arg_61_1
		})

		return
	end)
	self:bind(IslandMediator.SET_NAME, function(arg_62_0, arg_62_1, arg_62_2)
		self:sendNotification(GAME.ISLAND_SET_NAME, {
			name = arg_62_1,
			currency = arg_62_2
		})

		return
	end)
	self:bind(IslandMediator.ON_ACCEPT_TASK, function(arg_63_0, arg_63_1, arg_63_2)
		self:sendNotification(GAME.ISLAND_ACCEPT_TASK, {
			taskIds = arg_63_1,
			callback = arg_63_2
		})

		return
	end)
	self:bind(IslandMediator.ON_SUBMIT_TASK, function(arg_64_0, arg_64_1, arg_64_2)
		self:sendNotification(GAME.ISLAND_SUBMIT_TASK, {
			taskId = arg_64_1,
			callback = arg_64_2
		})

		return
	end)
	self:bind(IslandMediator.ON_SUBMIT_TASK_ONE_STEP, function(arg_65_0, arg_65_1, arg_65_2)
		self:sendNotification(GAME.ISLAND_SUBMIT_TASK_ONE_STEP, {
			taskIds = arg_65_1,
			callback = arg_65_2
		})

		return
	end)
	self:bind(IslandMediator.ON_CLIENT_UPDATE_TASK, function(arg_66_0, arg_66_1)
		self:sendNotification(GAME.ISLAND_UPDATE_TASK, {
			taskId = arg_66_1.taskId,
			targetId = arg_66_1.targetId,
			progress = arg_66_1.progress
		})

		return
	end)
	self:bind(IslandMediator.ON_SET_TRACE_ID, function(arg_67_0, arg_67_1, arg_67_2)
		self:sendNotification(GAME.ISLAND_SET_TRACE_TASK, {
			traceId = arg_67_1,
			type = arg_67_2
		})

		return
	end)
	self:bind(IslandMediator.ON_RESET_SEASON, function(arg_68_0, arg_68_1)
		self:sendNotification(GAME.ISLAND_RESET_SEASON, {
			callback = arg_68_1
		})

		return
	end)
	self:bind(IslandMediator.ON_GET_SEASON_RANK, function(arg_69_0, arg_69_1, arg_69_2)
		self:sendNotification(GAME.ISLAND_GET_SEASON_RANK, {
			type = arg_69_1,
			seasonId = arg_69_2
		})

		return
	end)
	self:bind(IslandMediator.ON_CONVERT_SEASON_PT, function(arg_70_0, arg_70_1)
		self:sendNotification(GAME.ISLAND_CONVERT_SEASON_PT, {
			type = 1,
			list = arg_70_1
		})

		return
	end)
	self:bind(IslandMediator.ON_CONVERT_SEASON_PT_4_OVERFLOW, function(arg_71_0, arg_71_1)
		self:sendNotification(GAME.ISLAND_CONVERT_SEASON_PT, {
			type = 2,
			list = arg_71_1
		})

		return
	end)
	self:bind(IslandMediator.ON_GET_SEASON_PT_AWARD, function(arg_72_0, arg_72_1)
		self:sendNotification(GAME.ISLAND_GET_SEASON_PT_AWARD, {
			pt = arg_72_1
		})

		return
	end)
	self:bind(IslandMediator.OPEN_RESTAURANT, function(arg_73_0, arg_73_1)
		self:sendNotification(GAME.ISLAND_OPEN_RESTAURANT, {
			restId = arg_73_1.restId,
			ships = arg_73_1.ships,
			commodities = arg_73_1.commodities,
			estimateData = arg_73_1.estimateData
		})

		return
	end)
	self:bind(IslandMediator.CLOSE_RESTAURANT, function(arg_74_0, arg_74_1, arg_74_2)
		self:sendNotification(GAME.ISLAND_CLOSE_RESTAURANT, {
			restId = arg_74_1,
			isPost = arg_74_2
		})

		return
	end)
	self:bind(IslandMediator.GET_ACHIEVEMENT_AWARD, function(arg_75_0, arg_75_1)
		self:sendNotification(GAME.ISLAND_GET_ACHV_AWARD, {
			ids = arg_75_1
		})

		return
	end)
	self:bind(IslandMediator.SET_SETTINGS_FLAG, function(arg_76_0, arg_76_1)
		self:sendNotification(GAME.ISLAND_SETTING_FLAG, {
			flags = arg_76_1
		})

		return
	end)
	self:bind(IslandMediator.UPDATE_ILLUSTRATION, function(arg_77_0, arg_77_1, arg_77_2)
		self:sendNotification(GAME.ISLAND_UPDATE_ILLUSTRATION, {
			type = arg_77_1,
			linkId = arg_77_2
		})

		return
	end)
	self:bind(IslandMediator.UNLOCK_ILLUSTRATION, function(arg_78_0, arg_78_1)
		self:sendNotification(GAME.ISLAND_UNLOCK_ILLUSTRATION, {
			ids = arg_78_1
		})

		return
	end)
	self:bind(IslandMediator.GET_COLLECT_POINT, function(arg_79_0, arg_79_1)
		self:sendNotification(GAME.ISLAND_GET_COLLECT_POINT, {
			ids = arg_79_1
		})

		return
	end)
	self:bind(IslandMediator.GET_POINT_AWARD, function(arg_80_0, arg_80_1)
		self:sendNotification(GAME.ISLAND_GET_POINT_AWARD, {
			id = arg_80_1
		})

		return
	end)
	self:bind(IslandMediator.REMOVE_EXPIRED_TICKETS, function(arg_81_0, arg_81_1, arg_81_2)
		self:sendNotification(GAME.ISLAND_REMOVE_EXPIRED_TICKET, {
			tickets = arg_81_1,
			callback = arg_81_2
		})

		return
	end)
	self:bind(IslandMediator.USE_TICKETS, function(arg_82_0, arg_82_1, arg_82_2, arg_82_3)
		self:sendNotification(GAME.ISLAND_USE_TICKET, {
			type = arg_82_1,
			id = arg_82_2,
			tickets = arg_82_3
		})

		return
	end)
	self:bind(IslandMediator.EXCHANGE_ITME, function(arg_83_0, arg_83_1, arg_83_2, arg_83_3)
		self:sendNotification(GAME.ISLAND_EXCHANGE_ITEM, {
			list = arg_83_1,
			tempId = arg_83_2,
			tempCnt = arg_83_3
		})

		return
	end)
	self:bind(IslandMediator.ON_UNLOCK_TECH, function(arg_84_0, arg_84_1)
		self:sendNotification(GAME.ISLAND_UNLOCK_TECH, {
			techId = arg_84_1
		})

		return
	end)
	self:bind(IslandMediator.ON_FINISH_TECH_IMMD, function(arg_85_0, arg_85_1, arg_85_2)
		self:sendNotification(GAME.ISLAND_FINISH_TECH_IMMD, {
			techId = arg_85_1,
			callback = arg_85_2
		})

		return
	end)
	self:bind(IslandMediator.START_DELEGATION, function(arg_86_0, arg_86_1, arg_86_2, arg_86_3, arg_86_4, arg_86_5, arg_86_6)
		self:sendNotification(GAME.ISLAND_START_DELEGATION, {
			build_id = arg_86_1,
			area_id = arg_86_2,
			ship_id = arg_86_3,
			formula_id = arg_86_4,
			num = arg_86_5,
			extraCost = arg_86_6
		})

		return
	end)
	self:bind(IslandMediator.ADD_DELEGATION, function(arg_87_0, arg_87_1, arg_87_2, arg_87_3, arg_87_4)
		self:sendNotification(GAME.ISLAND_ADD_DELEGATION, {
			build_id = arg_87_1,
			area_id = arg_87_2,
			add_num = arg_87_3,
			extraCost = arg_87_4
		})

		return
	end)
	self:bind(IslandMediator.STOP_DELEGATION, function(arg_88_0, arg_88_1, arg_88_2)
		self:sendNotification(GAME.ISLAND_FINISH_DELEGATION, {
			build_id = arg_88_1,
			area_id = arg_88_2
		})

		return
	end)
	self:bind(IslandMediator.GET_DELEGATION_AWARD, function(arg_89_0, arg_89_1, arg_89_2, arg_89_3, arg_89_4, arg_89_5)
		self:sendNotification(GAME.ISLAND_GET_DELEGATION_AWARD, {
			build_id = arg_89_1,
			area_id = arg_89_2,
			type = arg_89_3,
			callback = arg_89_4,
			isPost = arg_89_5
		})

		return
	end)
	self:bind(IslandMediator.GET_SHOP_DATA, function(arg_90_0, arg_90_1, arg_90_2)
		self:sendNotification(GAME.ISLAND_SHOP_OP, {
			operation = IslandConst.SHOP_GET_DATA,
			shopId = arg_90_1,
			refreshAll = arg_90_2
		})

		return
	end)
	self:bind(IslandMediator.BUY_COMMODITY, function(arg_91_0, arg_91_1)
		self:sendNotification(GAME.ISLAND_SHOP_OP, {
			operation = IslandConst.SHOP_BUY_COMMODITY,
			commodityList = arg_91_1
		})

		return
	end)
	self:bind(IslandMediator.REFRESH_SHOP_BY_PLAYER, function(arg_92_0, arg_92_1, arg_92_2)
		self:sendNotification(GAME.ISLAND_SHOP_OP, {
			operation = IslandConst.SHOP_REFRESH_BY_PLAYER,
			shopId = arg_92_1,
			resource = arg_92_2
		})

		return
	end)
	self:bind(IslandMediator.DRAW_AWARD_OPERATION, function(arg_93_0, arg_93_1)
		self:sendNotification(GAME.ACTIVITY_DRAW_AWARD_OPERATION, arg_93_1)

		return
	end)
	self:bind(IslandMediator.SHOPPING, function(arg_94_0, arg_94_1, arg_94_2)
		self:sendNotification(GAME.SHOPPING, {
			id = arg_94_1,
			count = arg_94_2
		})

		return
	end)
	self:bind(IslandMediator.GET_AUTO_COLLECTION_DATA, function(arg_95_0, arg_95_1)
		self:sendNotification(GAME.ISLAND_GET_AUTO_COLLECTION_DATA, {
			type = arg_95_1
		})

		return
	end)
	self:bind(IslandMediator.PLAY_ROOM_INVITE_AGREE, function(arg_96_0, arg_96_1)
		self:sendNotification(GAME.PLAY_ROOM_JOIN_ROOM, arg_96_1)

		return
	end)
	self:bind(IslandMediator.PLAY_ROOM_INVITE_REFUSE, function(arg_97_0, arg_97_1)
		self:sendNotification(GAME.PLAY_ROOM_INVITE_REFUSE, arg_97_1)

		return
	end)
	self:bind(IslandMediator.PLAY_ROOM_MATCH_STOP, function(arg_98_0)
		self:sendNotification(GAME.PLAY_ROOM_EXIT_ROOM, {
			arg = 0
		})

		return
	end)
	self:bind(IslandMediator.CHEATER_TAVERN_OPERATE, function(arg_99_0, arg_99_1, arg_99_2)
		self:sendNotification(GAME.ISLAND_PLAYER_CHEATER_OPERATE, {
			type = arg_99_1,
			arg_list = arg_99_2
		})

		return
	end)
	self:bind(IslandMediator.CHEATER_TAVERN_CANCEL_DELEGATE, function(arg_100_0, arg_100_1)
		self:sendNotification(GAME.ISLAND_PLAYER_CHEATER_CANCEL_DELEGATE, {
			type = 1
		})

		return
	end)
	self:bind(IslandMediator.CHEATER_TAVERN_START_SOLO_GAME, function(arg_101_0)
		self:sendNotification(GAME.ISLAND_CHEATER_START_SOLO_GAME, {
			bot_num = 3
		})

		return
	end)
	self:bind(IslandMediator.CHEATER_TAVERN_END_SOLO_GAME, function(arg_102_0)
		self:sendNotification(GAME.ISLAND_CHEATER_END_SOLO_GAME)

		return
	end)
	self:bind(IslandMediator.SHOW_MSG_BOX, function(arg_103_0, arg_103_1)
		self.viewComponent:ShowMsgbox(arg_103_1)

		return
	end)

	return
end

function IslandMediator:_listNotificationInterests()
	return {
		GAME.ISLAND_SET_NAME_DONE,
		GAME.ISLAND_PROSPERITY_AWARD_DONE,
		GAME.ISLAND_UPGRADE_DONE,
		GAME.ISLAND_SET_MANIFESTO_DONE,
		GAME.ISLAND_UPGRADE_INVENTORY_DONE,
		GAME.ISLAND_SUBMIT_ORDER_DONE,
		GAME.ISLAND_REPLACE_ORDER_DONE,
		GAME.ISLAND_GET_ORDER_EXP_AWARD_DONE,
		GAME.ISLAND_GET_RANDOM_REFRESH_TASK_DONE,
		GAME.ISLAND_ACCEPT_TASK_DONE,
		GAME.ISLAND_UPDATE_TASK_DONE,
		GAME.ISLAND_SUBMIT_TASK_DONE,
		GAME.ISLAND_SUBMIT_TASK_ONE_STEP_DONE,
		GAME.SUBMIT_ACTIVITY_TASK_IN_ISLAND_DONE,
		GAME.ISLAND_SET_TRACE_TASK_DONE,
		GAME.ISLAND_GET_ACHV_AWARD_DONE,
		GAME.ISLAND_SETTING_FLAG_DONE,
		GAME.ISLAND_UPDATE_ILLUSTRATION_DONE,
		GAME.ISLAND_UNLOCK_ILLUSTRATION_DONE,
		GAME.ISLAND_GET_COLLECT_POINT_DONE,
		GAME.ISLAND_GET_POINT_AWARD_DONE,
		GAME.ISLAND_REMOVE_EXPIRED_TICKET_DONE,
		GAME.ISLAND_USE_TICKET_DONE,
		GAME.ISLAND_EXCHANGE_ITEM_DONE,
		GAME.ISLAND_GET_SEASON_PT_AWARD_DONE,
		GAME.ISLAND_CONVERT_SEASON_PT_DONE,
		GAME.ISLAND_GET_SEASON_RANK_DONE,
		GAME.ISLAND_OPEN_RESTAURANT_DONE,
		GAME.ISLAND_CLOSE_RESTAURANT_DONE,
		GAME.ISLAND_UPGRADE_SKILL_DONE,
		GAME.ISLAND_USE_ITEM_DONE,
		GAME.ISLAND_GET_OVERFLOW_ITEM_DOME,
		GAME.ISLAND_SET_ORDER_TENDENCY_DONE,
		GAME.ISLAND_UNLOCK_TECH_DONE,
		GAME.ISLAND_FINISH_TECH_IMMD_DONE,
		GAME.ISLAND_SHIP_ORDER_OP_DONE,
		GAME.ISLAND_START_DELEGATION_DONE,
		GAME.ISLAND_GET_DELEGATION_AWARD_DONE,
		GAME.ISLAND_FINISH_DELEGATION_DONE,
		GAME.ISLAND_USE_SHIP_EXP_BOOK_DONE,
		GAME.ISLAND_SHIP_BREAKOUT_DONE,
		GAME.ISLNAD_SHIP_ATTR_UPGRADE_DONE,
		GAME.ISLNAD_SHIP_ATTR_LIMIT_UNLOCK_DONE,
		GAME.ISLAND_SHIP_SKILL_UPGRADE_DONE,
		GAME.ISLAND_INVITE_SHIP_DONE,
		GAME.ISLAND_GIVE_GIFT_DONE,
		GAME.ISLAND_SIGN_IN_INVITATION_DONE,
		GAME.FRIEND_SEARCH_DONE,
		GAME.ISLAND_REFRESH_INVITECODE_DONE,
		GAME.ISLAND_QUEUE_UP,
		GAME.ISLAND_ACCESS_OP_DONE,
		GAME.FRIEND_DELETE_DONE,
		GAME.FRIEND_SEND_REQUEST_DONE,
		GAME.ISLAND_SIGN_SHARE_SIGNIN_DONE,
		GAME.ISLAND_SIGN_IN_DONE,
		GAME.ISLAND_GET_NPC_ACTION_AWARD_DONE,
		GAME.ISLAND_FOLLOWER_OP_DONE,
		GAME.ISLAND_RESET_SP,
		GAME.ISLAND_REFRESH_SHIP_ORDER_DONE,
		GAME.ISLAND_EXCHANGE_SHIP_ORDER_DONE,
		GAME.ISLAND_RESET_SHIP_ORDER_DONE,
		GAME.ACTIVITY_DRAW_AWARD_OPERATION_DONE,
		NotificationProxy.FRIEND_REQUEST_REMOVED,
		NotificationProxy.FRIEND_REQUEST_ADDED,
		PlayerProxy.UPDATED,
		GAME.ISLAND_SHOP_OP_DONE,
		GAME.ISLAND_DROPMAIN_AWARD,
		GAME.ISLAND_CHANGE_COMMANDER_DRESS_DONE,
		GAME.ISLAND_CHANGE_ROLE_DRESS_DONE,
		GAME.ISLAND_SEND_ROLE_DRESS_READ_DONE,
		GAME.ISLAND_SEND_COMMANDER_DRESS_READ_DONE,
		GAME.ISLAND_BUY_ROLE_SKIN_COLOR_DONE,
		GAME.ISLAND_BUY_ROLE_DRESS_COLOR_DONE,
		GAME.ISLAND_GET_AUTO_COLLECTION_DATA_DONE,
		GAME.ISLAND_TAKE_AUTO_COLLECTION_DONE,
		PlayerProxy.UPDATED,
		IslandSettingsPage.SELECTCUSTOMGRAPHICSETTING,
		IslandSettingsPage.SELECTGRAPHICSETTINGLEVEL,
		NotificationProxy.FRIEND_REQUEST_REMOVED,
		NotificationProxy.FRIEND_REQUEST_ADDED,
		ActivityProxy.ACTIVITY_UPDATED,
		IslandShipOrderCard.EVENT_CD_END,
		GAME.PLAY_ROOM_JOIN_ROOM_DONE,
		GAME.PLAY_ROOM_MATCH_ENTER_READY_ROOM,
		GAME.ISLAND_CHEATER_FIRSTROND_START,
		GAME.ISLAND_PLAYER_CHEATER_OPERATE_DONE,
		GAME.ISLAND_CHEATER_OPERATE_DONE_NOTIFY,
		GAME.ISLAND_CHEATER_END_SCORE_NOTIFY,
		GAME.ISLAND_CHEATER_REAL_END_NOTIFY,
		GAME.ISLAND_CHEATER_START_SOLO_GAME_DONE,
		GAME.ISLAND_CHEATER_END_SOLO_GAME_DONE,
		GAME.ISLAND_CHEATER_RECONNECT,
		CheaterTavernEvent.PLAY_ROOM_LOAD_ROOM_SCENE,
		GAME.LOAD_LAYERS,
		CheaterTavernEvent.OPEN_SELECT_SHIP,
		GAME.PLAY_ROOM_ALL_LOAD_OVER,
		GAME.PLAY_ROOM_REDAY_ROOM_REFRESH,
		GAME.PLAY_ROOM_MATCH_REDAY_ROOM_REFRESH,
		GAME.ISLAND_CHEATER_DELEGATE_NOTIFY,
		CheaterTavernEvent.CLOSE_SHIP_SELECT_PAGE,
		IslandProxy.PRESS_BACK,
		IslandMediator.OPEN_MACHA_MODEL_PREVIEW,
		IslandMediator.SKIP_MAP
	}
end

function IslandMediator:_handleNotification(arg_105_1)
	local var_105_0 = arg_105_1:getName()
	local var_105_1 = arg_105_1:getBody()

	if var_105_0 == GAME.ISLAND_PROSPERITY_AWARD_DONE or var_105_0 == GAME.ISLAND_CONVERT_SEASON_PT_DONE or var_105_0 == GAME.ISLAND_GET_SEASON_PT_AWARD_DONE or var_105_0 == GAME.ISLAND_GET_ACHV_AWARD_DONE or var_105_0 == GAME.ISLAND_FINISH_TECH_DONE or var_105_0 == GAME.ISLAND_FINISH_TECH_IMMD_DONE or var_105_0 == GAME.ISLAND_SUBMIT_TASK_ONE_STEP_DONE or var_105_0 == GAME.SUBMIT_ACTIVITY_TASK_IN_ISLAND_DONE or var_105_0 == GAME.ISLAND_GET_POINT_AWARD_DONE or var_105_0 == GAME.ISLAND_UNLOCK_ILLUSTRATION_DONE or var_105_0 == GAME.ISLAND_EXCHANGE_ITEM_DONE or var_105_0 == GAME.ISLAND_SHIP_ORDER_OP_DONE or var_105_0 == GAME.ISLAND_GET_DELEGATION_AWARD_DONE or var_105_0 == GAME.ISLAND_GET_NPC_ACTION_AWARD_DONE then
		self.viewComponent:HandleAwardDisplay(var_105_1.dropData, var_105_1.callback)
	elseif var_105_0 == IslandMediator.OPEN_MACHA_MODEL_PREVIEW then
		self.viewComponent:OpenPage(IslandMechaModelPreviewPage)
	elseif var_105_0 == IslandMediator.SKIP_MAP then
		self.viewComponent:emit(IslandBaseMediator.SWITCH_MAP, var_105_1.mapId)
	elseif var_105_0 == GAME.ISLAND_INVITE_SHIP_DONE then
		self:HandleShipDisplay(var_105_1.ship)
	elseif var_105_0 == GAME.ISLAND_TAKE_AUTO_COLLECTION_DONE then
		self.viewComponent:HandleAwardDisplay(var_105_1.dropData, var_105_1.callback, IslandAwardDisplayPage.AUTO_COLLECT)
	elseif var_105_0 == GAME.ISLAND_SHIP_BREAKOUT_DONE then
		self:HandleShipBreakOutAwardDisplay(var_105_1)
	elseif var_105_0 == GAME.ISLAND_GET_ORDER_EXP_AWARD_DONE then
		seriesAsync({
			function(arg_106_0)
				self.viewComponent:emit(IslandOrderPage.ON_UPDADE, {
					level = var_105_1.level,
					callback = arg_106_0
				})

				return
			end
		}, function()
			self.viewComponent:HandleAwardDisplay(var_105_1.dropData, var_105_1.callback)

			return
		end)
	elseif var_105_0 == GAME.ISLAND_GET_OVERFLOW_ITEM_DOME then
		if #var_105_1.awards <= 0 then
			return
		end

		self.viewComponent:DisplayAward({
			title = i18n("island_item_transfer"),
			awards = var_105_1.awards,
			callback = var_105_1.callback
		})
	elseif var_105_0 == GAME.ISLAND_SET_MANIFESTO_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_set_manifesto_success"))
	elseif var_105_0 == GAME.ISLAND_SUBMIT_ORDER_DONE then
		seriesAsync({
			function(arg_108_0)
				self.viewComponent:HandleAwardDisplay(var_105_1.dropData, arg_108_0)

				return
			end
		}, function()
			if var_105_1.callback then
				var_105_1.callback()
			end

			self.viewComponent:emit(IslandScene.ON_CHECK_ORDER_EXP_AWARD)

			return
		end)
	elseif var_105_0 == GAME.ISLAND_ACCEPT_TASK_DONE then
		self:HandleTaskAccepted(var_105_1)
	elseif var_105_0 == GAME.ISLAND_SUBMIT_TASK_DONE then
		seriesAsync({
			function(arg_110_0)
				local var_110_0, var_110_1 = IslandTask.GetSubmitPlayInfo(var_105_1.taskId)

				if var_110_0 == 1 then
					self.viewComponent:PlayStory({
						name = var_110_1,
						callback = arg_110_0
					})
				elseif var_110_0 == 2 then
					self.viewComponent:OnPlayPerformance({
						name = var_110_1,
						callback = arg_110_0
					})
				else
					arg_110_0()
				end

				return
			end
		}, function()
			self.viewComponent:HandleAwardDisplay(var_105_1.dropData, function()
				if pg.island_task[var_105_1.taskId].com_page ~= "" and pg.island_task[var_105_1.taskId].com_page[1] then
					self.viewComponent:OpenPage(_G[pg.island_task[var_105_1.taskId].com_page[1]], pg.island_task[var_105_1.taskId].com_page[2] and unpack(pg.island_task[var_105_1.taskId].com_page[2]))
				end

				existCall(var_105_1.callback)

				return
			end)

			return
		end)
	elseif var_105_0 == GAME.ISLAND_SET_TRACE_TASK_DONE then
		self.viewComponent:OnUpdateTrackTask(var_105_1.traceId, var_105_1.type)
	elseif var_105_0 == GAME.ISLAND_REMOVE_EXPIRED_TICKET_DONE then
		self.viewComponent:ShowMsgbox({
			hideNo = true,
			type = IslandMsgBox.TYPE_TICKET_EXPIRED,
			body = {
				type = IslandTicketExpiredMsgBoxWindow.TYPES.EXPIRED,
				tickets = var_105_1.tickets
			},
			onHide = var_105_1.callback
		})
	elseif var_105_0 == GAME.ISLAND_CLOSE_RESTAURANT_DONE then
		seriesAsync({
			function(arg_113_0)
				if var_105_1.isUpgrade then
					self.viewComponent:OpenPage(IslandRestaurantUpgradePage, var_105_1, arg_113_0)
				else
					arg_113_0()
				end

				return
			end,
			function(arg_114_0)
				if var_105_1.isSpEvent then
					self.viewComponent:OpenPage(IslandRestaurantSettlePage4Event, var_105_1, arg_114_0)
				else
					self.viewComponent:OpenPage(IslandRestaurantSettlePage, var_105_1, arg_114_0)
				end

				return
			end
		}, function()
			self.viewComponent:HandleAwardDisplay(var_105_1.dropData)

			return
		end)
	elseif var_105_0 == GAME.ISLAND_DROPMAIN_AWARD then
		self.viewComponent:UpdateMainAwardReward({
			awards = var_105_1.dropData.awards
		})
	elseif var_105_0 == GAME.ISLAND_QUEUE_UP then
		self.viewComponent:ShowQueueUpMsgBox(var_105_1.id, var_105_1.pos)
	elseif var_105_0 == GAME.ISLAND_SIGN_IN_DONE then
		-- block empty
	elseif var_105_0 == GAME.ISLAND_RESET_SP then
		self.viewComponent:ShowMsgbox({
			content = i18n("grapihcs3d_setting_common_unstuck_msgbox"),
			onYes = function()
				self.viewComponent:emitCoreController(IslandProxy.RESET_SP)

				return
			end
		})
	elseif var_105_0 == GAME.PLAY_ROOM_JOIN_ROOM_DONE then
		if getProxy(ContextProxy):getCurrentContext():getContextByMediator(PlayRoomMainMediator) == nil then
			if self.viewComponent:GetPage(IslandCheaterTavernPrepareMainPage) then
				self:sendNotification(CheaterTavernEvent.PLAY_ROOM_LOAD_ROOM_SCENE, IslandCheaterTavernConst.SceneRoomType.CustomRoom)
			else
				self.viewComponent:OpenPage(_G.IslandCheaterTavernPrepareMainPage, true, IslandCheaterTavernConst.SceneRoomType.CustomRoom)
			end
		end
	elseif var_105_0 == GAME.PLAY_ROOM_MATCH_ENTER_READY_ROOM then
		if self.viewComponent:GetPage(IslandCheaterTavernPrepareMainPage) then
			self:sendNotification(CheaterTavernEvent.PLAY_ROOM_LOAD_ROOM_SCENE, IslandCheaterTavernConst.SceneRoomType.MatchInfoRoom)
		else
			self.viewComponent:OpenPage(_G.IslandCheaterTavernPrepareMainPage, true, IslandCheaterTavernConst.SceneRoomType.MatchInfoRoom)
		end
	end

	return
end

function IslandMediator:HandleTaskAccepted(arg_117_1)
	local var_117_0 = {}
	local var_117_1 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

	for iter_117_0, iter_117_1 in ipairs(arg_117_1.taskIds) do
		local var_117_2 = pg.island_task[iter_117_1]

		if pg.island_task[iter_117_1].rec_perform ~= "" then
			table.insert(var_117_0, function(arg_118_0)
				self.viewComponent:PlayStory({
					name = var_117_2.rec_perform,
					callback = arg_118_0
				})

				return
			end)
		end

		if pg.island_task[iter_117_1].trigger_tips == 1 then
			table.insert(var_117_0, function(arg_119_0)
				self.viewComponent:ShowTaskAcceptPage({
					taskId = iter_117_1,
					callback = arg_119_0
				})

				return
			end)
		end

		local var_117_3 = var_117_1:GetTask(iter_117_1)

		if var_117_3:IsFinish() and var_117_3:IsSubmitImmediately() then
			table.insert(var_117_0, function(arg_120_0)
				pg.m02:sendNotification(GAME.ISLAND_SUBMIT_TASK, {
					taskId = iter_117_1,
					callback = arg_120_0
				})

				return
			end)
		end
	end

	seriesAsync(var_117_0, function()
		existCall(arg_117_1.callback)

		return
	end)

	return
end

function IslandMediator:HandleShipBreakOutAwardDisplay(arg_122_1)
	seriesAsync({
		function(arg_123_0)
			self.viewComponent:DisplayAward({
				type = IslandAwardDisplayPage.TYPE_SHIP_BREAK,
				newShip = arg_122_1.newShip,
				oldShip = arg_122_1.oldShip,
				callback = arg_123_0
			})

			return
		end,
		function(arg_124_0)
			onNextTick(arg_124_0)

			return
		end,
		function(arg_125_0)
			if not arg_122_1.isUnlockSkill then
				arg_125_0()

				return
			end

			self.viewComponent:DisplayAward({
				type = IslandAwardDisplayPage.TYPE_SHIP_SKILL,
				skill = arg_122_1.newShip:GetSkill(),
				ship = arg_122_1.newShip,
				callback = arg_125_0
			})

			return
		end
	})

	return
end

function IslandMediator:HandleShipDisplay(arg_126_1)
	self.viewComponent:OpenPage(IslandGetShipPage, arg_126_1)

	return
end

return IslandMediator
