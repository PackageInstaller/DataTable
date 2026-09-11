local var_0_0 = {}
local var_0_1 = {
	kr = 4,
	zh_cn = 1,
	jp = 3,
	tw = 2,
	en = 5
}

function var_0_0.getItemName(arg_1_0)
	if ItemCfg[arg_1_0].type == ItemConst.ITEM_TYPE.HERO then
		return HeroTools.GetHeroFullName(arg_1_0)
	elseif ItemCfg[arg_1_0].type == ItemConst.ITEM_TYPE.HERO_SKIN and ItemCfg[arg_1_0].sub_type ~= ItemConst.ITEM_SUB_TYPE.LIMIT_SKIN then
		return GetI18NText(SkinCfg[arg_1_0].name)
	end

	return GetI18NText(ItemCfg[arg_1_0].name)
end

function var_0_0.getItemDesc(arg_2_0)
	if ItemCfg[arg_2_0].type == ItemConst.ITEM_TYPE.HERO then
		return string.format(GetTips("HERO_DESC"), GetI18NText(HeroCfg[arg_2_0].hero_desc))
	elseif ItemCfg[arg_2_0].type == ItemConst.ITEM_TYPE.HERO_SKIN then
		return string.format("%s%s", GetI18NText(ItemCfg[arg_2_0].desc), GetI18NText(SkinCfg[(ItemCfg[arg_2_0].param[1] or nil) and ItemCfg[arg_2_0].param[1]].desc))
	elseif ItemCfg[arg_2_0].type == ItemConst.ITEM_TYPE.SKIN_CHANGE then
		return string.format(GetTips("EXCHANGE"), var_0_0.getItemDesc(ItemCfg[arg_2_0].param[1]))
	elseif ItemCfg[arg_2_0].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		return string.format(GetTips("SERVANT_DESC"), GetI18NText(WeaponServantCfg[arg_2_0].desc))
	elseif ItemCfg[arg_2_0].sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM or ItemCfg[arg_2_0].sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM_MULT or ItemCfg[arg_2_0].sub_type == ItemConst.ITEM_SUB_TYPE.FUKUBUKURO or ItemCfg[arg_2_0].sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM_LIMIT_TIME or ItemCfg[arg_2_0].sub_type == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_ONE or ItemCfg[arg_2_0].sub_type == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_MULTI or ItemCfg[arg_2_0].sub_type == ItemConst.ITEM_SUB_TYPE.Hero_OPTIONAL_IMMEDIATELY_USE or ItemCfg[arg_2_0].sub_type == ItemConst.ITEM_SUB_TYPE.HERO_CHIP_GIFT then
		return GetI18NText(var_0_0.getDescByParams(arg_2_0))
	else
		return GetI18NText(ItemCfg[arg_2_0].desc)
	end
end

function var_0_0.getDescByParams(arg_3_0)
	local var_3_0 = ItemCfg[arg_3_0]

	if ItemCfg[arg_3_0] == nil then
		return ""
	end

	if var_3_0.desc and string.find(var_3_0.desc, "%<color=#%x+%>{AUTOPARAMS}%<%/color%>") then
		local var_3_1 = string.match(var_3_0.desc, "<color=#(%x+)>{AUTOPARAMS}</color>")
		local var_3_2 = ""

		if var_3_0.param and #var_3_0.param > 0 then
			local var_3_3

			if GameSetting.language_separator then
				var_3_3 = GameSetting.language_separator.value[var_0_1[SettingData:GetCurrentLanguage()] or 1] or "、"
			end

			local var_3_4 = SettingData:GetCurrentLanguage() == "kr" or SettingData:GetCurrentLanguage() == "en"
			local var_3_5 = var_3_4 and "×" or "x"

			for iter_3_0, iter_3_1 in ipairs(var_3_0.param) do
				if iter_3_0 > 1 then
					var_3_2 = var_3_2 .. var_3_3
				end

				var_3_2 = var_3_2 .. string.format("<color=#%s>%s%s%s</color>", var_3_1, GetI18NText(ItemCfg[iter_3_1[1]].name), var_3_5, (var_3_4 and iter_3_1[2] >= 1000 or nil) and string.format("%s", var_0_0.formatNumberWithSeparator(iter_3_1[2], thousandsSeparator)))
			end
		end

		return string.gsub(GetI18NText(var_3_0.desc), "<color=#(%x+)>{AUTOPARAMS}</color>", var_3_2)
	else
		return ItemCfg[arg_3_0].desc
	end
