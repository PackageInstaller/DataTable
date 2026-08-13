local var_0_0 = {
	GetCurrencyCnt = function()
		getProxy = var_1_10000
		AuctionGameBaseProxy = var_1_10002

		return var_1_10000(var_1_10002).gold
	end,
	GetPreorderCurrentyCnt = function()
		pg = var_1_10000

		return var_1_10000.gameset.auction_preorder_price.key_value
	end
}

function var_0_0.GetLastLocationSelectedID()
	getProxy = var_1_10000
	PlayerProxy = var_1_10002

	local var_3_0 = var_1_10000(var_1_10002)
	local var_3_1 = var_0.getPlayerId(var_3_0)

	pg = var_1_10001

	local var_3_2 = var_1_10001.auction_session.all[1]

	PlayerPrefs = var_3_0

	local var_3_3 = var_3_0.GetInt

	string = var_1_10004

	local var_3_4 = var_3_3(var_1_10004.format("AUCTION_GAME_SELECTED_LOCATION_%s", var_3_1), var_3_2)

	pg = var_2

	if var_2.auction_session[var_3_4] == nil then
		pg = var_2
		var_3_4 = var_2.auction_session.all[1]
	end

	local var_3_5 = var_0_0.GetCurrencyCnt()

	table = var_1_10003

	local var_3_6 = var_1_10003.keyof

	pg = var_5

	for iter_3_0 = var_3_6(var_5.auction_session.all, var_3_4), 1, -1 do
		pg = var_1_10008
		var_1_10008 = var_1_10008.auction_session.all[iter_3_0]
		pg = var_1_10009

		if var_3_5 >= var_1_10009.auction_session[var_1_10008].threshold then
			return var_1_10008
		end
	end

	pg = var_4

	return var_4.auction_session.all[1]
end

function var_0_0.SetLastLocationSelectedID(arg_4_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)
	local var_4_1 = var_1.getPlayerId(var_4_0)

	PlayerPrefs = var_1_10002

	local var_4_2 = var_1_10002.SetInt

	string = var_1_10004

	var_4_2(var_1_10004.format("AUCTION_GAME_SELECTED_LOCATION_%s", var_4_1), arg_4_0)

	return
end

function var_0_0.GetDisplayShipList()
	getProxy = var_1_10000
	PlayerProxy = var_1_10002

	local var_5_0 = var_1_10000(var_1_10002)
	local var_5_1 = var_0.getRawData(var_5_0)

	return (var_0.GetDisplayShipList(var_5_1))
end

function var_0_0.GetDisplayShipVO(arg_6_0, arg_6_1)
	if arg_6_1 == nil then
		getProxy = var_1_10002
		SettingsProxy = var_1_10004

		local var_6_0 = var_1_10002(var_1_10004)

		arg_6_1 = var_2.getCurrentSecretaryIndex(var_6_0)
	end

	return arg_6_0[arg_6_1], arg_6_1
end

function var_0_0.GetPlayerNoSortList(arg_7_0)
	getProxy = var_1_10001
	AuctionGameProxy = var_1_10003

	local var_7_0 = var_1_10001(var_1_10003)
	local var_7_1

	if not var_1.GetRoundEventAndBidInfoList(var_7_0)[arg_7_0] then
		var_7_1 = {}
	end

	local var_7_2 = var_1
	local var_7_3

	if not var_1.GetBidOrderList(var_7_2) then
		var_7_3 = {}
	end

	local var_7_4 = {}

	ipairs = var_7_2

	for iter_7_0, iter_7_1 in var_7_2(var_1:GetPlayerList()) do
		if not var_7_1[iter_7_1.id] then
			var_1_10011 = {}
		end

		local var_7_5

		if not var_1_10011.bidValue then
			var_7_5 = 0
		end

		local var_7_6 = {
			num = 0,
			playerID = var_10,
			bidValue = var_7_5
		}

		table = var_1_10014

		if not var_1_10014.keyof(var_7_3, var_10) then
			var_1_10014 = #var_7_3 + 1
		end

		var_7_6.bidOrder = var_1_10014
		var_7_6.index = iter_7_0
		var_7_4[var_10] = var_7_6
	end

	local var_7_7 = {}

	pairs = var_6

	for iter_7_2, iter_7_3 in var_6(var_7_4) do
		table = var_1_10011

		var_1_10011.insert(var_7_7, {
			id = iter_7_2,
			data = iter_7_3
		})
	end

	table = var_6

	var_6.sort(var_7_7, function(arg_8_0, arg_8_1)
		if arg_8_0.data.bidValue == arg_8_1.data.bidValue then
			if arg_8_0.data.bidOrder == arg_8_1.data.bidOrder then
				return arg_8_0.data.index < arg_8_1.data.index
			end

			return arg_8_0.data.bidOrder < arg_8_1.data.bidOrder
		end

		return arg_8_0.data.bidValue > arg_8_1.data.bidValue
	end)

	local var_7_8
	local var_7_9 = 0

	ipairs = var_8

	for iter_7_4, iter_7_5 in var_8(var_7_7) do
		if var_7_8 and iter_7_5.data.bidValue == var_7_8.bidValue and iter_7_5.data.bidOrder == var_7_8.bidOrder then
			iter_7_5.data.num = var_7_9
		else
			iter_7_5.data.num = iter_7_4
			var_7_9 = iter_7_4
		end

		var_7_8 = iter_7_5.data
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

	ipairs = var_1_10005

	for iter_9_0, iter_9_1 in var_1_10005(arg_9_0) do
		local var_9_4 = iter_9_1.x
		local var_9_5 = iter_9_1.y

		if var_9_0 then
			math = var_1_10012

			if not var_1_10012.min(var_9_0, var_9_4) then
				::label_9_0::

				var_9_0 = var_9_4
			end

			if var_9_1 then
				math = var_1_10012

				if not var_1_10012.max(var_9_1, var_9_4) then
					::label_9_1::

					var_9_1 = var_9_4
				end

				if var_9_2 then
					math = var_1_10012

					if not var_1_10012.min(var_9_2, var_9_5) then
						::label_9_2::

						var_9_2 = var_9_5
					end

					if var_9_3 then
						math = var_1_10012

						if not var_1_10012.max(var_9_3, var_9_5) then
							::label_9_3::

							var_9_3 = var_9_5
						end
					end
				end
			end
		end
	end

	return {
		var_9_1 - var_9_0 + 1,
		var_9_3 - var_9_2 + 1
	}
