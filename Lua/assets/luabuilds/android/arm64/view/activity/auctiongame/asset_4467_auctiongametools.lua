local var_0_0 = {
	GetCurrencyCnt = function()
		return getProxy(AuctionGameBaseProxy).gold
	end,
	GetPreorderCurrentyCnt = function()
		return pg.gameset.auction_preorder_price.key_value
	end
}

function var_0_0.GetLastLocationSelectedID()
	local var_3_0 = PlayerPrefs.GetInt(string.format("AUCTION_GAME_SELECTED_LOCATION_%s", (getProxy(PlayerProxy):getPlayerId())), pg.auction_session.all[1])

	if pg.auction_session[var_3_0] == nil then
		var_3_0 = pg.auction_session.all[1]
	end

	local var_3_1 = var_0_0.GetCurrencyCnt()

	for iter_3_0 = table.keyof(pg.auction_session.all, var_3_0), 1, -1 do
		if var_3_1 >= pg.auction_session[pg.auction_session.all[iter_3_0]].threshold then
			return pg.auction_session.all[iter_3_0]
		end
	end

	return pg.auction_session.all[1]
end

function var_0_0.SetLastLocationSelectedID(arg_4_0)
	PlayerPrefs.SetInt(string.format("AUCTION_GAME_SELECTED_LOCATION_%s", (getProxy(PlayerProxy):getPlayerId())), arg_4_0)

	return
end

function var_0_0.GetDisplayShipList()
	return (getProxy(PlayerProxy):getRawData():GetDisplayShipList())
end

function var_0_0:GetDisplayShipVO(arg_6_1)
	if arg_6_1 == nil then
		arg_6_1 = getProxy(SettingsProxy):getCurrentSecretaryIndex()
	end

	return self[arg_6_1], arg_6_1
end

function var_0_0.GetPlayerNoSortList(arg_7_0)
	local var_7_0 = getProxy(AuctionGameProxy)
	local var_7_1 = var_7_0:GetRoundEventAndBidInfoList()[arg_7_0] or {}
	local var_7_2 = var_7_0:GetBidOrderList() or {}
	local var_7_3 = {}

	for iter_7_0, iter_7_1 in ipairs(var_7_0:GetPlayerList()) do
		local var_7_5 = (var_7_1[iter_7_1.id] or {}).bidValue or 0
		local var_7_6 = {
			num = 0,
			playerID = iter_7_1.id,
			bidValue = var_7_5
		}

		var_7_6.bidOrder = table.keyof(var_7_2, iter_7_1.id) or #var_7_2 + 1
		var_7_6.index = iter_7_0
		var_7_3[iter_7_1.id] = var_7_6
	end

	local var_7_7 = {}

	for iter_7_2, iter_7_3 in pairs(var_7_3) do
		table.insert(var_7_7, {
			id = iter_7_2,
			data = iter_7_3
		})
	end

	table.sort(var_7_7, function(arg_8_0, arg_8_1)
		if arg_8_0.data.bidValue == arg_8_1.data.bidValue then
			if arg_8_0.data.bidOrder == arg_8_1.data.bidOrder then
				return arg_8_0.data.index < arg_8_1.data.index
			end

			return arg_8_0.data.bidOrder < arg_8_1.data.bidOrder
		end

		return arg_8_0.data.bidValue > arg_8_1.data.bidValue
	end)

	for iter_7_4, iter_7_5 in ipairs(var_7_7) do
		iter_7_5.data.num = nil and iter_7_5.data.bidValue == (nil).bidValue and iter_7_5.data.bidOrder == (nil).bidOrder and 0 or iter_7_4
	end

	return var_7_7
end

function var_0_0.GetPosRange(arg_9_0)
	if not arg_9_0 or #arg_9_0 == 0 then
		return {
			0,
			0
		}
	end

	local var_9_0
	local var_9_1
	local var_9_2
	local var_9_3

	for iter_9_0, iter_9_1 in ipairs(arg_9_0) do
		local var_9_4 = iter_9_1.x
		local var_9_5 = iter_9_1.y

		var_9_0 = var_9_0 and math.min(var_9_0, var_9_4) or var_9_4
		var_9_1 = var_9_1 and math.max(var_9_1, var_9_4) or var_9_4
		var_9_2 = var_9_2 and math.min(var_9_2, var_9_5) or var_9_5
		var_9_3 = var_9_3 and math.max(var_9_3, var_9_5) or var_9_5
	end

	return {
		var_9_1 - var_9_0 + 1,
		var_9_3 - var_9_2 + 1
	}
