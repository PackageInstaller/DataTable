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

function var_0_0:AddItemData()
	if ItemCfg[self.id].type == ItemConst.ITEM_TYPE.CURRENCY then
		CurrencyAction.SetCurrencyValue(self.id, self.num, self.time_valid)
	elseif ItemCfg[self.id].type == ItemConst.ITEM_TYPE.MATERIAL or ItemCfg[self.id].type == ItemConst.ITEM_TYPE.GIFT or ItemCfg[self.id].type == ItemConst.ITEM_TYPE.PROPS or ItemCfg[self.id].type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER or ItemCfg[self.id].type == ItemConst.ITEM_TYPE.ARCHIVE_GIFT then
		MaterialAction.SetMaterialValue(self.id, self.num, self.time_valid)
	elseif ItemCfg[self.id].type == ItemConst.ITEM_TYPE.SKIN_CHANGE then
		MaterialAction.SetMaterialValue(self.id, self.num, self.time_valid)
		HeroAction.UpdateSkinCouponRedPoint(SkinCfg[ItemCfg[self.id].param[1]].hero)
	elseif ItemCfg[self.id].type == ItemConst.ITEM_TYPE.HERO then
		HeroAction.UnlockHeroSuccess(self.id)
	elseif ItemCfg[self.id].type == ItemConst.ITEM_TYPE.HERO_PIECE then
		HeroAction.HeroPieceModify(ItemCfg[self.id].hero_id, self.num)
	elseif ItemCfg[self.id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
		HeroAction.SkinAdd(self.id, self.time_valid ~= 0, self.time_valid)
	elseif ItemCfg[self.id].type == ItemConst.ITEM_TYPE.PORTRAIT then
		PlayerAction.UnlockPortrait(self.id, self.time_valid)
	elseif ItemCfg[self.id].type == ItemConst.ITEM_TYPE.FRAME then
		PlayerAction.UnlockFrame(self.id)
	elseif ItemCfg[self.id].type == ItemConst.ITEM_TYPE.STICKER then
		PlayerAction.UnlockSticker(self.id)
	elseif ItemCfg[self.id].type == ItemConst.ITEM_TYPE.STICKER_BG then
		PlayerAction.UnlockStickerBg(self.id)
	elseif ItemCfg[self.id].type == ItemConst.ITEM_TYPE.STICKER_FG then
		PlayerAction.UnlockStickerFg(self.id)
	elseif ItemCfg[self.id].type == ItemConst.ITEM_TYPE.TAG then
		PlayerData:UnlockTag(self.id)
	elseif ItemCfg[self.id].type == ItemConst.ITEM_TYPE.CARD_BG then
		PlayerData:UnlockCardBg(self.id)
	elseif ItemCfg[self.id].type == ItemConst.ITEM_TYPE.CLUB_COMMON then
		if self.id == 52002 then
			GuildData:ModifyEXP(self.num)
		elseif self.id == CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A then
			GuildData:ModifyCoin(self.num)
		end
	elseif ItemCfg[self.id].type == ItemConst.ITEM_TYPE.SCENE then
		HomeSceneSettingData:UnlockScene(self.id, self.time_valid)
		HomeSceneSettingAction.CheckMatchScene(self.id, self.time_valid)
	elseif ItemCfg[self.id].type == ItemConst.ITEM_TYPE.CHAT_BUBBLE then
		PlayerData:UnlockChatBubble(self.id, self.time_valid)
	elseif ItemCfg[self.id].type == ItemConst.ITEM_TYPE.BLOOD_CARD then
		BloodCardData:UnlockCard(ItemCfg[self.id].param[2])
		QWorldData:AddHint(QWorldConst.QWorldHintType.BLOOD_CARD_GET_CARD)
	elseif ItemCfg[self.id].type == ItemConst.ITEM_TYPE.MOMOTALK then
		if ItemCfg[self.id].sub_type == ItemConst.ITEM_SUB_TYPE.MOMOTALK_FRAME then
			MomoTalkData:UpdateFrameData(self.id, 1)
		elseif ItemCfg[self.id].sub_type == ItemConst.ITEM_SUB_TYPE.MOMOTALK_CHATBG then
			MomoTalkData:UpdateBgData(self.id, 1)
		end
	end
end

function var_0_0.AddBackHomeItem(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
		if ItemCfg[iter_4_1.id].type == ItemConst.ITEM_TYPE.DORM_FURNITURE then
			DormAction.ModifyFurniture(iter_4_1.id, iter_4_1.num, iter_4_1.give_num)
		elseif ItemCfg[iter_4_1.id].type == ItemConst.ITEM_TYPE.CANTEEN_INGREDIENTS then
			CanteenFoodData:AddFoodIngredients(iter_4_1.id, iter_4_1.num)
		elseif ItemCfg[iter_4_1.id].type == ItemConst.ITEM_TYPE.FURNITURE_SUIT then
			DormSuitData:RefreshUnLockSuitList({
				iter_4_1.id
			}, false)
		end
	end
end

manager.net:Bind(17025, function(arg_5_0)
	if arg_5_0.last_fatigue_recover_time then
		CurrencyData:SetLastFatigueRecoverTime(arg_5_0.last_fatigue_recover_time)
	end
end)

return var_0_0
