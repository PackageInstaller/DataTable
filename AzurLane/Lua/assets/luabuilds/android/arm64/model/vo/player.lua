local var_0_0 = class("Player", import(".PlayerAttire"))
local var_0_1 = pg.player_resource.get_id_list_by_name

var_0_0.MAX_SHIP_BAG = 4000
var_0_0.MAX_EQUIP_BAG = 2000
var_0_0.MAX_COMMANDER_BAG = 400
var_0_0.ASSISTS_TYPE_SHAM = 0
var_0_0.ASSISTS_TYPE_GUILD = 1
var_0_0.CHANGE_NAME_KEY = 1

function id2res(arg_1_0)
	return var_0[arg_1_0].name
end

function res2id(arg_2_0)
	return var_0.get_id_list_by_name[arg_2_0][1]
end

function id2ItemId(arg_3_0)
	return var_0[arg_3_0].itemid
end

function itemId2Id(arg_4_0)
	assert(false)

	return
end

function var_0_0.isMetaShipNeedToTrans(arg_5_0)
	local var_5_0 = getProxy(BayProxy)
	local var_5_1 = getProxy(MetaCharacterProxy):getMetaIDMark(arg_5_0)
	local var_5_2 = var_5_1 and var_5_1 > 0

	return not not (var_5_0:getMetaShipByGroupId((MetaCharacterConst.GetMetaShipGroupIDByConfigID(arg_5_0))) or var_5_2)
end

function var_0_0.metaShip2Res(arg_6_0)
	local var_6_0 = MetaCharacterConst.GetMetaShipGroupIDByConfigID(arg_6_0)
	local var_6_1 = getProxy(BayProxy):getMetaShipByGroupId(var_6_0)
	local var_6_3

	if not var_6_1 then
		var_6_3 = false
	else
		local var_6_4 = var_6_1:getMetaCharacter():getSpecialMaterialInfoToMaxStar()

		var_6_3 = var_6_4.count <= getProxy(BagProxy):getItemCountById(var_6_4.itemID)
	end

	local var_6_5 = var_6_3 and pg.ship_transform[var_6_0].common_item or pg.ship_transform[var_6_0].exclusive_item
	local var_6_6 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_5) do
		table.insert(var_6_6, {
			type = iter_6_1[1],
			id = iter_6_1[2],
			count = iter_6_1[3]
		})
	end

	return var_6_6
end

function var_0_0.getSkinTicket(arg_7_0)
	local var_7_0 = pg.gameset.skin_ticket.key_value

	return pg.gameset.skin_ticket.key_value == 0 and 0 or arg_7_0:getResource(var_7_0)
end

