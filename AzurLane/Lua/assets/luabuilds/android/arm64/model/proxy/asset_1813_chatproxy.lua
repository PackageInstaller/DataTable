class = var_0_10000

local var_0_0 = "ChatProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.NEW_MSG = "ChatProxy public msg"

function var_0_1.InjectPublic(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0

	if arg_1_1.id == 0 then
		if not arg_1_1.args[1] or not arg_1_1.args[1].string then
			var_1_0 = ""
		end

		arg_1_0.text = var_1_0

		return
	end

	i18n = var_1_0

	local var_1_1 = var_1_0("ad_" .. arg_1_1.id)

	for iter_1_0 = 1, #arg_1_1.args do
		local var_1_2 = arg_1_1.args[iter_1_0]
		local var_1_3
		local var_1_4 = var_1_2.type

		PublicArg = var_1_10011

		if var_1_4 == var_1_10011.TypePlayerName then
			var_1_3 = var_1_2.string
		else
			var_1_4 = var_1_2.type
			PublicArg = var_1_10011

			if var_1_4 == var_1_10011.TypeShipId then
				pg = var_1_4
				var_1_4 = var_1_4.ship_data_statistics[var_1_2.int]
				var_1_10011 = "shiptype" .. iter_1_0
				GetSpriteFromAtlas = var_12

				local var_1_5 = "shiptype"

				shipType2print = var_1_10015

				local var_1_6 = var_12(var_1_5, var_1_10015(var_1_4.type))

				var_1_10015 = arg_1_0

				arg_1_0.AddSprite(var_1_10015, var_1_10011, var_1_6)

				local var_1_7 = "shipcolor" .. iter_1_0

				string = var_14

				local var_1_8 = var_14.gsub
				local var_1_9 = var_1_1
				local var_1_10 = var_1_7

				ItemRarity = var_1_10018
				var_1_1 = var_1_8(var_1_9, var_1_10, var_1_10018.Rarity2HexColor(var_1_4.rarity - 1))
				var_1_3 = var_1_4.name

				if arg_1_2 then
					local var_1_11 = false

					PLATFORM_CODE = var_1_10015
					PLATFORM_JP = var_1_9

					if var_1_10015 == var_1_9 then
						contentWrap = var_1_10015

						local var_1_12

						var_1_10015, var_1_12 = var_1_10015(var_1_3, 18, 1.65)
						var_1_3 = var_1_12
						var_1_11 = var_1_10015
					end

					if var_1_11 then
						var_1_3 = var_1_3 .. "..." or var_1_3
					end
				end
			else
				var_1_4 = var_1_2.type
				PublicArg = var_1_10011

				if var_1_4 == var_1_10011.TypeEquipId then
					pg = var_1_4
					var_1_3 = var_1_4.equip_data_statistics[var_1_2.int].name
				else
					var_1_4 = var_1_2.type
					PublicArg = var_1_10011

					if var_1_4 == var_1_10011.TypeItemId then
						Item = var_1_4
						var_1_3 = var_1_4.getConfigData(var_1_2.int).name
					else
						var_1_4 = var_1_2.type
						PublicArg = var_1_10011

						if var_1_4 == var_1_10011.TypeNums then
							var_1_3 = var_1_2.int
						else
							var_1_4 = var_1_2.type
							PublicArg = var_1_10011

							if var_1_4 == var_1_10011.TypeWorldBoss then
								var_1_3 = var_1_2.string
							else
								var_1_3 = var_1_2.string
							end
						end
					end
				end
			end
		end

		string = var_1_4
		var_1_1 = var_1_4.gsub(var_1_1, "$" .. iter_1_0, var_1_3)
	end

	arg_1_0.text = var_1_1

	return
end

function var_0_1.InjectPublicMsg(arg_2_0, arg_2_1)
	wordVer = var_1_10002

	local var_2_0, var_2_1 = var_1_10002(arg_2_0, {
		isReplace = true
	})
	local var_2_2

	string = var_5

	local var_2_3 = var_5.gsub
	local var_2_4 = var_2_1

	ChatConst = var_1_10008

	var_2_3(var_2_4, var_1_10008.EmojiCodeMatch, function(arg_3_0)
		tonumber = var_2_10001
		var_2_2 = var_2_10001(arg_3_0)

		return
	end)

	if var_2_2 then
		pg = var_2_3

		if var_2_3.emoji_template[var_2_2] then
			var_2_1 = var_5.desc
		else
			var_2_2 = nil
		end
	end

	local var_2_5 = {
		player = arg_2_1,
		content = var_2_1,
		emojiId = var_2_2
	}

	pg = var_1_10006

	local var_2_6 = var_1_10006.TimeMgr.GetInstance()

	var_2_5.timestamp = var_6.GetServerTime(var_2_6)

	return var_2_5
end

function var_0_1.register(arg_4_0)
	arg_4_0:on(50101, function(arg_5_0)
		local var_5_0 = arg_5_0.type

		ChatConst = var_2_10002

		if var_5_0 == var_2_10002.CODE_BANED then
			pg = var_5_0

			local var_5_1 = var_5_0.TipsMgr.GetInstance()

			var_1.ShowTips(var_5_1, arg_5_0.content)
		else
			local var_5_2 = arg_5_0.type

			ChatConst = var_2

			if var_5_2 == var_2.CODE_ACTOBSS_MSG_WORD then
				local var_5_3 = {
					name = arg_5_0.player.name,
					score = arg_5_0.content
				}

				var_2_10004 = arg_4_0

				local var_5_4 = var_2.sendNotification

				GAME = var_2_10005

				var_5_4(var_2_10004, var_2_10005.ACTIVITY_BOSS_MSG_ADDED, var_5_3)

				table = var_5_4

				var_5_4.insert(arg_4_0.actBossMsg, var_5_3)

				if #arg_4_0.actBossMsg > 6 then
					table = var_2

					var_2.remove(arg_4_0.actBossMsg, 1)
				end
			else
				local var_5_5 = var_0_1.InjectPublicMsg
				local var_5_6 = arg_5_0.content

				Player = var_2_10004

				local var_5_7 = var_5_5(var_5_6, var_2_10004.New(arg_5_0.player))
				local var_5_8 = arg_4_0
				local var_5_9 = var_2.addNewMsg

				ChatMsg = var_2_10005

				local var_5_10 = var_2_10005.New

				ChatConst = var_2_10007

				var_5_9(var_5_8, var_5_10(var_2_10007.ChannelWorld, var_5_7))
			end
		end

		return
	end)
	arg_4_0:on(50103, function(arg_6_0)
		local var_6_0 = {}

		ipairs = var_2_10002

		for iter_6_0, iter_6_1 in var_2_10002(arg_6_0.arg_list) do
			table = var_2_10007
			var_2_10007 = var_2_10007.insert

			local var_6_1 = var_6_0

			PublicArg = var_2_10010

			var_2_10007(var_6_1, var_2_10010.New(iter_6_1))
		end

		local var_6_2 = {
			id = arg_6_0.ad_id,
			args = var_6_0
		}

		pg = var_3

		local var_6_3 = var_3.TimeMgr.GetInstance()

		var_6_2.timestamp = var_3.GetServerTime(var_6_3)

		local var_6_4 = arg_4_0
		local var_6_5 = var_3.addNewMsg

		ChatMsg = iter_6_1

		local var_6_6 = iter_6_1.New

		ChatConst = var_2_10008

		var_6_5(var_6_4, var_6_6(var_2_10008.ChannelPublic, var_6_2))

		return
	end)

	arg_4_0.informs = {}
	arg_4_0.actBossMsg = {}

	return
end

function var_0_1.addNewMsg(arg_7_0, arg_7_1)
	if arg_7_1.id == 0 then
		arg_7_0.top = arg_7_1
		_ = var_2

		var_2.each(arg_7_1.args, function(arg_8_0)
			if arg_8_0.string then
				pg = var_1

				local var_8_0 = var_1.TipsMgr.GetInstance()

				var_1.ShowTips(var_8_0, arg_8_0.string)
			end

			return
		end)
	else
		table = var_2

		var_2.insert(arg_7_0.data, arg_7_1)

		if #arg_7_0.data > 100 then
			table = var_2

			var_2.remove(arg_7_0.data, 1)
		end
	end

	arg_7_0:sendNotification(var_0_1.NEW_MSG, arg_7_1)

	return
end

function var_0_1.UpdateMsg(arg_9_0, arg_9_1)
	ipairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0.data) do
		if iter_9_1:IsSame(arg_9_1.uniqueId) then
			arg_9_0.data[iter_9_0] = arg_9_1
		end
	end

	return
