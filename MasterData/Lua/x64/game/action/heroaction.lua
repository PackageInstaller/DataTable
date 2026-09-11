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

	if var_16_0.unlock == 0 and GameSetting.unlock_hero_need.value[HeroCfg[arg_16_0].rare] <= var_16_0.piece then
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
	local var_20_0

	if arg_20_1 then
		var_20_0 = RedPointConst.HERO_SKILL_ATTR .. arg_20_0 or RedPointConst.HERO_SKILL_UP .. arg_20_0

		if HeroTools.GetIsCanSkillUpNew(arg_20_0, arg_20_1) then
			manager.redPoint:setTip(var_20_0, 1)

			goto label_20_0
		end
	end

	manager.redPoint:setTip(var_20_0, 0)

	::label_20_0::
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

	for iter_24_0, iter_24_1 in ipairs(SkinCfg.get_id_list_by_hero[arg_24_0]) do
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
	manager.net:SendWithLoadingNew(14036, {
		hero_id = arg_29_0
	}, 14037, var_0_0.OnHeroBreak)
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

function var_0_0:OnAddHeroExp(arg_32_1)
	if isSuccess(self.result) then
		-- block empty
	else
		ShowTips(self.result)
	end

	manager.notify:CallUpdateFunc(ON_HERO_ADD_EXP, self)
end