function var_0_0.Ctor(arg_8_0, arg_8_1)
	var_0_0.super.Ctor(arg_8_0, arg_8_1)

	arg_8_0.educateCharacter = arg_8_1.child_display or 0
	arg_8_0.id = arg_8_1.id
	arg_8_0.name = arg_8_1.name
	arg_8_0.level = arg_8_1.level or arg_8_1.lv
	arg_8_0.configId = arg_8_0.level
	arg_8_0.exp = arg_8_1.exp or 0
	arg_8_0.attackCount = arg_8_1.attack_count or 0
	arg_8_0.winCount = arg_8_1.win_count or 0
	arg_8_0.manifesto = arg_8_1.adv or arg_8_1.manifesto
	arg_8_0.shipBagMax = arg_8_1.ship_bag_max
	arg_8_0.equipBagMax = arg_8_1.equip_bag_max
	arg_8_0.buff_list = arg_8_1.buffList or {}
	arg_8_0.rank = arg_8_1.rank or arg_8_1.title or 0
	arg_8_0.pvp_attack_count = arg_8_1.pvp_attack_count or 0
	arg_8_0.pvp_win_count = arg_8_1.pvp_win_count or 0
	arg_8_0.collect_attack_count = arg_8_1.collect_attack_count or 0
	arg_8_0.guideIndex = arg_8_1.guide_index
	arg_8_0.newGuideIndex = arg_8_1.new_guide_index
	arg_8_0.buyOilCount = arg_8_1.buy_oil_count
	arg_8_0.chatRoomId = arg_8_1.chat_room_id or 1
	arg_8_0.score = arg_8_1.score or 0
	arg_8_0.guildWaitTime = arg_8_1.guild_wait_time or 0
	arg_8_0.commanderBagMax = arg_8_1.commander_bag_max
	arg_8_0.displayTrophyList = arg_8_1.medal_id or {}
	arg_8_0.banBackyardUploadTime = arg_8_1.theme_upload_not_allowed_time or 0
	arg_8_0.identityFlag = arg_8_1.gm_flag
	arg_8_0.mailStoreLevel = arg_8_1.mail_storeroom_lv

	local var_8_1 = getProxy(AppreciateProxy)

	if arg_8_1.appreciation then
		local var_8_2 = arg_8_1.appreciation.gallerys or {}

		for iter_8_0, iter_8_1 in ipairs(var_8_2) do
			var_8_1:addPicIDToUnlockList(iter_8_1)
		end

		local var_8_3 = arg_8_1.appreciation.musics or {}

		for iter_8_2, iter_8_3 in ipairs(var_8_3) do
			var_8_1:addMusicIDToUnlockList(iter_8_3)
		end

		local var_8_4 = arg_8_1.appreciation.favor_gallerys or {}

		for iter_8_4, iter_8_5 in ipairs(var_8_4) do
			var_8_1:addPicIDToLikeList(iter_8_5)
		end

		local var_8_5 = arg_8_1.appreciation.favor_musics or {}

		for iter_8_6, iter_8_7 in ipairs(var_8_5) do
			var_8_1:addMusicIDToLikeList(iter_8_7)
		end

		var_8_1:setMainPlayMusicAlbum(arg_8_1.appreciation.music_no)
		var_8_1:setMusicPlayerLoopType(arg_8_1.appreciation.music_mode)

		local var_8_6 = getProxy(AppreciateProxy)
		local var_8_7 = var_8_6:getResultForVer()

		if var_8_7 then
			pg.ConnectionMgr.GetInstance():Send(15300, {
				type = 0,
				ver_str = var_8_7
			})
			var_8_6:clearVer()
		end
	end

	if arg_8_1.cartoon_read_mark then
		var_8_1:initMangaReadIDList(arg_8_1.cartoon_read_mark)
	end

	if arg_8_1.cartoon_collect_mark then
		var_8_1:initMangaLikeIDList(arg_8_1.cartoon_collect_mark)
	end

	arg_8_0.cdList = {}

	local var_8_8 = arg_8_1.cd_list or {}

	for iter_8_8, iter_8_9 in ipairs(var_8_8) do
		arg_8_0.cdList[iter_8_9.key] = iter_8_9.timestamp
	end

	arg_8_0.commonFlagList = {}

	local var_8_9 = arg_8_1.flag_list or {}

	for iter_8_10, iter_8_11 in ipairs(var_8_9) do
		arg_8_0.commonFlagList[iter_8_11] = true
	end

	arg_8_0.registerTime = arg_8_1.register_time
	arg_8_0.vipCards = {}

	local var_8_10 = arg_8_1.card_list or {}

	for iter_8_12, iter_8_13 in ipairs(var_8_10) do
		local var_8_11 = VipCard.New(iter_8_13)

		arg_8_0.vipCards[var_8_11.id] = var_8_11
	end

	arg_8_0:updateResources(arg_8_1.resource_list)

	arg_8_0.maxRank = arg_8_1.max_rank or 0
	arg_8_0.shipCount = arg_8_1.ship_count or 0
	arg_8_0.chargeExp = arg_8_1.acc_pay_lv or 0
	arg_8_0.mingshiflag = 0
	arg_8_0.mingshiCount = 0
	arg_8_0.chatMsgBanTime = arg_8_1.chat_msg_ban_time or 0
	arg_8_0.randomShipMode = arg_8_1.random_ship_mode or 0
	arg_8_0.buildShipNotification = {}

	local var_8_12 = arg_8_1.taking_ship_list or {}

	for iter_8_14, iter_8_15 in ipairs(var_8_12) do
		table.insert(arg_8_0.buildShipNotification, {
			uid = iter_8_15.uid,
			new = iter_8_15.isnew == 1
		})
	end

	arg_8_0.proposeShipId = arg_8_1.marry_ship
	arg_8_0.unlockCryptolaliaList = {}

	local var_8_13 = arg_8_1.soundstory or {}

	for iter_8_16, iter_8_17 in ipairs(var_8_13) do
		table.insert(arg_8_0.unlockCryptolaliaList, iter_8_17)
	end

	arg_8_0.displayInfo = arg_8_1.display or {}
	arg_8_0.attireInfo = {}
	arg_8_0.attireInfo[AttireConst.TYPE_ICON_FRAME] = arg_8_0.iconFrame
	arg_8_0.attireInfo[AttireConst.TYPE_CHAT_FRAME] = arg_8_0.chatFrame
	arg_8_0.activityMedalGroupList = {}

	local var_8_14 = arg_8_1.activity_medals or {}

	arg_8_0:updateMedalList(var_8_14)

	return
end

