local Player = class("Player", import(".PlayerAttire"))
local var_0_1 = pg.player_resource
local var_0_2 = pg.player_resource.get_id_list_by_name

Player.MAX_SHIP_BAG = 4000
Player.MAX_EQUIP_BAG = 2000
Player.MAX_COMMANDER_BAG = 400
Player.ASSISTS_TYPE_SHAM = 0
Player.ASSISTS_TYPE_GUILD = 1
Player.CHANGE_NAME_KEY = 1

function id2res(arg_1_0)
	return var_0_1[arg_1_0].name
end

function res2id(arg_2_0)
	return var_0_1.get_id_list_by_name[arg_2_0][1]
end

function id2ItemId(arg_3_0)
	return var_0_1[arg_3_0].itemid
end

function itemId2Id(arg_4_0)
	assert(false)

	return
end

function Player:isMetaShipNeedToTrans()
	local var_5_0 = getProxy(BayProxy)
	local var_5_1 = getProxy(MetaCharacterProxy):getMetaIDMark(self)

	return not not (var_5_0:getMetaShipByGroupId((MetaCharacterConst.GetMetaShipGroupIDByConfigID(self))) or var_5_1 and var_5_1 > 0)
end

function Player:metaShip2Res()
	local var_6_0 = MetaCharacterConst.GetMetaShipGroupIDByConfigID(self)
	local var_6_1 = getProxy(BayProxy):getMetaShipByGroupId(var_6_0)
	local var_6_3

	if not var_6_1 then
		var_6_3 = false
	else
		local var_6_4 = var_6_1:getMetaCharacter():getSpecialMaterialInfoToMaxStar()

		var_6_3 = var_6_4.count <= getProxy(BagProxy):getItemCountById(var_6_4.itemID)
	end

	local var_6_6 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_3 and pg.ship_transform[var_6_0].common_item or pg.ship_transform[var_6_0].exclusive_item) do
		table.insert(var_6_6, {
			type = iter_6_1[1],
			id = iter_6_1[2],
			count = iter_6_1[3]
		})
	end

	return var_6_6
end

function Player:getSkinTicket()
	return pg.gameset.skin_ticket.key_value == 0 and 0 or self:getResource(pg.gameset.skin_ticket.key_value)
end