end

function var_0_0.formatNumberWithSeparator(arg_4_0, arg_4_1)
	local var_4_0 = tostring(arg_4_0)
	local var_4_1 = #var_4_0

	while var_4_1 > 3 do
		var_4_1 = var_4_1 - 3
		var_4_0 = var_4_0:sub(1, var_4_1) .. arg_4_1 .. var_4_0:sub(var_4_1 + 1)
	end

	return var_4_0
end

function var_0_0.getItemTotalNumIgnoreTimeValid(arg_5_0)
	if arg_5_0 == nil or arg_5_0 == 0 then
		return 0
	end

	local var_5_0 = ItemCfg[arg_5_0]

	if ItemCfg[arg_5_0] == nil then
		return 0
	end

	local var_5_1 = var_5_0.type

	if var_5_0.type == ItemConst.ITEM_TYPE.PROPS or var_5_1 == ItemConst.ITEM_TYPE.MATERIAL or var_5_1 == ItemConst.ITEM_TYPE.ARCHIVE_GIFT or var_5_1 == ItemConst.ITEM_TYPE.SKIN_CHANGE or var_5_1 == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
		return MaterialData:GetTotalMaterialNum(arg_5_0)
	elseif var_5_1 == ItemConst.ITEM_TYPE.GIFT and var_5_0.sub_type ~= ItemConst.ITEM_SUB_TYPE.FUKUBUKURO then
		return MaterialData:GetTotalMaterialNum(arg_5_0)
	else
		return var_0_0.getItemNum(arg_5_0)
	end
end

function var_0_0.getItemNum(arg_6_0, arg_6_1)
	if arg_6_0 == nil or arg_6_0 == 0 then
		return 0
	end

	local var_6_0 = ItemCfg[arg_6_0]

	if ItemCfg[arg_6_0] == nil then
		return 0
	end

	local var_6_1 = var_6_0.type

	if var_6_0.type == ItemConst.ITEM_TYPE.CURRENCY then
		return CurrencyData:GetCurrencyNum(arg_6_0) or 0
	elseif var_6_1 == ItemConst.ITEM_TYPE.HERO_PIECE then
		local var_6_2 = HeroData:GetHeroData(var_6_0.hero_id)

		if var_6_2 then
			return var_6_2.piece
		end
	elseif var_6_1 == ItemConst.ITEM_TYPE.PROPS or var_6_1 == ItemConst.ITEM_TYPE.MATERIAL or var_6_1 == ItemConst.ITEM_TYPE.ARCHIVE_GIFT or var_6_1 == ItemConst.ITEM_TYPE.SKIN_CHANGE or var_6_1 == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
		return MaterialData:GetMaterialNum(arg_6_0, arg_6_1)
	elseif var_6_1 == ItemConst.ITEM_TYPE.GIFT then
		if var_6_0.sub_type == ItemConst.ITEM_SUB_TYPE.FUKUBUKURO then
			return FukubukuroData:CheckHaveItemId(arg_6_0) and 1 or 0
		else
			return MaterialData:GetMaterialNum(arg_6_0, arg_6_1)
		end
	elseif var_6_1 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		local var_6_3 = WeaponServantData:GetServantSByID(arg_6_0)

		return var_6_3 and table.length(var_6_3) or 0
	elseif var_6_1 == ItemConst.ITEM_TYPE.EQUIP then
		return #EquipTools.GetEquipListByEquipid(arg_6_0)
	elseif var_6_1 == ItemConst.ITEM_TYPE.HERO_SKIN then
		if var_6_0.param[1] then
			arg_6_0 = var_6_0.param[1]
		end

		return HeroTools.IsSkinUnlock(arg_6_0) and 1 or 0
	elseif var_6_1 == ItemConst.ITEM_TYPE.PORTRAIT then
		return PlayerData:GetPortrait(arg_6_0).unlock == 1 and 1 or 0
	elseif var_6_1 == ItemConst.ITEM_TYPE.FRAME then
		return PlayerData:GetFrame(arg_6_0).unlock == 1 and 1 or 0
	elseif var_6_1 == ItemConst.ITEM_TYPE.STICKER then
		return not PlayerData:GetSticker(arg_6_0).lock and 1 or 0
	elseif var_6_1 == ItemConst.ITEM_TYPE.CANTEEN_INGREDIENTS then
		return CanteenFoodData:GetHadIngredientNum(arg_6_0) or 0
	elseif var_6_1 == ItemConst.ITEM_TYPE.CLUB_COMMON then
		-- block empty
	elseif var_6_1 == ItemConst.ITEM_TYPE.DORM_FURNITURE then
		return DormData:GetFurNumInfo(arg_6_0).num or 0
	elseif var_6_1 == ItemConst.ITEM_TYPE.SCENE then
		return HomeSceneSettingData:IsHaveScene(arg_6_0) and 1 or 0
	elseif var_6_1 == ItemConst.ITEM_TYPE.FURNITURE_SUIT then
		return DormSuitData:CheckUnlockSuit(arg_6_0) and 1 or 0
	elseif var_6_1 == ItemConst.ITEM_TYPE.STICKER_BG then
		return not PlayerData:GetStickerBg(arg_6_0).lock and 1 or 0
	elseif var_6_1 == ItemConst.ITEM_TYPE.CARD_BG then
		return PlayerData:GetCardBg(arg_6_0).unlock == 1 and 1 or 0
	elseif var_6_1 == ItemConst.ITEM_TYPE.CHAT_BUBBLE then
		return table.keyof(PlayerData:GetUnlockChatBubbleIDList(), arg_6_0) and 1 or 0
	elseif var_6_1 == ItemConst.ITEM_TYPE.STICKER_FG then
		return not PlayerData:GetStickerFg(arg_6_0).lock and 1 or 0
	elseif var_6_1 == ItemConst.ITEM_TYPE.APP_ICON then
		return 1
	else
		print("未知的Item类型", var_6_1)
	end

	return 0
