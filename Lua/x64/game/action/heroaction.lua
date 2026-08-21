local var_0_0 = {}

manager.net:Bind(14007, function(arg_1_0)
	HeroData:ModifyHero(arg_1_0.hero)
	var_0_0.UpdateOneHeroNotice(arg_1_0.hero.hero_base_info.id)
end)
manager.net:Bind(14009, function(arg_2_0)
	HeroData:InitHero(arg_2_0.hero_info_list, arg_2_0.piece_list)
	HeroData:InitFavorite(arg_2_0.favorites)
	ArchiveData:InitArchive(arg_2_0.archives)
	ProposalData:InitProposal(arg_2_0.proposal_list)
	var_0_0.OnHeroInit()
end)
manager.net:Bind(14011, function(arg_3_0)
	HeroData:ModifyInvalidSkin(arg_3_0)
end)
manager.net:Bind(14019, function(arg_4_0)
	HeroData:ModifyHeroPieceByList(arg_4_0.piece_list)
end)
manager.notify:RegistListener(HERO_DATA_INIT, function()
	ComboSkillTools.InitComboList()
	var_0_0.UpdatePieceRedPoint()
end)
manager.notify:RegistListener(HERO_UNLOCK_SUCCESS, ComboSkillTools.InitComboList)
manager.notify:RegistListener(HERO_PIECE_MODIFY, function(arg_6_0)
	var_0_0.UpdateUnlockNotice(arg_6_0)
	var_0_0.UpdateStarNotice(arg_6_0)
	var_0_0.UpdatePieceRedPoint()
end)
manager.notify:RegistListener(HERO_DATA_MODIFY, function(arg_7_0)
	var_0_0.UpdatePieceRedPoint()
	var_0_0.UpdateUnlockNotice(arg_7_0)
	var_0_0.UpdateBreakNotice(arg_7_0)
	var_0_0.UpdateStarNotice(arg_7_0)
	var_0_0.UpdateOathNewHeroNotice(arg_7_0)
end)
manager.notify:RegistListener(MATERIAL_INIT, function()
	var_0_0.CheckHeroBreakNotice()
end)
manager.notify:RegistListener(MATERIAL_LIST_UPDATE, function()
	var_0_0.CheckHeroBreakNotice()
end)
manager.notify:RegistListener(MATERIAL_MODIFY, function()
	var_0_0.CheckHeroBreakNotice()
	var_0_0.UpdateAllOathCanCompleteNotice()
end)
manager.notify:RegistListener(CURRENCY_UPDATE, function(arg_11_0)
	if arg_11_0 == CurrencyConst.CURRENCY_TYPE_GOLD then
		var_0_0.CheckHeroBreakNotice()
		var_0_0.UpdateAllStarNotice()
	end
end)
manager.notify:RegistListener(PLAYER_LEVEL_UP, function()
	var_0_0.CheckHeroBreakNotice()
end)

function var_0_0.UpdateAllOathNewNotice()
	for iter_13_0, iter_13_1 in pairs(WeddingCfg.all) do
		var_0_0.UpdateOathNewHeroNotice(iter_13_1)
	end
end

function var_0_0.UpdateAllOathCanCompleteNotice()
	for iter_14_0, iter_14_1 in pairs(WeddingCfg.all) do
		OathSupportData:UpdateOathCanCompleteNotice(iter_14_1)
	end
end

function var_0_0.UpdateOathNewHeroNotice(arg_15_0)
	OathSupportData:UpdateOathNewHeroNotice(arg_15_0)
end

function var_0_0.UpdateUnlockNotice(arg_16_0)
	local var_16_0 = HeroData:GetHeroData(arg_16_0)
	local var_16_1 = HeroCfg[arg_16_0]
	local var_16_2 = GameSetting.unlock_hero_need.value[var_16_1.rare]

	if var_16_0.unlock == 0 and var_16_2 <= var_16_0.piece then
		manager.redPoint:setTip(RedPointConst.HERO_UNLOCK_ID .. arg_16_0, 1)
	else
		manager.redPoint:setTip(RedPointConst.HERO_UNLOCK_ID .. arg_16_0, 0)
	end
end

function var_0_0.UpdateBreakNotice(arg_17_0)
	if HeroTools.CanBreakHero(arg_17_0) then
		manager.redPoint:setTip(RedPointConst.HERO_BREAK_ID .. arg_17_0, 1)
	else
		manager.redPoint:setTip(RedPointConst.HERO_BREAK_ID .. arg_17_0, 0)
	end
end

function var_0_0.UpdateAllStarNotice()
	for iter_18_0, iter_18_1 in pairs(HeroData:GetHeroList()) do
		var_0_0.UpdateStarNotice(iter_18_1.id)
	end
end