function Player:Ctor(arg_8_1)
	Player.super.Ctor(self, arg_8_1)

	self.educateCharacter = arg_8_1.child_display or 0
	self.id = arg_8_1.id
	self.name = arg_8_1.name
	self.level = arg_8_1.level or arg_8_1.lv
	self.configId = self.level
	self.exp = arg_8_1.exp or 0
	self.attackCount = arg_8_1.attack_count or 0
	self.winCount = arg_8_1.win_count or 0
	self.manifesto = arg_8_1.adv or arg_8_1.manifesto
	self.shipBagMax = arg_8_1.ship_bag_max
	self.equipBagMax = arg_8_1.equip_bag_max
	self.buff_list = arg_8_1.buffList or {}
	self.rank = arg_8_1.rank or arg_8_1.title or 0
	self.pvp_attack_count = arg_8_1.pvp_attack_count or 0
	self.pvp_win_count = arg_8_1.pvp_win_count or 0
	self.collect_attack_count = arg_8_1.collect_attack_count or 0
	self.guideIndex = arg_8_1.guide_index
	self.newGuideIndex = arg_8_1.new_guide_index
	self.buyOilCount = arg_8_1.buy_oil_count
	self.chatRoomId = arg_8_1.chat_room_id or 1
	self.score = arg_8_1.score or 0
	self.guildWaitTime = arg_8_1.guild_wait_time or 0
	self.commanderBagMax = arg_8_1.commander_bag_max
	self.displayTrophyList = arg_8_1.medal_id or {}
	self.banBackyardUploadTime = arg_8_1.theme_upload_not_allowed_time or 0
	self.identityFlag = arg_8_1.gm_flag
	self.mailStoreLevel = arg_8_1.mail_storeroom_lv

	local var_8_1 = getProxy(AppreciateProxy)

	if arg_8_1.appreciation then
		for iter_8_0, iter_8_1 in ipairs(arg_8_1.appreciation.gallerys or {}) do
			var_8_1:addPicIDToUnlockList(iter_8_1)
		end

		for iter_8_2, iter_8_3 in ipairs(arg_8_1.appreciation.musics or {}) do
			var_8_1:addMusicIDToUnlockList(iter_8_3)
		end

		for iter_8_4, iter_8_5 in ipairs(arg_8_1.appreciation.favor_gallerys or {}) do
			var_8_1:addPicIDToLikeList(iter_8_5)
		end

		for iter_8_6, iter_8_7 in ipairs(arg_8_1.appreciation.favor_musics or {}) do
			var_8_1:addMusicIDToLikeList(iter_8_7)
		end

		var_8_1:setMainPlayMusicAlbum(arg_8_1.appreciation.music_no)
		var_8_1:setMusicPlayerLoopType(arg_8_1.appreciation.music_mode)

		local var_8_3 = getProxy(AppreciateProxy)
		local var_8_4 = var_8_3:getResultForVer()

		if var_8_4 then
			pg.ConnectionMgr.GetInstance():Send(15300, {
				type = 0,
				ver_str = var_8_4
			})
			var_8_3:clearVer()
		end
	end

	if arg_8_1.cartoon_read_mark then
		var_8_1:initMangaReadIDList(arg_8_1.cartoon_read_mark)
	end

	if arg_8_1.cartoon_collect_mark then
		var_8_1:initMangaLikeIDList(arg_8_1.cartoon_collect_mark)
	end

	self.cdList = {}

	for iter_8_8, iter_8_9 in ipairs(arg_8_1.cd_list or {}) do
		self.cdList[iter_8_9.key] = iter_8_9.timestamp
	end

	self.commonFlagList = {}

	for iter_8_10, iter_8_11 in ipairs(arg_8_1.flag_list or {}) do
		self.commonFlagList[iter_8_11] = true
	end

	self.registerTime = arg_8_1.register_time
	self.vipCards = {}

	for iter_8_12, iter_8_13 in ipairs(arg_8_1.card_list or {}) do
		local var_8_5 = VipCard.New(iter_8_13)

		self.vipCards[var_8_5.id] = var_8_5
	end

	self:updateResources(arg_8_1.resource_list)

	self.maxRank = arg_8_1.max_rank or 0
	self.shipCount = arg_8_1.ship_count or 0
	self.chargeExp = arg_8_1.acc_pay_lv or 0
	self.mingshiflag = 0
	self.mingshiCount = 0
	self.chatMsgBanTime = arg_8_1.chat_msg_ban_time or 0
	self.randomShipMode = arg_8_1.random_ship_mode or 0
	self.buildShipNotification = {}

	for iter_8_14, iter_8_15 in ipairs(arg_8_1.taking_ship_list or {}) do
		table.insert(self.buildShipNotification, {
			uid = iter_8_15.uid,
			new = iter_8_15.isnew == 1
		})
	end

	self.proposeShipId = arg_8_1.marry_ship
	self.unlockCryptolaliaList = {}

	for iter_8_16, iter_8_17 in ipairs(arg_8_1.soundstory or {}) do
		table.insert(self.unlockCryptolaliaList, iter_8_17)
	end

	self.displayInfo = arg_8_1.display or {}
	self.attireInfo = {}
	self.attireInfo[AttireConst.TYPE_ICON_FRAME] = self.iconFrame
	self.attireInfo[AttireConst.TYPE_CHAT_FRAME] = self.chatFrame
	self.activityMedalGroupList = {}

	self:updateMedalList(arg_8_1.activity_medals or {})

	return
end