end

function var_0_0.getItemTexturePath(arg_7_0, arg_7_1)
	if ItemCfg[arg_7_0] == nil then
		return
	end

	if ItemCfg[arg_7_0].type == ItemConst.ITEM_TYPE.EQUIP then
		return (arg_7_1 or nil) and (SpritePathCfg.EquipIcon_s.path or SpritePathCfg.EquipIcon_l.path)
	elseif ItemCfg[arg_7_0].type == ItemConst.ITEM_TYPE.HERO_SKIN or ItemCfg[arg_7_0].type == ItemConst.ITEM_TYPE.HERO then
		return SpritePathCfg.HeroLittleIcon.path
	elseif ItemCfg[arg_7_0].type == ItemConst.ITEM_TYPE.HERO_PIECE then
		return SpritePathCfg.HeroPiece.path
	elseif ItemCfg[arg_7_0].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		return SpritePathCfg.ServantIcon.path
	elseif ItemCfg[arg_7_0].type == ItemConst.ITEM_TYPE.PORTRAIT then
		if ItemCfg[arg_7_0].sub_type == ItemConst.ITEM_SUB_TYPE.NORMAL_PORTRAIT or arg_7_1 then
			return SpritePathCfg.HeroMediumIcon.path
		elseif ItemCfg[arg_7_0].sub_type == ItemConst.ITEM_SUB_TYPE.SPECIAL_PORTRAIT or ItemCfg[arg_7_0].sub_type == ItemConst.ITEM_SUB_TYPE.NORMAL_NONCHARA_PORTRAIT then
			return "TextureConfig/Item_l/"
		else
			print("暂未定义的头像来源")
		end
	elseif ItemCfg[arg_7_0].type == ItemConst.ITEM_TYPE.STICKER then
		return "TextureConfig/Sticker/Sticker/"
	elseif arg_7_1 then
		return SpritePathCfg.ItemLittleIcon.path
	else
		return SpritePathCfg.ItemIcon.path
	end
end