function var_0_0.UpdateStarNotice(arg_19_0)
	if HeroTools.GetIsCanUpStar(HeroData:GetHeroData(arg_19_0)) then
		manager.redPoint:setTip(RedPointConst.HERO_STAR_ID .. arg_19_0, 1)
	else
		manager.redPoint:setTip(RedPointConst.HERO_STAR_ID .. arg_19_0, 0)
	end
end

function var_0_0.UpdateSkillNotice(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1 and RedPointConst.HERO_SKILL_ATTR .. arg_20_0 or RedPointConst.HERO_SKILL_UP .. arg_20_0

	if HeroTools.GetIsCanSkillUpNew(arg_20_0, arg_20_1) then
		manager.redPoint:setTip(var_20_0, 1)
	else
		manager.redPoint:setTip(var_20_0, 0)
	end
end

function var_0_0.UpdatePieceRedPoint()
	if #HeroTools.GetCanExchangeHero() > 0 then
		manager.redPoint:setTip(RedPointConst.HERO_PIECE_EXCHANGE, 1)
	else
		manager.redPoint:setTip(RedPointConst.HERO_PIECE_EXCHANGE, 0)
	end
end

function var_0_0.OnHeroInit()
	var_0_0.CheckHeroBreakNotice()
	var_0_0.CheckHeroUnlockNotice()
	var_0_0.UpdateAllStarNotice()
	var_0_0.UpdateHeartRedPoint()
	var_0_0.InitHeartStoryRedPoint()
	var_0_0.UpdateStoryRedPoint()
	var_0_0.UpdateSuperStoryRedPoint()
	var_0_0.UpdateAllHeroSkinRedPoint()
	var_0_0.UpdateAllOathNewNotice()
	var_0_0.UpdateAllOathCanCompleteNotice()
end

function var_0_0.UpdateAllHeroSkinRedPoint()
	for iter_23_0, iter_23_1 in pairs(HeroData:GetHeroList()) do
		var_0_0.UpdateSkinCouponRedPoint(iter_23_1.id)
		var_0_0.UpdateHeroSkinRedPoint(iter_23_1.id)
	end
end

function var_0_0.UpdateSkinCouponRedPoint(arg_24_0)
	local var_24_0 = HeroData:GetHeroList()[arg_24_0].unlock > 0
	local var_24_1 = SkinCfg.get_id_list_by_hero[arg_24_0]

	for iter_24_0, iter_24_1 in ipairs(var_24_1) do
		if var_24_0 == true and HeroTools.CanChangeSkin(iter_24_1) then
			manager.redPoint:setTip(RedPointConst.HERO_SKIN_ID .. arg_24_0, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.HERO_SKIN_ID .. arg_24_0, 0)
end

function var_0_0.CheckHeroBreakNotice()
	for iter_25_0, iter_25_1 in pairs(HeroData:GetHeroList()) do
		var_0_0.UpdateBreakNotice(iter_25_1.id)
	end
end

function var_0_0.CheckHeroUnlockNotice()
	for iter_26_0, iter_26_1 in pairs(HeroData:GetHeroList()) do
		var_0_0.UpdateUnlockNotice(iter_26_1.id)
	end
end

function var_0_0.UpdateOneHeroNotice(arg_27_0)
	var_0_0.UpdateUnlockNotice(arg_27_0)
	var_0_0.UpdateBreakNotice(arg_27_0)
	var_0_0.UpdateStarNotice(arg_27_0)
	var_0_0.UpdateSkinCouponRedPoint(arg_27_0)
	var_0_0.UpdateOathNewHeroNotice(arg_27_0)
end

function var_0_0.HeroPieceModify(arg_28_0, arg_28_1)
	HeroData:HeroPieceModify(arg_28_0, arg_28_1)
end

function var_0_0.HeroBreak(arg_29_0)
	local var_29_0 = {
		hero_id = arg_29_0
	}

	manager.net:SendWithLoadingNew(14036, var_29_0, 14037, var_0_0.OnHeroBreak)
end

function var_0_0.OnHeroBreak(arg_30_0, arg_30_1)
	manager.notify:CallUpdateFunc(HERO_BREAK, arg_30_0, arg_30_1)
end

function var_0_0.AddHeroExp(arg_31_0, arg_31_1)
	manager.net:SendWithLoadingNew(14014, {
		id = arg_31_0,
		item_list = arg_31_1
	}, 14015, var_0_0.OnAddHeroExp)
end

function var_0_0.OnAddHeroExp(arg_32_0, arg_32_1)
	if isSuccess(arg_32_0.result) then
		-- block empty
	else
		ShowTips(arg_32_0.result)
	end

	manager.notify:CallUpdateFunc(ON_HERO_ADD_EXP, arg_32_0)
end

function var_0_0.HeroLevelUpAndBreak(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	local var_33_0 = {
		hero_id = arg_33_0,
		break_list = arg_33_1,
		level = arg_33_2,
		item_list = arg_33_3
	}

	manager.net:SendWithLoadingNew(14120, var_33_0, 14121, function(arg_34_0, arg_34_1)
		var_0_0.OnHeroLevelUpAndBreak(arg_34_0, arg_34_1, arg_33_4)
	end)
end

function var_0_0.OnHeroLevelUpAndBreak(arg_35_0, arg_35_1, arg_35_2)
	if isSuccess(arg_35_0.result) then
		if arg_35_2 then
			arg_35_2(arg_35_1, arg_35_0.item_list)
		end
	else
		ShowTips(arg_35_0.result)
	end
end

function var_0_0.UnlockHeroSuccess(arg_36_0)
	HeroData:UnlockHeroSuccess(arg_36_0)
	var_0_0.UpdateHeartRedPoint()
	var_0_0.UpdateStoryRedPoint()
	var_0_0.UpdateSuperStoryRedPoint()

	local var_36_0 = SkinCfg[arg_36_0].portrait or 2110111

	PlayerAction.UnlockPortrait(var_36_0)
	PlayerAction.RefreshSkinGiftRedPoint()
	var_0_0.UpdateSkinCouponRedPoint(arg_36_0)
end

function var_0_0.AddHeroExpSuccess(arg_37_0, arg_37_1, arg_37_2)
	HeroData:AddHeroExpSuccess(arg_37_0, arg_37_1, arg_37_2)
end

function var_0_0.BreakSuccess(arg_38_0, arg_38_1)
	HeroData:BreakSuccess(arg_38_0, arg_38_1)
end

function var_0_0.WeaponStr(arg_39_0, arg_39_1, arg_39_2)
	HeroData:WeaponStr(arg_39_0, arg_39_1, arg_39_2)
end

function var_0_0.WeaponBreak(arg_40_0, arg_40_1)
	HeroData:WeaponBreak(arg_40_0, arg_40_1)
end

function var_0_0.ServantReplace(arg_41_0, arg_41_1)
	HeroData:ServantReplace(arg_41_0, arg_41_1)
end

function var_0_0.EquipSwap(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = {
		hero_id = arg_42_0,
		equip_id = arg_42_1,
		pos = arg_42_2
	}

	manager.net:SendWithLoadingNew(13012, var_42_0, 13013, var_0_0.OnEquipSwap)
end

function var_0_0.OnEquipSwap(arg_43_0, arg_43_1)
	if isSuccess(arg_43_0.result) then
		HeroData:EquipSwap(arg_43_1.hero_id, arg_43_1.equip_id, arg_43_1.pos)
	end

	manager.notify:CallUpdateFunc(EQUIP_SWAP, arg_43_0, arg_43_1)
end

function var_0_0.EquipUnloadAll(arg_44_0)
	local var_44_0 = {
		hero_id = arg_44_0
	}

	manager.net:SendWithLoadingNew(13018, var_44_0, 13019, var_0_0.OnEquipUnloadAll)
end

function var_0_0.OnEquipUnloadAll(arg_45_0, arg_45_1)
	if isSuccess(arg_45_0.result) then
		HeroData:EquipUnloadAll(arg_45_1.hero_id)
	end

	manager.notify:CallUpdateFunc(EQUIP_UNLOAD_ALL, arg_45_0, arg_45_1)
end

function var_0_0.HeroChangeEquip(arg_46_0, arg_46_1, arg_46_2)
	HeroData:EquipSwap(arg_46_0, arg_46_1, arg_46_2)
end

function var_0_0.HeroSkillUpgrade(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = {
		hero_id = arg_47_0,
		skill_id = arg_47_1,
		num = arg_47_2
	}

	manager.net:SendWithLoadingNew(14030, var_47_0, 14031, var_0_0.OnHeroSkillUpgrade)
end

function var_0_0.OnHeroSkillUpgrade(arg_48_0, arg_48_1)
	if isSuccess(arg_48_0.result) then
		HeroData:HeroSkillUpgrade(arg_48_1.hero_id, arg_48_1.skill_id, arg_48_1.num)
	end

	manager.notify:CallUpdateFunc(HERO_SKILL_UPGRADE, arg_48_0, arg_48_1)
end

function var_0_0.HeroSkillAttrUpgrade(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = {
		hero_id = arg_49_0,
		index = arg_49_1,
		num = arg_49_2
	}

	manager.net:SendWithLoadingNew(14044, var_49_0, 14045, var_0_0.OnHeroSkillAttrUpgrade)
end

function var_0_0.OnHeroSkillAttrUpgrade(arg_50_0, arg_50_1)
	if isSuccess(arg_50_0.result) then
		HeroData:HeroSkillAttrUpgrade(arg_50_1.hero_id, arg_50_1.index, arg_50_1.num)
	end

	manager.notify:CallUpdateFunc(HERO_SKILL_ATTR_UPGRADE, arg_50_0, arg_50_1)
end

function var_0_0.SelectSkin(arg_51_0, arg_51_1)
	if arg_51_0 == arg_51_1 then
		arg_51_1 = 0
	end

	return manager.net:SendWithLoadingNew(14034, {
		hero_id = arg_51_0,
		skin_id = arg_51_1
	}, 14035, var_0_0.OnSelectSkin)
end

function var_0_0.HeroStarUp(arg_52_0)
	local var_52_0 = {
		id = arg_52_0
	}

	manager.net:SendWithLoadingNew(14012, var_52_0, 14013, var_0_0.OnHeroStarUp)
end

function var_0_0.OnHeroStarUp(arg_53_0, arg_53_1)
	if isSuccess(arg_53_0.result) then
		HeroData:HeroStarUp(arg_53_1.id)
	end

	manager.notify:CallUpdateFunc(HERO_STAR_UP, arg_53_0, arg_53_1)
end

function var_0_0.OnSelectSkin(arg_54_0, arg_54_1)
	if isSuccess(arg_54_0.result) then
		HeroData:SelectSkin(arg_54_1.hero_id, arg_54_1.skin_id)
		HeroData:SetBattleSkin(arg_54_1.hero_id, arg_54_1.skin_id)
		HomeSceneSettingAction.AutoSwitchMatchSkinScene(arg_54_1.hero_id)
		manager.notify:Invoke(HERO_BATTLE_SKIN_CHANGE, arg_54_1.skin_id)
	else
		ShowTips(arg_54_0.result)
	end

	manager.notify:CallUpdateFunc(HERO_SKIN_SELECT, arg_54_0, arg_54_1)
end

function var_0_0.SelectSkinWithCallback(arg_55_0, arg_55_1, arg_55_2)
	if arg_55_0 == arg_55_1 then
		arg_55_1 = 0
	end

	if HeroData:GetHeroData(arg_55_0).using_skin == arg_55_1 then
		arg_55_2()

		return
	end

	manager.net:SendWithLoadingNew(14034, {
		hero_id = arg_55_0,
		skin_id = arg_55_1
	}, 14035, function(arg_56_0)
		if isSuccess(arg_56_0.result) then
			HeroData:SelectSkin(arg_55_0, arg_55_1)
			HeroData:SetBattleSkin(arg_55_0, arg_55_1)
			manager.notify:Invoke(HERO_BATTLE_SKIN_CHANGE, arg_55_1)
			arg_55_2()
		else
			ShowTips(arg_56_0.result)
		end
	end)
end

function var_0_0.SkinAdd(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0 = SkinCfg[arg_57_0].hero
	local var_57_1 = HeroData:GetHeroData(var_57_0).unlocked_skin

	if not arg_57_1 then
		table.insert(var_57_1, {
			time = 0,
			skin_id = arg_57_0
		})
	else
		table.insert(var_57_1, {
			skin_id = arg_57_0,
			time = arg_57_2
		})
	end

	if HeroData:GetHeroList()[var_57_0].unlock > 0 then
		if SkinCfg[arg_57_0] and #SkinCfg[arg_57_0].gift > 0 then
			manager.redPoint:setTip(RedPointConst.SKIN_GIFT .. "_" .. arg_57_0, 1)
		end

		manager.redPoint:setTip(RedPointConst.HERO_SKIN_ROUTE_ID .. arg_57_0, 1, RedPointStyle.SHOW_NEW_TAG)
	end

	local var_57_2 = SkinCfg[arg_57_0].portrait

	if not arg_57_1 then
		PlayerAction.UnlockPortrait(var_57_2)
	end
end

local var_0_1

function var_0_0.SendGift(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = {
		archive_id = arg_58_0,
		gift_list = arg_58_1
	}

	var_0_1 = arg_58_2

	manager.net:SendWithLoadingNew(14100, var_58_0, 14101, var_0_0.OnSendGift)
end

function var_0_0.OnSendGift(arg_59_0, arg_59_1)
	if isSuccess(arg_59_0.result) then
		ArchiveData:AddExp(arg_59_1.archive_id, var_0_1)
		ArchiveData:AddGift(arg_59_1.archive_id, arg_59_1.gift_list)
		var_0_0.UpdateHeartRedPoint()
		var_0_0.UpdateStoryRedPoint()
		var_0_0.UpdateSuperStoryRedPoint()
		manager.notify:CallUpdateFunc(HERO_SEND_GIFT, arg_59_0, arg_59_1)
	else
		ShowTips(arg_59_0.result)
	end
end

function var_0_0.InitHeartStoryRedPoint()
	local var_60_0 = ArchiveData:GetArchiveList()

	if not var_60_0 then
		return
	end

	for iter_60_0, iter_60_1 in pairs(var_60_0) do
		local var_60_1 = RedPointConst.HERO_STORY_ID .. iter_60_0
		local var_60_2 = RedPointConst.HERO_SUPER_STORY_ID .. iter_60_0
		local var_60_3 = RedPointConst.HERO_ANEDOTE_ID .. iter_60_0
		local var_60_4 = RedPointConst.HERO_HEART_STORY_ROOT_ID .. iter_60_0

		manager.redPoint:addGroup(var_60_4, {
			var_60_2,
			var_60_1,
			var_60_3
		})
	end
end

function var_0_0.UpdateStoryRedPoint()
	local function var_61_0(arg_62_0)
		local var_62_0 = HeroRecordCfg[arg_62_0].plot_id

		for iter_62_0, iter_62_1 in ipairs(var_62_0) do
			local var_62_1 = GameSetting.hero_plot_unlock_condition.value[iter_62_0]
			local var_62_2 = IsConditionAchieved(var_62_1, {
				heroId = arg_62_0
			})
			local var_62_3 = true
			local var_62_4

			if iter_62_0 > 1 then
				var_62_3 = ArchiveData:IsStoryRead(arg_62_0, HeroRecordCfg[arg_62_0].plot_id[iter_62_0 - 1])
			end

			local var_62_5 = ArchiveData:IsStoryRead(arg_62_0, HeroRecordCfg[arg_62_0].plot_id[iter_62_0])

			if var_62_2 and var_62_3 and not var_62_5 then
				return true
			end
		end

		return false
	end

	local var_61_1 = ArchiveData:GetArchiveList()

	for iter_61_0, iter_61_1 in pairs(var_61_1) do
		if HeroRecordCfg.get_id_list_by_hero_id[iter_61_0] then
			local var_61_2 = RedPointConst.HERO_STORY_ID .. iter_61_0
			local var_61_3 = "heartStroy_" .. PlayerData:GetPlayerInfo().userID .. "_" .. HeroRecordCfg.get_id_list_by_hero_id[iter_61_0][1]
			local var_61_4 = getData("HearListRedPoint", var_61_3)
			local var_61_5, var_61_6, var_61_7 = ArchiveData:GetUnlockHeartListInfoLengthByHeroId(iter_61_0)
			local var_61_8 = var_61_4 and var_61_4[1] == var_61_5

			manager.redPoint:setTip(var_61_2, var_61_0(iter_61_0) and not var_61_8 and 1 or 0)
		end
	end
end

function var_0_0.UpdateSuperStoryRedPoint()
	local function var_63_0(arg_64_0)
		local var_64_0 = HeroRecordCfg[arg_64_0].super_plot_id

		for iter_64_0, iter_64_1 in ipairs(var_64_0) do
			local var_64_1 = false

			for iter_64_2, iter_64_3 in ipairs(HeroRecordCfg[arg_64_0].hero_id) do
				local var_64_2 = GameSetting.hero_super_plot_unlock_condition.value[iter_64_0]

				var_64_1 = var_64_1 or IsConditionAchieved(var_64_2, {
					heroId = iter_64_3
				})
			end

			if var_64_1 and not ArchiveData:IsSuperHeartRead(arg_64_0, iter_64_0) then
				return true
			end
		end

		return false
	end

	local function var_63_1(arg_65_0)
		local var_65_0 = GameSetting.hero_anecdote_unlock_condition.value[1]
		local var_65_1 = HeroRecordCfg[arg_65_0]
		local var_65_2 = false

		for iter_65_0, iter_65_1 in ipairs(var_65_1.hero_id) do
			var_65_2 = var_65_2 or IsConditionAchieved(var_65_0, {
				heroId = iter_65_1
			})

			local var_65_3 = ArchiveData:IsArchiveStoryRead(arg_65_0, iter_65_1)

			if var_65_2 and not var_65_3 then
				return true
			end
		end

		return false
	end

	local var_63_2 = ArchiveData:GetArchiveList()

	for iter_63_0, iter_63_1 in pairs(var_63_2) do
		if HeroRecordCfg.get_id_list_by_hero_id[iter_63_0] then
			local var_63_3 = RedPointConst.HERO_SUPER_STORY_ID .. iter_63_0
			local var_63_4 = RedPointConst.HERO_ANEDOTE_ID .. iter_63_0
			local var_63_5 = "heartStroy_" .. PlayerData:GetPlayerInfo().userID .. "_" .. HeroRecordCfg.get_id_list_by_hero_id[iter_63_0][1]
			local var_63_6 = getData("HearListRedPoint", var_63_5)
			local var_63_7, var_63_8, var_63_9 = ArchiveData:GetUnlockHeartListInfoLengthByHeroId(iter_63_0)
			local var_63_10 = var_63_6 and var_63_6[2] == var_63_8
			local var_63_11 = var_63_6 and var_63_6[3] == var_63_9

			manager.redPoint:setTip(var_63_3, var_63_0(iter_63_0) and not var_63_10 and 1 or 0)
			manager.redPoint:setTip(var_63_4, var_63_1(iter_63_0) and not var_63_11 and 1 or 0)
		end
	end
end

function var_0_0.UpdateHeartRedPoint()
	local var_66_0 = HeroRecordCfg.all

	if not var_66_0 then
		return
	end

	for iter_66_0, iter_66_1 in pairs(var_66_0) do
		for iter_66_2 = 1, HeroConst.HERO_HEARTLINK_STORY_MAX_COUNT do
			local var_66_1 = RedPointConst.HERO_HEARTLINK_ID .. iter_66_1 .. "_" .. iter_66_2
			local var_66_2 = GameSetting.heart_chain_unlock_condition.value[iter_66_2]
			local var_66_3 = IsConditionAchieved(var_66_2, {
				heroId = iter_66_1
			}) and not ArchiveData:IsHeartRead(iter_66_1, iter_66_2)

			manager.redPoint:setTip(var_66_1, var_66_3 and 1 or 0)
		end
	end
end

function var_0_0.ReadStory(arg_67_0, arg_67_1, arg_67_2, arg_67_3)
	local var_67_0 = {
		arg_67_1
	}
	local var_67_1 = {
		archive_id = arg_67_0,
		video_list = var_67_0
	}

	if arg_67_2 == 1 then
		ArchiveData:SetStoryRead(arg_67_0, arg_67_1)
		manager.net:SendWithLoadingNew(14104, var_67_1, 14105, var_0_0.OnReadStory)
		var_0_0.UpdateStoryRedPoint()
	elseif arg_67_2 == 2 then
		ArchiveData:SetSuperHeartRead(arg_67_0, arg_67_3)
		ArchiveAction.SendViewSuperHeart(arg_67_0, arg_67_3)
		HeroAction.UpdateSuperStoryRedPoint()
	end

	manager.notify:Invoke(UPDATE_HEARTLIST)
end

function var_0_0.OnReadStory(arg_68_0, arg_68_1)
	if not isSuccess(arg_68_0.result) then
		ShowTips(arg_68_0.result)
	end
end

function var_0_0.ReadHeartLink(arg_69_0, arg_69_1)
	local var_69_0 = {
		arg_69_1
	}
	local var_69_1 = {
		archive_id = arg_69_0,
		text_list = var_69_0
	}

	ArchiveData:SetHeartRead(arg_69_0, arg_69_1)
	manager.net:SendWithLoadingNew(14102, var_69_1, 14103, var_0_0.OnReadHeartLink)
end

function var_0_0.OnReadHeartLink(arg_70_0, arg_70_1)
	if not isSuccess(arg_70_0.result) then
		ShowTips(arg_70_0.result)
	end
end

function var_0_0.SetFavoriteHeroOn(arg_71_0)
	local var_71_0 = {
		hero_id = arg_71_0
	}

	manager.net:SendWithLoadingNew(14106, var_71_0, 14107, var_0_0.OnSetFavoriteHeroOn)
end

function var_0_0.OnSetFavoriteHeroOn(arg_72_0, arg_72_1)
	if isSuccess(arg_72_0.result) then
		HeroData:SetFavoriteHeroOn(arg_72_1.hero_id)
		manager.notify:Invoke(FAVORITE_HERO)
	else
		ShowTips(arg_72_0.result)
	end
end

function var_0_0.SetFavoriteHeroOff(arg_73_0)
	local var_73_0 = {
		hero_id = arg_73_0
	}

	manager.net:SendWithLoadingNew(14108, var_73_0, 14109, var_0_0.OnSetFavoriteHeroOff)
end

function var_0_0.OnSetFavoriteHeroOff(arg_74_0, arg_74_1)
	if isSuccess(arg_74_0.result) then
		HeroData:SetFavoriteHeroOff(arg_74_1.hero_id)
		manager.notify:Invoke(FAVORITE_HERO)
	else
		ShowTips(arg_74_0.result)
	end
end

function var_0_0.UnLockSkin(arg_75_0)
	manager.net:SendWithLoadingNew(14110, {
		skin_id = arg_75_0
	}, 14111, var_0_0.OnUnLockSkin)
end

function var_0_0.OnUnLockSkin(arg_76_0, arg_76_1)
	if isSuccess(arg_76_0.result) then
		HeroAction.GetSkinAni(arg_76_1.skin_id)
		PlayerAction.RefreshSkinGiftRedPoint()
	else
		ShowTips(arg_76_0.result)
	end
end

function var_0_0.TryToImproveTransitionGiftPt(arg_77_0, arg_77_1, arg_77_2, arg_77_3)
	local var_77_0 = {
		hero_id = arg_77_0,
		slot_id = arg_77_1,
		lv_up_num = arg_77_2
	}

	manager.net:SendWithLoadingNew(14112, var_77_0, 14113, function(arg_78_0)
		if isSuccess(arg_78_0.result) then
			HeroData:ImproveTransitionGiftPt(var_77_0)
			manager.notify:Invoke(IMPROVE_TRANSITION_GIFT_PT)
		else
			ShowTips(arg_78_0.result)
		end
	end)
end

function var_0_0.TryToSaveTransitionSkill(arg_79_0, arg_79_1, arg_79_2, arg_79_3)
	local var_79_0 = {
		hero_id = arg_79_0,
		slot_id = arg_79_1,
		skill_list = arg_79_2
	}

	manager.net:SendWithLoadingNew(14114, var_79_0, 14115, function(arg_80_0)
		if isSuccess(arg_80_0.result) then
			HeroData:ModifyTransitionSkill(var_79_0)

			if arg_79_3 then
				arg_79_3()
			end
		else
			ShowTips(arg_80_0.result)
		end
	end)
end

function var_0_0.TryToLevelUpModule(arg_81_0)
	manager.net:SendWithLoadingNew(14116, {
		hero_id = arg_81_0
	}, 14117, function(arg_82_0)
		if isSuccess(arg_82_0.result) then
			local var_82_0 = HeroData:GetCurModuleLevel(arg_81_0) + 1
			local var_82_1 = WeaponModuleCfg[arg_81_0].cost[var_82_0]

			HeroData:ModuleLevelUp(arg_81_0)
			HeroAction.UpdateModuleRedPointByHeroID(arg_81_0)

			if HeroData:GetCurModuleLevel(arg_81_0) > 1 then
				JumpTools.OpenPageByJump("weaponModuleLevelUpPopView", {
					heroID = arg_81_0
				})
			else
				JumpTools.OpenPageByJump("/weaponModuleUnlockPopView", {
					heroID = arg_81_0
				})
			end

			manager.notify:Invoke(HERO_DATA_MODIFY, arg_81_0)
		else
			ShowTips(arg_82_0.result)
		end
	end)
end

function var_0_0.ResolveModuleItem(arg_83_0)
	manager.net:SendWithLoadingNew(14118, {
		item_list = arg_83_0
	}, 14119, function(arg_84_0, arg_84_1)
		if isSuccess(arg_84_0.result) then
			manager.notify:CallUpdateFunc(ON_RESOLVE_MODULE_ITEM, arg_84_0, arg_84_1.item_list)
		else
			ShowTips(arg_84_0.result)
		end
	end)
end

function var_0_0.GetSkinAni(arg_85_0)
	local var_85_0 = SkinCfg[arg_85_0].hero

	getReward({
		{
			num = 1,
			id = arg_85_0
		}
	})
	HeroAction.SkinAdd(arg_85_0)
	HeroAction.UpdateHeroSkinRedPoint(var_85_0)
end

function var_0_0.UpdateAllSkinRedPoint()
	local var_86_0 = HeroData:GetHeroList()

	for iter_86_0, iter_86_1 in pairs(var_86_0) do
		local var_86_1 = iter_86_1.unlocked_skin
		local var_86_2 = iter_86_1.unlock > 0
		local var_86_3 = {}

		for iter_86_2, iter_86_3 in ipairs(var_86_1) do
			table.insert(var_86_3, iter_86_3.skin_id)
		end

		for iter_86_4, iter_86_5 in pairs(SkinCfg.get_id_list_by_hero[iter_86_1.id]) do
			local var_86_4 = RedPointConst.HERO_SKIN_ID_EXTEND .. iter_86_5

			if var_86_2 and not table.indexof(var_86_3, iter_86_5) and HeroTools.GetSkinIsCanUnlockAndGet(iter_86_5) then
				manager.redPoint:setTip(var_86_4, 1)
			else
				manager.redPoint:setTip(var_86_4, 0)
			end
		end
	end
end

function var_0_0.UpdateHeroSkinRedPoint(arg_87_0)
	local var_87_0 = HeroData:GetHeroList()
	local var_87_1 = var_87_0[arg_87_0].unlocked_skin
	local var_87_2 = {}

	for iter_87_0, iter_87_1 in ipairs(var_87_1) do
		table.insert(var_87_2, iter_87_1.skin_id)
	end

	local var_87_3 = var_87_0[arg_87_0].unlock > 0

	for iter_87_2, iter_87_3 in pairs(SkinCfg.get_id_list_by_hero[arg_87_0]) do
		local var_87_4 = RedPointConst.HERO_SKIN_ID_EXTEND .. iter_87_3

		if var_87_3 and not table.indexof(var_87_2, iter_87_3) and HeroTools.GetSkinIsCanUnlockAndGet(iter_87_3) then
			manager.redPoint:setTip(var_87_4, 1)
		else
			manager.redPoint:setTip(var_87_4, 0)
		end

		manager.redPoint:setTip(RedPointConst.HERO_SKIN_ROUTE_ID .. iter_87_3, not table.indexof(var_87_2, iter_87_3) and HeroTools.GetSkinIsCanUnlockAndGet(iter_87_3) and 1 or 0, RedPointStyle.SHOW_NEW_TAG)
	end
end

function var_0_0.RefreshHeroRedPointAfterSeverSendData()
	var_0_0.UpdateAllSkinRedPoint()
end

function var_0_0.UpdateModuleRedPointByHeroID(arg_89_0)
	local var_89_0 = WeaponModuleCfg[arg_89_0]

	if var_89_0 == nil then
		return
	end

	local var_89_1 = HeroData:GetCurModuleLevel(arg_89_0)
	local var_89_2 = HeroData:GetModuleMaxLevel(arg_89_0)
	local var_89_3 = RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. arg_89_0

	if var_89_2 <= var_89_1 then
		manager.redPoint:setTip(var_89_3, 0)

		return
	end

	local var_89_4 = var_89_0.condition[var_89_1 + 1]
	local var_89_5 = var_89_0.cost[var_89_1 + 1]
	local var_89_6 = {}
	local var_89_7 = 0

	for iter_89_0, iter_89_1 in pairs(var_89_5) do
		if iter_89_1[1] == 2 then
			var_89_7 = iter_89_1[2]
		else
			table.insert(var_89_6, iter_89_1)
		end
	end

	if not checkGold(var_89_7, false) then
		manager.redPoint:setTip(var_89_3, 0)

		return
	end

	if not HeroData:GetModuleAssignmentIsFinish(arg_89_0) then
		manager.redPoint:setTip(var_89_3, 0)

		return
	end

	if var_89_4 and var_89_4[1] then
		for iter_89_2, iter_89_3 in pairs(var_89_4) do
			if not IsConditionAchieved(iter_89_3, {
				heroId = arg_89_0
			}) then
				manager.redPoint:setTip(var_89_3, 0)

				return
			end
		end
	end

	for iter_89_4, iter_89_5 in pairs(var_89_6) do
		if iter_89_5[2] > ItemTools.getItemNum(iter_89_5[1]) then
			manager.redPoint:setTip(var_89_3, 0)

			return
		end
	end

	manager.redPoint:setTip(var_89_3, 1)
end

function var_0_0.QueryHeroNewData(arg_90_0)
	manager.net:SendWithLoadingNew(14042, {
		hero_id = arg_90_0
	}, 14043, var_0_0.OnHeroNewDataBack)
end

function var_0_0.OnHeroNewDataBack(arg_91_0)
	if isSuccess(arg_91_0.result) then
		-- block empty
	else
		ShowTips(arg_91_0.result)
	end
end

function var_0_0.ReqHeroHeartRate(arg_92_0)
	manager.net:SendWithLoadingNew(14122, {
		hero_id = arg_92_0
	}, 14123, var_0_0.OnReqHeroHeartRate)
end

function var_0_0.OnReqHeroHeartRate(arg_93_0, arg_93_1)
	if isSuccess(arg_93_0.result) then
		local var_93_0 = arg_93_1.hero_id

		print("修正者" .. var_93_0 .. "的心动值为：", arg_93_0.value)
		SpecialAttributesTools.OnReqHeroHeartRate(arg_93_0.value)
	else
		ShowTips(arg_93_0.result)
	end
end

function var_0_0.ChangeBattleSkin(arg_94_0, arg_94_1, arg_94_2)
	manager.net:SendWithLoadingNew(14046, {
		hero_id = arg_94_0,
		skin_id = arg_94_1
	}, 14047, function(arg_95_0)
		if isSuccess(arg_95_0.result) then
			HeroData:SetBattleSkin(arg_94_0, arg_94_1)

			if arg_94_2 then
				arg_94_2()
			end

			manager.notify:Invoke(HERO_BATTLE_SKIN_CHANGE, arg_94_1)
		else
			ShowTips(arg_95_0.result)
		end
	end)
end

return var_0_0