end

function var_0_0.IsNoBid()
	local var_10_0 = getProxy(AuctionGameProxy):GetRoundEventAndBidInfoList()

	for iter_10_0, iter_10_1 in pairs(var_10_0[#var_10_0]) do
		if iter_10_1.bidValue ~= 0 then
			return false
		end
	end

	return true
end

function var_0_0.IsBidSuccess()
	local var_11_0 = getProxy(AuctionGameProxy):GetRoundEventAndBidInfoList()

	for iter_11_0, iter_11_1 in pairs(var_11_0[#var_11_0]) do
		if iter_11_1.state == 1 then
			return true
		end
	end

	return false
end

function var_0_0.GetRevealItemEffectName(arg_12_0)
	return string.format("effect/vx_auctiongame_icon%sx%s_%s", pg.auction_collection[arg_12_0].contour[1], pg.auction_collection[arg_12_0].contour[2], ({
		"hui",
		"lan",
		"zi",
		"jin",
		"cai"
	})[pg.auction_collection[arg_12_0].rarity])
end

function var_0_0:RefreshItemDataByEvent()
	local var_13_0 = pg.auction_event[self.event_id]

	if pg.auction_event[self.event_id] == nil then
		return
	end

	print("触发事件:", self.event_id, var_13_0.describe)

	local var_13_1 = getProxy(AuctionGameProxy)
	local var_13_2 = var_13_1:GetStoreItemDataList()
	local var_13_3 = var_13_0.group == AuctionGameConst.EVENT_TYPE_GROUP.COMMON

	switch(var_13_0.type, {
		[AuctionGameConst.EVENT_TYPE.ITEM_CONTOUR_BY_SIZE] = function()
			for iter_14_0, iter_14_1 in ipairs(self.item_list) do
				local var_14_0 = iter_14_1.uid

				if var_13_2[iter_14_1.uid] == nil then
					var_13_2[var_14_0] = AuctionGameStoreItemData.New(iter_14_1)
				else
					var_13_2[var_14_0]:UpdateContour(iter_14_1.pos)
				end

				var_13_2[var_14_0]:InitContour(var_13_0.config_data[1], var_13_0.config_data[2])
				var_13_2[var_14_0]:SetShowContour()
				var_13_2[var_14_0]:SetRevealFlag(true)
			end

			return
		end,
		[AuctionGameConst.EVENT_TYPE.ITEM_POSITION] = function()
			for iter_15_0, iter_15_1 in ipairs(self.item_list) do
				local var_15_0 = iter_15_1.uid

				if var_13_2[iter_15_1.uid] == nil then
					var_13_2[var_15_0] = AuctionGameStoreItemData.New(iter_15_1)
				else
					var_13_2[var_15_0].position = iter_15_1.pos[1]
				end

				var_13_2[var_15_0]:SetShowPos()
				var_13_2[var_15_0]:SetRevealFlag(true)
			end

			return
		end,
		[AuctionGameConst.EVENT_TYPE.RARITY_ITEM_COUNT] = function()
			return
		end,
		[AuctionGameConst.EVENT_TYPE.RANDOM_ITEM_RARITY] = function()
			for iter_17_0, iter_17_1 in ipairs(self.item_list) do
				local var_17_0 = iter_17_1.uid

				if var_13_2[iter_17_1.uid] == nil then
					var_13_2[var_17_0] = AuctionGameStoreItemData.New(iter_17_1)
				else
					var_13_2[var_17_0]:UpdateRarity(iter_17_1.rarity)
				end

				var_13_2[var_17_0]:SetShowRarity()
				var_13_2[var_17_0]:SetRevealFlag(true)
			end

			return
		end,
		[AuctionGameConst.EVENT_TYPE.REVEAL_ITEM] = function()
			for iter_18_0, iter_18_1 in ipairs(self.item_list) do
				var_13_2[iter_18_1.uid] = AuctionGameStoreItemData.New(iter_18_1)

				var_13_2[iter_18_1.uid]:SetRevealFlag(true)
			end

			return
		end,
		[AuctionGameConst.EVENT_TYPE.RARITY_TOTAL_PRICE] = function()
			return
		end,
		[AuctionGameConst.EVENT_TYPE.MAX_CELL_ITEM_CONTOUR] = function()
			for iter_20_0, iter_20_1 in ipairs(self.item_list) do
				local var_20_0 = iter_20_1.uid

				if var_13_2[iter_20_1.uid] == nil then
					var_13_2[var_20_0] = AuctionGameStoreItemData.New(iter_20_1)
				else
					var_13_2[var_20_0]:UpdateContour(iter_20_1.pos)
				end

				var_13_2[var_20_0]:SetShowContour()
				var_13_2[var_20_0]:SetRevealFlag(true)
			end

			return
		end,
		[AuctionGameConst.EVENT_TYPE.RARITY_ITEM_CONTOUR] = function()
			for iter_21_0, iter_21_1 in ipairs(self.item_list) do
				local var_21_0 = iter_21_1.uid

				if var_13_2[iter_21_1.uid] == nil then
					var_13_2[var_21_0] = AuctionGameStoreItemData.New(iter_21_1)
				else
					var_13_2[var_21_0]:UpdateContour(iter_21_1.pos)
					var_13_2[var_21_0]:UpdateRarity(iter_21_1.rarity)
				end

				var_13_2[var_21_0]:UpdateRarity(var_13_0.config_data[1])
				var_13_2[var_21_0]:SetShowContour()
				var_13_2[var_21_0]:SetShowRarity()
				var_13_2[var_21_0]:SetRevealFlag(true)
			end

			return
		end,
		[AuctionGameConst.EVENT_TYPE.MAX_PRICE_ITEM_PRICE] = function()
			return
		end,
		[AuctionGameConst.EVENT_TYPE.MAX_CELL_PRICE] = function()
			return
		end,
		[AuctionGameConst.EVENT_TYPE.MAX_RARITY] = function()
			return
		end,
		[AuctionGameConst.EVENT_TYPE.TOTAL_CELL_COUNT] = function()
			return
		end,
		[AuctionGameConst.EVENT_TYPE.RARITY_ITEMS_TOTAL_PRICE] = function()
			return
		end,
		[AuctionGameConst.EVENT_TYPE.AVERAGE_PRICE] = function()
			return
		end,
		[AuctionGameConst.EVENT_TYPE.ALL_ITEM_CONTOUR] = function()
			for iter_28_0, iter_28_1 in ipairs(self.item_list) do
				local var_28_0 = iter_28_1.uid

				if var_13_2[iter_28_1.uid] == nil then
					var_13_2[var_28_0] = AuctionGameStoreItemData.New(iter_28_1)
				else
					var_13_2[var_28_0]:UpdateContour(iter_28_1.pos)
				end

				var_13_2[var_28_0]:SetShowContour()
				var_13_2[var_28_0]:SetRevealFlag(true)
			end

			return
		end,
		[AuctionGameConst.EVENT_TYPE.RARITY_ITEMS_POSITION] = function()
			for iter_29_0, iter_29_1 in ipairs(self.item_list) do
				local var_29_0 = iter_29_1.uid

				if var_13_2[iter_29_1.uid] == nil then
					var_13_2[var_29_0] = AuctionGameStoreItemData.New(iter_29_1)
				else
					var_13_2[var_29_0]:UpdateRarity(iter_29_1.rarity)
					var_13_2[var_29_0]:UpdatePos(iter_29_1.pos[1])
				end

				var_13_2[var_29_0]:UpdateRarity(var_13_0.config_data[1])
				var_13_2[var_29_0]:SetShowRarity()
				var_13_2[var_29_0]:SetShowPos()
				var_13_2[var_29_0]:SetRevealFlag(true)
			end

			return
		end,
		[AuctionGameConst.EVENT_TYPE.CONTOUR_AVERAGE_PRICE] = function()
			return
		end,
		[AuctionGameConst.EVENT_TYPE.RARITY_ITEMS_CELL_COUNT] = function()
			return
		end,
		[AuctionGameConst.EVENT_TYPE.NULL] = function()
			return
		end
	}, function()
		print("事件类型未支持:" .. var_13_0.type)

		return
	end)
	var_13_1:AddEventSummary(var_13_1:GetRound(), var_13_3, {
		eventID = self.event_id,
		value = self.int_value
	})

	return
end

function var_0_0.GuideInitPlayerList()
	getProxy(AuctionGameProxy):InitGameData(1)

	local var_34_0 = getProxy(PlayerProxy):getRawData()
	local var_34_1 = {
		player_list = {}
	}

	for iter_34_0, iter_34_1 in ipairs(AuctionGameConst.GUIDE_NPC_LIST) do
		local var_34_2 = iter_34_0 == 1 and iter_34_1.icon or ShipSkin.New({
			id = iter_34_1.icon
		}):ToShip().configId

		table.insert(var_34_1.player_list, {
			user_id = tostring(iter_34_0),
			sort = iter_34_0,
			player_info = {
				level = 100,
				id = tostring(iter_34_0),
				name = pg.ship_skin_template[iter_34_1.icon].name,
				display = {
					icon = var_34_2,
					skin = iter_34_1.icon,
					icon_frame = iter_34_1.icon_frame
				}
			}
		})
	end

	table.insert(var_34_1.player_list, {
		sort = 4,
		user_id = var_34_0.id,
		player_info = {
			id = var_34_0.id,
			level = var_34_0.level,
			name = var_34_0.name,
			display = {
				icon = var_34_0.icon,
				skin = var_34_0.skinId,
				icon_frame = var_34_0.iconFrame,
				chat_frame = var_34_0.chatFrame,
				marry_flag = var_34_0.propose and 1 or 0
			}
		}
	})
	getProxy(AuctionGameProxy):UpdatePlayerList(var_34_1)

	return
end

function var_0_0.GuideRound1()
	local var_35_0 = {
		round = 1
	}

	var_35_0.start_time = pg.TimeMgr.GetInstance():GetServerTime()
	var_35_0.public_event_effect = var_0_0.GetFirstRoundPublicEventData()
	var_35_0.event_list = {
		501,
		401,
		201
	}
	var_35_0.timestamp = pg.TimeMgr.GetInstance():GetServerTime() + pg.gameset.auction_event_choose_time.key_value

	local var_35_1 = getProxy(AuctionGameProxy)

	var_35_1:UpdateRoundData(var_35_0)
	var_35_1:ResetPlayerOptState()

	var_35_1.phaseTimestamp = var_35_0.timestamp

	pg.m02:sendNotification(GAME.AUCTION_GAME_NEW_ROUND)

	return
end

function var_0_0.GetFirstRoundPublicEventData(arg_36_0)
	return {
		event_id = 102,
		item_list = {
			{
				uid = 7,
				rarity = AuctionGameConst.GUIDE_ITEM_LIST[7].rarity,
				pos = AuctionGameConst.GUIDE_ITEM_LIST[7].pos
			},
			{
				uid = 9,
				rarity = AuctionGameConst.GUIDE_ITEM_LIST[9].rarity,
				pos = AuctionGameConst.GUIDE_ITEM_LIST[9].pos
			}
		}
	}
end

function var_0_0.GetSecondRoundPublicEventEffect(arg_37_0)
	return {
		event_id = 1101,
		int_value = 3
	}
end

function var_0_0.GuideSelectedEvent(arg_38_0)
	local var_38_0 = {}

	if arg_38_0 == 201 then
		var_38_0 = {
			result = 0,
			public_event_effect = {
				event_id = 201,
				item_list = {
					{
						uid = 1,
						pos = {
							AuctionGameConst.GUIDE_ITEM_LIST[1].pos[1]
						}
					},
					{
						uid = 4,
						pos = {
							AuctionGameConst.GUIDE_ITEM_LIST[4].pos[1]
						}
					},
					{
						uid = 5,
						pos = {
							AuctionGameConst.GUIDE_ITEM_LIST[5].pos[1]
						}
					},
					{
						uid = 10,
						pos = {
							AuctionGameConst.GUIDE_ITEM_LIST[10].pos[1]
						}
					}
				}
			}
		}
	elseif arg_38_0 == 17 then
		var_38_0 = {
			result = 0,
			public_event_effect = {
				event_id = 401,
				item_list = {
					{
						uid = 5,
						rarity = AuctionGameConst.GUIDE_ITEM_LIST[5].rarity,
						pos = {
							AuctionGameConst.GUIDE_ITEM_LIST[5].pos[1]
						}
					},
					{
						uid = 2,
						rarity = AuctionGameConst.GUIDE_ITEM_LIST[2].rarity,
						pos = {
							AuctionGameConst.GUIDE_ITEM_LIST[2].pos[1]
						}
					}
				}
			}
		}
	elseif arg_38_0 == 501 then
		var_38_0 = {
			result = 0,
			public_event_effect = {
				event_id = 501,
				item_list = {
					{
						uid = 3,
						id = AuctionGameConst.GUIDE_ITEM_LIST[3].id,
						rarity = AuctionGameConst.GUIDE_ITEM_LIST[3].rarity,
						pos = AuctionGameConst.GUIDE_ITEM_LIST[3].pos
					}
				}
			}
		}
	end

	local var_38_1 = getProxy(AuctionGameProxy)

	var_38_1:SetPersonalEventSelectedID(arg_38_0)
	var_38_1:UpdateEventEffect(var_38_0.public_event_effect)

	var_38_1.auctionState = AuctionGameConst.AUCTION_PHASE.BID

	var_0_0.GuideSelectedEventOver()

	return
end

function var_0_0.GuideOperateNotify()
	local var_39_0 = {
		round = 1,
		opt_type = 2
	}

	var_39_0.user_id = getProxy(PlayerProxy):getPlayerId()

	getProxy(AuctionGameProxy):UpdatePlayerOptState(var_39_0)

	return
end

function var_0_0.GuideSelectedEventOver()
	local var_40_0 = {}

	var_40_0.timestamp = pg.TimeMgr.GetInstance():GetServerTime() + pg.gameset.auction_bid_time.key_value

	local var_40_1 = {}
	local var_40_2 = {
		event_id = 501
	}

	var_40_2.user_id = getProxy(PlayerProxy):getPlayerId()
	var_40_1[1] = var_40_2
	var_40_1[2] = {
		event_id = 201,
		user_id = "1"
	}
	var_40_1[3] = {
		event_id = 401,
		user_id = "2"
	}
	var_40_1[4] = {
		event_id = 301,
		user_id = "3"
	}
	var_40_0.player_events = var_40_1

	local var_40_3 = getProxy(AuctionGameProxy)

	var_40_3:UpdateGroundEventList(var_40_0.player_events)

	if var_40_0.event_effect then
		var_40_3:UpdateEventEffect(var_40_0.event_effect)
	end

	var_40_3:ResetPlayerOptState()

	var_40_3.phaseTimestamp = var_40_0.timestamp

	pg.m02:sendNotification(GAME.AUCTION_GAME_BID_PHASE)

	return
end

function var_0_0.GuideBided(arg_41_0)
	local var_41_0 = getProxy(PlayerProxy)
	local var_41_1 = {
		timestamp = pg.TimeMgr.GetInstance().GetServerTime(var_41_0) + pg.gameset.auction_publicity_time.key_value
	}
	local var_41_2 = {}

	var_41_2[1] = {
		state = 0,
		user_id = var_41_0:getPlayerId(),
		price = arg_41_0
	}
	var_41_2[2] = {
		state = 0,
		user_id = "1",
		price = arg_41_0
	}
	var_41_2[3] = {
		state = 0,
		user_id = "2",
		price = AuctionGameConst.GUIDE_NPC_BID_VALUE[2][1]
	}
	var_41_2[4] = {
		state = 0,
		user_id = "3",
		price = AuctionGameConst.GUIDE_NPC_BID_VALUE[3][1]
	}
	var_41_1.bid_list = var_41_2

	local var_41_3 = getProxy(AuctionGameProxy)

	var_41_3:UpdatePlayerBidList(var_41_1.bid_list)

	var_41_3.phaseTimestamp = var_41_1.timestamp

	var_0_0.GuideOperateNotify()
	pg.m02:sendNotification(GAME.AUCTION_GAME_ROUND_OVER)

	return
end

function var_0_0.GuideRound2()
	local var_42_0 = {
		round = 2
	}

	var_42_0.start_time = pg.TimeMgr.GetInstance():GetServerTime()
	var_42_0.public_event_effect = var_0_0.GetSecondRoundPublicEventEffect()
	var_42_0.event_list = {
		501,
		401,
		201
	}
	var_42_0.timestamp = pg.TimeMgr.GetInstance():GetServerTime() + pg.gameset.auction_event_choose_time.key_value

	local var_42_1 = getProxy(AuctionGameProxy)

	var_42_1:UpdateRoundData(var_42_0)
	var_42_1:ResetPlayerOptState()

	var_42_1.phaseTimestamp = var_42_0.timestamp

	pg.m02:sendNotification(GAME.AUCTION_GAME_NEW_ROUND)
	var_42_1:SetPersonalEventSelectedID(201)

	var_42_1.auctionState = AuctionGameConst.AUCTION_PHASE.BID

	var_0_0.GuideSelectedEventOver()

	return
end

function var_0_0.GuideSkipToRound2()
	local var_43_0 = {}
	local var_43_1 = {
		state = 0,
		price = 0
	}

	var_43_1.user_id = getProxy(PlayerProxy):getPlayerId()
	var_43_0[1] = var_43_1
	var_43_0[2] = {
		state = 0,
		price = 0,
		user_id = "1"
	}
	var_43_0[3] = {
		state = 0,
		user_id = "2",
		price = AuctionGameConst.GUIDE_NPC_BID_VALUE[2][1]
	}
	var_43_0[4] = {
		state = 0,
		user_id = "3",
		price = AuctionGameConst.GUIDE_NPC_BID_VALUE[3][1]
	}

	local var_43_2 = getProxy(AuctionGameProxy)

	var_43_2:UpdateRoundData({
		round = 1,
		public_event_effect = var_0_0.GetFirstRoundPublicEventData(),
		event_list = {
			501,
			401,
			201
		}
	})
	var_43_2:UpdateGroundEventList({})
	var_43_2:UpdatePlayerBidList(var_43_0)

	local var_43_3 = {
		round = 2
	}

	var_43_3.start_time = pg.TimeMgr.GetInstance():GetServerTime()
	var_43_3.public_event_effect = var_0_0.GetSecondRoundPublicEventEffect()
	var_43_3.event_list = {
		501,
		401,
		201
	}
	var_43_3.timestamp = pg.TimeMgr.GetInstance():GetServerTime() + pg.gameset.auction_event_choose_time.key_value

	local var_43_4 = getProxy(AuctionGameProxy)

	var_43_4:UpdateRoundData(var_43_3)
	var_43_4:ResetPlayerOptState()

	var_43_4.phaseTimestamp = var_43_3.timestamp

	pg.m02:sendNotification(GAME.AUCTION_GAME_NEW_ROUND)
	var_43_4:SetPersonalEventSelectedID(201)

	var_43_4.auctionState = AuctionGameConst.AUCTION_PHASE.BID

	var_0_0.GuideSelectedEventOver()

	return
end

function var_0_0.GuideBided2(arg_44_0)
	local var_44_0 = getProxy(PlayerProxy)
	local var_44_1 = {
		timestamp = pg.TimeMgr.GetInstance().GetServerTime(var_44_0) + pg.gameset.auction_publicity_time.key_value
	}
	local var_44_2 = {}

	var_44_2[1] = {
		state = 0,
		user_id = var_44_0:getPlayerId(),
		price = arg_44_0
	}
	var_44_2[2] = {
		state = 0,
		user_id = "1",
		price = AuctionGameConst.GUIDE_NPC_BID_VALUE[1][2]
	}
	var_44_2[3] = {
		state = 0,
		user_id = "2",
		price = AuctionGameConst.GUIDE_NPC_BID_VALUE[2][2]
	}
	var_44_2[4] = {
		state = 0,
		user_id = "3",
		price = AuctionGameConst.GUIDE_NPC_BID_VALUE[3][2]
	}
	var_44_1.bid_list = var_44_2

	local var_44_3 = getProxy(AuctionGameProxy)

	var_44_3:UpdatePlayerBidList(var_44_1.bid_list)

	var_44_3.phaseTimestamp = var_44_1.timestamp

	pg.m02:sendNotification(GAME.AUCTION_GAME_ROUND_OVER)

	return
end

function var_0_0.GuideSettlement()
	local var_45_0 = 0

	for iter_45_0, iter_45_1 in ipairs(AuctionGameConst.GUIDE_ITEM_LIST) do
		var_45_0 = var_45_0 + pg.auction_collection[iter_45_1.id].value
	end

	local var_45_1 = {}

	var_45_1.bid_user_id = getProxy(PlayerProxy):getPlayerId()
	var_45_1.bid_price = AuctionGameConst.GUIDE_BID_VALUE
	var_45_1.item_list = AuctionGameConst.GUIDE_ITEM_LIST
	var_45_1.change_gold = var_45_0 - AuctionGameConst.GUIDE_BID_VALUE

	getProxy(AuctionGameProxy):UpdateSettlementData(var_45_1)
	pg.m02:sendNotification(GAME.AUCTION_GAME_SETTLEMENT)

	return
end

return var_0_0