function var_0_0.HeroLevelUpAndBreak(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	manager.net:SendWithLoadingNew(14120, {
		hero_id = arg_33_0,
		break_list = arg_33_1,
		level = arg_33_2,
		item_list = arg_33_3
	}, 14121, function(arg_34_0, arg_34_1)
		var_0_0.OnHeroLevelUpAndBreak(arg_34_0, arg_34_1, arg_33_4)
	end)
end

function var_0_0:OnHeroLevelUpAndBreak(arg_35_1, arg_35_2)
	if isSuccess(self.result) then
		if arg_35_2 then
			arg_35_2(arg_35_1, self.item_list)
		end
	else
		ShowTips(self.result)
	end
end

function var_0_0.UnlockHeroSuccess(arg_36_0)
	HeroData:UnlockHeroSuccess(arg_36_0)
	var_0_0.UpdateHeartRedPoint()
	var_0_0.UpdateStoryRedPoint()
	var_0_0.UpdateSuperStoryRedPoint()
	PlayerAction.UnlockPortrait(SkinCfg[arg_36_0].portrait or 2110111)
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
	manager.net:SendWithLoadingNew(13012, {
		hero_id = arg_42_0,
		equip_id = arg_42_1,
		pos = arg_42_2
	}, 13013, var_0_0.OnEquipSwap)
end

function var_0_0:OnEquipSwap(arg_43_1)
	if isSuccess(self.result) then
		HeroData:EquipSwap(arg_43_1.hero_id, arg_43_1.equip_id, arg_43_1.pos)
	end

	manager.notify:CallUpdateFunc(EQUIP_SWAP, self, arg_43_1)
end

function var_0_0.EquipUnloadAll(arg_44_0)
	manager.net:SendWithLoadingNew(13018, {
		hero_id = arg_44_0
	}, 13019, var_0_0.OnEquipUnloadAll)
end

function var_0_0:OnEquipUnloadAll(arg_45_1)
	if isSuccess(self.result) then
		HeroData:EquipUnloadAll(arg_45_1.hero_id)
	end

	manager.notify:CallUpdateFunc(EQUIP_UNLOAD_ALL, self, arg_45_1)
end

function var_0_0.HeroChangeEquip(arg_46_0, arg_46_1, arg_46_2)
	HeroData:EquipSwap(arg_46_0, arg_46_1, arg_46_2)
end

function var_0_0.HeroSkillUpgrade(arg_47_0, arg_47_1, arg_47_2)
	manager.net:SendWithLoadingNew(14030, {
		hero_id = arg_47_0,
		skill_id = arg_47_1,
		num = arg_47_2
	}, 14031, var_0_0.OnHeroSkillUpgrade)
end

function var_0_0:OnHeroSkillUpgrade(arg_48_1)
	if isSuccess(self.result) then
		HeroData:HeroSkillUpgrade(arg_48_1.hero_id, arg_48_1.skill_id, arg_48_1.num)
	end

	manager.notify:CallUpdateFunc(HERO_SKILL_UPGRADE, self, arg_48_1)
end

function var_0_0.HeroSkillAttrUpgrade(arg_49_0, arg_49_1, arg_49_2)
	manager.net:SendWithLoadingNew(14044, {
		hero_id = arg_49_0,
		index = arg_49_1,
		num = arg_49_2
	}, 14045, var_0_0.OnHeroSkillAttrUpgrade)
end

function var_0_0:OnHeroSkillAttrUpgrade(arg_50_1)
	if isSuccess(self.result) then
		HeroData:HeroSkillAttrUpgrade(arg_50_1.hero_id, arg_50_1.index, arg_50_1.num)
	end

	manager.notify:CallUpdateFunc(HERO_SKILL_ATTR_UPGRADE, self, arg_50_1)
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
	manager.net:SendWithLoadingNew(14012, {
		id = arg_52_0
	}, 14013, var_0_0.OnHeroStarUp)
end

function var_0_0:OnHeroStarUp(arg_53_1)
	if isSuccess(self.result) then
		HeroData:HeroStarUp(arg_53_1.id)
	end

	manager.notify:CallUpdateFunc(HERO_STAR_UP, self, arg_53_1)
end

function var_0_0:OnSelectSkin(arg_54_1)
	if isSuccess(self.result) then
		HeroData:SelectSkin(arg_54_1.hero_id, arg_54_1.skin_id)
		HeroData:SetBattleSkin(arg_54_1.hero_id, arg_54_1.skin_id)
		HomeSceneSettingAction.AutoSwitchMatchSkinScene(arg_54_1.hero_id)
		manager.notify:Invoke(HERO_BATTLE_SKIN_CHANGE, arg_54_1.skin_id)
	else
		ShowTips(self.result)
	end

	manager.notify:CallUpdateFunc(HERO_SKIN_SELECT, self, arg_54_1)
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
	local var_57_1 = HeroData:GetHeroData(SkinCfg[arg_57_0].hero).unlocked_skin

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

	if not arg_57_1 then
		PlayerAction.UnlockPortrait(SkinCfg[arg_57_0].portrait)
	end
end

local var_0_1

function var_0_0.SendGift(arg_58_0, arg_58_1, arg_58_2)
	var_0_1 = arg_58_2

	manager.net:SendWithLoadingNew(14100, {
		archive_id = arg_58_0,
		gift_list = arg_58_1
	}, 14101, var_0_0.OnSendGift)
end

function var_0_0:OnSendGift(arg_59_1)
	if isSuccess(self.result) then
		ArchiveData:AddExp(arg_59_1.archive_id, var_0_1)
		ArchiveData:AddGift(arg_59_1.archive_id, arg_59_1.gift_list)
		var_0_0.UpdateHeartRedPoint()
		var_0_0.UpdateStoryRedPoint()
		var_0_0.UpdateSuperStoryRedPoint()
		manager.notify:CallUpdateFunc(HERO_SEND_GIFT, self, arg_59_1)
	else
		ShowTips(self.result)
	end
end

function var_0_0.InitHeartStoryRedPoint()
	local var_60_0 = ArchiveData:GetArchiveList()

	if not var_60_0 then
		return
	end

	for iter_60_0, iter_60_1 in pairs(var_60_0) do
		manager.redPoint:addGroup(RedPointConst.HERO_HEART_STORY_ROOT_ID .. iter_60_0, {
			RedPointConst.HERO_SUPER_STORY_ID .. iter_60_0,
			RedPointConst.HERO_STORY_ID .. iter_60_0,
			RedPointConst.HERO_ANEDOTE_ID .. iter_60_0
		})
	end
end

function var_0_0.UpdateStoryRedPoint()
	local function var_61_0(arg_62_0)
		for iter_62_0, iter_62_1 in ipairs(HeroRecordCfg[arg_62_0].plot_id) do
			if IsConditionAchieved(GameSetting.hero_plot_unlock_condition.value[iter_62_0], {
				heroId = arg_62_0
			}) and (iter_62_0 > 1 or nil) and ArchiveData:IsStoryRead(arg_62_0, HeroRecordCfg[arg_62_0].plot_id[iter_62_0 - 1]) and not ArchiveData:IsStoryRead(arg_62_0, HeroRecordCfg[arg_62_0].plot_id[iter_62_0]) then
				return true
			end
		end

		return false
	end

	for iter_61_0, iter_61_1 in pairs((ArchiveData:GetArchiveList())) do
		if HeroRecordCfg.get_id_list_by_hero_id[iter_61_0] then
			local var_61_1 = RedPointConst.HERO_STORY_ID .. iter_61_0
			local var_61_2 = getData("HearListRedPoint", "heartStroy_" .. PlayerData:GetPlayerInfo().userID .. "_" .. HeroRecordCfg.get_id_list_by_hero_id[iter_61_0][1])
			local var_61_3, var_61_4, var_61_5 = ArchiveData:GetUnlockHeartListInfoLengthByHeroId(iter_61_0)

			manager.redPoint:setTip(var_61_1, var_61_0(iter_61_0) and not (var_61_2 and var_61_2[1] == var_61_3) and 1 or 0)
		end
	end
end

function var_0_0.UpdateSuperStoryRedPoint()
	local function var_63_0(arg_64_0)
		for iter_64_0, iter_64_1 in ipairs(HeroRecordCfg[arg_64_0].super_plot_id) do
			local var_64_0 = false

			for iter_64_2, iter_64_3 in ipairs(HeroRecordCfg[arg_64_0].hero_id) do
				var_64_0 = var_64_0 or IsConditionAchieved(GameSetting.hero_super_plot_unlock_condition.value[iter_64_0], {
					heroId = iter_64_3
				})
			end

			if var_64_0 and not ArchiveData:IsSuperHeartRead(arg_64_0, iter_64_0) then
				return true
			end
		end

		return false
	end

	local function var_63_1(arg_65_0)
		local var_65_0 = false

		for iter_65_0, iter_65_1 in ipairs(HeroRecordCfg[arg_65_0].hero_id) do
			var_65_0 = var_65_0 or IsConditionAchieved(GameSetting.hero_anecdote_unlock_condition.value[1], {
				heroId = iter_65_1
			})

			if var_65_0 and not ArchiveData:IsArchiveStoryRead(arg_65_0, iter_65_1) then
				return true
			end
		end

		return false
	end

	for iter_63_0, iter_63_1 in pairs((ArchiveData:GetArchiveList())) do
		if HeroRecordCfg.get_id_list_by_hero_id[iter_63_0] then
			local var_63_2 = RedPointConst.HERO_SUPER_STORY_ID .. iter_63_0
			local var_63_3 = RedPointConst.HERO_ANEDOTE_ID .. iter_63_0
			local var_63_4 = getData("HearListRedPoint", "heartStroy_" .. PlayerData:GetPlayerInfo().userID .. "_" .. HeroRecordCfg.get_id_list_by_hero_id[iter_63_0][1])
			local var_63_5, var_63_6, var_63_7 = ArchiveData:GetUnlockHeartListInfoLengthByHeroId(iter_63_0)
			local var_63_8 = var_63_4 and var_63_4[3] == var_63_7

			manager.redPoint:setTip(var_63_2, var_63_0(iter_63_0) and not (var_63_4 and var_63_4[2] == var_63_6) and 1 or 0)
			manager.redPoint:setTip(var_63_3, var_63_1(iter_63_0) and not var_63_8 and 1 or 0)
		end
	end
end

function var_0_0.UpdateHeartRedPoint()
	if not HeroRecordCfg.all then
		return
	end

	for iter_66_0, iter_66_1 in pairs(HeroRecordCfg.all) do
		for iter_66_2 = 1, HeroConst.HERO_HEARTLINK_STORY_MAX_COUNT do
			manager.redPoint:setTip(RedPointConst.HERO_HEARTLINK_ID .. iter_66_1 .. "_" .. iter_66_2, IsConditionAchieved(GameSetting.heart_chain_unlock_condition.value[iter_66_2], {
				heroId = iter_66_1
			}) and not ArchiveData:IsHeartRead(iter_66_1, iter_66_2) and 1 or 0)
		end
	end
end

function var_0_0.ReadStory(arg_67_0, arg_67_1, arg_67_2, arg_67_3)
	if arg_67_2 == 1 then
		ArchiveData:SetStoryRead(arg_67_0, arg_67_1)
		manager.net:SendWithLoadingNew(14104, {
			archive_id = arg_67_0,
			video_list = {
				arg_67_1
			}
		}, 14105, var_0_0.OnReadStory)
		var_0_0.UpdateStoryRedPoint()
	elseif arg_67_2 == 2 then
		ArchiveData:SetSuperHeartRead(arg_67_0, arg_67_3)
		ArchiveAction.SendViewSuperHeart(arg_67_0, arg_67_3)
		HeroAction.UpdateSuperStoryRedPoint()
	end

	manager.notify:Invoke(UPDATE_HEARTLIST)
end

function var_0_0:OnReadStory(arg_68_1)
	if not isSuccess(self.result) then
		ShowTips(self.result)
	end
end

function var_0_0.ReadHeartLink(arg_69_0, arg_69_1)
	ArchiveData:SetHeartRead(arg_69_0, arg_69_1)
	manager.net:SendWithLoadingNew(14102, {
		archive_id = arg_69_0,
		text_list = {
			arg_69_1
		}
	}, 14103, var_0_0.OnReadHeartLink)
end

function var_0_0:OnReadHeartLink(arg_70_1)
	if not isSuccess(self.result) then
		ShowTips(self.result)
	end
end

function var_0_0.SetFavoriteHeroOn(arg_71_0)
	manager.net:SendWithLoadingNew(14106, {
		hero_id = arg_71_0
	}, 14107, var_0_0.OnSetFavoriteHeroOn)
end

function var_0_0:OnSetFavoriteHeroOn(arg_72_1)
	if isSuccess(self.result) then
		HeroData:SetFavoriteHeroOn(arg_72_1.hero_id)
		manager.notify:Invoke(FAVORITE_HERO)
	else
		ShowTips(self.result)
	end
end

function var_0_0.SetFavoriteHeroOff(arg_73_0)
	manager.net:SendWithLoadingNew(14108, {
		hero_id = arg_73_0
	}, 14109, var_0_0.OnSetFavoriteHeroOff)
end

function var_0_0:OnSetFavoriteHeroOff(arg_74_1)
	if isSuccess(self.result) then
		HeroData:SetFavoriteHeroOff(arg_74_1.hero_id)
		manager.notify:Invoke(FAVORITE_HERO)
	else
		ShowTips(self.result)
	end
end

function var_0_0.UnLockSkin(arg_75_0)
	manager.net:SendWithLoadingNew(14110, {
		skin_id = arg_75_0
	}, 14111, var_0_0.OnUnLockSkin)
end

function var_0_0:OnUnLockSkin(arg_76_1)
	if isSuccess(self.result) then
		HeroAction.GetSkinAni(arg_76_1.skin_id)
		PlayerAction.RefreshSkinGiftRedPoint()
	else
		ShowTips(self.result)
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
			local var_82_0 = WeaponModuleCfg[arg_81_0].cost[HeroData:GetCurModuleLevel(arg_81_0) + 1]

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
	getReward({
		{
			num = 1,
			id = arg_85_0
		}
	})
	HeroAction.SkinAdd(arg_85_0)
	HeroAction.UpdateHeroSkinRedPoint(SkinCfg[arg_85_0].hero)
end

function var_0_0.UpdateAllSkinRedPoint()
	for iter_86_0, iter_86_1 in pairs((HeroData:GetHeroList())) do
		local var_86_0 = iter_86_1.unlock > 0
		local var_86_1 = {}

		for iter_86_2, iter_86_3 in ipairs(iter_86_1.unlocked_skin) do
			table.insert(var_86_1, iter_86_3.skin_id)
		end

		for iter_86_4, iter_86_5 in pairs(SkinCfg.get_id_list_by_hero[iter_86_1.id]) do
			if var_86_0 and not table.indexof(var_86_1, iter_86_5) and HeroTools.GetSkinIsCanUnlockAndGet(iter_86_5) then
				manager.redPoint:setTip(RedPointConst.HERO_SKIN_ID_EXTEND .. iter_86_5, 1)
			else
				manager.redPoint:setTip(RedPointConst.HERO_SKIN_ID_EXTEND .. iter_86_5, 0)
			end
		end
	end
end

function var_0_0.UpdateHeroSkinRedPoint(arg_87_0)
	local var_87_0 = HeroData:GetHeroList()
	local var_87_1 = {}

	for iter_87_0, iter_87_1 in ipairs(var_87_0[arg_87_0].unlocked_skin) do
		table.insert(var_87_1, iter_87_1.skin_id)
	end

	local var_87_2 = var_87_0[arg_87_0].unlock > 0

	for iter_87_2, iter_87_3 in pairs(SkinCfg.get_id_list_by_hero[arg_87_0]) do
		if var_87_2 and not table.indexof(var_87_1, iter_87_3) and HeroTools.GetSkinIsCanUnlockAndGet(iter_87_3) then
			manager.redPoint:setTip(RedPointConst.HERO_SKIN_ID_EXTEND .. iter_87_3, 1)
		else
			manager.redPoint:setTip(RedPointConst.HERO_SKIN_ID_EXTEND .. iter_87_3, 0)
		end

		manager.redPoint:setTip(RedPointConst.HERO_SKIN_ROUTE_ID .. iter_87_3, not table.indexof(var_87_1, iter_87_3) and HeroTools.GetSkinIsCanUnlockAndGet(iter_87_3) and 1 or 0, RedPointStyle.SHOW_NEW_TAG)
	end
end

function var_0_0.RefreshHeroRedPointAfterSeverSendData()
	var_0_0.UpdateAllSkinRedPoint()
end

function var_0_0.UpdateModuleRedPointByHeroID(arg_89_0)
	if WeaponModuleCfg[arg_89_0] == nil then
		return
	end

	local var_89_0 = HeroData:GetCurModuleLevel(arg_89_0)

	if HeroData:GetModuleMaxLevel(arg_89_0) <= var_89_0 then
		manager.redPoint:setTip(RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. arg_89_0, 0)

		return
	end

	local var_89_1 = WeaponModuleCfg[arg_89_0].condition[var_89_0 + 1]
	local var_89_2 = {}
	local var_89_3 = 0

	for iter_89_0, iter_89_1 in pairs(WeaponModuleCfg[arg_89_0].cost[var_89_0 + 1]) do
		if iter_89_1[1] == 2 then
			var_89_3 = iter_89_1[2]
		else
			table.insert(var_89_2, iter_89_1)
		end
	end

	if not checkGold(var_89_3, false) then
		manager.redPoint:setTip(RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. arg_89_0, 0)

		return
	end

	if not HeroData:GetModuleAssignmentIsFinish(arg_89_0) then
		manager.redPoint:setTip(RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. arg_89_0, 0)

		return
	end

	if var_89_1 and var_89_1[1] then
		for iter_89_2, iter_89_3 in pairs(var_89_1) do
			if not IsConditionAchieved(iter_89_3, {
				heroId = arg_89_0
			}) then
				manager.redPoint:setTip(RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. arg_89_0, 0)

				return
			end
		end
	end

	for iter_89_4, iter_89_5 in pairs(var_89_2) do
		if iter_89_5[2] > ItemTools.getItemNum(iter_89_5[1]) then
			manager.redPoint:setTip(RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. arg_89_0, 0)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. arg_89_0, 1)
end

function var_0_0.QueryHeroNewData(arg_90_0)
	manager.net:SendWithLoadingNew(14042, {
		hero_id = arg_90_0
	}, 14043, var_0_0.OnHeroNewDataBack)
end

function var_0_0:OnHeroNewDataBack()
	if isSuccess(self.result) then
		-- block empty
	else
		ShowTips(self.result)
	end
end

function var_0_0.ReqHeroHeartRate(arg_92_0)
	manager.net:SendWithLoadingNew(14122, {
		hero_id = arg_92_0
	}, 14123, var_0_0.OnReqHeroHeartRate)
end

function var_0_0:OnReqHeroHeartRate(arg_93_1)
	if isSuccess(self.result) then
		print("修正者" .. arg_93_1.hero_id .. "的心动值为：", self.value)
		SpecialAttributesTools.OnReqHeroHeartRate(self.value)
	else
		ShowTips(self.result)
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
