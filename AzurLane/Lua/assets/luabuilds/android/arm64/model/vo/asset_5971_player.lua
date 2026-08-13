class = var_0_10000

local var_0_0 = "Player"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".PlayerAttire"))

pg = var_0_10001

local var_0_2 = var_0_10001.player_resource.get_id_list_by_name
local var_0_3
local var_0_4

var_0_1.MAX_SHIP_BAG = 4000
var_0_1.MAX_EQUIP_BAG = 2000
var_0_1.MAX_COMMANDER_BAG = 400
var_0_1.ASSISTS_TYPE_SHAM = 0
var_0_1.ASSISTS_TYPE_GUILD = 1
var_0_1.CHANGE_NAME_KEY = 1

local function var_0_5(arg_1_0)
	return var_0[arg_1_0].name
end

local var_0_6 = id2res

local function var_0_7(arg_2_0)
	return var_0.get_id_list_by_name[arg_2_0][1]
end

local var_0_8 = res2id

local function var_0_9(arg_3_0)
	return var_0[arg_3_0].itemid
end

local var_0_10 = id2ItemId

local function var_0_11(arg_4_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

local var_0_12 = itemId2Id

function var_0_1.isMetaShipNeedToTrans(arg_5_0)
	MetaCharacterConst = var_1_10001

	local var_5_0 = var_1_10001.GetMetaShipGroupIDByConfigID(arg_5_0)

	getProxy = var_1_10002
	BayProxy = var_1_10004

	local var_5_1 = var_1_10002(var_1_10004)
	local var_5_2 = var_2.getMetaShipByGroupId(var_5_1, var_5_0)

	getProxy = var_3
	MetaCharacterProxy = var_5

	local var_5_3 = var_3(var_5)
	local var_5_4 = var_3.getMetaIDMark(var_5_3, arg_5_0) and var_3 > 0

	return (var_5_2 or var_5_4) and true or false
end

function var_0_1.metaShip2Res(arg_6_0)
	MetaCharacterConst = var_1_10001

	local var_6_0 = var_1_10001.GetMetaShipGroupIDByConfigID(arg_6_0)

	getProxy = var_1_10002
	BayProxy = var_1_10004

	local var_6_1 = var_1_10002(var_1_10004)
	local var_6_2 = var_2.getMetaShipByGroupId(var_6_1, var_6_0)
	local var_6_3

	if not var_6_2 then
		var_6_3 = false
	else
		var_1_10006 = var_6_2

		local var_6_4 = var_6_2.getMetaCharacter(var_1_10006)

		var_1_10006 = var_4.getSpecialMaterialInfoToMaxStar(var_6_4).itemID

		local var_6_5 = var_5.count

		getProxy = var_1_10008
		BagProxy = var_1_10010

		local var_6_6 = var_1_10008(var_1_10010)

		var_6_3 = var_6_5 <= var_8.getItemCountById(var_6_6, var_1_10006)
	end

	local var_6_7

	if var_6_3 then
		pg = var_5
		var_6_7 = var_5.ship_transform[var_6_0].common_item
	else
		pg = var_5
		var_6_7 = var_5.ship_transform[var_6_0].exclusive_item
	end

	local var_6_8 = {}

	ipairs = var_1_10006

	for iter_6_0, iter_6_1 in var_1_10006(var_6_7) do
		local var_6_9 = {
			type = iter_6_1[1],
			id = iter_6_1[2],
			count = iter_6_1[3]
		}

		table = var_12

		var_12.insert(var_6_8, var_6_9)
	end

	return var_6_8
end

function var_0_1.getSkinTicket(arg_7_0)
	pg = var_1_10001

	return var_1_10001.gameset.skin_ticket.key_value == 0 and 0 or arg_7_0:getResource(var_1)
end

function var_0_1.Ctor(arg_8_0, arg_8_1)
	var_0_1.super.Ctor(arg_8_0, arg_8_1)

	local var_8_0 = arg_8_0.character
	local var_8_1

	if not arg_8_1.child_display then
		var_8_1 = 0
	end

	arg_8_0.educateCharacter = var_8_1
	arg_8_0.id = arg_8_1.id
	arg_8_0.name = arg_8_1.name

	local var_8_2

	if not arg_8_1.level then
		var_8_2 = arg_8_1.lv
	end

	arg_8_0.level = var_8_2
	arg_8_0.configId = arg_8_0.level

	local var_8_3

	if not arg_8_1.exp then
		var_8_3 = 0
	end

	arg_8_0.exp = var_8_3

	local var_8_4

	if not arg_8_1.attack_count then
		var_8_4 = 0
	end

	arg_8_0.attackCount = var_8_4

	local var_8_5

	if not arg_8_1.win_count then
		var_8_5 = 0
	end

	arg_8_0.winCount = var_8_5

	local var_8_6

	if not arg_8_1.adv then
		var_8_6 = arg_8_1.manifesto
	end

	arg_8_0.manifesto = var_8_6
	arg_8_0.shipBagMax = arg_8_1.ship_bag_max
	arg_8_0.equipBagMax = arg_8_1.equip_bag_max

	local var_8_7

	if not arg_8_1.buffList then
		var_8_7 = {}
	end

	arg_8_0.buff_list = var_8_7

	local var_8_8

	if not arg_8_1.rank and not arg_8_1.title then
		var_8_8 = 0
	end

	arg_8_0.rank = var_8_8

	local var_8_9

	if not arg_8_1.pvp_attack_count then
		var_8_9 = 0
	end

	arg_8_0.pvp_attack_count = var_8_9

	local var_8_10

	if not arg_8_1.pvp_win_count then
		var_8_10 = 0
	end

	arg_8_0.pvp_win_count = var_8_10

	local var_8_11

	if not arg_8_1.collect_attack_count then
		var_8_11 = 0
	end

	arg_8_0.collect_attack_count = var_8_11
	arg_8_0.guideIndex = arg_8_1.guide_index
	arg_8_0.newGuideIndex = arg_8_1.new_guide_index
	arg_8_0.buyOilCount = arg_8_1.buy_oil_count

	local var_8_12

	if not arg_8_1.chat_room_id then
		var_8_12 = 1
	end

	arg_8_0.chatRoomId = var_8_12

	local var_8_13

	if not arg_8_1.score then
		var_8_13 = 0
	end

	arg_8_0.score = var_8_13

	local var_8_14

	if not arg_8_1.guild_wait_time then
		var_8_14 = 0
	end

	arg_8_0.guildWaitTime = var_8_14
	arg_8_0.commanderBagMax = arg_8_1.commander_bag_max

	local var_8_15

	if not arg_8_1.medal_id then
		var_8_15 = {}
	end

	arg_8_0.displayTrophyList = var_8_15

	local var_8_16

	if not arg_8_1.theme_upload_not_allowed_time then
		var_8_16 = 0
	end

	arg_8_0.banBackyardUploadTime = var_8_16
	arg_8_0.identityFlag = arg_8_1.gm_flag
	arg_8_0.mailStoreLevel = arg_8_1.mail_storeroom_lv
	getProxy = var_3
	AppreciateProxy = var_5

	local var_8_17 = var_3(var_5)

	if arg_8_1.appreciation then
		ipairs = var_4

		local var_8_18

		if not arg_8_1.appreciation.gallerys then
			var_8_18 = {}
		end

		for iter_8_0, iter_8_1 in var_4(var_8_18) do
			var_8_17:addPicIDToUnlockList(iter_8_1)
		end

		ipairs = var_4

		local var_8_19

		if not arg_8_1.appreciation.musics then
			var_8_19 = {}
		end

		for iter_8_2, iter_8_3 in var_4(var_8_19) do
			var_8_17:addMusicIDToUnlockList(iter_8_3)
		end

		ipairs = var_4

		local var_8_20

		if not arg_8_1.appreciation.favor_gallerys then
			var_8_20 = {}
		end

		for iter_8_4, iter_8_5 in var_4(var_8_20) do
			var_8_17:addPicIDToLikeList(iter_8_5)
		end

		ipairs = var_4

		local var_8_21

		if not arg_8_1.appreciation.favor_musics then
			var_8_21 = {}
		end

		for iter_8_6, iter_8_7 in var_4(var_8_21) do
			var_8_17:addMusicIDToLikeList(iter_8_7)
		end

		var_8_17:setMainPlayMusicAlbum(arg_8_1.appreciation.music_no)

		local var_8_22 = var_8_17

		var_8_17.setMusicPlayerLoopType(var_8_22, arg_8_1.appreciation.music_mode)

		getProxy = var_4
		AppreciateProxy = var_8_22

		local var_8_23 = var_4(var_8_22)

		if var_4.getResultForVer(var_8_23) then
			pg = var_8_22

			local var_8_24 = var_8_22.ConnectionMgr.GetInstance()

			var_6.Send(var_8_24, 15300, {
				type = 0,
				ver_str = var_5
			})
			var_4:clearVer()
		end
	end

	if arg_8_1.cartoon_read_mark then
		var_8_17:initMangaReadIDList(arg_8_1.cartoon_read_mark)
	end

	if arg_8_1.cartoon_collect_mark then
		var_8_17:initMangaLikeIDList(arg_8_1.cartoon_collect_mark)
	end

	arg_8_0.cdList = {}
	ipairs = var_4

	local var_8_25

	if not arg_8_1.cd_list then
		var_8_25 = {}
	end

	for iter_8_8, iter_8_9 in var_4(var_8_25) do
		var_1_10009 = arg_8_0.cdList
		var_1_10009[iter_8_9.key] = iter_8_9.timestamp
	end

	arg_8_0.commonFlagList = {}
	ipairs = var_4

	local var_8_26

	if not arg_8_1.flag_list then
		var_8_26 = {}
	end

	for iter_8_10, iter_8_11 in var_4(var_8_26) do
		var_1_10009 = arg_8_0.commonFlagList
		var_1_10009[iter_8_11] = true
	end

	arg_8_0.registerTime = arg_8_1.register_time
	arg_8_0.vipCards = {}
	ipairs = var_4

	local var_8_27

	if not arg_8_1.card_list then
		var_8_27 = {}
	end

	for iter_8_12, iter_8_13 in var_4(var_8_27) do
		VipCard = var_1_10009
		var_1_10009 = var_1_10009.New(iter_8_13)
		arg_8_0.vipCards[var_1_10009.id] = var_1_10009
	end

	arg_8_0:updateResources(arg_8_1.resource_list)

	local var_8_28

	if not arg_8_1.max_rank then
		var_8_28 = 0
	end

	arg_8_0.maxRank = var_8_28

	local var_8_29

	if not arg_8_1.ship_count then
		var_8_29 = 0
	end

	arg_8_0.shipCount = var_8_29

	local var_8_30

	if not arg_8_1.acc_pay_lv then
		var_8_30 = 0
	end

	arg_8_0.chargeExp = var_8_30
	arg_8_0.mingshiflag = 0
	arg_8_0.mingshiCount = 0

	local var_8_31

	if not arg_8_1.chat_msg_ban_time then
		var_8_31 = 0
	end

	arg_8_0.chatMsgBanTime = var_8_31

	local var_8_32

	if not arg_8_1.random_ship_mode then
		var_8_32 = 0
	end

	arg_8_0.randomShipMode = var_8_32
	arg_8_0.buildShipNotification = {}
	ipairs = var_4

	local var_8_33

	if not arg_8_1.taking_ship_list then
		var_8_33 = {}
	end

	for iter_8_14, iter_8_15 in var_4(var_8_33) do
		table = var_1_10009

		var_1_10009.insert(arg_8_0.buildShipNotification, {
			uid = iter_8_15.uid,
			new = iter_8_15.isnew == 1
		})
	end

	arg_8_0.proposeShipId = arg_8_1.marry_ship
	arg_8_0.unlockCryptolaliaList = {}
	ipairs = var_4

	local var_8_34

	if not arg_8_1.soundstory then
		var_8_34 = {}
	end

	for iter_8_16, iter_8_17 in var_4(var_8_34) do
		table = var_1_10009

		var_1_10009.insert(arg_8_0.unlockCryptolaliaList, iter_8_17)
	end

	local var_8_35

	if not arg_8_1.display then
		var_8_35 = {}
	end

	arg_8_0.displayInfo = var_8_35
	arg_8_0.attireInfo = {}

	local var_8_36 = arg_8_0.attireInfo

	AttireConst = var_6
	var_8_36[var_6.TYPE_ICON_FRAME] = arg_8_0.iconFrame

	local var_8_37 = arg_8_0.attireInfo

	AttireConst = var_6
	var_8_37[var_6.TYPE_CHAT_FRAME] = arg_8_0.chatFrame
	arg_8_0.activityMedalGroupList = {}

	local var_8_38 = arg_8_0
	local var_8_39 = arg_8_0.updateMedalList
	local var_8_40

	if not arg_8_1.activity_medals then
		var_8_40 = {}
	end

	var_8_39(var_8_38, var_8_40)

	return
end

function var_0_1.updateAttireFrame(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.attireInfo

	var_9_0[arg_9_1] = arg_9_2
	AttireConst = var_9_0

	if arg_9_1 == var_9_0.TYPE_COMBAT_UI_STYLE then
		pg = var_3

		local var_9_1 = var_3.item_data_battleui[arg_9_2].key
		local var_9_2 = COMBAT_SKIN_KEY
	end

	return
end

function var_0_1.getAttireByType(arg_10_0, arg_10_1)
	return arg_10_0.attireInfo[arg_10_1]
end

function var_0_1.getRandomSecretary(arg_11_0)
	local var_11_0 = arg_11_0.characters

	math = var_1_10002

	return var_11_0[var_1_10002.random(#arg_11_0.characters)]
end

function var_0_1.canModifyName(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.TimeMgr.GetInstance()
	local var_12_1 = var_1.GetServerTime(var_12_0)

	pg = var_1_10002

	if var_1_10002.gameset.player_name_change_lv_limit.key_value > arg_12_0.level then
		local var_12_2 = false

		i18n = var_1_10004
		var_1_10004 = var_1_10004("player_name_change_time_lv_tip", var_2)

		return
	end

	if var_12_1 < arg_12_0:getModifyNameTimestamp() then
		pg = var_1_10004

		local var_12_3 = var_1_10004.TimeMgr.GetInstance()
		local var_12_4, var_12_5, var_12_6, var_12_7 = var_4.parseTimeFrom(var_12_3, var_3 - var_12_1)
		local var_12_8

		if var_12_4 == 0 then
			if var_12_5 == 0 then
				math = var_1_10009

				local var_12_9 = var_1_10009.max(var_12_6, 1)

				i18n = var_1_10010
				var_12_8 = var_12_9 .. var_1_10010("word_minute")
			else
				local var_12_10 = var_12_5

				i18n = var_1_10010
				var_12_8 = var_12_10 .. var_1_10010("word_hour")
			end
		else
			local var_12_11 = var_12_4

			i18n = var_1_10010
			var_12_8 = var_12_11 .. var_1_10010("word_date")
		end

		local var_12_12 = false

		i18n = var_1_10010

		local var_12_13 = var_1_10010("player_name_change_time_limit_tip", var_12_8)

		return
	end

	return true
end

function var_0_1.getModifyNameComsume(arg_13_0)
	pg = var_1_10001

	return var_1_10001.gameset.player_name_change_cost.description
end

function var_0_1.getModifyNameTimestamp(arg_14_0)
	local var_14_0

	if not arg_14_0.cdList[var_0_1.CHANGE_NAME_KEY] then
		var_14_0 = 0
	end

	return var_14_0
end

function var_0_1.updateModifyNameColdTime(arg_15_0, arg_15_1)
	arg_15_0.cdList[var_0_1.CHANGE_NAME_KEY] = arg_15_1

	return
end

function var_0_1.getMaxGold(arg_16_0)
	pg = var_1_10001

	return var_1_10001.gameset.max_gold.key_value
end

function var_0_1.getMaxOil(arg_17_0)
	pg = var_1_10001

	return var_1_10001.gameset.max_oil.key_value
end

function var_0_1.getLevelMaxGold(arg_18_0)
	local var_18_0 = arg_18_0:getConfig("max_gold")

	getProxy = var_1_10002
	GuildProxy = var_4

	local var_18_1 = var_1_10002(var_4)
	local var_18_2

	if not var_2.GetAdditionGuild(var_18_1) or not (var_18_0 + var_2:getMaxGoldAddition()) then
		var_18_2 = var_18_0
	end

	return var_18_2
end

function var_0_1.getLevelMaxOil(arg_19_0)
	local var_19_0 = arg_19_0:getConfig("max_oil")

	getProxy = var_1_10002
	GuildProxy = var_4

	local var_19_1 = var_1_10002(var_4)
	local var_19_2

	if not var_2.GetAdditionGuild(var_19_1) or not (var_19_0 + var_2:getMaxOilAddition()) then
		var_19_2 = var_19_0
	end

	return var_19_2
end

function var_0_1.getResource(arg_20_0, arg_20_1)
	id2res = var_1_10002

	local var_20_0

	if not arg_20_0[var_1_10002(arg_20_1)] then
		var_20_0 = 0
	end

	return var_20_0
end

function var_0_1.updateResources(arg_21_0, arg_21_1)
	pairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(var_0_2) do
		assert = var_1_10007

		var_1_10007(#iter_21_1 == 1, "Multiple ID have the same name : " .. iter_21_0)

		var_1_10007 = iter_21_1[1]

		if iter_21_0 == "gem" then
			arg_21_0.chargeGem = 0
		elseif iter_21_0 == "freeGem" then
			arg_21_0.awardGem = 0
		else
			arg_21_0[iter_21_0] = 0
		end
	end

	ipairs = var_2

	for iter_21_2, iter_21_3 in var_2(arg_21_1 or {}) do
		id2res = var_1_10007
		var_1_10007 = var_1_10007(iter_21_3.type)
		assert = var_1_10008

		var_1_10008(var_1_10007, "resource type erro>>>>>" .. iter_21_3.type)

		if var_1_10007 == "gem" then
			arg_21_0.chargeGem = iter_21_3.num
		elseif var_1_10007 == "freeGem" then
			arg_21_0.awardGem = iter_21_3.num
		else
			arg_21_0[var_1_10007] = iter_21_3.num
		end
	end

	return
end

function var_0_1.getPainting(arg_22_0)
	pg = var_1_10001

	local var_22_0 = var_1_10001.ship_skin_template[arg_22_0.skinId]

	tobool = var_2

	if var_2(arg_22_0.character) then
		ShipSkin = var_2

		if var_2.GetChangeSkinData(arg_22_0.skinId) then
			ShipSkin = var_2

			local var_22_1 = var_2.GetChangeSkinGroupId(arg_22_0.skinId)

			ShipSkin = var_1_10003

			if var_1_10003.GetStoreChangeSkinId(var_22_1, arg_22_0:GetFlagShipPhantomMark()) then
				pg = var_4
				var_22_0 = var_4.ship_skin_template[var_3]
			end
		end
	end

	local var_22_2

	if not var_22_0 or not var_22_0.painting then
		var_22_2 = "unknown"
	end

	return var_22_2
end

function var_0_1.inGuildCDTime(arg_23_0)
	local var_23_0 = arg_23_0.guildWaitTime

	if 0 < var_23_0 then
		local var_23_1 = arg_23_0.guildWaitTime

		pg = var_2

		local var_23_2 = var_2.TimeMgr.GetInstance()
		local var_23_3

		if not (var_23_1 > var_2.GetServerTime(var_23_2)) then
			var_23_3 = false
		else
			var_23_3 = true
		end

		return var_23_3
	end
end

function var_0_1.setGuildWaitTime(arg_24_0, arg_24_1)
	arg_24_0.guildWaitTime = arg_24_1

	return
end

function var_0_1.getChargeLevel(arg_25_0)
	pg = var_1_10001

	local var_25_0 = var_1_10001.pay_level_award.all[1]
	local var_25_1 = var_1.all[#var_1.all]

	ipairs = var_4

	for iter_25_0, iter_25_1 in var_4(var_1.all) do
		if arg_25_0.chargeExp >= var_1[iter_25_1].exp then
			math = var_9
			var_25_0 = var_9.min(iter_25_1 + 1, var_25_1)
		end
	end

	return var_25_0
end

function var_0_1.getCardById(arg_26_0, arg_26_1)
	Clone = var_1_10002

	return var_1_10002(arg_26_0.vipCards[arg_26_1])
end

function var_0_1.addVipCard(arg_27_0, arg_27_1)
	arg_27_0.vipCards[arg_27_1.id] = arg_27_1

	return
end

function var_0_1.addShipBagCount(arg_28_0, arg_28_1)
	arg_28_0.shipBagMax = arg_28_0.shipBagMax + arg_28_1

	return
end

function var_0_1.addEquipmentBagCount(arg_29_0, arg_29_1)
	arg_29_0.equipBagMax = arg_29_0.equipBagMax + arg_29_1

	return
end

function var_0_1.bindConfigTable(arg_30_0)
	pg = var_1_10001

	return var_1_10001.user_level
end

function var_0_1.updateScoreAndRank(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0.score = arg_31_1
	arg_31_0.rank = arg_31_2

	return
end

function var_0_1.increasePvpCount(arg_32_0)
	arg_32_0.pvp_attack_count = arg_32_0.pvp_attack_count + 1

	return
end

function var_0_1.increasePvpWinCount(arg_33_0)
	arg_33_0.pvp_win_count = arg_33_0.pvp_win_count + 1

	return
end

function var_0_1.isEnough(arg_34_0, arg_34_1)
	pairs = var_1_10002

	for iter_34_0, iter_34_1 in var_1_10002(arg_34_1) do
		if arg_34_0[iter_34_0] == nil or iter_34_1 > arg_34_0[iter_34_0] then
			return false, iter_34_0
		end
	end

	return true
end

function var_0_1.increaseBuyOilCount(arg_35_0)
	arg_35_0.buyOilCount = arg_35_0.buyOilCount + 1

	return
end

function var_0_1.changeChatRoom(arg_36_0, arg_36_1)
	arg_36_0.chatRoomId = arg_36_1

	return
end

function var_0_1.increaseAttackCount(arg_37_0)
	arg_37_0.attackCount = arg_37_0.attackCount + 1

	return
end

function var_0_1.increaseAttackWinCount(arg_38_0)
	arg_38_0.winCount = arg_38_0.winCount + 1

	return
end

function var_0_1.increaseShipCount(arg_39_0, arg_39_1)
	arg_39_0.shipCount = arg_39_0.shipCount + (arg_39_1 and arg_39_1 or 1)

	return
end

function var_0_1.isFull(arg_40_0)
	pairs = var_1_10001

	for iter_40_0, iter_40_1 in var_1_10001(var_0_2) do
		pg = var_1_10006

		if var_1_10006.user_level["max_" .. iter_40_0] and var_1_10006 > arg_40_0[iter_40_0] then
			return false
		end
	end

	return true
end

function var_0_1.getMaxEquipmentBag(arg_41_0)
	local var_41_0 = arg_41_0.equipBagMax
	local var_41_1 = 0

	getProxy = var_1_10003
	GuildProxy = var_1_10005

	local var_41_2 = var_1_10003(var_1_10005)

	if var_3.GetAdditionGuild(var_41_2) then
		var_41_1 = var_3:getEquipmentBagAddition()
	end

	return var_41_1 + var_41_0
end

function var_0_1.getMaxShipBag(arg_42_0)
	local var_42_0 = arg_42_0.shipBagMax
	local var_42_1 = 0

	getProxy = var_1_10003
	GuildProxy = var_1_10005

	local var_42_2 = var_1_10003(var_1_10005)

	if var_3.GetAdditionGuild(var_42_2) then
		var_42_1 = var_3:getShipBagAddition()
	end

	return var_42_1 + var_42_0
end

function var_0_1.getMaxEquipmentBagExcludeGuild(arg_43_0)
	return arg_43_0.equipBagMax
end

function var_0_1.getMaxShipBagExcludeGuild(arg_44_0)
	return arg_44_0.shipBagMax
end

function var_0_1.__index(arg_45_0, arg_45_1)
	if arg_45_1 == "gem" then
		return arg_45_0:getChargeGem()
	elseif arg_45_1 == "freeGem" then
		return arg_45_0:getTotalGem()
	elseif arg_45_1 == "equipBagMax" then
		return arg_45_0:getMaxEquipmentBag()
	elseif arg_45_1 == "shipBagMax" then
		return arg_45_0:getMaxShipBag()
	end

	rawget = var_1_10002

	local var_45_0

	if not var_1_10002(arg_45_0, arg_45_1) then
		var_45_0 = var_0_1[arg_45_1]
	end

	var_45_0 = var_45_0 or var_0_1.super[arg_45_1]

	return var_45_0
end

function var_0_1.__newindex(arg_46_0, arg_46_1, arg_46_2)
	assert = var_1_10003

	var_1_10003(arg_46_1 ~= "gem" and arg_46_1 ~= "freeGem", "Do not set gem directly.")

	rawset = var_1_10003

	var_1_10003(arg_46_0, arg_46_1, arg_46_2)

	return
end

function var_0_1.getFreeGem(arg_47_0)
	return arg_47_0.awardGem
end

function var_0_1.getChargeGem(arg_48_0)
	return arg_48_0.chargeGem
end

function var_0_1.getTotalGem(arg_49_0)
	return arg_49_0:getFreeGem() + arg_49_0:getChargeGem()
end

function var_0_1.getResById(arg_50_0, arg_50_1)
	if arg_50_1 == 4 then
		return arg_50_0:getTotalGem()
	else
		id2res = var_1_10002

		return arg_50_0[var_1_10002(arg_50_1)]
	end

	return
end

function var_0_1.consume(arg_51_0, arg_51_1)
	local var_51_0

	if not arg_51_1.freeGem then
		var_51_0 = 0
	end

	local var_51_1

	if not arg_51_1.gem then
		var_51_1 = 0
	end

	local var_51_2 = var_51_0 + var_51_1

	arg_51_1.freeGem = nil
	arg_51_1.gem = nil

	local var_51_3

	if 0 < var_51_2 then
		var_51_3 = arg_51_0:getFreeGem()
		math = var_1_10004
		arg_51_0.awardGem = var_51_3 - var_1_10004.min(var_51_2, var_51_3)
		arg_51_0.chargeGem = arg_51_0.chargeGem - (var_51_2 - var_4)
	end

	pairs = var_51_3

	for iter_51_0, iter_51_1 in var_51_3(arg_51_1) do
		arg_51_0[iter_51_0] = arg_51_0[iter_51_0] - iter_51_1
	end

	return
end

function var_0_1.addResources(arg_52_0, arg_52_1)
	pairs = var_1_10002

	for iter_52_0, iter_52_1 in var_1_10002(arg_52_1) do
		if iter_52_0 == "gold" then
			var_1_10009 = arg_52_0
			var_1_10007 = arg_52_0.getMaxGold(var_1_10009)
			math = var_1_10008
			arg_52_0[iter_52_0] = var_1_10008.min(arg_52_0[iter_52_0] + iter_52_1, var_1_10007)
		elseif iter_52_0 == "oil" then
			var_1_10009 = arg_52_0
			var_1_10007 = arg_52_0.getMaxOil(var_1_10009)
			math = var_1_10008
			arg_52_0[iter_52_0] = var_1_10008.min(arg_52_0[iter_52_0] + iter_52_1, var_1_10007)
		elseif iter_52_0 == "gem" then
			var_1_10009 = arg_52_0
			arg_52_0.chargeGem = arg_52_0.getChargeGem(var_1_10009) + iter_52_1
		elseif iter_52_0 == "freeGem" then
			var_1_10009 = arg_52_0
			arg_52_0.awardGem = arg_52_0.getFreeGem(var_1_10009) + iter_52_1
		else
			id2res = var_1_10007
			WorldConst = var_1_10009

			if iter_52_0 == var_1_10007(var_1_10009.ResourceID) then
				pg = var_1_10007
				var_1_10007 = var_1_10007.gameset.world_resource_max.key_value
				math = var_1_10008
				arg_52_0[iter_52_0] = var_1_10008.min(arg_52_0[iter_52_0] + iter_52_1, var_1_10007)
			elseif iter_52_0 == "gameticket" then
				pg = var_1_10007
				var_1_10007 = var_1_10007.gameset.game_room_remax.key_value
				math = var_1_10008
				arg_52_0[iter_52_0] = var_1_10008.min(arg_52_0[iter_52_0] + iter_52_1, var_1_10007)
			else
				arg_52_0[iter_52_0] = arg_52_0[iter_52_0] + iter_52_1
			end
		end
	end

	return
end

function var_0_1.resetBuyOilCount(arg_53_0)
	arg_53_0.buyOilCount = 0

	return
end

function var_0_1.addExp(arg_54_0, arg_54_1)
	assert = var_1_10002

	var_1_10002(arg_54_1 >= 0, "exp should greater than zero")

	arg_54_0.exp = arg_54_0.exp + arg_54_1

	while arg_54_0:canLevelUp() do
		local var_54_0 = arg_54_0.exp
		local var_54_1 = arg_54_0

		arg_54_0.exp = var_54_0 - arg_54_0.getLevelExpConfig(var_54_1).exp_interval
		arg_54_0.level = arg_54_0.level + 1
		pg = var_2

		local var_54_2 = var_2.TrackerMgr.GetInstance()
		local var_54_3 = var_2.Tracking

		TRACKING_USER_LEVELUP = var_54_1

		var_54_3(var_54_2, var_54_1, arg_54_0.level)

		if arg_54_0.level == 30 then
			pg = var_2

			local var_54_4 = var_2.TrackerMgr.GetInstance()
			local var_54_5 = var_2.Tracking

			TRACKING_USER_LEVEL_THIRTY = var_54_1

			var_54_5(var_54_4, var_54_1)
		elseif arg_54_0.level == 40 then
			pg = var_2

			local var_54_6 = var_2.TrackerMgr.GetInstance()
			local var_54_7 = var_2.Tracking

			TRACKING_USER_LEVEL_FORTY = var_54_1

			var_54_7(var_54_6, var_54_1)
		end

		if arg_54_0.level == 10 then
			pg = var_2

			local var_54_8 = var_2.TrackerMgr.GetInstance()
			local var_54_9 = var_2.Tracking

			TRACKING_EXP_LV_10 = var_54_1

			var_54_9(var_54_8, var_54_1)
		elseif arg_54_0.level == 20 then
			pg = var_2

			local var_54_10 = var_2.TrackerMgr.GetInstance()
			local var_54_11 = var_2.Tracking

			TRACKING_EXP_LV_20 = var_54_1

			var_54_11(var_54_10, var_54_1)
		elseif arg_54_0.level == 30 then
			pg = var_2

			local var_54_12 = var_2.TrackerMgr.GetInstance()
			local var_54_13 = var_2.Tracking

			TRACKING_EXP_LV_30 = var_54_1

			var_54_13(var_54_12, var_54_1)
		end
	end

	return
end

function var_0_1.addExpToLevel(arg_55_0, arg_55_1)
	getConfigFromLevel1 = var_1_10002
	pg = var_1_10004

	local var_55_0 = var_1_10002(var_1_10004.user_level, arg_55_1)

	if arg_55_0:getLevelExpConfig().exp_start + arg_55_0.exp >= var_55_0.exp_start then
		print = var_4

		var_4("EXP Overflow, Return")

		return
	end

	arg_55_0:addExp(var_55_0.exp_start - var_3.exp_start - arg_55_0.exp)

	return
end

function var_0_1.GetBuffs(arg_56_0)
	return arg_56_0.buff_list
end

function var_0_1.getLevelExpConfig(arg_57_0)
	getConfigFromLevel1 = var_1_10001
	pg = var_1_10003

	return var_1_10001(var_1_10003.user_level, arg_57_0.level)
end

function var_0_1.getMaxLevel(arg_58_0)
	pg = var_1_10001

	local var_58_0 = var_1_10001.user_level.all

	pg = var_1_10002

	return var_58_0[#var_1_10002.user_level.all]
end

function var_0_1.getTotalExp(arg_59_0)
	return arg_59_0:getLevelExpConfig().exp_start + arg_59_0.exp
end

function var_0_1.canLevelUp(arg_60_0)
	getConfigFromLevel1 = var_1_10001
	pg = var_1_10003

	local var_60_0 = var_1_10001(var_1_10003.user_level, arg_60_0.level + 1)
	local var_60_1 = arg_60_0:getLevelExpConfig()

	return var_60_0 and var_60_1 ~= var_60_0 and var_60_1.exp_interval <= arg_60_0.exp
end

function var_0_1.isSelf(arg_61_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_61_0 = var_1_10001(var_1_10003)

	return var_1.isSelf(var_61_0, arg_61_0.id)
end

function var_0_1.isFriend(arg_62_0)
	getProxy = var_1_10001
	FriendProxy = var_1_10003

	local var_62_0 = var_1_10001(var_1_10003)

	return var_1.isFriend(var_62_0, arg_62_0.id)
end

function var_0_1.OilMax(arg_63_0, arg_63_1)
	arg_63_1 = arg_63_1 or 0
	pg = var_1_10002

	return var_1_10002.gameset.max_oil.key_value < arg_63_0.oil + arg_63_1
end

function var_0_1.GoldMax(arg_64_0, arg_64_1)
	arg_64_1 = arg_64_1 or 0
	pg = var_1_10002

	return var_1_10002.gameset.max_gold.key_value < arg_64_0.gold + arg_64_1
end

function var_0_1.ResLack(arg_65_0, arg_65_1, arg_65_2)
	pg = var_1_10003

	if var_1_10003.gameset["max_" .. arg_65_1].key_value < arg_65_0[arg_65_1] then
		return 0
	else
		math = var_4

		return var_4.min(arg_65_2, var_3 - arg_65_0[arg_65_1])
	end

	return
end

function var_0_1.OverStore(arg_66_0, arg_66_1, arg_66_2)
	arg_66_2 = arg_66_2 or 0
	id2res = var_1_10003

	local var_66_0 = var_1_10003(arg_66_1)

	pg = var_1_10004

	local var_66_1 = var_1_10004.mail_storeroom[arg_66_0.mailStoreLevel]

	switch = var_5

	local var_66_2 = arg_66_1
	local var_66_3 = {}

	PlayerConst = var_1_10009
	var_66_3[var_1_10009.ResStoreGold] = function()
		return var_66_1.gold_store
	end
	PlayerConst = var_9
	var_66_3[var_9.ResStoreOil] = function()
		return var_66_1.oil_store
	end

	local var_66_4 = var_5(var_66_2, var_66_3)

	return arg_66_0[var_66_0] + arg_66_2 - var_66_4
end

function var_0_1.UpdateCommonFlag(arg_69_0, arg_69_1)
	arg_69_0.commonFlagList[arg_69_1] = true

	return
end

function var_0_1.GetCommonFlag(arg_70_0, arg_70_1)
	return arg_70_0.commonFlagList[arg_70_1]
end

function var_0_1.CancelCommonFlag(arg_71_0, arg_71_1)
	arg_71_0.commonFlagList[arg_71_1] = false

	return
end

function var_0_1.SetCommonFlag(arg_72_0, arg_72_1, arg_72_2)
	arg_72_0.commonFlagList[arg_72_1] = arg_72_2

	return
end

function var_0_1.updateCommanderBagMax(arg_73_0, arg_73_1)
	arg_73_0.commanderBagMax = arg_73_0.commanderBagMax + arg_73_1

	return
end

function var_0_1.GetDaysFromRegister(arg_74_0)
	pg = var_1_10001

	local var_74_0 = var_1_10001.TimeMgr.GetInstance()
	local var_74_1 = var_1.GetServerTime(var_74_0)

	pg = var_1_10002

	local var_74_2 = var_1_10002.TimeMgr.GetInstance()

	return var_2.DiffDay(var_74_2, arg_74_0.registerTime, var_74_1)
end

function var_0_1.CanUploadBackYardThemeTemplate(arg_75_0)
	pg = var_1_10001

	local var_75_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_75_0) >= arg_75_0.banBackyardUploadTime
end

function var_0_1.GetBanUploadBackYardThemeTemplateTime(arg_76_0)
	pg = var_1_10001

	local var_76_0 = var_1_10001.TimeMgr.GetInstance()
	local var_76_1 = var_1.STimeDescC
	local var_76_2

	if not arg_76_0.banBackyardUploadTime then
		var_76_2 = 0
	end

	return var_76_1(var_76_0, var_76_2)
end

function var_0_1.CheckIdentityFlag(arg_77_0)
	return arg_77_0.identityFlag == 1
end

function var_0_1.GetRegisterTime(arg_78_0)
	return arg_78_0.registerTime
end

function var_0_1.GetFlagShipPhantomMark(arg_79_0)
	ShipPhantom = var_1_10001

	return var_1_10001.PackMark(arg_79_0.character, arg_79_0.phantomId)
end

function var_0_1.GetShipPhantomMarks(arg_80_0)
	local var_80_0 = {}

	ipairs = var_1_10002

	for iter_80_0, iter_80_1 in var_1_10002(arg_80_0.characters) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_80_1 = var_80_0

		ShipPhantom = var_1_10010

		var_1_10007(var_80_1, var_1_10010.PackMark(iter_80_1, arg_80_0.phantoms[iter_80_0]))
	end

	return var_80_0
end

function var_0_1.GetFlagShip(arg_81_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_81_0 = var_1_10001(var_1_10003)
	local var_81_1 = var_1.getCurrentSecretaryIndex(var_81_0)
	local var_81_2

	if var_1:IsOpenRandomFlagShip() then
		var_81_2 = arg_81_0:GetRandomFlagShip(var_81_1)
	else
		var_81_2 = arg_81_0:GetNativeFlagShip(var_81_1)
	end

	return var_81_2
end

local function var_0_13(arg_82_0)
	local var_82_0 = {}
	local var_82_1 = {}

	getProxy = var_1_10003
	SettingsProxy = var_1_10005

	local var_82_2 = var_1_10003(var_1_10005)
	local var_82_3 = var_3.GetFlagShipDisplayMode(var_82_2)

	getProxy = var_1_10004
	PlayerProxy = var_1_10006

	local var_82_4 = var_1_10004(var_1_10006)
	local var_82_5 = var_4.getRawData(var_82_4)
	local var_82_6 = var_4.ExistEducateChar(var_82_5)

	FlAG_SHIP_DISPLAY_ONLY_EDUCATECHAR = var_82_2

	if var_82_3 == var_82_2 and not var_82_6 then
		FlAG_SHIP_DISPLAY_ALL = var_82_3
		getProxy = var_82_2
		SettingsProxy = var_1_10007
		var_1_10007 = var_82_2(var_1_10007)

		var_82_2.SetFlagShipDisplayMode(var_1_10007, var_82_3)
	end

	FlAG_SHIP_DISPLAY_ONLY_EDUCATECHAR = var_82_2

	if var_82_3 ~= var_82_2 then
		getProxy = var_82_2
		BayProxy = var_1_10007
		var_82_2 = var_82_2(var_1_10007)
		ipairs = var_82_5

		for iter_82_0, iter_82_1 in var_82_5(arg_82_0) do
			var_82_0[iter_82_0] = false

			if var_82_2:GetShipPhantom(iter_82_1) then
				var_82_0[iter_82_0] = var_11
			end

			table = var_1_10012

			var_1_10012.insert(var_82_1, iter_82_0)
		end
	end

	if var_82_6 then
		FlAG_SHIP_DISPLAY_ONLY_SHIP = var_82_2

		if var_82_3 ~= var_82_2 then
			table = var_82_2

			local var_82_7 = var_82_2.insert
			local var_82_8 = var_82_1

			PlayerVitaeShipsPage = var_1_10008

			var_82_7(var_82_8, var_1_10008.EDUCATE_CHAR_SLOT_ID)

			getProxy = var_82_7
			PlayerProxy = var_82_8

			local var_82_9 = var_82_7(var_82_8)
			local var_82_10 = var_5.getRawData(var_82_9)
			local var_82_11 = var_5.GetEducateCharacter(var_82_10)

			VirtualEducateCharShip = var_82_5

			local var_82_12 = var_82_5.New(var_82_11)

			PlayerVitaeShipsPage = var_82_10
			var_82_0[var_82_10.EDUCATE_CHAR_SLOT_ID] = var_82_12
		end
	end

	return var_82_0, var_82_1
end

function var_0_1.GetNativeFlagShip(arg_83_0, arg_83_1)
	local var_83_0 = var_0_13
	local var_83_1 = arg_83_0
	local var_83_2, var_83_3 = var_83_0(arg_83_0.GetShipPhantomMarks(var_83_1))

	getProxy = var_4
	SettingsProxy = var_83_1

	local var_83_4 = var_4(var_83_1)

	getProxy = var_1_10005
	PlayerProxy = var_1_10007

	local var_83_5 = var_1_10005(var_1_10007)

	if var_5.getFlag(var_83_5, "random_skin") then
		math = var_5
		arg_83_1 = var_83_3[var_5.random(#var_83_3)]

		local var_83_6 = var_83_4

		var_83_4.setCurrentSecretaryIndex(var_83_6, var_5)

		getProxy = var_83_1
		PlayerProxy = var_83_6

		local var_83_7 = var_83_1(var_83_6)

		var_83_1.setFlag(var_83_7, "random_skin", false)
	end

	if not var_83_2[arg_83_1] then
		PlayerVitaeShipsPage = var_83_1

		local var_83_8 = var_83_1.GetSlotIndexList()

		table = var_83_5

		if var_83_5.indexof(var_83_8, arg_83_1) and var_7 > 0 then
			for iter_83_0 = var_7 + 1, #var_83_8 do
				if var_83_2[var_83_8[iter_83_0]] then
					var_83_4:setCurrentSecretaryIndex(iter_83_0)

					break
				end
			end
		end
	end

	local var_83_9

	if not var_83_9 then
		arg_83_1 = 1

		var_83_4:setCurrentSecretaryIndex(arg_83_1)

		var_83_9 = var_83_2[arg_83_1]
	end

	return var_83_9
end

function var_0_1.GetRandomFlagShip(arg_84_0, arg_84_1)
	getProxy = var_1_10002
	SettingsProxy = var_1_10004

	local var_84_0 = var_1_10002(var_1_10004)
	local var_84_1 = var_0_13
	local var_84_2 = var_84_0
	local var_84_3, var_84_4 = var_84_1(var_84_0.GetRandomFlagShipList(var_84_2))

	getProxy = var_5
	PlayerProxy = var_84_2

	local var_84_5 = var_5(var_84_2)

	if var_5.getFlag(var_84_5, "random_skin") then
		math = var_5
		arg_84_1 = var_84_4[var_5.random(#var_84_4)]

		local var_84_6 = var_84_0

		var_84_0.setCurrentSecretaryIndex(var_84_6, var_5)

		getProxy = var_1_10006
		PlayerProxy = var_84_6

		local var_84_7 = var_1_10006(var_84_6)

		var_1_10006.setFlag(var_84_7, "random_skin", false)
	end

	if not var_84_3[arg_84_1] then
		PlayerVitaeShipsPage = var_1_10006

		local var_84_8 = var_1_10006.GetSlotIndexList()

		table = var_84_5

		if var_84_5.indexof(var_84_8, arg_84_1) and var_84_5 > 0 then
			for iter_84_0 = var_84_5 + 1, #var_84_8 do
				if var_84_3[var_84_8[iter_84_0]] then
					var_84_0:setCurrentSecretaryIndex(iter_84_0)

					break
				end
			end
		end
	end

	local var_84_10

	if not var_84_10 then
		local var_84_9 = {}

		pairs = var_84_5

		for iter_84_1, iter_84_2 in var_84_5(var_84_3) do
			if iter_84_2 then
				table = var_1_10012

				var_1_10012.insert(var_84_9, iter_84_1)
			end
		end

		if #var_84_9 > 0 then
			math = var_7
			var_84_10 = var_84_3[var_84_9[var_7.random(1, #var_84_9)]]
			table = var_7

			if var_7.indexof(var_84_4, arg_84_1) then
				var_84_0:setCurrentSecretaryIndex(var_7)
			end
		end
	end

	if not var_84_10 then
		arg_84_1 = 1

		var_84_0:setCurrentSecretaryIndex(arg_84_1)

		var_84_10 = var_84_3[arg_84_1]
	end

	return var_84_10
end

function var_0_1.GetNextFlagShip(arg_85_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_85_0 = var_1_10001(var_1_10003)

	var_1.rotateCurrentSecretaryIndex(var_85_0)

	return arg_85_0:GetFlagShip()
end

function var_0_1.IsOpenShipEvaluationImpeach(arg_86_0)
	LOCK_IMPEACH = var_1_10001

	if not var_1_10001 then
		local var_86_0 = arg_86_0.level

		pg = var_1_10002

		local var_86_1

		if not (var_86_0 >= var_1_10002.gameset.report_level_limit.key_value) then
			var_86_1 = false
		else
			var_86_1 = true
		end

		return var_86_1
	end
end

function var_0_1.ShouldCheckCustomName(arg_87_0)
	local var_87_0 = arg_87_0
	local var_87_1 = arg_87_0.GetCommonFlag

	REVERT_CUSTOM_NAME = var_1_10004

	return var_87_1(var_87_0, var_1_10004)
end

function var_0_1.WhetherServerModifiesName(arg_88_0)
	local var_88_0 = arg_88_0
	local var_88_1 = arg_88_0.GetCommonFlag

	ILLEGALITY_PLAYER_NAME = var_1_10004

	return var_88_1(var_88_0, var_1_10004)
end

function var_0_1.GetManifesto(arg_89_0)
	local var_89_0

	if not arg_89_0.manifesto then
		var_89_0 = ""
	end

	return var_89_0
end

function var_0_1.GetName(arg_90_0)
	return arg_90_0.name
end

function var_0_1.GetRandomFlagShipMode(arg_91_0)
	if arg_91_0.randomShipMode <= 0 then
		local var_91_0 = arg_91_0
		local var_91_1 = arg_91_0.GetCommonFlag

		RANDOM_FLAG_SHIP_MODE = var_1_10004

		if var_91_1(var_91_0, var_1_10004) then
			SettingsRandomFlagShipAndSkinPanel = var_2
			arg_91_0.randomShipMode = var_2.SHIP_LOCKED
		else
			SettingsRandomFlagShipAndSkinPanel = var_2
			arg_91_0.randomShipMode = var_2.SHIP_FREQUENTLYUSED
		end
	end

	return arg_91_0.randomShipMode
end

function var_0_1.UpdateRandomFlagShipMode(arg_92_0, arg_92_1)
	arg_92_0.randomShipMode = arg_92_1

	return
end

function var_0_1.SetProposeShipId(arg_93_0, arg_93_1)
	arg_93_0.proposeShipId = arg_93_1

	return
end

function var_0_1.GetProposeShipId(arg_94_0)
	return arg_94_0.proposeShipId
end

function var_0_1.GetCryptolaliaList(arg_95_0)
	local var_95_0 = {}
	local var_95_1 = {}
	local var_95_2 = arg_95_0.unlockCryptolaliaList

	ipairs = var_1_10004

	for iter_95_0, iter_95_1 in var_1_10004(var_95_2) do
		var_95_1[iter_95_1] = true
	end

	ipairs = var_4
	pg = var_6

	for iter_95_2, iter_95_3 in var_4(var_6.soundstory_template.all) do
		Cryptolalia = var_1_10009
		var_1_10009 = var_1_10009.New({
			id = iter_95_3
		})

		if var_95_1[iter_95_3] then
			var_1_10009:Unlock()
		end

		table = var_10

		var_10.insert(var_95_0, var_1_10009)
	end

	return var_95_0
end

function var_0_1.UnlockCryptolalia(arg_96_0, arg_96_1)
	table = var_1_10002

	if not var_1_10002.contains(arg_96_0.unlockCryptolaliaList) then
		table = var_2

		var_2.insert(arg_96_0.unlockCryptolaliaList, arg_96_1)
	end

	return
end

function var_0_1.ExistCryptolalia(arg_97_0, arg_97_1)
	local var_97_0 = arg_97_0:GetCryptolaliaList()

	ipairs = var_1_10003

	for iter_97_0, iter_97_1 in var_1_10003(var_97_0) do
		if (iter_97_1:InTime() or not iter_97_1:IsLock()) and iter_97_1:IsSameGroup(arg_97_1) then
			return true
		end
	end

	return false
end

function var_0_1.ExistEducateChar(arg_98_0)
	return arg_98_0.educateCharacter > 0
end

function var_0_1.GetEducateCharacter(arg_99_0)
	return arg_99_0.educateCharacter
end

function var_0_1.SetEducateCharacter(arg_100_0, arg_100_1)
	arg_100_0.educateCharacter = arg_100_1

	return
end

function var_0_1.CanGetResource(arg_101_0, arg_101_1)
	id2res = var_1_10002

	local var_101_0 = var_1_10002(arg_101_1)
	local var_101_1

	if arg_101_1 == 1 then
		var_101_1 = arg_101_0:getLevelMaxGold()
	elseif arg_101_1 == 2 then
		var_101_1 = arg_101_0:getLevelMaxOil()
	else
		assert = var_4

		var_4(false)
	end

	if var_101_1 <= arg_101_0[var_101_0] then
		return false
	end

	return true
end

function var_0_1.GetExtendStoreCost(arg_102_0)
	pg = var_1_10001

	local var_102_0 = var_1_10001.mail_storeroom[arg_102_0.mailStoreLevel]
	local var_102_1 = {}

	if var_102_0.upgrade_gem > 0 then
		Drop = var_3

		local var_102_2 = var_3.New
		local var_102_3 = {}

		DROP_TYPE_RESOURCE = var_1_10006
		var_102_3.type = var_1_10006
		PlayerConst = var_1_10006
		var_102_3.id = var_1_10006.ResDiamond
		var_102_3.count = var_102_0.upgrade_gem
		var_102_1.diamond = var_102_2(var_102_3)
	end

	if var_102_0.upgrade_gold > 0 then
		Drop = var_3

		local var_102_4 = var_3.New
		local var_102_5 = {}

		DROP_TYPE_RESOURCE = var_1_10006
		var_102_5.type = var_1_10006
		PlayerConst = var_1_10006
		var_102_5.id = var_1_10006.ResGold
		var_102_5.count = var_102_0.upgrade_gold
		var_102_1.gold = var_102_4(var_102_5)
	end

	return var_102_1.diamond, var_102_1.gold
end

function var_0_1.IsStoreLevelMax(arg_103_0)
	pg = var_1_10001

	return not var_1_10001.mail_storeroom[arg_103_0.mailStoreLevel + 1]
end

function var_0_1.updateMedalList(arg_104_0, arg_104_1)
	ipairs = var_1_10002

	for iter_104_0, iter_104_1 in var_1_10002(arg_104_1) do
		local var_104_0 = iter_104_1.key
		local var_104_1 = iter_104_1.value

		pg = var_1_10009
		var_1_10009 = var_1_10009.activity_medal_template[var_104_0].group

		local var_104_2 = arg_104_0.activityMedalGroupList
		local var_104_3

		if not arg_104_0.activityMedalGroupList[var_1_10009] then
			ActivityMedalGroup = var_104_3
			var_104_3 = var_104_3.New(var_1_10009)
		end

		var_104_2[var_1_10009] = var_104_3

		local var_104_4 = arg_104_0.activityMedalGroupList[var_1_10009]

		var_10.UpdateMedal(var_104_4, var_104_0, var_104_1)
	end

	return
end

function var_0_1.getActivityMedalGroup(arg_105_0)
	return arg_105_0.activityMedalGroupList
end

function var_0_1.GetGuideIndex(arg_106_0, arg_106_1)
	if arg_106_1 then
		return arg_106_0.newGuideIndex
	else
		return arg_106_0.guideIndex
	end

	return
end

function var_0_1.UpdateGuideIndex(arg_107_0, arg_107_1, arg_107_2)
	if arg_107_1 then
		arg_107_0.newGuideIndex = arg_107_2
	else
		arg_107_0.guideIndex = arg_107_2
	end

	return
end

function var_0_1.GetDisplayShipList(arg_108_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_108_0 = var_1_10001(var_1_10003)
	local var_108_1

	if var_108_0:IsOpenRandomFlagShip() then
		var_108_1 = var_108_0:GetRandomFlagShipList()
	else
		var_108_1 = arg_108_0:GetShipPhantomMarks()
	end

	local var_108_2, var_108_3 = var_0_13(var_108_1)

	return var_108_2
end

return var_0_1