function var_0_0.updateAttireFrame(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.attireInfo[arg_9_1] = arg_9_2

	if arg_9_1 == AttireConst.TYPE_COMBAT_UI_STYLE then
		COMBAT_SKIN_KEY = pg.item_data_battleui[arg_9_2].key
	end

	return
end

function var_0_0.getAttireByType(arg_10_0, arg_10_1)
	return arg_10_0.attireInfo[arg_10_1]
end

function var_0_0.getRandomSecretary(arg_11_0)
	return arg_11_0.characters[math.random(#arg_11_0.characters)]
end

function var_0_0.canModifyName(arg_12_0)
	local var_12_0 = pg.TimeMgr.GetInstance():GetServerTime()

	if pg.gameset.player_name_change_lv_limit.key_value > arg_12_0.level then
		local var_12_2 = i18n("player_name_change_time_lv_tip", pg.gameset.player_name_change_lv_limit.key_value)

		return
	end

	local var_12_3 = arg_12_0:getModifyNameTimestamp()

	if var_12_0 < var_12_3 then
		local var_12_4, var_12_5, var_12_6, var_12_7 = pg.TimeMgr.GetInstance():parseTimeFrom(var_12_3 - var_12_0)
		local var_12_8 = var_12_4 == 0 and (var_12_5 == 0 and math.max(var_12_6, 1) .. i18n("word_minute") or var_12_5 .. i18n("word_hour")) or var_12_4 .. i18n("word_date")
		local var_12_10 = i18n("player_name_change_time_limit_tip", var_12_8)

		return
	end

	return true
end

function var_0_0.getModifyNameComsume(arg_13_0)
	return pg.gameset.player_name_change_cost.description
end

function var_0_0.getModifyNameTimestamp(arg_14_0)
	return arg_14_0.cdList[var_0_0.CHANGE_NAME_KEY] or 0
end

function var_0_0.updateModifyNameColdTime(arg_15_0, arg_15_1)
	arg_15_0.cdList[var_0_0.CHANGE_NAME_KEY] = arg_15_1

	return
end

function var_0_0.getMaxGold(arg_16_0)
	return pg.gameset.max_gold.key_value
end

function var_0_0.getMaxOil(arg_17_0)
	return pg.gameset.max_oil.key_value
end

function var_0_0.getLevelMaxGold(arg_18_0)
	local var_18_0 = arg_18_0:getConfig("max_gold")
	local var_18_1 = getProxy(GuildProxy):GetAdditionGuild()

	return var_18_1 and var_18_0 + var_18_1:getMaxGoldAddition() or var_18_0
end

function var_0_0.getLevelMaxOil(arg_19_0)
	local var_19_0 = arg_19_0:getConfig("max_oil")
	local var_19_1 = getProxy(GuildProxy):GetAdditionGuild()

	return var_19_1 and var_19_0 + var_19_1:getMaxOilAddition() or var_19_0
end

function var_0_0.getResource(arg_20_0, arg_20_1)
	return arg_20_0[id2res(arg_20_1)] or 0
end

function var_0_0.updateResources(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in pairs(var_0_1) do
		assert(#iter_21_1 == 1, "Multiple ID have the same name : " .. iter_21_0)

		if iter_21_0 == "gem" then
			arg_21_0.chargeGem = 0
		elseif iter_21_0 == "freeGem" then
			arg_21_0.awardGem = 0
		else
			arg_21_0[iter_21_0] = 0
		end
	end

	for iter_21_2, iter_21_3 in ipairs(arg_21_1 or {}) do
		local var_21_1 = id2res(iter_21_3.type)

		assert(var_21_1, "resource type erro>>>>>" .. iter_21_3.type)

		if var_21_1 == "gem" then
			arg_21_0.chargeGem = iter_21_3.num
		elseif var_21_1 == "freeGem" then
			arg_21_0.awardGem = iter_21_3.num
		else
			arg_21_0[var_21_1] = iter_21_3.num
		end
	end

	return
end

function var_0_0.getPainting(arg_22_0)
	local var_22_0 = pg.ship_skin_template[arg_22_0.skinId]

	if tobool(arg_22_0.character) and ShipSkin.GetChangeSkinData(arg_22_0.skinId) then
		local var_22_1 = ShipSkin.GetStoreChangeSkinId(ShipSkin.GetChangeSkinGroupId(arg_22_0.skinId), arg_22_0:GetFlagShipPhantomMark())

		if var_22_1 then
			var_22_0 = pg.ship_skin_template[var_22_1]
		end
	end

	if var_22_0 then
		return var_22_0.painting or "unknown"
	end
end

function var_0_0.inGuildCDTime(arg_23_0)
	if arg_23_0.guildWaitTime > 0 then
		local var_23_0 = arg_23_0.guildWaitTime > pg.TimeMgr.GetInstance():GetServerTime()

		return var_23_0
	end
end

function var_0_0.setGuildWaitTime(arg_24_0, arg_24_1)
	arg_24_0.guildWaitTime = arg_24_1

	return
end

function var_0_0.getChargeLevel(arg_25_0)
	local var_25_0 = pg.pay_level_award.all[1]

	for iter_25_0, iter_25_1 in ipairs(pg.pay_level_award.all) do
		if arg_25_0.chargeExp >= pg.pay_level_award[iter_25_1].exp then
			var_25_0 = math.min(iter_25_1 + 1, pg.pay_level_award.all[#pg.pay_level_award.all])
		end
	end

	return var_25_0
end

function var_0_0.getCardById(arg_26_0, arg_26_1)
	return Clone(arg_26_0.vipCards[arg_26_1])
end

function var_0_0.addVipCard(arg_27_0, arg_27_1)
	arg_27_0.vipCards[arg_27_1.id] = arg_27_1

	return
end

function var_0_0.addShipBagCount(arg_28_0, arg_28_1)
	arg_28_0.shipBagMax = arg_28_0.shipBagMax + arg_28_1

	return
end

function var_0_0.addEquipmentBagCount(arg_29_0, arg_29_1)
	arg_29_0.equipBagMax = arg_29_0.equipBagMax + arg_29_1

	return
end

function var_0_0.bindConfigTable(arg_30_0)
	return pg.user_level
end

function var_0_0.updateScoreAndRank(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0.score = arg_31_1
	arg_31_0.rank = arg_31_2

	return
end

function var_0_0.increasePvpCount(arg_32_0)
	arg_32_0.pvp_attack_count = arg_32_0.pvp_attack_count + 1

	return
end

function var_0_0.increasePvpWinCount(arg_33_0)
	arg_33_0.pvp_win_count = arg_33_0.pvp_win_count + 1

	return
end

function var_0_0.isEnough(arg_34_0, arg_34_1)
	for iter_34_0, iter_34_1 in pairs(arg_34_1) do
		if arg_34_0[iter_34_0] == nil or iter_34_1 > arg_34_0[iter_34_0] then
			return false, iter_34_0
		end
	end

	return true
end

function var_0_0.increaseBuyOilCount(arg_35_0)
	arg_35_0.buyOilCount = arg_35_0.buyOilCount + 1

	return
end

function var_0_0.changeChatRoom(arg_36_0, arg_36_1)
	arg_36_0.chatRoomId = arg_36_1

	return
end

function var_0_0.increaseAttackCount(arg_37_0)
	arg_37_0.attackCount = arg_37_0.attackCount + 1

	return
end

function var_0_0.increaseAttackWinCount(arg_38_0)
	arg_38_0.winCount = arg_38_0.winCount + 1

	return
end

function var_0_0.increaseShipCount(arg_39_0, arg_39_1)
	arg_39_0.shipCount = arg_39_0.shipCount + (arg_39_1 and arg_39_1 or 1)

	return
end

function var_0_0.isFull(arg_40_0)
	for iter_40_0, iter_40_1 in pairs(var_0_1) do
		if pg.user_level["max_" .. iter_40_0] and pg.user_level["max_" .. iter_40_0] > arg_40_0[iter_40_0] then
			return false
		end
	end

	return true
end

function var_0_0.getMaxEquipmentBag(arg_41_0)
	local var_41_0 = 0
	local var_41_1 = getProxy(GuildProxy):GetAdditionGuild()

	if var_41_1 then
		var_41_0 = var_41_1:getEquipmentBagAddition()
	end

	return var_41_0 + arg_41_0.equipBagMax
end

function var_0_0.getMaxShipBag(arg_42_0)
	local var_42_0 = 0
	local var_42_1 = getProxy(GuildProxy):GetAdditionGuild()

	if var_42_1 then
		var_42_0 = var_42_1:getShipBagAddition()
	end

	return var_42_0 + arg_42_0.shipBagMax
end

function var_0_0.getMaxEquipmentBagExcludeGuild(arg_43_0)
	return arg_43_0.equipBagMax
end

function var_0_0.getMaxShipBagExcludeGuild(arg_44_0)
	return arg_44_0.shipBagMax
end

function var_0_0.__index(arg_45_0, arg_45_1)
	if arg_45_1 == "gem" then
		return arg_45_0:getChargeGem()
	elseif arg_45_1 == "freeGem" then
		return arg_45_0:getTotalGem()
	elseif arg_45_1 == "equipBagMax" then
		return arg_45_0:getMaxEquipmentBag()
	elseif arg_45_1 == "shipBagMax" then
		return arg_45_0:getMaxShipBag()
	end

	return rawget(arg_45_0, arg_45_1) or var_0_0[arg_45_1] or var_0_0.super[arg_45_1]
end

function var_0_0.__newindex(arg_46_0, arg_46_1, arg_46_2)
	assert(arg_46_1 ~= "gem" and arg_46_1 ~= "freeGem", "Do not set gem directly.")
	rawset(arg_46_0, arg_46_1, arg_46_2)

	return
end

function var_0_0.getFreeGem(arg_47_0)
	return arg_47_0.awardGem
end

function var_0_0.getChargeGem(arg_48_0)
	return arg_48_0.chargeGem
end

function var_0_0.getTotalGem(arg_49_0)
	return arg_49_0:getFreeGem() + arg_49_0:getChargeGem()
end

function var_0_0.getResById(arg_50_0, arg_50_1)
	if arg_50_1 == 4 then
		return arg_50_0:getTotalGem()
	else
		return arg_50_0[id2res(arg_50_1)]
	end

	return
end

function var_0_0.consume(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_1.freeGem or 0
	local var_51_1 = arg_51_1.gem or 0
	local var_51_2 = var_51_0 + var_51_1

	arg_51_1.freeGem = nil
	arg_51_1.gem = nil

	if var_51_2 > 0 then
		local var_51_3 = arg_51_0:getFreeGem()
		local var_51_4 = math.min(var_51_2, var_51_3)

		arg_51_0.awardGem = var_51_3 - var_51_4
		arg_51_0.chargeGem = arg_51_0.chargeGem - (var_51_2 - var_51_4)
	end

	for iter_51_0, iter_51_1 in pairs(arg_51_1) do
		arg_51_0[iter_51_0] = arg_51_0[iter_51_0] - iter_51_1
	end

	return
end

function var_0_0.addResources(arg_52_0, arg_52_1)
	for iter_52_0, iter_52_1 in pairs(arg_52_1) do
		if iter_52_0 == "gold" then
			arg_52_0[iter_52_0] = math.min(arg_52_0[iter_52_0] + iter_52_1, (arg_52_0:getMaxGold()))
		elseif iter_52_0 == "oil" then
			arg_52_0[iter_52_0] = math.min(arg_52_0[iter_52_0] + iter_52_1, (arg_52_0:getMaxOil()))
		elseif iter_52_0 == "gem" then
			arg_52_0.chargeGem = arg_52_0:getChargeGem() + iter_52_1
		elseif iter_52_0 == "freeGem" then
			arg_52_0.awardGem = arg_52_0:getFreeGem() + iter_52_1
		else
			arg_52_0[iter_52_0] = iter_52_0 == id2res(WorldConst.ResourceID) and math.min(arg_52_0[iter_52_0] + iter_52_1, pg.gameset.world_resource_max.key_value) or iter_52_0 == "gameticket" and math.min(arg_52_0[iter_52_0] + iter_52_1, pg.gameset.game_room_remax.key_value) or arg_52_0[iter_52_0] + iter_52_1
		end
	end

	return
end

function var_0_0.resetBuyOilCount(arg_53_0)
	arg_53_0.buyOilCount = 0

	return
end

function var_0_0.addExp(arg_54_0, arg_54_1)
	assert(arg_54_1 >= 0, "exp should greater than zero")

	arg_54_0.exp = arg_54_0.exp + arg_54_1

	while arg_54_0:canLevelUp() do
		arg_54_0.exp = arg_54_0.exp - arg_54_0:getLevelExpConfig().exp_interval
		arg_54_0.level = arg_54_0.level + 1

		pg.TrackerMgr.GetInstance():Tracking(TRACKING_USER_LEVELUP, arg_54_0.level)

		if arg_54_0.level == 30 then
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_USER_LEVEL_THIRTY)
		elseif arg_54_0.level == 40 then
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_USER_LEVEL_FORTY)
		end

		if arg_54_0.level == 10 then
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_EXP_LV_10)
		elseif arg_54_0.level == 20 then
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_EXP_LV_20)
		elseif arg_54_0.level == 30 then
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_EXP_LV_30)
		end
	end

	return
end

function var_0_0.addExpToLevel(arg_55_0, arg_55_1)
	local var_55_0 = getConfigFromLevel1(pg.user_level, arg_55_1)
	local var_55_1 = arg_55_0:getLevelExpConfig()

	if var_55_1.exp_start + arg_55_0.exp >= var_55_0.exp_start then
		print("EXP Overflow, Return")

		return
	end

	arg_55_0:addExp(var_55_0.exp_start - var_55_1.exp_start - arg_55_0.exp)

	return
end

function var_0_0.GetBuffs(arg_56_0)
	return arg_56_0.buff_list
end

function var_0_0.getLevelExpConfig(arg_57_0)
	return getConfigFromLevel1(pg.user_level, arg_57_0.level)
end

function var_0_0.getMaxLevel(arg_58_0)
	return pg.user_level.all[#pg.user_level.all]
end

function var_0_0.getTotalExp(arg_59_0)
	return arg_59_0:getLevelExpConfig().exp_start + arg_59_0.exp
end

function var_0_0.canLevelUp(arg_60_0)
	local var_60_0 = getConfigFromLevel1(pg.user_level, arg_60_0.level + 1)
	local var_60_1 = arg_60_0:getLevelExpConfig()

	return var_60_0 and var_60_1 ~= var_60_0 and var_60_1.exp_interval <= arg_60_0.exp
end

function var_0_0.isSelf(arg_61_0)
	return getProxy(PlayerProxy):isSelf(arg_61_0.id)
end

function var_0_0.isFriend(arg_62_0)
	return getProxy(FriendProxy):isFriend(arg_62_0.id)
end

function var_0_0.OilMax(arg_63_0, arg_63_1)
	arg_63_1 = arg_63_1 or 0

	return pg.gameset.max_oil.key_value < arg_63_0.oil + arg_63_1
end

function var_0_0.GoldMax(arg_64_0, arg_64_1)
	arg_64_1 = arg_64_1 or 0

	return pg.gameset.max_gold.key_value < arg_64_0.gold + arg_64_1
end

function var_0_0.ResLack(arg_65_0, arg_65_1, arg_65_2)
	if pg.gameset["max_" .. arg_65_1].key_value < arg_65_0[arg_65_1] then
		return 0
	else
		return math.min(arg_65_2, pg.gameset["max_" .. arg_65_1].key_value - arg_65_0[arg_65_1])
	end

	return
end

function var_0_0.OverStore(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0

	if not arg_66_2 then
		arg_66_2 = 0
		var_66_0 = pg.mail_storeroom[arg_66_0.mailStoreLevel]
	end

	return arg_66_0[id2res(arg_66_1)] + arg_66_2 - switch(arg_66_1, {
		[PlayerConst.ResStoreGold] = function()
			return var_66_0.gold_store
		end,
		[PlayerConst.ResStoreOil] = function()
			return var_66_0.oil_store
		end
	})
end

function var_0_0.UpdateCommonFlag(arg_69_0, arg_69_1)
	arg_69_0.commonFlagList[arg_69_1] = true

	return
end

function var_0_0.GetCommonFlag(arg_70_0, arg_70_1)
	return arg_70_0.commonFlagList[arg_70_1]
end

function var_0_0.CancelCommonFlag(arg_71_0, arg_71_1)
	arg_71_0.commonFlagList[arg_71_1] = false

	return
end

function var_0_0.SetCommonFlag(arg_72_0, arg_72_1, arg_72_2)
	arg_72_0.commonFlagList[arg_72_1] = arg_72_2

	return
end

function var_0_0.updateCommanderBagMax(arg_73_0, arg_73_1)
	arg_73_0.commanderBagMax = arg_73_0.commanderBagMax + arg_73_1

	return
end

function var_0_0.GetDaysFromRegister(arg_74_0)
	return pg.TimeMgr.GetInstance():DiffDay(arg_74_0.registerTime, (pg.TimeMgr.GetInstance():GetServerTime()))
end

function var_0_0.CanUploadBackYardThemeTemplate(arg_75_0)
	local var_75_0 = pg.TimeMgr.GetInstance()

	return var_75_0:GetServerTime() >= arg_75_0.banBackyardUploadTime
end

function var_0_0.GetBanUploadBackYardThemeTemplateTime(arg_76_0)
	local var_76_0 = arg_76_0.banBackyardUploadTime or 0

	return pg.TimeMgr.GetInstance():STimeDescC(var_76_0)
end

function var_0_0.CheckIdentityFlag(arg_77_0)
	return arg_77_0.identityFlag == 1
end

function var_0_0.GetRegisterTime(arg_78_0)
	return arg_78_0.registerTime
end

function var_0_0.GetFlagShipPhantomMark(arg_79_0)
	return ShipPhantom.PackMark(arg_79_0.character, arg_79_0.phantomId)
end

function var_0_0.GetShipPhantomMarks(arg_80_0)
	for iter_80_0, iter_80_1 in ipairs(arg_80_0.characters) do
		table.insert({}, ShipPhantom.PackMark(iter_80_1, arg_80_0.phantoms[iter_80_0]))
	end

	return {}
end

function var_0_0.GetFlagShip(arg_81_0)
	local var_81_0 = getProxy(SettingsProxy)
	local var_81_1 = var_81_0:getCurrentSecretaryIndex()

	return var_81_0:IsOpenRandomFlagShip() and arg_81_0:GetRandomFlagShip(var_81_1) or arg_81_0:GetNativeFlagShip(var_81_1)
end

local function var_0_4(arg_82_0)
	local var_82_0 = getProxy(SettingsProxy):GetFlagShipDisplayMode()
	local var_82_1 = getProxy(PlayerProxy):getRawData():ExistEducateChar()

	if var_82_0 == FlAG_SHIP_DISPLAY_ONLY_EDUCATECHAR and not var_82_1 then
		var_82_0 = FlAG_SHIP_DISPLAY_ALL

		getProxy(SettingsProxy):SetFlagShipDisplayMode(FlAG_SHIP_DISPLAY_ALL)
	end

	if var_82_0 ~= FlAG_SHIP_DISPLAY_ONLY_EDUCATECHAR then
		local var_82_2 = getProxy(BayProxy)

		for iter_82_0, iter_82_1 in ipairs(arg_82_0) do
			({})[iter_82_0] = false

			local var_82_3 = var_82_2:GetShipPhantom(iter_82_1)

			if var_82_3 then
				({})[iter_82_0] = var_82_3
			end

			table.insert({}, iter_82_0)
		end
	end

	if var_82_1 and var_82_0 ~= FlAG_SHIP_DISPLAY_ONLY_SHIP then
		table.insert({}, PlayerVitaeShipsPage.EDUCATE_CHAR_SLOT_ID)

		;({})[PlayerVitaeShipsPage.EDUCATE_CHAR_SLOT_ID] = VirtualEducateCharShip.New((getProxy(PlayerProxy):getRawData():GetEducateCharacter()))
	end

	return {}, {}
end

function var_0_0.GetNativeFlagShip(arg_83_0, arg_83_1)
	local var_83_0, var_83_1 = var_0_4(arg_83_0:GetShipPhantomMarks())
	local var_83_2 = getProxy(SettingsProxy)

	if getProxy(PlayerProxy):getFlag("random_skin") then
		local var_83_3 = math.random(#var_83_1)

		arg_83_1 = var_83_1[var_83_3]

		var_83_2:setCurrentSecretaryIndex(var_83_3)
		getProxy(PlayerProxy):setFlag("random_skin", false)
	end

	local var_83_4 = var_83_0[arg_83_1]

	if not var_83_0[arg_83_1] then
		local var_83_5 = PlayerVitaeShipsPage.GetSlotIndexList()
		local var_83_6 = table.indexof(var_83_5, arg_83_1)

		if var_83_6 and var_83_6 > 0 then
			for iter_83_0 = var_83_6 + 1, #var_83_5 do
				arg_83_1 = var_83_5[iter_83_0]
				var_83_4 = var_83_0[var_83_5[iter_83_0]]

				if var_83_0[var_83_5[iter_83_0]] then
					var_83_2:setCurrentSecretaryIndex(iter_83_0)

					break
				end
			end
		end
	end

	if not var_83_4 then
		arg_83_1 = 1

		var_83_2:setCurrentSecretaryIndex(1)

		var_83_4 = var_83_0[arg_83_1]
	end

	return var_83_4
end

function var_0_0.GetRandomFlagShip(arg_84_0, arg_84_1)
	local var_84_0 = getProxy(SettingsProxy)
	local var_84_1, var_84_2 = var_0_4(var_84_0:GetRandomFlagShipList())

	if getProxy(PlayerProxy):getFlag("random_skin") then
		local var_84_3 = math.random(#var_84_2)

		arg_84_1 = var_84_2[var_84_3]

		var_84_0:setCurrentSecretaryIndex(var_84_3)
		getProxy(PlayerProxy):setFlag("random_skin", false)
	end

	local var_84_4 = var_84_1[arg_84_1]

	if not var_84_1[arg_84_1] then
		local var_84_5 = PlayerVitaeShipsPage.GetSlotIndexList()
		local var_84_6 = table.indexof(var_84_5, arg_84_1)

		if var_84_6 and var_84_6 > 0 then
			for iter_84_0 = var_84_6 + 1, #var_84_5 do
				arg_84_1 = var_84_5[iter_84_0]
				var_84_4 = var_84_1[var_84_5[iter_84_0]]

				if var_84_1[var_84_5[iter_84_0]] then
					var_84_0:setCurrentSecretaryIndex(iter_84_0)

					break
				end
			end
		end
	end

	if not var_84_4 then
		for iter_84_1, iter_84_2 in pairs(var_84_1) do
			if iter_84_2 then
				table.insert({}, iter_84_1)
			end
		end

		if #{} > 0 then
			arg_84_1 = ({})[math.random(1, #{})]
			var_84_4 = var_84_1[arg_84_1]

			local var_84_7 = table.indexof(var_84_2, arg_84_1)

			if var_84_7 then
				var_84_0:setCurrentSecretaryIndex(var_84_7)
			end
		end
	end

	if not var_84_4 then
		arg_84_1 = 1

		var_84_0:setCurrentSecretaryIndex(1)

		var_84_4 = var_84_1[arg_84_1]
	end

	return var_84_4
end

function var_0_0.GetNextFlagShip(arg_85_0)
	getProxy(SettingsProxy):rotateCurrentSecretaryIndex()

	return arg_85_0:GetFlagShip()
end

function var_0_0.IsOpenShipEvaluationImpeach(arg_86_0)
	return not LOCK_IMPEACH and arg_86_0.level >= pg.gameset.report_level_limit.key_value
end

function var_0_0.ShouldCheckCustomName(arg_87_0)
	return arg_87_0:GetCommonFlag(REVERT_CUSTOM_NAME)
end

function var_0_0.WhetherServerModifiesName(arg_88_0)
	return arg_88_0:GetCommonFlag(ILLEGALITY_PLAYER_NAME)
end

function var_0_0.GetManifesto(arg_89_0)
	return arg_89_0.manifesto or ""
end

function var_0_0.GetName(arg_90_0)
	return arg_90_0.name
end

function var_0_0.GetRandomFlagShipMode(arg_91_0)
	if arg_91_0.randomShipMode <= 0 then
		arg_91_0.randomShipMode = arg_91_0:GetCommonFlag(RANDOM_FLAG_SHIP_MODE) and SettingsRandomFlagShipAndSkinPanel.SHIP_LOCKED or SettingsRandomFlagShipAndSkinPanel.SHIP_FREQUENTLYUSED
	end

	return arg_91_0.randomShipMode
end

function var_0_0.UpdateRandomFlagShipMode(arg_92_0, arg_92_1)
	arg_92_0.randomShipMode = arg_92_1

	return
end

function var_0_0.SetProposeShipId(arg_93_0, arg_93_1)
	arg_93_0.proposeShipId = arg_93_1

	return
end

function var_0_0.GetProposeShipId(arg_94_0)
	return arg_94_0.proposeShipId
end

function var_0_0.GetCryptolaliaList(arg_95_0)
	for iter_95_0, iter_95_1 in ipairs(arg_95_0.unlockCryptolaliaList) do
		({})[iter_95_1] = true
	end

	for iter_95_2, iter_95_3 in ipairs(pg.soundstory_template.all) do
		local var_95_0 = Cryptolalia.New({
			id = iter_95_3
		})

		if ({})[iter_95_3] then
			var_95_0:Unlock()
		end

		table.insert({}, var_95_0)
	end

	return {}
end

function var_0_0.UnlockCryptolalia(arg_96_0, arg_96_1)
	if not table.contains(arg_96_0.unlockCryptolaliaList) then
		table.insert(arg_96_0.unlockCryptolaliaList, arg_96_1)
	end

	return
end

function var_0_0.ExistCryptolalia(arg_97_0, arg_97_1)
	for iter_97_0, iter_97_1 in ipairs((arg_97_0:GetCryptolaliaList())) do
		if (iter_97_1:InTime() or not iter_97_1:IsLock()) and iter_97_1:IsSameGroup(arg_97_1) then
			return true
		end
	end

	return false
end

function var_0_0.ExistEducateChar(arg_98_0)
	return arg_98_0.educateCharacter > 0
end

function var_0_0.GetEducateCharacter(arg_99_0)
	return arg_99_0.educateCharacter
end

function var_0_0.SetEducateCharacter(arg_100_0, arg_100_1)
	arg_100_0.educateCharacter = arg_100_1

	return
end

function var_0_0.CanGetResource(arg_101_0, arg_101_1)
	local var_101_0 = id2res(arg_101_1)
	local var_101_1

	if arg_101_1 == 1 then
		var_101_1 = arg_101_0:getLevelMaxGold()
	elseif arg_101_1 == 2 then
		var_101_1 = arg_101_0:getLevelMaxOil()
	else
		assert(false)
	end

	if var_101_1 <= arg_101_0[var_101_0] then
		return false
	end

	return true
end

function var_0_0.GetExtendStoreCost(arg_102_0)
	if pg.mail_storeroom[arg_102_0.mailStoreLevel].upgrade_gem > 0 then
		({}).diamond = Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResDiamond,
			count = pg.mail_storeroom[arg_102_0.mailStoreLevel].upgrade_gem
		})
	end

	if pg.mail_storeroom[arg_102_0.mailStoreLevel].upgrade_gold > 0 then
		({}).gold = Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResGold,
			count = pg.mail_storeroom[arg_102_0.mailStoreLevel].upgrade_gold
		})
	end

	return ({}).diamond, ({}).gold
end

function var_0_0.IsStoreLevelMax(arg_103_0)
	return not pg.mail_storeroom[arg_103_0.mailStoreLevel + 1]
end

function var_0_0.updateMedalList(arg_104_0, arg_104_1)
	for iter_104_0, iter_104_1 in ipairs(arg_104_1) do
		arg_104_0.activityMedalGroupList[pg.activity_medal_template[iter_104_1.key].group] = arg_104_0.activityMedalGroupList[pg.activity_medal_template[iter_104_1.key].group] or ActivityMedalGroup.New(pg.activity_medal_template[iter_104_1.key].group)

		arg_104_0.activityMedalGroupList[pg.activity_medal_template[iter_104_1.key].group]:UpdateMedal(iter_104_1.key, iter_104_1.value)
	end

	return
end

function var_0_0.getActivityMedalGroup(arg_105_0)
	return arg_105_0.activityMedalGroupList
end

function var_0_0.GetGuideIndex(arg_106_0, arg_106_1)
	if arg_106_1 then
		return arg_106_0.newGuideIndex
	else
		return arg_106_0.guideIndex
	end

	return
end

function var_0_0.UpdateGuideIndex(arg_107_0, arg_107_1, arg_107_2)
	if arg_107_1 then
		arg_107_0.newGuideIndex = arg_107_2
	else
		arg_107_0.guideIndex = arg_107_2
	end

	return
end

function var_0_0.GetDisplayShipList(arg_108_0)
	local var_108_0 = getProxy(SettingsProxy)
	local var_108_1 = var_108_0:IsOpenRandomFlagShip() and var_108_0:GetRandomFlagShipList() or arg_108_0:GetShipPhantomMarks()
	local var_108_2, var_108_3 = var_0_4(var_108_1)

	return var_108_2
end

return var_0_0