end

function var_0_1.GetMessagesByUniqueId(arg_10_0, arg_10_1)
	_ = var_1_10002

	return var_1_10002.select(arg_10_0.data, function(arg_11_0)
		return arg_11_0.uniqueId == arg_10_1
	end)
end

function var_0_1.clearMsg(arg_12_0)
	arg_12_0.data = {}

	return
end

function var_0_1.loadUsedEmoji(arg_13_0)
	arg_13_0.usedEmoji = {}
	getProxy = var_1
	PlayerProxy = var_1_10003

	local var_13_0 = var_1(var_1_10003)
	local var_13_1 = var_1.getRawData(var_13_0).id

	string = var_1_10002

	local var_13_2 = var_1_10002.split

	PlayerPrefs = var_1_10004

	local var_13_3 = var_1_10004.GetString

	ChatConst = var_1_10006

	local var_13_4

	if not var_13_3(var_1_10006.EMOJI_SAVE_TAG .. var_13_1) then
		var_13_4 = ""
	end

	if #var_13_2(var_13_4, ":") > 0 then
		_ = var_3

		var_3.each(var_2, function(arg_14_0)
			string = var_2_10001

			if #var_2_10001.split(arg_14_0, "|") == 2 then
				local var_14_0 = arg_13_0.usedEmoji

				tonumber = var_3

				local var_14_1 = var_3(var_1[1])

				tonumber = var_4
				var_14_0[var_14_1] = var_4(var_1[2])
			end

			return
		end)
	end

	return