function Player:updateAttireFrame(arg_9_1, arg_9_2)
	self.attireInfo[arg_9_1] = arg_9_2

	if arg_9_1 == AttireConst.TYPE_COMBAT_UI_STYLE then
		COMBAT_SKIN_KEY = pg.item_data_battleui[arg_9_2].key
	end

	return
end

function Player:getAttireByType(arg_10_1)
	return self.attireInfo[arg_10_1]
end

function Player:getRandomSecretary()
	return self.characters[math.random(#self.characters)]
end

function Player:canModifyName()
	local var_12_0 = pg.TimeMgr.GetInstance():GetServerTime()

	if pg.gameset.player_name_change_lv_limit.key_value > self.level then
		local var_12_2 = i18n("player_name_change_time_lv_tip", pg.gameset.player_name_change_lv_limit.key_value)

		return
	end

	local var_12_3 = self:getModifyNameTimestamp()

	if var_12_0 < var_12_3 then
		local var_12_4, var_12_5, var_12_6, var_12_7 = pg.TimeMgr.GetInstance():parseTimeFrom(var_12_3 - var_12_0)
		local var_12_10 = i18n("player_name_change_time_limit_tip", var_12_4 == 0 and (var_12_5 == 0 and math.max(var_12_6, 1) .. i18n("word_minute") or var_12_5 .. i18n("word_hour")) or var_12_4 .. i18n("word_date"))

		return
	end

	return true
end

function Player:getModifyNameComsume()
	return pg.gameset.player_name_change_cost.description
end

function Player:getModifyNameTimestamp()
	return self.cdList[Player.CHANGE_NAME_KEY] or 0
end

function Player:updateModifyNameColdTime(arg_15_1)
	self.cdList[Player.CHANGE_NAME_KEY] = arg_15_1

	return
end

function Player:getMaxGold()
	return pg.gameset.max_gold.key_value
end

function Player:getMaxOil()
	return pg.gameset.max_oil.key_value
end

function Player:getLevelMaxGold()
	local var_18_0 = self:getConfig("max_gold")
	local var_18_1 = getProxy(GuildProxy):GetAdditionGuild()

	return var_18_1 and var_18_0 + var_18_1:getMaxGoldAddition() or var_18_0
end

function Player:getLevelMaxOil()
	local var_19_0 = self:getConfig("max_oil")
	local var_19_1 = getProxy(GuildProxy):GetAdditionGuild()

	return var_19_1 and var_19_0 + var_19_1:getMaxOilAddition() or var_19_0
end

function Player:getResource(arg_20_1)
	return self[id2res(arg_20_1)] or 0
end

function Player:updateResources(arg_21_1)
	for iter_21_0, iter_21_1 in pairs(var_0_2) do
		assert(#iter_21_1 == 1, "Multiple ID have the same name : " .. iter_21_0)

		if iter_21_0 == "gem" then
			self.chargeGem = 0
		elseif iter_21_0 == "freeGem" then
			self.awardGem = 0
		else
			self[iter_21_0] = 0
		end
	end

	for iter_21_2, iter_21_3 in ipairs(arg_21_1 or {}) do
		local var_21_1 = id2res(iter_21_3.type)

		assert(var_21_1, "resource type erro>>>>>" .. iter_21_3.type)

		if var_21_1 == "gem" then
			self.chargeGem = iter_21_3.num
		elseif var_21_1 == "freeGem" then
			self.awardGem = iter_21_3.num
		else
			self[var_21_1] = iter_21_3.num
		end
	end

	return
end

function Player:getPainting()
	local var_22_0 = pg.ship_skin_template[self.skinId]

	if tobool(self.character) and ShipSkin.GetChangeSkinData(self.skinId) then
		local var_22_1 = ShipSkin.GetStoreChangeSkinId(ShipSkin.GetChangeSkinGroupId(self.skinId), self:GetFlagShipPhantomMark())

		if var_22_1 then
			var_22_0 = pg.ship_skin_template[var_22_1]
		end
	end

	return (var_22_0 or nil) and (var_22_0.painting or "unknown")
end

function Player:inGuildCDTime()
	local var_23_0

	if self.guildWaitTime > 0 then
		if self.guildWaitTime <= pg.TimeMgr.GetInstance():GetServerTime() then
			var_23_0 = false

			goto label_23_0
		end
	end

	::label_23_0::

	return true
end

function Player:setGuildWaitTime(arg_24_1)
	self.guildWaitTime = arg_24_1

	return
end

function Player:getChargeLevel()
	local var_25_0 = pg.pay_level_award.all[1]
	local var_25_1 = pg.pay_level_award.all[#pg.pay_level_award.all]

	for iter_25_0, iter_25_1 in ipairs(pg.pay_level_award.all) do
		if self.chargeExp >= pg.pay_level_award[iter_25_1].exp then
			var_25_0 = math.min(iter_25_1 + 1, var_25_1)
		end
	end

	return var_25_0
end

function Player:getCardById(arg_26_1)
	return Clone(self.vipCards[arg_26_1])
end

function Player:addVipCard(arg_27_1)
	self.vipCards[arg_27_1.id] = arg_27_1

	return
end

function Player:addShipBagCount(arg_28_1)
	self.shipBagMax = self.shipBagMax + arg_28_1

	return
end

function Player:addEquipmentBagCount(arg_29_1)
	self.equipBagMax = self.equipBagMax + arg_29_1

	return
end

function Player:bindConfigTable()
	return pg.user_level
end

function Player:updateScoreAndRank(arg_31_1, arg_31_2)
	self.score = arg_31_1
	self.rank = arg_31_2

	return
end

function Player:increasePvpCount()
	self.pvp_attack_count = self.pvp_attack_count + 1

	return
end

function Player:increasePvpWinCount()
	self.pvp_win_count = self.pvp_win_count + 1

	return
end

function Player:isEnough(arg_34_1)
	for iter_34_0, iter_34_1 in pairs(arg_34_1) do
		if self[iter_34_0] == nil or iter_34_1 > self[iter_34_0] then
			return false, iter_34_0
		end
	end

	return true
end

function Player:increaseBuyOilCount()
	self.buyOilCount = self.buyOilCount + 1

	return
end

function Player:changeChatRoom(arg_36_1)
	self.chatRoomId = arg_36_1

	return
end

function Player:increaseAttackCount()
	self.attackCount = self.attackCount + 1

	return
end

function Player:increaseAttackWinCount()
	self.winCount = self.winCount + 1

	return
end

function Player:increaseShipCount(arg_39_1)
	self.shipCount = self.shipCount + (arg_39_1 and arg_39_1 or 1)

	return
end

function Player:isFull()
	for iter_40_0, iter_40_1 in pairs(var_0_2) do
		if pg.user_level["max_" .. iter_40_0] and pg.user_level["max_" .. iter_40_0] > self[iter_40_0] then
			return false
		end
	end

	return true
end

function Player:getMaxEquipmentBag()
	local var_41_1 = getProxy(GuildProxy):GetAdditionGuild()

	return ((var_41_1 or nil) and var_41_1:getEquipmentBagAddition()) + self.equipBagMax
end

function Player:getMaxShipBag()
	local var_42_1 = getProxy(GuildProxy):GetAdditionGuild()

	return ((var_42_1 or nil) and var_42_1:getShipBagAddition()) + self.shipBagMax
end

function Player:getMaxEquipmentBagExcludeGuild()
	return self.equipBagMax
end

function Player:getMaxShipBagExcludeGuild()
	return self.shipBagMax
end

function Player:__index(arg_45_1)
	if arg_45_1 == "gem" then
		return self:getChargeGem()
	elseif arg_45_1 == "freeGem" then
		return self:getTotalGem()
	elseif arg_45_1 == "equipBagMax" then
		return self:getMaxEquipmentBag()
	elseif arg_45_1 == "shipBagMax" then
		return self:getMaxShipBag()
	end

	return rawget(self, arg_45_1) or Player[arg_45_1] or Player.super[arg_45_1]
end

function Player:__newindex(arg_46_1, arg_46_2)
	assert(arg_46_1 ~= "gem" and arg_46_1 ~= "freeGem", "Do not set gem directly.")
	rawset(self, arg_46_1, arg_46_2)

	return
end

function Player:getFreeGem()
	return self.awardGem
end

function Player:getChargeGem()
	return self.chargeGem
end

function Player:getTotalGem()
	return self:getFreeGem() + self:getChargeGem()
end

function Player:getResById(arg_50_1)
	if arg_50_1 == 4 then
		return self:getTotalGem()
	else
		return self[id2res(arg_50_1)]
	end

	return
end

function Player:consume(arg_51_1)
	local var_51_1 = (arg_51_1.freeGem or 0) + (arg_51_1.gem or 0)

	arg_51_1.freeGem = nil
	arg_51_1.gem = nil

	if var_51_1 > 0 then
		local var_51_2 = self:getFreeGem()
		local var_51_3 = math.min(var_51_1, var_51_2)

		self.awardGem = var_51_2 - var_51_3
		self.chargeGem = self.chargeGem - (var_51_1 - var_51_3)
	end

	for iter_51_0, iter_51_1 in pairs(arg_51_1) do
		self[iter_51_0] = self[iter_51_0] - iter_51_1
	end

	return
end

function Player:addResources(arg_52_1)
	for iter_52_0, iter_52_1 in pairs(arg_52_1) do
		if iter_52_0 == "gold" then
			self[iter_52_0] = math.min(self[iter_52_0] + iter_52_1, (self:getMaxGold()))
		elseif iter_52_0 == "oil" then
			self[iter_52_0] = math.min(self[iter_52_0] + iter_52_1, (self:getMaxOil()))
		elseif iter_52_0 == "gem" then
			self.chargeGem = self:getChargeGem() + iter_52_1
		elseif iter_52_0 == "freeGem" then
			self.awardGem = self:getFreeGem() + iter_52_1
		else
			self[iter_52_0] = iter_52_0 == id2res(WorldConst.ResourceID) and math.min(self[iter_52_0] + iter_52_1, pg.gameset.world_resource_max.key_value) or iter_52_0 == "gameticket" and math.min(self[iter_52_0] + iter_52_1, pg.gameset.game_room_remax.key_value) or self[iter_52_0] + iter_52_1
		end
	end

	return
end

function Player:resetBuyOilCount()
	self.buyOilCount = 0

	return
end

function Player:addExp(arg_54_1)
	assert(arg_54_1 >= 0, "exp should greater than zero")

	self.exp = self.exp + arg_54_1

	while self:canLevelUp() do
		self.exp = self.exp - self:getLevelExpConfig().exp_interval
		self.level = self.level + 1

		pg.TrackerMgr.GetInstance():Tracking(TRACKING_USER_LEVELUP, self.level)

		if self.level == 30 then
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_USER_LEVEL_THIRTY)
		elseif self.level == 40 then
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_USER_LEVEL_FORTY)
		end

		if self.level == 10 then
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_EXP_LV_10)
		elseif self.level == 20 then
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_EXP_LV_20)
		elseif self.level == 30 then
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_EXP_LV_30)
		end
	end

	return
