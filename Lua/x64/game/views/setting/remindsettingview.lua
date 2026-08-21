local var_0_0 = class("RemindSettingView", ReduxView)

function var_0_0.SetActive(arg_1_0, arg_1_1)
	if arg_1_0.gameObject_ then
		SetActive(arg_1_0.gameObject_, arg_1_1)
	end

	if arg_1_1 then
		arg_1_0.scrollView_.verticalNormalizedPosition = 1
	end
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.hander_ = arg_2_1
	arg_2_0.gameObject_ = arg_2_2
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:Init()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
	arg_3_0:OnEnter()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddToggleListener(arg_5_0.fatigueFullReminderTgl_, function(arg_6_0)
		local var_6_0
		local var_6_1 = arg_6_0 and 1 or 0

		SettingAction.ChangeRemindSetting("fatigue_full_reminder", var_6_1)
	end)
	arg_5_0:AddToggleListener(arg_5_0.signReminderTgl_, function(arg_7_0)
		local var_7_0
		local var_7_1 = arg_7_0 and 1 or 0

		SettingAction.ChangeRemindSetting("activity_sign_reminder", var_7_1)
	end)
	arg_5_0:AddToggleListener(arg_5_0.monthCardReminderTgl_, function(arg_8_0)
		local var_8_0
		local var_8_1 = arg_8_0 and 1 or 0

		SettingAction.ChangeRemindSetting("month_card_reminder", var_8_1)
	end)
	arg_5_0:AddToggleListener(arg_5_0.dailyFatigueReminderTgl_, function(arg_9_0)
		local var_9_0
		local var_9_1 = arg_9_0 and 1 or 0

		SettingAction.ChangeRemindSetting("daily_fatigue_reminder", var_9_1)
	end)
	arg_5_0:AddToggleListener(arg_5_0.catExploreReminderTgl_, function(arg_10_0)
		local var_10_0
		local var_10_1 = arg_10_0 and 1 or 0

		SettingAction.ChangeRemindSetting("cat_explore_reminder", var_10_1)
	end)
	arg_5_0:AddToggleListener(arg_5_0.canteenDispatchReminderTgl_, function(arg_11_0)
		local var_11_0
		local var_11_1 = arg_11_0 and 1 or 0

		SettingAction.ChangeRemindSetting("canteen_dispatch_reminder", var_11_1)
	end)
	arg_5_0:AddToggleListener(arg_5_0.canteenFullReminderTgl_, function(arg_12_0)
		local var_12_0
		local var_12_1 = arg_12_0 and 1 or 0

		SettingAction.ChangeRemindSetting("canteen_full_reminder", var_12_1)
	end)
	arg_5_0:AddToggleListener(arg_5_0.diamondBuyItemTgl_, function(arg_13_0)
		local var_13_0
		local var_13_1 = arg_13_0 and 1 or 0

		SettingAction.ChangeRemindSetting("diamond_buy_item_reminder", var_13_1)
	end)
	arg_5_0:AddToggleListener(arg_5_0.coreEquipBuyItemTgl_, function(arg_14_0)
		local var_14_0
		local var_14_1 = arg_14_0 and 1 or 0

		SettingAction.ChangeRemindSetting("core_equip_buy_item_reminder", var_14_1)
	end)
	arg_5_0:AddToggleListener(arg_5_0.infoBadgeTopBuyItemTgl_, function(arg_15_0)
		local var_15_0
		local var_15_1 = arg_15_0 and 1 or 0

		SettingAction.ChangeRemindSetting("info_badge_top_buy_item_reminder", var_15_1)
	end)
	arg_5_0:AddToggleListener(arg_5_0.bossChallengeSBuyItemTgl_, function(arg_16_0)
		local var_16_0
		local var_16_1 = arg_16_0 and 1 or 0

		SettingAction.ChangeRemindSetting("boss_challenge_s_buy_item_reminder", var_16_1)
	end)
	arg_5_0:AddToggleListener(arg_5_0.diamondBuyFatigueTgl_, function(arg_17_0)
		local var_17_0
		local var_17_1 = arg_17_0 and 1 or 0

		SettingAction.ChangeRemindSetting("diamond_buy_fatigue_reminder", var_17_1)
	end)
	arg_5_0:AddToggleListener(arg_5_0.diamondBuyGoldTgl_, function(arg_18_0)
		local var_18_0
		local var_18_1 = arg_18_0 and 1 or 0

		SettingAction.ChangeRemindSetting("diamond_buy_gold_reminder", var_18_1)
	end)
	arg_5_0:AddToggleListener(arg_5_0.spiritRefineTgl_, function(arg_19_0)
		local var_19_0
		local var_19_1 = arg_19_0 and 1 or 0

		SettingAction.ChangeRemindSetting("spirit_refine_reminder", var_19_1)
	end)
	arg_5_0:AddToggleListener(arg_5_0.refreshEnchantmentTimesTgl_, function(arg_20_0)
		local var_20_0
		local var_20_1 = arg_20_0 and 1 or 0

		SettingAction.ChangeRemindSetting("refresh_enchantment_times_reminder", var_20_1)
	end)
	arg_5_0:AddToggleListener(arg_5_0.uninstallEquipTgl_, function(arg_21_0)
		local var_21_0
		local var_21_1 = arg_21_0 and 1 or 0

		SettingAction.ChangeRemindSetting("uninstall_equip_reminder", var_21_1)
	end)
	arg_5_0:AddToggleListener(arg_5_0.rebuildHeroEquipTgl_, function(arg_22_0)
		local var_22_0
		local var_22_1 = arg_22_0 and 1 or 0

		SettingAction.ChangeRemindSetting("rebuild_hero_equip_reminder", var_22_1)
	end)
	arg_5_0:AddToggleListener(arg_5_0.servantPromoteTgl_, function(arg_23_0)
		local var_23_0
		local var_23_1 = arg_23_0 and 1 or 0

		SettingAction.ChangeRemindSetting("servant_promote_reminder", var_23_1)
	end)
	arg_5_0:AddToggleListener(arg_5_0.battleLowFpsTgl_, function(arg_24_0)
		local var_24_0
		local var_24_1 = arg_24_0 and 1 or 0

		SettingAction.ChangeRemindSetting("battle_low_fps_tips", var_24_1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_cooperationGuildTgl_, nil, function()
		local var_25_0 = CooperationData:GetInviteRestrict(2) and 2 or 1

		CooperationAction.SetInviteRestrict(2, var_25_0)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_cooperationFriendTgl_, nil, function()
		local var_26_0 = CooperationData:GetInviteRestrict(1) and 2 or 1

		CooperationAction.SetInviteRestrict(1, var_26_0)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_cooperationRecentTgl_, nil, function()
		local var_27_0 = CooperationData:GetInviteRestrict(3) and 2 or 1

		CooperationAction.SetInviteRestrict(3, var_27_0)
	end)
end

function var_0_0.OnEnter(arg_28_0)
	arg_28_0.settingData_ = SettingData:GetRemindSettingData()

	arg_28_0:RefreshSignReminder()
	arg_28_0:RefreshMonthCardReminder()
	arg_28_0:RefreshFatigueFullReminder()
	arg_28_0:RefreshDailyFatigueReminder()
	arg_28_0:RefreshCatExploreReminder()
	arg_28_0:RefreshCanteenDispatchReminder()
	arg_28_0:RefreshCanteenFullReminder()
	arg_28_0:RefreshDiamondBuyItemReminder()
	arg_28_0:RefreshCoreEquipBuyItemReminder()
	arg_28_0:RefreshInfoBadgeTopBuyItemReminder()
	arg_28_0:RefreshBossChallengeSBuyItemReminder()
	arg_28_0:RefreshDiamondBuyFatigueReminder()
	arg_28_0:RefreshDiamondBuyGoldReminder()
	arg_28_0:RefreshSpiritRefineReminder()
	arg_28_0:RefreshServantPromoteReminder()
	arg_28_0:RefreshRefreshEnchantmentTimesReminder()
	arg_28_0:RefreshUninstallEquipReminder()
	arg_28_0:RefreshRebuildHeroEquipReminder()
	arg_28_0:RefreshBattleLowFpsTipReminder()

	arg_28_0.tmpSettingData_ = deepClone(arg_28_0.settingData_)

	arg_28_0:RefreshCooperationRestrict()

	arg_28_0.tmpCoopData_ = {}

	for iter_28_0 = 1, 3 do
		table.insert(arg_28_0.tmpCoopData_, iter_28_0, CooperationData:GetInviteRestrict(iter_28_0) and 2 or 1)
	end
end

function var_0_0.OnExit(arg_29_0)
	return
end

function var_0_0.RefreshCooperationRestrict(arg_30_0)
	local var_30_0 = CooperationData:GetInviteRestrict(1) and 0 or 1

	arg_30_0.m_cooperationFriendCon_:GetController("default0"):SetSelectedIndex(var_30_0)

	local var_30_1 = CooperationData:GetInviteRestrict(2) and 0 or 1

	arg_30_0.m_cooperationGuildCon_:GetController("default0"):SetSelectedIndex(var_30_1)

	local var_30_2 = CooperationData:GetInviteRestrict(3) and 0 or 1

	arg_30_0.m_cooperationRecentCon_:GetController("default0"):SetSelectedIndex(var_30_2)
end

function var_0_0.OnCooperationRestrictUpdate(arg_31_0)
	arg_31_0:RefreshCooperationRestrict()
end

function var_0_0.OnRemindChange(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_2.key == "allData" then
		arg_32_0:RefreshSignReminder()
		arg_32_0:RefreshMonthCardReminder()
		arg_32_0:RefreshFatigueFullReminder()
		arg_32_0:RefreshDailyFatigueReminder()
		arg_32_0:RefreshCatExploreReminder()
		arg_32_0:RefreshCanteenDispatchReminder()
		arg_32_0:RefreshCanteenFullReminder()
		arg_32_0:RefreshDiamondBuyItemReminder()
		arg_32_0:RefreshCoreEquipBuyItemReminder()
		arg_32_0:RefreshInfoBadgeTopBuyItemReminder()
		arg_32_0:RefreshBossChallengeSBuyItemReminder()
		arg_32_0:RefreshDiamondBuyFatigueReminder()
		arg_32_0:RefreshDiamondBuyGoldReminder()
		arg_32_0:RefreshSpiritRefineReminder()
		arg_32_0:RefreshRefreshEnchantmentTimesReminder()
		arg_32_0:RefreshUninstallEquipReminder()
		arg_32_0:RefreshRebuildHeroEquipReminder()
		arg_32_0:RefreshServantPromoteReminder()
		arg_32_0:RefreshBattleLowFpsTipReminder()
	elseif arg_32_2.key == "activity_sign_reminder" then
		arg_32_0:RefreshSignReminder()
	elseif arg_32_2.key == "month_card_reminder" then
		arg_32_0:RefreshMonthCardReminder()
	elseif arg_32_2.key == "fatigue_full_reminder" then
		arg_32_0:RefreshFatigueFullReminder()
	elseif arg_32_2.key == "daily_fatigue_reminder" then
		arg_32_0:RefreshDailyFatigueReminder()
	elseif arg_32_2.key == "cat_explore_reminder" then
		arg_32_0:RefreshCatExploreReminder()
	elseif arg_32_2.key == "canteen_dispatch_reminder" then
		arg_32_0:RefreshCanteenDispatchReminder()
	elseif arg_32_2.key == "canteen_full_reminder" then
		arg_32_0:RefreshCanteenFullReminder()
	elseif arg_32_2.key == "diamond_buy_item_reminder" then
		arg_32_0:RefreshDiamondBuyItemReminder()
	elseif arg_32_2.key == "core_equip_buy_item_reminder" then
		arg_32_0:RefreshCoreEquipBuyItemReminder()
	elseif arg_32_2.key == "info_badge_top_buy_item_reminder" then
		arg_32_0:RefreshInfoBadgeTopBuyItemReminder()
	elseif arg_32_2.key == "boss_challenge_s_buy_item_reminder" then
		arg_32_0:RefreshBossChallengeSBuyItemReminder()
	elseif arg_32_2.key == "diamond_buy_fatigue_reminder" then
		arg_32_0:RefreshDiamondBuyFatigueReminder()
	elseif arg_32_2.key == "diamond_buy_gold_reminder" then
		arg_32_0:RefreshDiamondBuyGoldReminder()
	elseif arg_32_2.key == "spirit_refine_reminder" then
		arg_32_0:RefreshSpiritRefineReminder()
	elseif arg_32_2.key == "refresh_enchantment_times_reminder" then
		arg_32_0:RefreshRefreshEnchantmentTimesReminder()
	elseif arg_32_2.key == "uninstall_equip_reminder" then
		arg_32_0:RefreshUninstallEquipReminder()
	elseif arg_32_2.key == "rebuild_hero_equip_reminder" then
		arg_32_0:RefreshRebuildHeroEquipReminder()
	elseif arg_32_2.key == "servant_promote_reminder" then
		arg_32_0:RefreshServantPromoteReminder()
	elseif arg_32_2.key == "battle_low_fps_tips" then
		arg_32_0:RefreshBattleLowFpsTipReminder()
	end
end

function var_0_0.RefreshSignReminder(arg_33_0)
	local var_33_0 = arg_33_0.settingData_.activity_sign_reminder == 1

	arg_33_0.signReminderTgl_.isOn = var_33_0

	arg_33_0.signReminderCon_:GetController("default0"):SetSelectedIndex(arg_33_0.settingData_.activity_sign_reminder)
end

function var_0_0.RefreshMonthCardReminder(arg_34_0)
	local var_34_0 = arg_34_0.settingData_.month_card_reminder == 1

	arg_34_0.monthCardReminderTgl_.isOn = var_34_0

	arg_34_0.monthCardReminderCon_:GetController("default0"):SetSelectedIndex(arg_34_0.settingData_.month_card_reminder)
end

function var_0_0.RefreshFatigueFullReminder(arg_35_0)
	local var_35_0 = arg_35_0.settingData_.fatigue_full_reminder == 1

	arg_35_0.fatigueFullReminderTgl_.isOn = var_35_0

	arg_35_0.fatigueFullReminderCon_:GetController("default0"):SetSelectedIndex(arg_35_0.settingData_.fatigue_full_reminder)
end

function var_0_0.RefreshDailyFatigueReminder(arg_36_0)
	local var_36_0 = arg_36_0.settingData_.daily_fatigue_reminder == 1

	arg_36_0.dailyFatigueReminderTgl_.isOn = var_36_0

	arg_36_0.dailyFatigueReminderCon_:GetController("default0"):SetSelectedIndex(arg_36_0.settingData_.daily_fatigue_reminder)
end

function var_0_0.RefreshCatExploreReminder(arg_37_0)
	local var_37_0 = arg_37_0.settingData_.cat_explore_reminder == 1

	arg_37_0.catExploreReminderTgl_.isOn = var_37_0

	arg_37_0.catExploreReminderCon_:GetController("default0"):SetSelectedIndex(arg_37_0.settingData_.cat_explore_reminder)
end

function var_0_0.RefreshCanteenDispatchReminder(arg_38_0)
	local var_38_0 = arg_38_0.settingData_.canteen_dispatch_reminder == 1

	arg_38_0.canteenDispatchReminderTgl_.isOn = var_38_0

	arg_38_0.canteenDispatchReminderCon_:GetController("default0"):SetSelectedIndex(arg_38_0.settingData_.canteen_dispatch_reminder)
end

function var_0_0.RefreshCanteenFullReminder(arg_39_0)
	local var_39_0 = arg_39_0.settingData_.canteen_full_reminder == 1

	arg_39_0.canteenFullReminderTgl_.isOn = var_39_0

	arg_39_0.canteenFullReminderCon_:GetController("default0"):SetSelectedIndex(arg_39_0.settingData_.canteen_full_reminder)
end

function var_0_0.RefreshDiamondBuyItemReminder(arg_40_0)
	local var_40_0 = arg_40_0.settingData_.diamond_buy_item_reminder == 1

	arg_40_0.diamondBuyItemTgl_.isOn = var_40_0

	arg_40_0.diamondBuyItemCon_:GetController("default0"):SetSelectedIndex(arg_40_0.settingData_.diamond_buy_item_reminder)
end

function var_0_0.RefreshCoreEquipBuyItemReminder(arg_41_0)
	local var_41_0 = arg_41_0.settingData_.core_equip_buy_item_reminder == 1

	arg_41_0.coreEquipBuyItemTgl_.isOn = var_41_0

	arg_41_0.coreEquipBuyItemCon_:GetController("default0"):SetSelectedIndex(arg_41_0.settingData_.core_equip_buy_item_reminder)
end

function var_0_0.RefreshInfoBadgeTopBuyItemReminder(arg_42_0)
	local var_42_0 = arg_42_0.settingData_.info_badge_top_buy_item_reminder == 1

	arg_42_0.infoBadgeTopBuyItemTgl_.isOn = var_42_0

	arg_42_0.infoBadgeTopBuyItemCon_:GetController("default0"):SetSelectedIndex(arg_42_0.settingData_.info_badge_top_buy_item_reminder)
end

function var_0_0.RefreshBossChallengeSBuyItemReminder(arg_43_0)
	local var_43_0 = arg_43_0.settingData_.boss_challenge_s_buy_item_reminder == 1

	arg_43_0.bossChallengeSBuyItemTgl_.isOn = var_43_0

	arg_43_0.bossChallengeSBuyItemCon_:GetController("default0"):SetSelectedIndex(arg_43_0.settingData_.boss_challenge_s_buy_item_reminder)
end

function var_0_0.RefreshDiamondBuyFatigueReminder(arg_44_0)
	local var_44_0 = arg_44_0.settingData_.diamond_buy_fatigue_reminder == 1

	arg_44_0.diamondBuyFatigueTgl_.isOn = var_44_0

	arg_44_0.diamondBuyFatigueCon_:GetController("default0"):SetSelectedIndex(arg_44_0.settingData_.diamond_buy_fatigue_reminder)
end

function var_0_0.RefreshDiamondBuyGoldReminder(arg_45_0)
	local var_45_0 = arg_45_0.settingData_.diamond_buy_gold_reminder == 1

	arg_45_0.diamondBuyGoldTgl_.isOn = var_45_0

	arg_45_0.diamondBuyGoldCon_:GetController("default0"):SetSelectedIndex(arg_45_0.settingData_.diamond_buy_gold_reminder)
end

function var_0_0.RefreshSpiritRefineReminder(arg_46_0)
	local var_46_0 = arg_46_0.settingData_.spirit_refine_reminder == 1

	arg_46_0.spiritRefineTgl_.isOn = var_46_0

	arg_46_0.spiritRefineCon_:GetController("default0"):SetSelectedIndex(arg_46_0.settingData_.spirit_refine_reminder)
end

function var_0_0.RefreshServantPromoteReminder(arg_47_0)
	local var_47_0 = arg_47_0.settingData_.servant_promote_reminder == 1

	arg_47_0.servantPromoteTgl_.isOn = var_47_0

	arg_47_0.servantPromoteCon_:GetController("default0"):SetSelectedIndex(arg_47_0.settingData_.servant_promote_reminder)
end

function var_0_0.RefreshRefreshEnchantmentTimesReminder(arg_48_0)
	local var_48_0 = arg_48_0.settingData_.refresh_enchantment_times_reminder == 1

	arg_48_0.refreshEnchantmentTimesTgl_.isOn = var_48_0

	arg_48_0.refreshEnchantmentTimesCon_:GetController("default0"):SetSelectedIndex(arg_48_0.settingData_.refresh_enchantment_times_reminder)
end

function var_0_0.RefreshUninstallEquipReminder(arg_49_0)
	local var_49_0 = arg_49_0.settingData_.uninstall_equip_reminder == 1

	arg_49_0.uninstallEquipTgl_.isOn = var_49_0

	arg_49_0.uninstallEquipCon_:GetController("default0"):SetSelectedIndex(arg_49_0.settingData_.uninstall_equip_reminder)
end

function var_0_0.RefreshRebuildHeroEquipReminder(arg_50_0)
	local var_50_0 = arg_50_0.settingData_.rebuild_hero_equip_reminder == 1

	arg_50_0.rebuildHeroEquipTgl_.isOn = var_50_0

	arg_50_0.rebuildHeroEquipCon_:GetController("default0"):SetSelectedIndex(arg_50_0.settingData_.rebuild_hero_equip_reminder)
end

function var_0_0.RefreshBattleLowFpsTipReminder(arg_51_0)
	local var_51_0 = arg_51_0.settingData_.battle_low_fps_tips == 1

	arg_51_0.battleLowFpsTgl_.isOn = var_51_0

	arg_51_0.battleLowFpsCon_:GetController("default0"):SetSelectedIndex(arg_51_0.settingData_.battle_low_fps_tips)
end

function var_0_0.CheckDataChange(arg_52_0, arg_52_1)
	if arg_52_0.tmpSettingData_ and not table.equal(arg_52_0.tmpSettingData_, arg_52_0.settingData_, "all") then
		return true
	end

	if arg_52_0:CheckCoopChange() then
		return true
	end

	return false
end

function var_0_0.CheckCoopChange(arg_53_0)
	for iter_53_0 = 1, 3 do
		if (CooperationData:GetInviteRestrict(iter_53_0) and 2 or 1) ~= arg_53_0.tmpCoopData_[iter_53_0] then
			return true
		end
	end

	return false
end

function var_0_0.SaveData(arg_54_0)
	if arg_54_0:CheckDataChange() then
		SDKTools.SendMessageToSDK("remind_setting", {
			signin_push_setting = arg_54_0.settingData_.activity_sign_reminder,
			insider_push_setting = arg_54_0.settingData_.month_card_reminder,
			dundun_push_setting = arg_54_0.settingData_.fatigue_full_reminder
		})

		if arg_54_0.settingData_.fatigue_full_reminder == 0 then
			TimerReminderData:CancelReminder(TimerReminderConst.FATIGUE)
		end

		ReminderAction:SettingMotify(arg_54_0.settingData_.activity_sign_reminder, arg_54_0.settingData_.month_card_reminder)
	end

	if arg_54_0:CheckCoopChange() then
		arg_54_0.tmpSettingData_ = deepClone(arg_54_0.settingData_)
		arg_54_0.tmpCoopData_ = {}

		for iter_54_0 = 1, 3 do
			table.insert(arg_54_0.tmpCoopData_, iter_54_0, CooperationData:GetInviteRestrict(iter_54_0) and 2 or 1)
		end
	end
end

function var_0_0.RecoverTmpData(arg_55_0)
	if arg_55_0:CheckDataChange() then
		SettingAction.ChangeRemindSetting("allData", arg_55_0.tmpSettingData_)
	end

	if arg_55_0:CheckCoopChange() then
		CooperationAction.SetInviteRestrictByList(arg_55_0.tmpCoopData_)
	end
end

function var_0_0.Dispose(arg_56_0)
	arg_56_0.hander_ = nil

	arg_56_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_56_0)
end

return var_0_0