end

function var_0_1.saveUsedEmoji(arg_15_0)
	local var_15_0 = {}

	pairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(arg_15_0.usedEmoji) do
		table = var_1_10007

		var_1_10007.insert(var_15_0, iter_15_0 .. "|" .. iter_15_1)
	end

	getProxy = var_2
	PlayerProxy = var_4

	local var_15_1 = var_2(var_4)
	local var_15_2 = var_2.getRawData(var_15_1).id

	PlayerPrefs = var_3

	local var_15_3 = var_3.SetString

	ChatConst = iter_15_0

	local var_15_4 = iter_15_0.EMOJI_SAVE_TAG .. var_15_2

	table = var_6

	var_15_3(var_15_4, var_6.concat(var_15_0, ":"))

	return
end

function var_0_1.getUsedEmoji(arg_16_0)
	if not arg_16_0.usedEmoji then
		arg_16_0:loadUsedEmoji()
	end

	return arg_16_0.usedEmoji
end

function var_0_1.addUsedEmoji(arg_17_0, arg_17_1)
	local var_17_0

	if not arg_17_0:getUsedEmoji()[arg_17_1] then
		var_17_0 = 0
	end

	var_2[arg_17_1] = var_17_0 + 1

	arg_17_0:saveUsedEmoji()

	return
end

function var_0_1.loadUsedEmojiIcon(arg_18_0)
	arg_18_0.usedEmojiIcon = {}

	for iter_18_0 = 1, 6 do
		local var_18_0 = arg_18_0.usedEmojiIcon

		pg = var_1_10006
		var_18_0[iter_18_0] = var_1_10006.emoji_small_template.all[iter_18_0]
	end

	getProxy = var_1
	PlayerProxy = var_3

	local var_18_1 = var_1(var_3)
	local var_18_2 = var_1.getRawData(var_18_1).id

	string = var_2

	local var_18_3 = var_2.split

	PlayerPrefs = iter_18_0

	local var_18_4 = iter_18_0.GetString

	ChatConst = var_1_10006

	local var_18_5

	if not var_18_4(var_1_10006.EMOJI_ICON_SAVE_TAG .. var_18_2) then
		var_18_5 = ""
	end

	if #var_18_3(var_18_5, ":") > 0 then
		ipairs = var_3

		for iter_18_1, iter_18_2 in var_3(var_2) do
			local var_18_6 = arg_18_0.usedEmojiIcon

			tonumber = var_1_10009
			var_18_6[iter_18_1] = var_1_10009(iter_18_2)
		end
	end

	return
end