end

function Player:addExpToLevel(arg_55_1)
	local var_55_0 = getConfigFromLevel1(pg.user_level, arg_55_1)
	local var_55_1 = self:getLevelExpConfig()

	if var_55_1.exp_start + self.exp >= var_55_0.exp_start then
		print("EXP Overflow, Return")

		return
	end

	self:addExp(var_55_0.exp_start - var_55_1.exp_start - self.exp)

	return
end

function Player:GetBuffs()
	return self.buff_list
end

function Player:getLevelExpConfig()
	return getConfigFromLevel1(pg.user_level, self.level)
end

function Player:getMaxLevel()
	return pg.user_level.all[#pg.user_level.all]
end

function Player:getTotalExp()
	return self:getLevelExpConfig().exp_start + self.exp
end

function Player:canLevelUp()
	local var_60_0 = getConfigFromLevel1(pg.user_level, self.level + 1)
	local var_60_1 = self:getLevelExpConfig()

	return var_60_0 and var_60_1 ~= var_60_0 and var_60_1.exp_interval <= self.exp
end

function Player:isSelf()
	return getProxy(PlayerProxy):isSelf(self.id)
end

function Player:isFriend()
	return getProxy(FriendProxy):isFriend(self.id)
end

function Player:OilMax(arg_63_1)
	arg_63_1 = arg_63_1 or 0

	return pg.gameset.max_oil.key_value < self.oil + arg_63_1
end

function Player:GoldMax(arg_64_1)
	arg_64_1 = arg_64_1 or 0

	return pg.gameset.max_gold.key_value < self.gold + arg_64_1
end

function Player:ResLack(arg_65_1, arg_65_2)
	if pg.gameset["max_" .. arg_65_1].key_value < self[arg_65_1] then
		return 0
	else
		return math.min(arg_65_2, pg.gameset["max_" .. arg_65_1].key_value - self[arg_65_1])
	end

	return
end

function Player:OverStore(arg_66_1, arg_66_2)
	if not arg_66_2 then
		arg_66_2 = 0

		local var_66_0 = pg.mail_storeroom[self.mailStoreLevel]
	end

	return self[id2res(arg_66_1)] + arg_66_2 - switch(arg_66_1, {
		[PlayerConst.ResStoreGold] = function()
			return var_66_0.gold_store
		end,
		[PlayerConst.ResStoreOil] = function()
			return var_66_0.oil_store
		end
	})
end

function Player:UpdateCommonFlag(arg_69_1)
	self.commonFlagList[arg_69_1] = true

	return
end

function Player:GetCommonFlag(arg_70_1)
	return self.commonFlagList[arg_70_1]
end

function Player:CancelCommonFlag(arg_71_1)
	self.commonFlagList[arg_71_1] = false

	return
end

function Player:SetCommonFlag(arg_72_1, arg_72_2)
	self.commonFlagList[arg_72_1] = arg_72_2

	return
end

function Player:updateCommanderBagMax(arg_73_1)
	self.commanderBagMax = self.commanderBagMax + arg_73_1

	return
end

function Player:GetDaysFromRegister()
	return pg.TimeMgr.GetInstance():DiffDay(self.registerTime, (pg.TimeMgr.GetInstance():GetServerTime()))
end

function Player:CanUploadBackYardThemeTemplate()
	return pg.TimeMgr.GetInstance():GetServerTime() >= self.banBackyardUploadTime
end

function Player:GetBanUploadBackYardThemeTemplateTime()
	return pg.TimeMgr.GetInstance():STimeDescC(self.banBackyardUploadTime or 0)
end

function Player:CheckIdentityFlag()
	return self.identityFlag == 1
end

function Player:GetRegisterTime()
	return self.registerTime
end

function Player:GetFlagShipPhantomMark()
	return ShipPhantom.PackMark(self.character, self.phantomId)
end

function Player:GetShipPhantomMarks()
	local var_80_0 = {}

	for iter_80_0, iter_80_1 in ipairs(self.characters) do
		table.insert(var_80_0, ShipPhantom.PackMark(iter_80_1, self.phantoms[iter_80_0]))
	end

	return var_80_0
end

function Player:GetFlagShip()
	local var_81_0 = getProxy(SettingsProxy)
	local var_81_1 = var_81_0:getCurrentSecretaryIndex()

	return var_81_0:IsOpenRandomFlagShip() and self:GetRandomFlagShip(var_81_1) or self:GetNativeFlagShip(var_81_1)
end

local function var_0_5(arg_82_0)
	local var_82_0 = {}
	local var_82_1 = {}
	local var_82_2 = getProxy(SettingsProxy):GetFlagShipDisplayMode()
	local var_82_3 = getProxy(PlayerProxy):getRawData():ExistEducateChar()

	if var_82_2 == FlAG_SHIP_DISPLAY_ONLY_EDUCATECHAR and not var_82_3 then
		var_82_2 = FlAG_SHIP_DISPLAY_ALL

		getProxy(SettingsProxy):SetFlagShipDisplayMode(FlAG_SHIP_DISPLAY_ALL)
	end

	if var_82_2 ~= FlAG_SHIP_DISPLAY_ONLY_EDUCATECHAR then
		local var_82_4 = getProxy(BayProxy)

		for iter_82_0, iter_82_1 in ipairs(arg_82_0) do
			var_82_0[iter_82_0] = false

			local var_82_5 = var_82_4:GetShipPhantom(iter_82_1)

			if var_82_5 then
				var_82_0[iter_82_0] = var_82_5
			end

			table.insert(var_82_1, iter_82_0)
		end
	end

	if var_82_3 and var_82_2 ~= FlAG_SHIP_DISPLAY_ONLY_SHIP then
		table.insert(var_82_1, PlayerVitaeShipsPage.EDUCATE_CHAR_SLOT_ID)

		var_82_0[PlayerVitaeShipsPage.EDUCATE_CHAR_SLOT_ID] = VirtualEducateCharShip.New((getProxy(PlayerProxy):getRawData():GetEducateCharacter()))
	end

	return var_82_0, var_82_1
end

function Player:GetNativeFlagShip(arg_83_1)
	local var_83_0, var_83_1 = var_0_5(self:GetShipPhantomMarks())
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

function Player:GetRandomFlagShip(arg_84_1)
	local var_84_0 = getProxy(SettingsProxy)
	local var_84_1, var_84_2 = var_0_5(var_84_0:GetRandomFlagShipList())

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
		local var_84_7 = {}

		for iter_84_1, iter_84_2 in pairs(var_84_1) do
			if iter_84_2 then
				table.insert(var_84_7, iter_84_1)
			end
		end

		if #var_84_7 > 0 then
			arg_84_1 = var_84_7[math.random(1, #var_84_7)]
			var_84_4 = var_84_1[arg_84_1]

			local var_84_8 = table.indexof(var_84_2, arg_84_1)

			if var_84_8 then
				var_84_0:setCurrentSecretaryIndex(var_84_8)
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

function Player:GetNextFlagShip()
	getProxy(SettingsProxy):rotateCurrentSecretaryIndex()

	return self:GetFlagShip()
end

function Player:IsOpenShipEvaluationImpeach()
	return not LOCK_IMPEACH and self.level >= pg.gameset.report_level_limit.key_value
end

function Player:ShouldCheckCustomName()
	return self:GetCommonFlag(REVERT_CUSTOM_NAME)
end

function Player:WhetherServerModifiesName()
	return self:GetCommonFlag(ILLEGALITY_PLAYER_NAME)
end

function Player:GetManifesto()
	return self.manifesto or ""
end

function Player:GetName()
	return self.name
end

function Player:GetRandomFlagShipMode()
	if self.randomShipMode <= 0 then
		self.randomShipMode = self:GetCommonFlag(RANDOM_FLAG_SHIP_MODE) and SettingsRandomFlagShipAndSkinPanel.SHIP_LOCKED or SettingsRandomFlagShipAndSkinPanel.SHIP_FREQUENTLYUSED
	end

	return self.randomShipMode
end

function Player:UpdateRandomFlagShipMode(arg_92_1)
	self.randomShipMode = arg_92_1

	return
end

function Player:SetProposeShipId(arg_93_1)
	self.proposeShipId = arg_93_1

	return
end

function Player:GetProposeShipId()
	return self.proposeShipId
end

function Player:GetCryptolaliaList()
	local var_95_0 = {}
	local var_95_1 = {}

	for iter_95_0, iter_95_1 in ipairs(self.unlockCryptolaliaList) do
		var_95_1[iter_95_1] = true
	end

	for iter_95_2, iter_95_3 in ipairs(pg.soundstory_template.all) do
		local var_95_2 = Cryptolalia.New({
			id = iter_95_3
		})

		if var_95_1[iter_95_3] then
			var_95_2:Unlock()
		end

		table.insert(var_95_0, var_95_2)
	end

	return var_95_0
end

function Player:UnlockCryptolalia(arg_96_1)
	if not table.contains(self.unlockCryptolaliaList) then
		table.insert(self.unlockCryptolaliaList, arg_96_1)
	end

	return
end

function Player:ExistCryptolalia(arg_97_1)
	for iter_97_0, iter_97_1 in ipairs((self:GetCryptolaliaList())) do
		if (iter_97_1:InTime() or not iter_97_1:IsLock()) and iter_97_1:IsSameGroup(arg_97_1) then
			return true
		end
	end

	return false
end

function Player:ExistEducateChar()
	return self.educateCharacter > 0
end

function Player:GetEducateCharacter()
	return self.educateCharacter
end

function Player:SetEducateCharacter(arg_100_1)
	self.educateCharacter = arg_100_1

	return
end

function Player:CanGetResource(arg_101_1)
	local var_101_0 = id2res(arg_101_1)
	local var_101_1

	if arg_101_1 == 1 then
		var_101_1 = self:getLevelMaxGold()
	elseif arg_101_1 == 2 then
		var_101_1 = self:getLevelMaxOil()
	else
		assert(false)
	end

	if var_101_1 <= self[var_101_0] then
		return false
	end

	return true
end

function Player:GetExtendStoreCost()
	local var_102_0 = {}

	if pg.mail_storeroom[self.mailStoreLevel].upgrade_gem > 0 then
		var_102_0.diamond = Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResDiamond,
			count = pg.mail_storeroom[self.mailStoreLevel].upgrade_gem
		})
	end

	if pg.mail_storeroom[self.mailStoreLevel].upgrade_gold > 0 then
		var_102_0.gold = Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResGold,
			count = pg.mail_storeroom[self.mailStoreLevel].upgrade_gold
		})
	end

	return var_102_0.diamond, var_102_0.gold
