local var_0_0 = {}

manager.net:Bind(17023, function(arg_1_0)
	var_0_0.ModifyItemList(arg_1_0.normal_items)
	EquipAction.ModifyEquipList(arg_1_0.equip_list)
	var_0_0.AddBackHomeItem(arg_1_0.back_home_list)
	ServantAction.ModifyServantList(arg_1_0.weapon_list)
	FukubukuroAction.UpdateItem(arg_1_0.rand_item)
end)

function var_0_0.ModifyItemList(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		var_0_0.AddItemData(iter_2_1)
	end
end

function var_0_0.AddItemData(arg_3_0)
	local var_3_0 = arg_3_0.id
	local var_3_1 = arg_3_0.num
	local var_3_2 = arg_3_0.time_valid
	local var_3_3 = ItemCfg[var_3_0]
	local var_3_4 = var_3_3.type

	if var_3_4 == ItemConst.ITEM_TYPE.CURRENCY then
		CurrencyAction.SetCurrencyValue(var_3_0, var_3_1, var_3_2)
	elseif var_3_4 == ItemConst.ITEM_TYPE.MATERIAL or var_3_4 == ItemConst.ITEM_TYPE.GIFT or var_3_4 == ItemConst.ITEM_TYPE.PROPS or var_3_4 == ItemConst.ITEM_TYPE.DYNAMIC_STICKER or var_3_4 == ItemConst.ITEM_TYPE.ARCHIVE_GIFT then
		MaterialAction.SetMaterialValue(var_3_0, var_3_1, var_3_2)
	elseif var_3_4 == ItemConst.ITEM_TYPE.SKIN_CHANGE then
		MaterialAction.SetMaterialValue(var_3_0, var_3_1, var_3_2)

		local var_3_5 = ItemCfg[var_3_0].param[1]
		local var_3_6 = SkinCfg[var_3_5].hero

		HeroAction.UpdateSkinCouponRedPoint(var_3_6)
	elseif var_3_4 == ItemConst.ITEM_TYPE.HERO then
		HeroAction.UnlockHeroSuccess(var_3_0)
	elseif var_3_4 == ItemConst.ITEM_TYPE.HERO_PIECE then
		HeroAction.HeroPieceModify(var_3_3.hero_id, var_3_1)
	elseif var_3_4 == ItemConst.ITEM_TYPE.HERO_SKIN then
		HeroAction.SkinAdd(var_3_0, arg_3_0.time_valid ~= 0, arg_3_0.time_valid)
	elseif var_3_4 == ItemConst.ITEM_TYPE.PORTRAIT then
		PlayerAction.UnlockPortrait(var_3_0, var_3_2)
	elseif var_3_4 == ItemConst.ITEM_TYPE.FRAME then
		PlayerAction.UnlockFrame(var_3_0)
	elseif var_3_4 == ItemConst.ITEM_TYPE.STICKER then
		PlayerAction.UnlockSticker(var_3_0)
	elseif var_3_4 == ItemConst.ITEM_TYPE.STICKER_BG then
		PlayerAction.UnlockStickerBg(var_3_0)
	elseif var_3_4 == ItemConst.ITEM_TYPE.STICKER_FG then
		PlayerAction.UnlockStickerFg(var_3_0)
	elseif var_3_4 == ItemConst.ITEM_TYPE.TAG then
		PlayerData:UnlockTag(var_3_0)
	elseif var_3_4 == ItemConst.ITEM_TYPE.CARD_BG then
		PlayerData:UnlockCardBg(var_3_0)
	elseif var_3_4 == ItemConst.ITEM_TYPE.CLUB_COMMON then
		if var_3_0 == 52002 then
			GuildData:ModifyEXP(var_3_1)
		elseif var_3_0 == CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A then
			GuildData:ModifyCoin(var_3_1)
		end
	elseif var_3_4 == ItemConst.ITEM_TYPE.SCENE then
		HomeSceneSettingData:UnlockScene(var_3_0, arg_3_0.time_valid)
		HomeSceneSettingAction.CheckMatchScene(var_3_0, arg_3_0.time_valid)
	elseif var_3_4 == ItemConst.ITEM_TYPE.CHAT_BUBBLE then
		PlayerData:UnlockChatBubble(var_3_0, var_3_2)
	elseif var_3_4 == ItemConst.ITEM_TYPE.BLOOD_CARD then
		local var_3_7 = ItemCfg[var_3_0].param[2]

		BloodCardData:UnlockCard(var_3_7)
		QWorldData:AddHint(QWorldConst.QWorldHintType.BLOOD_CARD_GET_CARD)
	elseif var_3_4 == ItemConst.ITEM_TYPE.MOMOTALK then
		local var_3_8 = var_3_3.sub_type

		if var_3_8 == ItemConst.ITEM_SUB_TYPE.MOMOTALK_FRAME then
			MomoTalkData:UpdateFrameData(var_3_0, 1)
		elseif var_3_8 == ItemConst.ITEM_SUB_TYPE.MOMOTALK_CHATBG then
			MomoTalkData:UpdateBgData(var_3_0, 1)
		end
	end
end

function var_0_0.AddBackHomeItem(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
		local var_4_0 = ItemCfg[iter_4_1.id]

		if var_4_0.type == ItemConst.ITEM_TYPE.DORM_FURNITURE then
			DormAction.ModifyFurniture(iter_4_1.id, iter_4_1.num, iter_4_1.give_num)
		elseif var_4_0.type == ItemConst.ITEM_TYPE.CANTEEN_INGREDIENTS then
			CanteenFoodData:AddFoodIngredients(iter_4_1.id, iter_4_1.num)
		elseif var_4_0.type == ItemConst.ITEM_TYPE.FURNITURE_SUIT then
			DormSuitData:RefreshUnLockSuitList({
				iter_4_1.id
			}, false)
		end
	end
end

manager.net:Bind(17025, function(arg_5_0)
	local var_5_0 = arg_5_0.last_fatigue_recover_time

	if var_5_0 then
		CurrencyData:SetLastFatigueRecoverTime(var_5_0)
	end
end)

return var_0_0