function var_0_1.saveUsedEmojiIcon(arg_19_0)
	local var_19_0 = {}

	ipairs = var_1_10002

	for iter_19_0, iter_19_1 in var_1_10002(arg_19_0.usedEmojiIcon) do
		table = var_1_10007

		var_1_10007.insert(var_19_0, iter_19_1)
	end

	getProxy = var_2
	PlayerProxy = var_4

	local var_19_1 = var_2(var_4)
	local var_19_2 = var_2.getRawData(var_19_1).id

	PlayerPrefs = var_3

	local var_19_3 = var_3.SetString

	ChatConst = iter_19_0

	local var_19_4 = iter_19_0.EMOJI_ICON_SAVE_TAG .. var_19_2

	table = var_6

	var_19_3(var_19_4, var_6.concat(var_19_0, ":"))

	return
end

function var_0_1.getUsedEmojiIcon(arg_20_0)
	if not arg_20_0.usedEmojiIcon then
		arg_20_0:loadUsedEmojiIcon()
	end

	return arg_20_0.usedEmojiIcon
end

function var_0_1.addUsedEmojiIcon(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.getUsedEmojiIcon(var_21_0)

	table = var_1_10003

	if var_1_10003.indexof(var_21_1, arg_21_1, 1) then
		table = var_21_0

		var_21_0.remove(var_21_1, var_3)
	else
		table = var_21_0

		var_21_0.remove(var_21_1, #var_21_1)
	end

	table = var_21_0

	var_21_0.insert(var_21_1, 1, arg_21_1)
	arg_21_0:saveUsedEmojiIcon()

	return
end

function var_0_1.GetAllTypeChatMessages(arg_22_0, arg_22_1)
	local var_22_0 = {}

	getProxy = var_1_10003
	ChatProxy = var_1_10005

	if not var_1_10003(var_1_10005) then
		return
	end

	_ = var_1_10004

	var_1_10004.each(var_3:getRawData(), function(arg_23_0)
		table = var_2_10001

		var_2_10001.insert(var_22_0, arg_23_0)

		return
	end)

	getProxy = var_4
	GuildProxy = var_6

	local var_22_1 = var_4(var_6)

	if var_4.getRawData(var_22_1) then
		_ = var_5

		var_5.each(var_4:getChatMsgs(), function(arg_24_0)
			table = var_2_10001

			var_2_10001.insert(var_22_0, arg_24_0)

			return
		end)
	end

	getProxy = var_5
	FriendProxy = var_22_1

	local var_22_2 = var_5(var_22_1)

	_ = var_6

	local var_22_3 = var_6.each
	local var_22_4 = var_22_2

	var_22_3(var_22_2.getCacheMsgList(var_22_4), function(arg_25_0)
		table = var_2_10001

		var_2_10001.insert(var_22_0, arg_25_0)

		return
	end)

	_ = var_22_3

	local var_22_5 = var_22_3(var_22_0)
	local var_22_6 = var_6.chain(var_22_5)
	local var_22_7 = var_6.filter(var_22_6, function(arg_26_0)
		local var_26_0 = var_22_2

		return not var_1.isInBlackList(var_26_0, arg_26_0.playerId)
	end)
	local var_22_8 = var_6.sort(var_22_7, function(arg_27_0, arg_27_1)
		return arg_27_0.timestamp < arg_27_1.timestamp
	end)

	var_22_0 = var_6.value(var_22_8)
	NotificationLayer = var_6

	local var_22_9 = var_6.ChannelBits.recv

	bit = var_22_1

	local var_22_10 = var_22_1.lshift
	local var_22_11 = 1

	ChatConst = var_22_4

	local var_22_12 = var_22_10(var_22_11, var_22_4.ChannelAll)

	_ = var_22_8
	var_22_0 = var_22_8.filter(var_22_0, function(arg_28_0)
		local var_28_2

		if var_22_9 ~= var_22_12 then
			bit = var_1

			local var_28_0 = var_1.band
			local var_28_1 = var_22_9

			bit = var_2_10004

			if not (var_28_0(var_28_1, var_2_10004.lshift(1, arg_28_0.type)) > 0) then
				var_28_2 = false

				goto label_28_0
			end
		end

		var_28_2 = true

		::label_28_0::

		return var_28_2
	end)
	_ = var_8

	return (var_8.slice(var_22_0, #var_22_0 - arg_22_1 + 1, arg_22_1))
end

return var_0_1