end

function var_0_0.IsNoBid()
	getProxy = var_1_10000
	AuctionGameProxy = var_1_10002

	local var_10_0 = var_1_10000(var_1_10002)
	local var_10_1 = var_0.GetRoundEventAndBidInfoList(var_10_0)

	pairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(var_10_1[#var_10_1]) do
		if iter_10_1.bidValue ~= 0 then
			return false
		end
	end

	return true
end

function var_0_0.IsBidSuccess()
	getProxy = var_1_10000
	AuctionGameProxy = var_1_10002

	local var_11_0 = var_1_10000(var_1_10002)
	local var_11_1 = var_0.GetRoundEventAndBidInfoList(var_11_0)

	pairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(var_11_1[#var_11_1]) do
		if iter_11_1.state == 1 then
			return true
		end
	end

	return false
end

function var_0_0.GetRevealItemEffectName(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.auction_collection[arg_12_0].rarity
	local var_12_1 = var_1.contour
	local var_12_2 = {
		"hui",
		"lan",
		"zi",
		"jin",
		"cai"
	}

	string = var_1_10005

	return var_1_10005.format("effect/vx_auctiongame_icon%sx%s_%s", var_12_1[1], var_12_1[2], var_12_2[var_12_0])
end

function var_0_0.RefreshItemDataByEvent(arg_13_0)
	local var_13_0 = arg_13_0.event_id

	pg = var_1_10002

	if var_1_10002.auction_event[var_13_0] == nil then
		return
	end

	print = var_1_10003

	var_1_10003("触发事件:", var_13_0, var_2.describe)

	getProxy = var_1_10003
	AuctionGameProxy = var_5

	local var_13_1 = var_1_10003(var_5)
	local var_13_2 = var_3.GetStoreItemDataList(var_13_1)
	local var_13_3 = var_2.group

	AuctionGameConst = var_13_1

	local var_13_4 = var_13_3 == var_13_1.EVENT_TYPE_GROUP.COMMON

	switch = var_6

	local var_13_5 = var_2.type
	local var_13_6 = {}

	AuctionGameConst = var_1_10010
	var_13_6[var_1_10010.EVENT_TYPE.ITEM_CONTOUR_BY_SIZE] = function()
		ipairs = var_2_10000

		for iter_14_0, iter_14_1 in var_2_10000(arg_13_0.item_list) do
			local var_14_0 = iter_14_1.uid

			if var_13_2[var_14_0] == nil then
				local var_14_1 = var_13_2

				AuctionGameStoreItemData = var_2_10007
				var_14_1[var_14_0] = var_2_10007.New(iter_14_1)
			else
				local var_14_2 = var_13_2[var_14_0]

				var_6.UpdateContour(var_14_2, iter_14_1.pos)
			end

			local var_14_3 = var_0.config_data
			local var_14_4 = var_13_2[var_14_0]

			var_2_10007.InitContour(var_14_4, var_14_3[1], var_14_3[2])

			local var_14_5 = var_13_2[var_14_0]

			var_2_10007.SetShowContour(var_14_5)

			local var_14_6 = var_13_2[var_14_0]

			var_2_10007.SetRevealFlag(var_14_6, true)
		end

		return
	end
	AuctionGameConst = var_10
	var_13_6[var_10.EVENT_TYPE.ITEM_POSITION] = function()
		ipairs = var_2_10000

		for iter_15_0, iter_15_1 in var_2_10000(arg_13_0.item_list) do
			local var_15_0 = iter_15_1.uid

			if var_13_2[var_15_0] == nil then
				local var_15_1 = var_13_2

				AuctionGameStoreItemData = var_2_10007
				var_15_1[var_15_0] = var_2_10007.New(iter_15_1)
			else
				var_13_2[var_15_0].position = iter_15_1.pos[1]
			end

			local var_15_2 = var_13_2[var_15_0]

			var_6.SetShowPos(var_15_2)

			local var_15_3 = var_13_2[var_15_0]

			var_6.SetRevealFlag(var_15_3, true)
		end

		return
	end
	AuctionGameConst = var_10
	var_13_6[var_10.EVENT_TYPE.RARITY_ITEM_COUNT] = function()
		return
	end
	AuctionGameConst = var_10
	var_13_6[var_10.EVENT_TYPE.RANDOM_ITEM_RARITY] = function()
		ipairs = var_2_10000

		for iter_17_0, iter_17_1 in var_2_10000(arg_13_0.item_list) do
			local var_17_0 = iter_17_1.uid

			if var_13_2[var_17_0] == nil then
				local var_17_1 = var_13_2

				AuctionGameStoreItemData = var_2_10007
				var_17_1[var_17_0] = var_2_10007.New(iter_17_1)
			else
				local var_17_2 = var_13_2[var_17_0]

				var_6.UpdateRarity(var_17_2, iter_17_1.rarity)
			end

			local var_17_3 = var_13_2[var_17_0]

			var_6.SetShowRarity(var_17_3)

			local var_17_4 = var_13_2[var_17_0]

			var_6.SetRevealFlag(var_17_4, true)
		end

		return
	end
	AuctionGameConst = var_10
	var_13_6[var_10.EVENT_TYPE.REVEAL_ITEM] = function()
		ipairs = var_2_10000

		for iter_18_0, iter_18_1 in var_2_10000(arg_13_0.item_list) do
			local var_18_0 = iter_18_1.uid
			local var_18_1 = var_13_2

			AuctionGameStoreItemData = var_2_10007
			var_18_1[var_18_0] = var_2_10007.New(iter_18_1)

			local var_18_2 = var_13_2[var_18_0]

			var_6.SetRevealFlag(var_18_2, true)
		end

		return
	end
	AuctionGameConst = var_10
	var_13_6[var_10.EVENT_TYPE.RARITY_TOTAL_PRICE] = function()
		return
	end
	AuctionGameConst = var_10
	var_13_6[var_10.EVENT_TYPE.MAX_CELL_ITEM_CONTOUR] = function()
		ipairs = var_2_10000

		for iter_20_0, iter_20_1 in var_2_10000(arg_13_0.item_list) do
			local var_20_0 = iter_20_1.uid

			if var_13_2[var_20_0] == nil then
				local var_20_1 = var_13_2

				AuctionGameStoreItemData = var_2_10007
				var_20_1[var_20_0] = var_2_10007.New(iter_20_1)
			else
				local var_20_2 = var_13_2[var_20_0]

				var_6.UpdateContour(var_20_2, iter_20_1.pos)
			end

			local var_20_3 = var_13_2[var_20_0]

			var_6.SetShowContour(var_20_3)

			local var_20_4 = var_13_2[var_20_0]

			var_6.SetRevealFlag(var_20_4, true)
		end

		return
	end
	AuctionGameConst = var_10
	var_13_6[var_10.EVENT_TYPE.RARITY_ITEM_CONTOUR] = function()
		ipairs = var_2_10000

		for iter_21_0, iter_21_1 in var_2_10000(arg_13_0.item_list) do
			local var_21_0 = iter_21_1.uid

			if var_13_2[var_21_0] == nil then
				local var_21_1 = var_13_2

				AuctionGameStoreItemData = var_2_10007
				var_21_1[var_21_0] = var_2_10007.New(iter_21_1)
			else
				local var_21_2 = var_13_2[var_21_0]

				var_6.UpdateContour(var_21_2, iter_21_1.pos)

				local var_21_3 = var_13_2[var_21_0]

				var_6.UpdateRarity(var_21_3, iter_21_1.rarity)
			end

			local var_21_4 = var_0.config_data[1]
			local var_21_5 = var_13_2[var_21_0]

			var_2_10007.UpdateRarity(var_21_5, var_21_4)

			local var_21_6 = var_13_2[var_21_0]

			var_2_10007.SetShowContour(var_21_6)

			local var_21_7 = var_13_2[var_21_0]

			var_2_10007.SetShowRarity(var_21_7)

			local var_21_8 = var_13_2[var_21_0]

			var_2_10007.SetRevealFlag(var_21_8, true)
		end

		return
	end
	AuctionGameConst = var_10
	var_13_6[var_10.EVENT_TYPE.MAX_PRICE_ITEM_PRICE] = function()
		return
	end
	AuctionGameConst = var_10
	var_13_6[var_10.EVENT_TYPE.MAX_CELL_PRICE] = function()
		return
	end
	AuctionGameConst = var_10
	var_13_6[var_10.EVENT_TYPE.MAX_RARITY] = function()
		return
	end
	AuctionGameConst = var_10
	var_13_6[var_10.EVENT_TYPE.TOTAL_CELL_COUNT] = function()
		return
	end
	AuctionGameConst = var_10
	var_13_6[var_10.EVENT_TYPE.RARITY_ITEMS_TOTAL_PRICE] = function()
		return
	end
	AuctionGameConst = var_10
	var_13_6[var_10.EVENT_TYPE.AVERAGE_PRICE] = function()
		return
	end
	AuctionGameConst = var_10
	var_13_6[var_10.EVENT_TYPE.ALL_ITEM_CONTOUR] = function()
		ipairs = var_2_10000

		for iter_28_0, iter_28_1 in var_2_10000(arg_13_0.item_list) do
			local var_28_0 = iter_28_1.uid

			if var_13_2[var_28_0] == nil then
				local var_28_1 = var_13_2

				AuctionGameStoreItemData = var_2_10007
				var_28_1[var_28_0] = var_2_10007.New(iter_28_1)
			else
				local var_28_2 = var_13_2[var_28_0]

				var_6.UpdateContour(var_28_2, iter_28_1.pos)
			end

			local var_28_3 = var_13_2[var_28_0]

			var_6.SetShowContour(var_28_3)

			local var_28_4 = var_13_2[var_28_0]

			var_6.SetRevealFlag(var_28_4, true)
		end

		return
	end
	AuctionGameConst = var_10
	var_13_6[var_10.EVENT_TYPE.RARITY_ITEMS_POSITION] = function()
		ipairs = var_2_10000

		for iter_29_0, iter_29_1 in var_2_10000(arg_13_0.item_list) do
			local var_29_0 = iter_29_1.uid

			if var_13_2[var_29_0] == nil then
				local var_29_1 = var_13_2

				AuctionGameStoreItemData = var_2_10007
				var_29_1[var_29_0] = var_2_10007.New(iter_29_1)
			else
				local var_29_2 = var_13_2[var_29_0]

				var_6.UpdateRarity(var_29_2, iter_29_1.rarity)

				local var_29_3 = var_13_2[var_29_0]

				var_6.UpdatePos(var_29_3, iter_29_1.pos[1])
			end

			local var_29_4 = var_0.config_data[1]
			local var_29_5 = var_13_2[var_29_0]

			var_2_10007.UpdateRarity(var_29_5, var_29_4)

			local var_29_6 = var_13_2[var_29_0]

			var_2_10007.SetShowRarity(var_29_6)

			local var_29_7 = var_13_2[var_29_0]

			var_2_10007.SetShowPos(var_29_7)

			local var_29_8 = var_13_2[var_29_0]

			var_2_10007.SetRevealFlag(var_29_8, true)
		end

		return
	end
	AuctionGameConst = var_10
	var_13_6[var_10.EVENT_TYPE.CONTOUR_AVERAGE_PRICE] = function()
		return
	end
	AuctionGameConst = var_10
	var_13_6[var_10.EVENT_TYPE.RARITY_ITEMS_CELL_COUNT] = function()
		return
	end
	AuctionGameConst = var_10
	var_13_6[var_10.EVENT_TYPE.NULL] = function()
		return
	end

	var_6(var_13_5, var_13_6, function()
		print = var_2_10000

		var_2_10000("事件类型未支持:" .. var_0.type)

		return
	end)
	var_3:AddEventSummary(var_3:GetRound(), var_13_4, {
		eventID = var_13_0,
		value = arg_13_0.int_value
	})

	return
end

function var_0_0.GuideInitPlayerList()
	getProxy = var_1_10000
	AuctionGameProxy = var_1_10002

	local var_34_0 = var_1_10000(var_1_10002)

	var_0.InitGameData(var_34_0, 1)

	getProxy = var_0
	PlayerProxy = var_34_0

	local var_34_1 = var_0(var_34_0)
	local var_34_2 = var_0.getRawData(var_34_1)
	local var_34_3 = {
		player_list = {}
	}

	ipairs = var_3
	AuctionGameConst = var_1_10005

	for iter_34_0, iter_34_1 in var_3(var_1_10005.GUIDE_NPC_LIST) do
		local var_34_4

		if iter_34_0 == 1 then
			var_34_4 = iter_34_1.icon
		else
			ShipSkin = var_1_10009

			local var_34_5 = var_1_10009.New({
				id = iter_34_1.icon
			})

			var_34_4 = var_1_10009.ToShip(var_34_5).configId
		end

		table = var_1_10009
		var_1_10009 = var_1_10009.insert

		local var_34_6 = var_34_3.player_list
		local var_34_7 = {}

		tostring = var_1_10013
		var_34_7.user_id = var_1_10013(iter_34_0)
		var_34_7.sort = iter_34_0
		var_1_10013 = {
			level = 100
		}
		tostring = var_1_10014
		var_1_10013.id = var_1_10014(iter_34_0)
		pg = var_1_10014
		var_1_10013.name = var_1_10014.ship_skin_template[iter_34_1.icon].name
		var_1_10013.display = {
			icon = var_34_4,
			skin = iter_34_1.icon,
			icon_frame = iter_34_1.icon_frame
		}
		var_34_7.player_info = var_1_10013

		var_1_10009(var_34_6, var_34_7)
	end

	table = var_3

	var_3.insert(var_34_3.player_list, {
		sort = 4,
		user_id = var_34_2.id,
		player_info = {
			id = var_34_2.id,
			level = var_34_2.level,
			name = var_34_2.name,
			display = {
				icon = var_34_2.icon,
				skin = var_34_2.skinId,
				icon_frame = var_34_2.iconFrame,
				chat_frame = var_34_2.chatFrame,
				marry_flag = var_34_2.propose and 1 or 0
			}
		}
	})

	getProxy = var_3
	AuctionGameProxy = var_5

	local var_34_8 = var_3(var_5)

	var_3.UpdatePlayerList(var_34_8, var_34_3)

	return
end

function var_0_0.GuideRound1()
	local var_35_0 = {
		round = 1
	}

	pg = var_1_10001

	local var_35_1 = var_1_10001.TimeMgr.GetInstance()

	var_35_0.start_time = var_1.GetServerTime(var_35_1)
	var_35_0.public_event_effect = var_0_0.GetFirstRoundPublicEventData()
	var_35_0.event_list = {
		501,
		401,
		201
	}
	pg = var_1

	local var_35_2 = var_1.TimeMgr.GetInstance()
	local var_35_3 = var_1.GetServerTime(var_35_2)

	pg = var_1_10002
	var_35_0.timestamp = var_35_3 + var_1_10002.gameset.auction_event_choose_time.key_value
	getProxy = var_1
	AuctionGameProxy = var_35_2

	local var_35_4 = var_1(var_35_2)

	var_1.UpdateRoundData(var_35_4, var_35_0)
	var_1:ResetPlayerOptState()

	var_1.phaseTimestamp = var_35_0.timestamp
	pg = var_2

	local var_35_5 = var_2.m02
	local var_35_6 = var_2.sendNotification

	GAME = var_5

	var_35_6(var_35_5, var_5.AUCTION_GAME_NEW_ROUND)

	return
end

function var_0_0.GetFirstRoundPublicEventData(arg_36_0)
	local var_36_0 = {
		event_id = 102
	}
	local var_36_1 = {}
	local var_36_2 = {
		uid = 7
	}

	AuctionGameConst = var_1_10004
	var_36_2.rarity = var_1_10004.GUIDE_ITEM_LIST[7].rarity
	AuctionGameConst = var_4
	var_36_2.pos = var_4.GUIDE_ITEM_LIST[7].pos
	var_36_1[1] = var_36_2

	local var_36_3 = {
		uid = 9
	}

	AuctionGameConst = var_4
	var_36_3.rarity = var_4.GUIDE_ITEM_LIST[9].rarity
	AuctionGameConst = var_4
	var_36_3.pos = var_4.GUIDE_ITEM_LIST[9].pos
	var_36_1[2] = var_36_3
	var_36_0.item_list = var_36_1

	return var_36_0
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
		var_1_10002 = {
			result = 0
		}

		local var_38_1 = {
			event_id = 201
		}

		var_1_10004 = {}

		local var_38_2 = {
			uid = 1
		}

		var_1_10006 = {}
		AuctionGameConst = var_1_10007
		var_1_10006[1] = var_1_10007.GUIDE_ITEM_LIST[1].pos[1]
		var_38_2.pos = var_1_10006
		var_1_10004[1] = var_38_2

		local var_38_3 = {
			uid = 4
		}

		var_1_10006 = {}
		AuctionGameConst = var_1_10007
		var_1_10006[1] = var_1_10007.GUIDE_ITEM_LIST[4].pos[1]
		var_38_3.pos = var_1_10006
		var_1_10004[2] = var_38_3

		local var_38_4 = {
			uid = 5
		}

		var_1_10006 = {}
		AuctionGameConst = var_1_10007
		var_1_10006[1] = var_1_10007.GUIDE_ITEM_LIST[5].pos[1]
		var_38_4.pos = var_1_10006
		var_1_10004[3] = var_38_4

		local var_38_5 = {
			uid = 10
		}

		var_1_10006 = {}
		AuctionGameConst = var_1_10007
		var_1_10006[1] = var_1_10007.GUIDE_ITEM_LIST[10].pos[1]
		var_38_5.pos = var_1_10006
		var_1_10004[4] = var_38_5
		var_38_1.item_list = var_1_10004
		var_1_10002.public_event_effect = var_38_1
		var_38_0 = var_1_10002
	elseif arg_38_0 == 17 then
		var_1_10002 = {
			result = 0
		}

		local var_38_6 = {
			event_id = 401
		}

		var_1_10004 = {}

		local var_38_7 = {
			uid = 5
		}

		AuctionGameConst = var_1_10006
		var_38_7.rarity = var_1_10006.GUIDE_ITEM_LIST[5].rarity
		var_1_10006 = {}
		AuctionGameConst = var_1_10007
		var_1_10006[1] = var_1_10007.GUIDE_ITEM_LIST[5].pos[1]
		var_38_7.pos = var_1_10006
		var_1_10004[1] = var_38_7

		local var_38_8 = {
			uid = 2
		}

		AuctionGameConst = var_1_10006
		var_38_8.rarity = var_1_10006.GUIDE_ITEM_LIST[2].rarity
		var_1_10006 = {}
		AuctionGameConst = var_7
		var_1_10006[1] = var_7.GUIDE_ITEM_LIST[2].pos[1]
		var_38_8.pos = var_1_10006
		var_1_10004[2] = var_38_8
		var_38_6.item_list = var_1_10004
		var_1_10002.public_event_effect = var_38_6
		var_38_0 = var_1_10002
	elseif arg_38_0 == 501 then
		var_1_10002 = {
			result = 0
		}

		local var_38_9 = {
			event_id = 501
		}

		var_1_10004 = {}

		local var_38_10 = {
			uid = 3
		}

		AuctionGameConst = var_1_10006
		var_38_10.id = var_1_10006.GUIDE_ITEM_LIST[3].id
		AuctionGameConst = var_6
		var_38_10.rarity = var_6.GUIDE_ITEM_LIST[3].rarity
		AuctionGameConst = var_6
		var_38_10.pos = var_6.GUIDE_ITEM_LIST[3].pos
		var_1_10004[1] = var_38_10
		var_38_9.item_list = var_1_10004
		var_1_10002.public_event_effect = var_38_9
		var_38_0 = var_1_10002
	end

	getProxy = var_1_10002
	AuctionGameProxy = var_1_10004

	local var_38_11 = var_1_10002(var_1_10004)

	var_2.SetPersonalEventSelectedID(var_38_11, arg_38_0)
	var_2:UpdateEventEffect(var_38_0.public_event_effect)

	AuctionGameConst = var_3
	var_2.auctionState = var_3.AUCTION_PHASE.BID

	var_0_0.GuideSelectedEventOver()

	return
end

function var_0_0.GuideOperateNotify()
	local var_39_0 = {
		round = 1,
		opt_type = 2
	}

	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_39_1 = var_1_10001(var_1_10003)

	var_39_0.user_id = var_1.getPlayerId(var_39_1)
	getProxy = var_1
	AuctionGameProxy = var_39_1

	local var_39_2 = var_1(var_39_1)

	var_1.UpdatePlayerOptState(var_39_2, var_39_0)

	return
end

function var_0_0.GuideSelectedEventOver()
	local var_40_0 = {}

	pg = var_1_10001

	local var_40_1 = var_1_10001.TimeMgr.GetInstance()
	local var_40_2 = var_1.GetServerTime(var_40_1)

	pg = var_1_10002
	var_40_0.timestamp = var_40_2 + var_1_10002.gameset.auction_bid_time.key_value

	local var_40_3 = {}
	local var_40_4 = {
		event_id = 501
	}

	getProxy = var_40_1
	PlayerProxy = var_1_10005

	local var_40_5 = var_40_1(var_1_10005)

	var_40_4.user_id = var_3.getPlayerId(var_40_5)
	var_40_3[1] = var_40_4
	var_40_3[2] = {
		event_id = 201,
		user_id = "1"
	}
	var_40_3[3] = {
		event_id = 401,
		user_id = "2"
	}
	var_40_3[4] = {
		event_id = 301,
		user_id = "3"
	}
	var_40_0.player_events = var_40_3
	getProxy = var_40_3
	AuctionGameProxy = var_3

	local var_40_6 = var_40_3(var_3)

	var_1.UpdateGroundEventList(var_40_6, var_40_0.player_events)

	if var_40_0.event_effect then
		var_1:UpdateEventEffect(var_40_0.event_effect)
	end

	var_1:ResetPlayerOptState()

	var_1.phaseTimestamp = var_40_0.timestamp
	pg = var_2

	local var_40_7 = var_2.m02
	local var_40_8 = var_2.sendNotification

	GAME = var_5

	var_40_8(var_40_7, var_5.AUCTION_GAME_BID_PHASE)

	return
end

function var_0_0.GuideBided(arg_41_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_41_0 = var_1_10001(var_1_10003)
	local var_41_1 = var_1.getPlayerId(var_41_0)
	local var_41_2 = {}

	pg = var_41_0

	local var_41_3 = var_41_0.TimeMgr.GetInstance()
	local var_41_4 = var_3.GetServerTime(var_41_3)

	pg = var_1_10004
	var_41_2.timestamp = var_41_4 + var_1_10004.gameset.auction_publicity_time.key_value

	local var_41_5 = {
		{
			state = 0,
			user_id = var_41_1,
			price = arg_41_0
		},
		{
			state = 0,
			user_id = "1",
			price = arg_41_0
		}
	}
	local var_41_6 = {
		state = 0,
		user_id = "2"
	}

	AuctionGameConst = var_41_3
	var_41_6.price = var_41_3.GUIDE_NPC_BID_VALUE[2][1]
	var_41_5[3] = var_41_6

	local var_41_7 = {
		state = 0,
		user_id = "3"
	}

	AuctionGameConst = var_5
	var_41_7.price = var_5.GUIDE_NPC_BID_VALUE[3][1]
	var_41_5[4] = var_41_7
	var_41_2.bid_list = var_41_5
	getProxy = var_41_5
	AuctionGameProxy = var_5

	local var_41_8 = var_41_5(var_5)

	var_3.UpdatePlayerBidList(var_41_8, var_41_2.bid_list)

	var_3.phaseTimestamp = var_41_2.timestamp

	var_0_0.GuideOperateNotify()

	pg = var_4

	local var_41_9 = var_4.m02
	local var_41_10 = var_4.sendNotification

	GAME = var_7

	var_41_10(var_41_9, var_7.AUCTION_GAME_ROUND_OVER)

	return
end

function var_0_0.GuideRound2()
	local var_42_0 = {
		round = 2
	}

	pg = var_1_10001

	local var_42_1 = var_1_10001.TimeMgr.GetInstance()

	var_42_0.start_time = var_1.GetServerTime(var_42_1)
	var_42_0.public_event_effect = var_0_0.GetSecondRoundPublicEventEffect()
	var_42_0.event_list = {
		501,
		401,
		201
	}
	pg = var_1

	local var_42_2 = var_1.TimeMgr.GetInstance()
	local var_42_3 = var_1.GetServerTime(var_42_2)

	pg = var_1_10002
	var_42_0.timestamp = var_42_3 + var_1_10002.gameset.auction_event_choose_time.key_value
	getProxy = var_1
	AuctionGameProxy = var_42_2

	local var_42_4 = var_1(var_42_2)

	var_1.UpdateRoundData(var_42_4, var_42_0)
	var_1:ResetPlayerOptState()

	var_1.phaseTimestamp = var_42_0.timestamp
	pg = var_2

	local var_42_5 = var_2.m02
	local var_42_6 = var_2.sendNotification

	GAME = var_5

	var_42_6(var_42_5, var_5.AUCTION_GAME_NEW_ROUND)
	var_1:SetPersonalEventSelectedID(201)

	AuctionGameConst = var_2
	var_1.auctionState = var_2.AUCTION_PHASE.BID

	var_0_0.GuideSelectedEventOver()

	return
end

function var_0_0.GuideSkipToRound2()
	local var_43_0 = {}
	local var_43_1 = {
		state = 0,
		price = 0
	}

	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_43_2 = var_1_10002(var_1_10004)

	var_43_1.user_id = var_2.getPlayerId(var_43_2)
	var_43_0[1] = var_43_1
	var_43_0[2] = {
		state = 0,
		price = 0,
		user_id = "1"
	}

	local var_43_3 = {
		state = 0,
		user_id = "2"
	}

	AuctionGameConst = var_2
	var_43_3.price = var_2.GUIDE_NPC_BID_VALUE[2][1]
	var_43_0[3] = var_43_3

	local var_43_4 = {
		state = 0,
		user_id = "3"
	}

	AuctionGameConst = var_2
	var_43_4.price = var_2.GUIDE_NPC_BID_VALUE[3][1]
	var_43_0[4] = var_43_4

	local var_43_5 = {
		round = 1,
		public_event_effect = var_0_0.GetFirstRoundPublicEventData(),
		event_list = {
			501,
			401,
			201
		}
	}

	getProxy = var_2
	AuctionGameProxy = var_43_2

	local var_43_6 = var_2(var_43_2)

	var_2.UpdateRoundData(var_43_6, var_43_5)
	var_2:UpdateGroundEventList({})

	local var_43_7 = var_2

	var_2.UpdatePlayerBidList(var_43_7, var_43_0)

	local var_43_8 = {
		round = 2
	}

	pg = var_43_2

	local var_43_9 = var_43_2.TimeMgr.GetInstance()

	var_43_8.start_time = var_4.GetServerTime(var_43_9)
	var_43_8.public_event_effect = var_0_0.GetSecondRoundPublicEventEffect()
	var_43_8.event_list = {
		501,
		401,
		201
	}
	pg = var_4

	local var_43_10 = var_4.TimeMgr.GetInstance()
	local var_43_11 = var_4.GetServerTime(var_43_10)

	pg = var_43_7
	var_43_8.timestamp = var_43_11 + var_43_7.gameset.auction_event_choose_time.key_value
	getProxy = var_4
	AuctionGameProxy = var_43_10

	local var_43_12 = var_4(var_43_10)

	var_4.UpdateRoundData(var_43_12, var_43_8)
	var_4:ResetPlayerOptState()

	var_4.phaseTimestamp = var_43_8.timestamp
	pg = var_5

	local var_43_13 = var_5.m02
	local var_43_14 = var_5.sendNotification

	GAME = var_8

	var_43_14(var_43_13, var_8.AUCTION_GAME_NEW_ROUND)
	var_4:SetPersonalEventSelectedID(201)

	AuctionGameConst = var_5
	var_4.auctionState = var_5.AUCTION_PHASE.BID

	var_0_0.GuideSelectedEventOver()

	return
end

function var_0_0.GuideBided2(arg_44_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_44_0 = var_1_10001(var_1_10003)
	local var_44_1 = var_1.getPlayerId(var_44_0)
	local var_44_2 = {}

	pg = var_44_0

	local var_44_3 = var_44_0.TimeMgr.GetInstance()
	local var_44_4 = var_3.GetServerTime(var_44_3)

	pg = var_1_10004
	var_44_2.timestamp = var_44_4 + var_1_10004.gameset.auction_publicity_time.key_value

	local var_44_5 = {
		{
			state = 0,
			user_id = var_44_1,
			price = arg_44_0
		}
	}
	local var_44_6 = {
		state = 0,
		user_id = "1"
	}

	AuctionGameConst = var_44_3
	var_44_6.price = var_44_3.GUIDE_NPC_BID_VALUE[1][2]
	var_44_5[2] = var_44_6

	local var_44_7 = {
		state = 0,
		user_id = "2"
	}

	AuctionGameConst = var_5
	var_44_7.price = var_5.GUIDE_NPC_BID_VALUE[2][2]
	var_44_5[3] = var_44_7

	local var_44_8 = {
		state = 0,
		user_id = "3"
	}

	AuctionGameConst = var_5
	var_44_8.price = var_5.GUIDE_NPC_BID_VALUE[3][2]
	var_44_5[4] = var_44_8
	var_44_2.bid_list = var_44_5
	getProxy = var_44_5
	AuctionGameProxy = var_5

	local var_44_9 = var_44_5(var_5)

	var_3.UpdatePlayerBidList(var_44_9, var_44_2.bid_list)

	var_3.phaseTimestamp = var_44_2.timestamp
	pg = var_4

	local var_44_10 = var_4.m02
	local var_44_11 = var_4.sendNotification

	GAME = var_7

	var_44_11(var_44_10, var_7.AUCTION_GAME_ROUND_OVER)

	return
end

function var_0_0.GuideSettlement()
	local var_45_0 = 0

	ipairs = var_1_10001
	AuctionGameConst = var_1_10003

	for iter_45_0, iter_45_1 in var_1_10001(var_1_10003.GUIDE_ITEM_LIST) do
		pg = var_1_10006
		var_45_0 = var_45_0 + var_1_10006.auction_collection[iter_45_1.id].value
	end

	local var_45_1 = {}

	getProxy = var_2
	PlayerProxy = iter_45_0

	local var_45_2 = var_2(iter_45_0)

	var_45_1.bid_user_id = var_2.getPlayerId(var_45_2)
	AuctionGameConst = var_2
	var_45_1.bid_price = var_2.GUIDE_BID_VALUE
	AuctionGameConst = var_2
	var_45_1.item_list = var_2.GUIDE_ITEM_LIST
	AuctionGameConst = var_2
	var_45_1.change_gold = var_45_0 - var_2.GUIDE_BID_VALUE
	getProxy = var_2
	AuctionGameProxy = var_45_2

	local var_45_3 = var_2(var_45_2)

	var_2.UpdateSettlementData(var_45_3, var_45_1)

	pg = var_3

	local var_45_4 = var_3.m02
	local var_45_5 = var_3.sendNotification

	GAME = var_6

	var_45_5(var_45_4, var_6.AUCTION_GAME_SETTLEMENT)

	return
end

return var_0_0