end

function Player:IsStoreLevelMax()
	return not pg.mail_storeroom[self.mailStoreLevel + 1]
end

function Player:updateMedalList(arg_104_1)
	for iter_104_0, iter_104_1 in ipairs(arg_104_1) do
		self.activityMedalGroupList[pg.activity_medal_template[iter_104_1.key].group] = self.activityMedalGroupList[pg.activity_medal_template[iter_104_1.key].group] or ActivityMedalGroup.New(pg.activity_medal_template[iter_104_1.key].group)

		self.activityMedalGroupList[pg.activity_medal_template[iter_104_1.key].group]:UpdateMedal(iter_104_1.key, iter_104_1.value)
	end

	return
end

function Player:getActivityMedalGroup()
	return self.activityMedalGroupList
end

function Player:GetGuideIndex(arg_106_1)
	if arg_106_1 then
		return self.newGuideIndex
	else
		return self.guideIndex
	end

	return
end

function Player:UpdateGuideIndex(arg_107_1, arg_107_2)
	if arg_107_1 then
		self.newGuideIndex = arg_107_2
	else
		self.guideIndex = arg_107_2
	end

	return
end

function Player:GetDisplayShipList()
	local var_108_0 = getProxy(SettingsProxy)
	local var_108_2, var_108_3 = var_0_5(var_108_0:IsOpenRandomFlagShip() and var_108_0:GetRandomFlagShipList() or self:GetShipPhantomMarks())

	return var_108_2
end

return Player