function var_0_0.getItemSprite(arg_8_0, arg_8_1, arg_8_2)
	if ItemCfg[arg_8_0] == nil then
		return
	end

	local var_8_0 = var_0_0.getItemTexturePath(arg_8_0, arg_8_2)

	if ItemCfg[arg_8_0].type == ItemConst.ITEM_TYPE.STICKER then
		local var_8_1 = getSpriteWithoutAtlas(var_8_0 .. ItemCfg[arg_8_0].icon)

		if var_8_1 then
			return var_8_1
		else
			return getSpriteWithoutAtlas(var_8_0 .. ItemCfg[arg_8_0].icon .. SettingData:GetCurrentLanguageKey())
		end
	else
		return getSpriteWithoutAtlas(var_8_0 .. ItemCfg[arg_8_0].icon)
	end
end

function var_0_0.GetItemSpriteAsync(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = ItemCfg[arg_9_0] or RechargeShopDescriptionCfg[arg_9_0] or {
		sub_type = 3,
		icon = "30042"
	}

	var_9_0.icon = var_9_0.icon or "30042"

	local var_9_1 = true

	if not arg_9_2 then
		if var_9_0.type == ItemConst.ITEM_TYPE.STICKER then
			var_9_1 = false
		end

		arg_9_2 = var_0_0.getItemTexturePath(arg_9_0, arg_9_3) .. var_9_0.icon
	end

	if not var_9_1 then
		arg_9_1(arg_9_0, (var_0_0.getItemSprite(arg_9_0, nil, arg_9_3)))
	else
		getSpriteWithoutAtlasAsync(arg_9_2, function(arg_10_0)
			arg_9_1(arg_9_0, arg_10_0)
		end)
	end
end

function var_0_0.getItemLittleSprite(arg_11_0)
	return var_0_0.getItemSprite(arg_11_0, nil, true)
end

function var_0_0:GetItemExpiredTimeByInfo()
	if self.timeValid ~= nil and self.timeValid > 0 then
		return self.timeValid
	end

	return var_0_0.GetItemExpiredTimeByID(self.id)
end

function var_0_0.GetItemExpiredTimeByID(arg_13_0)
	if ItemCfg[arg_13_0].time ~= nil and ItemCfg[arg_13_0].time ~= "" then
		if ItemCfg[arg_13_0].time[1] == 1 or ItemCfg[arg_13_0].time[1] == 5 then
			for iter_13_0, iter_13_1 in ipairs(ItemCfg[arg_13_0].time[2]) do
				local var_13_0, var_13_1 = ActivityData:GetActivityTime(iter_13_1)

				return var_13_1
			end
		elseif ItemCfg[arg_13_0].time[1] == 2 then
			return ItemCfg[arg_13_0].time[2][1]
		elseif ItemCfg[arg_13_0].time[1] == 3 then
			return _G.gameTimer:GetNextWeekFreshTime() + ItemCfg[arg_13_0].time[2][1] * 604800 + (ItemCfg[arg_13_0].time[2][2][1] - 1) * 24 * 3600 + (ItemCfg[arg_13_0].time[2][2][2] - 5) * 3600 + ItemCfg[arg_13_0].time[2][2][3] * 60
		elseif ItemCfg[arg_13_0].time[1] == 4 then
			return _G.gameTimer:GetNextDayFreshTime() + ItemCfg[arg_13_0].time[2][1] * 24 * 3600 + (ItemCfg[arg_13_0].time[2][2][1] - 5) * 3600 + ItemCfg[arg_13_0].time[2][2][2] * 60 + ItemCfg[arg_13_0].time[2][2][3]
		end
	end

	return 0
end

function var_0_0:IsItemExpired()
	if var_0_0.IsItemExpiredByItemId(self.id) then
		return true
	end

	if self.timeValid ~= nil and self.timeValid > 0 and manager.time:GetServerTime() > self.timeValid then
		return true
	end

	return false
end

function var_0_0.IsItemExpiredByItemId(arg_15_0)
	if ItemCfg[arg_15_0].type ~= ItemConst.ITEM_TYPE.MATERIAL then
		return false
	end

	local var_15_0 = ItemCfg[arg_15_0]

	if ItemCfg[arg_15_0].time ~= nil and var_15_0.time ~= "" then
		if var_15_0.time[1] == 1 then
			return not ActivityData:GetActivityIsOpen(var_15_0.time[2][1])
		elseif var_15_0.time[1] == 2 then
			return manager.time:GetServerTime() > var_15_0.time[2][1]
		end
	end

	return false
end

function var_0_0.GetItemCountdownText(arg_16_0)
	if arg_16_0 <= manager.time:GetServerTime() then
		return GetTips("TIP_EXPIRED")
	else
		return manager.time:GetLostTimeStr2(arg_16_0, nil, false)
	end
end

function var_0_0.RefreshLimitRed()
	PlayerData:RefreshTagRed()
	PlayerData:RefreshCardBgRed()
	PlayerData:RefreshPortraitRed()
	PlayerData:RefreshFrameRed()
end

function var_0_0.StopRefreshLimitRed()
	PlayerData:StopTagRed()
	PlayerData:StopCardRed()
	PlayerData:StopPortraitRed()
	PlayerData:StopFrameRed()
end

function var_0_0.GetItemIsOwned(arg_19_0)
	local var_19_0 = ItemCfg[arg_19_0]

	if ItemCfg[arg_19_0].type == ItemConst.ITEM_TYPE.SKIN_CHANGE then
		return var_0_0.getItemNum(arg_19_0) > 0 or HeroTools.GetSkinIsUnlock(var_19_0.param[1])
	elseif ItemCfg[arg_19_0].type == ItemConst.ITEM_TYPE.HERO_SKIN then
		if var_19_0.param[1] then
			return HeroTools.GetSkinIsUnlock(var_19_0.param[1])
		else
			return HeroTools.GetSkinIsUnlock(var_19_0.id)
		end
	elseif ItemCfg[arg_19_0].type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
		return var_0_0.getItemNum(arg_19_0) > 0 or not ChatStickerData:IsLockSticker(var_19_0.param[1])
	elseif ItemCfg[arg_19_0].type == ItemConst.ITEM_TYPE.STICKER_BG then
		return var_0_0.getItemNum(arg_19_0) > 0 or not PlayerData:GetStickerBg(arg_19_0).lock
	elseif ItemCfg[arg_19_0].type == ItemConst.ITEM_TYPE.TAG then
		return var_0_0.getItemNum(arg_19_0) > 0 or PlayerData:GetTagInfo(arg_19_0).unlock == 1
	elseif ItemCfg[arg_19_0].type == ItemConst.ITEM_TYPE.CARD_BG then
		return var_0_0.getItemNum(arg_19_0) > 0 or PlayerData:GetCardBg(arg_19_0).unlock == 1
	elseif ItemCfg[arg_19_0].type == ItemConst.ITEM_TYPE.CHAT_BUBBLE then
		return var_0_0.getItemNum(arg_19_0) > 0 or table.keyof(PlayerData:GetUnlockChatBubbleIDList(), arg_19_0)
	elseif ItemCfg[arg_19_0].type == ItemConst.ITEM_TYPE.SCENE then
		return HomeSceneSettingData:GetUsedState(ItemCfg[arg_19_0].param[1]) == SceneConst.HOME_SCENE_TYPE.UNLOCK
	end

	return false
end

local var_0_2

local function var_0_3()
	if var_0_2 == nil then
		var_0_2 = {
			[MaterialConst.MATERIAL_TYPE.MYTHIC_REFRESH] = true,
			[ItemConst.ITEM_SUB_TYPE.OATH_RING] = true
		}
	end
end

function var_0_0.isCanUseItem(arg_21_0)
	var_0_3()

	local var_21_0 = ItemCfg[arg_21_0]

	return (ItemCfg[arg_21_0].use == 1 or var_21_0.use == 2) and not var_0_2[var_21_0.sub_type]
end

function var_0_0.GetItemSourceList(arg_22_0)
	local var_22_0 = {}
	local var_22_1 = ItemCfg[arg_22_0]
	local var_22_2 = clone(ItemCfg[arg_22_0].source)

	if ItemCfg[arg_22_0].type == ItemConst.ITEM_TYPE.HERO_PIECE then
		for iter_22_0, iter_22_1 in ipairs(var_22_2) do
			if iter_22_1[1] == ViewConst.SYSTEM_ID.DRAW then
				table.insert(var_22_0, iter_22_1)
			elseif iter_22_1[1] == ViewConst.SYSTEM_ID.LIMIT_DRAW or iter_22_1[1] == ViewConst.SYSTEM_ID.LIMIT_MUST_DRAW then
				if HeroTools:CanBeDraw(iter_22_1[2]) then
					table.insert(var_22_0, iter_22_1)
				end
			elseif iter_22_1[1] == ViewConst.SYSTEM_ID.NEWS_SHOP or iter_22_1[1] == ViewConst.SYSTEM_ID.DREAM_SHOP then
				if HeroTools.GetHeroIsUnlock(var_22_1.id - 10000) then
					table.insert(var_22_0, iter_22_1)
				end
			elseif iter_22_1[1] == ViewConst.SYSTEM_ID.SERVANT_SHOP then
				if not iter_22_1[2] then
					var_22_2[iter_22_0][2] = arg_22_0
				end

				table.insert(var_22_0, iter_22_1)
			else
				table.insert(var_22_0, iter_22_1)
			end
		end
	else
		for iter_22_2, iter_22_3 in ipairs(var_22_2) do
			if not iter_22_3[2] then
				var_22_2[iter_22_2][2] = arg_22_0
			end
		end

		var_22_0 = var_22_2
	end

	local var_22_3 = {}
	local var_22_4 = {}

	for iter_22_4 = #var_22_0, 1, -1 do
		if JumpTools.NeedHide(var_22_0[iter_22_4], arg_22_0) then
			table.remove(var_22_0, iter_22_4)
		end

		local var_22_5 = nullable(var_22_0, iter_22_4, 1)

		if var_22_5 then
			if var_22_5 == ViewConst.JUMP_SPECIAL_ID.HEROITEM_SPECIAL_SOURCE then
				table.remove(var_22_0, iter_22_4)

				_, var_22_4 = SourceTool.GetJumpDataByHeroSpecialType(arg_22_0)
			elseif var_22_5 == ViewConst.JUMP_SPECIAL_ID.SERVANT_SPECIAL_SOURCE then
				table.remove(var_22_0, iter_22_4)

				_, var_22_3 = SourceTool.GetJumpDataByServantSpecialType(arg_22_0)
			elseif var_22_5 == ViewConst.JUMP_SPECIAL_ID.GODEATER_SPECIAL_SERVANT then
				table.remove(var_22_0, iter_22_4)

				_, var_22_3 = SourceTool.GetGodEaterSourece(arg_22_0)
			elseif var_22_5 == ViewConst.JUMP_SPECIAL_ID.EQUIP_SPECIAL_SOURCE then
				local var_22_6 = SourceTool.GetJumpDataByEquipSpecialType(var_22_0, arg_22_0)

				table.remove(var_22_0, iter_22_4)

				if var_22_6 and var_22_6[1] and not JumpTools.NeedHide(var_22_6, arg_22_0) then
					table.insert(var_22_0, var_22_6)
				end
			elseif var_22_5 == ViewConst.JUMP_SPECIAL_ID.OATH_RING_COUPON_FROM_ACTIVITY_DRAW then
				local var_22_7 = ActivityTools.GetAnyOpenActivityByTemplate(ActivityTemplateConst.ACTIVITY_OATH_DRAW_MAIN)

				if var_22_7 == nil then
					table.remove(var_22_0, iter_22_4)
				elseif ActivityOathDrawData:IsGetSkinLastDrop(var_22_7) then
					table.remove(var_22_0, iter_22_4)
				end
			elseif var_22_5 == ViewConst.JUMP_SPECIAL_ID.OATH_RING_COUPON_FROM_SKIN_SHOP then
				if not OathTools.CheckAnySkinGiveBackOathRingCoupon() then
					table.remove(var_22_0, iter_22_4)
				end
			elseif var_22_5 == ViewConst.JUMP_SPECIAL_ID.PASSPORT_SHOP and var_22_1.type == ItemConst.ITEM_TYPE.HERO_PIECE and not HeroTools.GetHeroIsUnlock(var_22_1.id - 10000) then
				table.remove(var_22_0, iter_22_4)
			end
		end
	end

	for iter_22_5, iter_22_6 in pairs(var_22_3) do
		local var_22_8 = true

		for iter_22_7, iter_22_8 in pairs(var_22_0) do
			if iter_22_8[1] == iter_22_6[1] then
				var_22_8 = false
			end
		end

		if var_22_8 then
			table.insert(var_22_0, iter_22_6)
		end
	end

	for iter_22_9, iter_22_10 in pairs(var_22_4) do
		local var_22_9 = true

		for iter_22_11, iter_22_12 in pairs(var_22_0) do
			if iter_22_12[1] == iter_22_10[1] then
				var_22_9 = false
			end
		end

		if var_22_9 then
			table.insert(var_22_0, iter_22_10)
		end
	end

	return var_22_0
end

function var_0_0.HasOwnAllLimitCardItems(arg_23_0)
	local var_23_0
	local var_23_1
	local var_23_2

	for iter_23_0, iter_23_1 in ipairs(ItemCfg[arg_23_0].param) do
		local var_23_3

		if ItemCfg[iter_23_1].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			var_23_3 = iter_23_1
		elseif ItemCfg[iter_23_1].type == ItemConst.ITEM_TYPE.SCENE then
			var_23_2 = iter_23_1
		end
	end

	if nil and ItemCfg[nil] then
		var_23_1 = ItemCfg[nil].param[1]
	end

	if var_23_2 and ItemCfg[var_23_2] then
		var_23_0 = ItemCfg[var_23_2].param[1]
	end

	if var_23_1 and var_23_0 then
		if HomeSceneSettingData:IsHaveScene(var_23_0) and HeroTools.GetHasOwnedSkin(var_23_1) then
			return true
		end
	elseif not var_23_1 and var_23_0 then
		if HomeSceneSettingData:IsHaveScene(var_23_0) then
			return true
		end
	elseif var_23_1 and not var_23_0 and HeroTools.GetHasOwnedSkin(var_23_1) then
		return true
	end

	return false
end

local function var_0_5(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = table.indexof(arg_25_0, arg_25_2.type)

	if var_25_0 and arg_25_1[arg_25_2.type] then
		local var_25_1 = table.indexof(arg_25_1[arg_25_2.type], arg_25_2.id)

		if var_25_1 then
			return var_25_0, var_25_1
		else
			return false
		end
	end

	return var_25_0
end

function var_0_0.SortRewardItemList(arg_26_0)
	local var_26_0 = {
		ItemConst.ITEM_TYPE.HERO,
		ItemConst.ITEM_TYPE.HERO_SKIN,
		ItemConst.ITEM_TYPE.SCENE,
		ItemConst.ITEM_TYPE.WEAPON_SERVANT,
		ItemConst.ITEM_TYPE.GIFT,
		ItemConst.ITEM_TYPE.CURRENCY,
		ItemConst.ITEM_TYPE.PORTRAIT,
		ItemConst.ITEM_TYPE.FRAME,
		ItemConst.ITEM_TYPE.STICKER,
		ItemConst.ITEM_TYPE.DORM_FURNITURE
	}
	local var_26_1 = {
		[ItemConst.ITEM_TYPE.CURRENCY] = {
			1,
			30,
			31,
			32
		}
	}

	table.sort(arg_26_0, function(arg_27_0, arg_27_1)
		local var_27_0, var_27_1 = var_0_5(var_26_0, var_26_1, ItemCfg[arg_27_0.id])
		local var_27_2, var_27_3 = var_0_5(var_26_0, var_26_1, ItemCfg[arg_27_1.id])

		if var_27_0 and var_27_2 then
			local var_27_4 = var_27_0 == var_27_2

			if var_27_0 == var_27_2 and var_27_1 and var_27_3 then
				return var_27_1 < var_27_3
			elseif not var_27_4 then
				return var_27_0 < var_27_2
			end
		elseif var_27_0 ~= var_27_2 then
			return var_27_2 == false
		end

		return rewardSortFunc(arg_27_0, arg_27_1)
	end)

	return arg_26_0
end

function var_0_0.GetTemplateItemID(arg_28_0)
	if ItemCfg[arg_28_0].sub_type == ItemConst.ITEM_SUB_TYPE.TIME_LIMIT_ITEM or ItemCfg[arg_28_0].sub_type == ItemConst.ITEM_SUB_TYPE.OATH_RING_COUPON_TEMPLATE then
		return ItemCfg[arg_28_0].param[1]
	else
		return arg_28_0
	end
end

return var_0_0
