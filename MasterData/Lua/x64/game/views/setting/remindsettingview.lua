local RemindSettingView = class("RemindSettingView", ReduxView)

function RemindSettingView:SetActive(arg_1_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_1_1)
	end

	if arg_1_1 then
		self.scrollView_.verticalNormalizedPosition = 1
	end
end

function RemindSettingView:Ctor(arg_2_1, arg_2_2, arg_2_3)
	self.hander_ = arg_2_1
	self.gameObject_ = arg_2_2
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function RemindSettingView:Init()
	self:InitUI()
	self:AddUIListeners()
	self:OnEnter()
end

function RemindSettingView:InitUI()
	self:BindCfgUI()
end

function RemindSettingView:AddUIListeners()
	self:AddToggleListener(self.fatigueFullReminderTgl_, function(arg_6_0)
		SettingAction.ChangeRemindSetting("fatigue_full_reminder", arg_6_0 and 1 or 0)
	end)
	self:AddToggleListener(self.signReminderTgl_, function(arg_7_0)
		SettingAction.ChangeRemindSetting("activity_sign_reminder", arg_7_0 and 1 or 0)
	end)
	self:AddToggleListener(self.monthCardReminderTgl_, function(arg_8_0)
		SettingAction.ChangeRemindSetting("month_card_reminder", arg_8_0 and 1 or 0)
	end)
	self:AddToggleListener(self.dailyFatigueReminderTgl_, function(arg_9_0)
		SettingAction.ChangeRemindSetting("daily_fatigue_reminder", arg_9_0 and 1 or 0)
	end)
	self:AddToggleListener(self.catExploreReminderTgl_, function(arg_10_0)
		SettingAction.ChangeRemindSetting("cat_explore_reminder", arg_10_0 and 1 or 0)
	end)
	self:AddToggleListener(self.canteenDispatchReminderTgl_, function(arg_11_0)
		SettingAction.ChangeRemindSetting("canteen_dispatch_reminder", arg_11_0 and 1 or 0)
	end)
	self:AddToggleListener(self.canteenFullReminderTgl_, function(arg_12_0)
		SettingAction.ChangeRemindSetting("canteen_full_reminder", arg_12_0 and 1 or 0)
	end)
	self:AddToggleListener(self.diamondBuyItemTgl_, function(arg_13_0)
		SettingAction.ChangeRemindSetting("diamond_buy_item_reminder", arg_13_0 and 1 or 0)
	end)
	self:AddToggleListener(self.coreEquipBuyItemTgl_, function(arg_14_0)
		SettingAction.ChangeRemindSetting("core_equip_buy_item_reminder", arg_14_0 and 1 or 0)
	end)
	self:AddToggleListener(self.infoBadgeTopBuyItemTgl_, function(arg_15_0)
		SettingAction.ChangeRemindSetting("info_badge_top_buy_item_reminder", arg_15_0 and 1 or 0)
	end)
	self:AddToggleListener(self.bossChallengeSBuyItemTgl_, function(arg_16_0)
		SettingAction.ChangeRemindSetting("boss_challenge_s_buy_item_reminder", arg_16_0 and 1 or 0)
	end)
	self:AddToggleListener(self.diamondBuyFatigueTgl_, function(arg_17_0)
		SettingAction.ChangeRemindSetting("diamond_buy_fatigue_reminder", arg_17_0 and 1 or 0)
	end)
	self:AddToggleListener(self.diamondBuyGoldTgl_, function(arg_18_0)
		SettingAction.ChangeRemindSetting("diamond_buy_gold_reminder", arg_18_0 and 1 or 0)
	end)
	self:AddToggleListener(self.spiritRefineTgl_, function(arg_19_0)
		SettingAction.ChangeRemindSetting("spirit_refine_reminder", arg_19_0 and 1 or 0)
	end)
	self:AddToggleListener(self.refreshEnchantmentTimesTgl_, function(arg_20_0)
		SettingAction.ChangeRemindSetting("refresh_enchantment_times_reminder", arg_20_0 and 1 or 0)
	end)
	self:AddToggleListener(self.uninstallEquipTgl_, function(arg_21_0)
		SettingAction.ChangeRemindSetting("uninstall_equip_reminder", arg_21_0 and 1 or 0)
	end)
	self:AddToggleListener(self.rebuildHeroEquipTgl_, function(arg_22_0)
		SettingAction.ChangeRemindSetting("rebuild_hero_equip_reminder", arg_22_0 and 1 or 0)
	end)
	self:AddToggleListener(self.servantPromoteTgl_, function(arg_23_0)
		SettingAction.ChangeRemindSetting("servant_promote_reminder", arg_23_0 and 1 or 0)
	end)
	self:AddToggleListener(self.battleLowFpsTgl_, function(arg_24_0)
		SettingAction.ChangeRemindSetting("battle_low_fps_tips", arg_24_0 and 1 or 0)
	end)
	self:AddBtnListener(self.m_cooperationGuildTgl_, nil, function()
		CooperationAction.SetInviteRestrict(2, CooperationData:GetInviteRestrict(2) and 2 or 1)
	end)
	self:AddBtnListener(self.m_cooperationFriendTgl_, nil, function()
		CooperationAction.SetInviteRestrict(1, CooperationData:GetInviteRestrict(1) and 2 or 1)
	end)
	self:AddBtnListener(self.m_cooperationRecentTgl_, nil, function()
		CooperationAction.SetInviteRestrict(3, CooperationData:GetInviteRestrict(3) and 2 or 1)
	end)
end

function RemindSettingView:OnEnter()
	self.settingData_ = SettingData:GetRemindSettingData()

	self:RefreshSignReminder()
	self:RefreshMonthCardReminder()
	self:RefreshFatigueFullReminder()
	self:RefreshDailyFatigueReminder()
	self:RefreshCatExploreReminder()
	self:RefreshCanteenDispatchReminder()
	self:RefreshCanteenFullReminder()
	self:RefreshDiamondBuyItemReminder()
	self:RefreshCoreEquipBuyItemReminder()
	self:RefreshInfoBadgeTopBuyItemReminder()
	self:RefreshBossChallengeSBuyItemReminder()
	self:RefreshDiamondBuyFatigueReminder()
	self:RefreshDiamondBuyGoldReminder()
	self:RefreshSpiritRefineReminder()
	self:RefreshServantPromoteReminder()
	self:RefreshRefreshEnchantmentTimesReminder()
	self:RefreshUninstallEquipReminder()
	self:RefreshRebuildHeroEquipReminder()
	self:RefreshBattleLowFpsTipReminder()

	self.tmpSettingData_ = deepClone(self.settingData_)

	self:RefreshCooperationRestrict()

	self.tmpCoopData_ = {}

	for iter_28_0 = 1, 3 do
		table.insert(self.tmpCoopData_, iter_28_0, CooperationData:GetInviteRestrict(iter_28_0) and 2 or 1)
	end
end

function RemindSettingView:OnExit()
	return
end

function RemindSettingView:RefreshCooperationRestrict()
	self.m_cooperationFriendCon_:GetController("default0"):SetSelectedIndex(CooperationData:GetInviteRestrict(1) and 0 or 1)
	self.m_cooperationGuildCon_:GetController("default0"):SetSelectedIndex(CooperationData:GetInviteRestrict(2) and 0 or 1)
	self.m_cooperationRecentCon_:GetController("default0"):SetSelectedIndex(CooperationData:GetInviteRestrict(3) and 0 or 1)
end

function RemindSettingView:OnCooperationRestrictUpdate()
	self:RefreshCooperationRestrict()
end

function RemindSettingView:OnRemindChange(arg_32_1, arg_32_2)
	if arg_32_2.key == "allData" then
		self:RefreshSignReminder()
		self:RefreshMonthCardReminder()
		self:RefreshFatigueFullReminder()
		self:RefreshDailyFatigueReminder()
		self:RefreshCatExploreReminder()
		self:RefreshCanteenDispatchReminder()
		self:RefreshCanteenFullReminder()
		self:RefreshDiamondBuyItemReminder()
		self:RefreshCoreEquipBuyItemReminder()
		self:RefreshInfoBadgeTopBuyItemReminder()
		self:RefreshBossChallengeSBuyItemReminder()
		self:RefreshDiamondBuyFatigueReminder()
		self:RefreshDiamondBuyGoldReminder()
		self:RefreshSpiritRefineReminder()
		self:RefreshRefreshEnchantmentTimesReminder()
		self:RefreshUninstallEquipReminder()
		self:RefreshRebuildHeroEquipReminder()
		self:RefreshServantPromoteReminder()
		self:RefreshBattleLowFpsTipReminder()
	elseif arg_32_2.key == "activity_sign_reminder" then
		self:RefreshSignReminder()
	elseif arg_32_2.key == "month_card_reminder" then
		self:RefreshMonthCardReminder()
	elseif arg_32_2.key == "fatigue_full_reminder" then
		self:RefreshFatigueFullReminder()
	elseif arg_32_2.key == "daily_fatigue_reminder" then
		self:RefreshDailyFatigueReminder()
	elseif arg_32_2.key == "cat_explore_reminder" then
		self:RefreshCatExploreReminder()
	elseif arg_32_2.key == "canteen_dispatch_reminder" then
		self:RefreshCanteenDispatchReminder()
	elseif arg_32_2.key == "canteen_full_reminder" then
		self:RefreshCanteenFullReminder()
	elseif arg_32_2.key == "diamond_buy_item_reminder" then
		self:RefreshDiamondBuyItemReminder()
	elseif arg_32_2.key == "core_equip_buy_item_reminder" then
		self:RefreshCoreEquipBuyItemReminder()
	elseif arg_32_2.key == "info_badge_top_buy_item_reminder" then
		self:RefreshInfoBadgeTopBuyItemReminder()
	elseif arg_32_2.key == "boss_challenge_s_buy_item_reminder" then
		self:RefreshBossChallengeSBuyItemReminder()
	elseif arg_32_2.key == "diamond_buy_fatigue_reminder" then
		self:RefreshDiamondBuyFatigueReminder()
	elseif arg_32_2.key == "diamond_buy_gold_reminder" then
		self:RefreshDiamondBuyGoldReminder()
	elseif arg_32_2.key == "spirit_refine_reminder" then
		self:RefreshSpiritRefineReminder()
	elseif arg_32_2.key == "refresh_enchantment_times_reminder" then
		self:RefreshRefreshEnchantmentTimesReminder()
	elseif arg_32_2.key == "uninstall_equip_reminder" then
		self:RefreshUninstallEquipReminder()
	elseif arg_32_2.key == "rebuild_hero_equip_reminder" then
		self:RefreshRebuildHeroEquipReminder()
	elseif arg_32_2.key == "servant_promote_reminder" then
		self:RefreshServantPromoteReminder()
	elseif arg_32_2.key == "battle_low_fps_tips" then
		self:RefreshBattleLowFpsTipReminder()
	end
end

function RemindSettingView:RefreshSignReminder()
	self.signReminderTgl_.isOn = self.settingData_.activity_sign_reminder == 1

	self.signReminderCon_:GetController("default0"):SetSelectedIndex(self.settingData_.activity_sign_reminder)
end

function RemindSettingView:RefreshMonthCardReminder()
	self.monthCardReminderTgl_.isOn = self.settingData_.month_card_reminder == 1

	self.monthCardReminderCon_:GetController("default0"):SetSelectedIndex(self.settingData_.month_card_reminder)
end

function RemindSettingView:RefreshFatigueFullReminder()
	self.fatigueFullReminderTgl_.isOn = self.settingData_.fatigue_full_reminder == 1

	self.fatigueFullReminderCon_:GetController("default0"):SetSelectedIndex(self.settingData_.fatigue_full_reminder)
end

function RemindSettingView:RefreshDailyFatigueReminder()
	self.dailyFatigueReminderTgl_.isOn = self.settingData_.daily_fatigue_reminder == 1

	self.dailyFatigueReminderCon_:GetController("default0"):SetSelectedIndex(self.settingData_.daily_fatigue_reminder)
end

function RemindSettingView:RefreshCatExploreReminder()
	self.catExploreReminderTgl_.isOn = self.settingData_.cat_explore_reminder == 1

	self.catExploreReminderCon_:GetController("default0"):SetSelectedIndex(self.settingData_.cat_explore_reminder)
end

function RemindSettingView:RefreshCanteenDispatchReminder()
	self.canteenDispatchReminderTgl_.isOn = self.settingData_.canteen_dispatch_reminder == 1

	self.canteenDispatchReminderCon_:GetController("default0"):SetSelectedIndex(self.settingData_.canteen_dispatch_reminder)
end

function RemindSettingView:RefreshCanteenFullReminder()
	self.canteenFullReminderTgl_.isOn = self.settingData_.canteen_full_reminder == 1

	self.canteenFullReminderCon_:GetController("default0"):SetSelectedIndex(self.settingData_.canteen_full_reminder)
end

function RemindSettingView:RefreshDiamondBuyItemReminder()
	self.diamondBuyItemTgl_.isOn = self.settingData_.diamond_buy_item_reminder == 1

	self.diamondBuyItemCon_:GetController("default0"):SetSelectedIndex(self.settingData_.diamond_buy_item_reminder)
end

function RemindSettingView:RefreshCoreEquipBuyItemReminder()
	self.coreEquipBuyItemTgl_.isOn = self.settingData_.core_equip_buy_item_reminder == 1

	self.coreEquipBuyItemCon_:GetController("default0"):SetSelectedIndex(self.settingData_.core_equip_buy_item_reminder)
end

function RemindSettingView:RefreshInfoBadgeTopBuyItemReminder()
	self.infoBadgeTopBuyItemTgl_.isOn = self.settingData_.info_badge_top_buy_item_reminder == 1

	self.infoBadgeTopBuyItemCon_:GetController("default0"):SetSelectedIndex(self.settingData_.info_badge_top_buy_item_reminder)
end

function RemindSettingView:RefreshBossChallengeSBuyItemReminder()
	self.bossChallengeSBuyItemTgl_.isOn = self.settingData_.boss_challenge_s_buy_item_reminder == 1

	self.bossChallengeSBuyItemCon_:GetController("default0"):SetSelectedIndex(self.settingData_.boss_challenge_s_buy_item_reminder)
end

function RemindSettingView:RefreshDiamondBuyFatigueReminder()
	self.diamondBuyFatigueTgl_.isOn = self.settingData_.diamond_buy_fatigue_reminder == 1

	self.diamondBuyFatigueCon_:GetController("default0"):SetSelectedIndex(self.settingData_.diamond_buy_fatigue_reminder)
end

function RemindSettingView:RefreshDiamondBuyGoldReminder()
	self.diamondBuyGoldTgl_.isOn = self.settingData_.diamond_buy_gold_reminder == 1

	self.diamondBuyGoldCon_:GetController("default0"):SetSelectedIndex(self.settingData_.diamond_buy_gold_reminder)
end

function RemindSettingView:RefreshSpiritRefineReminder()
	self.spiritRefineTgl_.isOn = self.settingData_.spirit_refine_reminder == 1

	self.spiritRefineCon_:GetController("default0"):SetSelectedIndex(self.settingData_.spirit_refine_reminder)
end

function RemindSettingView:RefreshServantPromoteReminder()
	self.servantPromoteTgl_.isOn = self.settingData_.servant_promote_reminder == 1

	self.servantPromoteCon_:GetController("default0"):SetSelectedIndex(self.settingData_.servant_promote_reminder)
end

function RemindSettingView:RefreshRefreshEnchantmentTimesReminder()
	self.refreshEnchantmentTimesTgl_.isOn = self.settingData_.refresh_enchantment_times_reminder == 1

	self.refreshEnchantmentTimesCon_:GetController("default0"):SetSelectedIndex(self.settingData_.refresh_enchantment_times_reminder)
end

function RemindSettingView:RefreshUninstallEquipReminder()
	self.uninstallEquipTgl_.isOn = self.settingData_.uninstall_equip_reminder == 1

	self.uninstallEquipCon_:GetController("default0"):SetSelectedIndex(self.settingData_.uninstall_equip_reminder)
end

function RemindSettingView:RefreshRebuildHeroEquipReminder()
	self.rebuildHeroEquipTgl_.isOn = self.settingData_.rebuild_hero_equip_reminder == 1

	self.rebuildHeroEquipCon_:GetController("default0"):SetSelectedIndex(self.settingData_.rebuild_hero_equip_reminder)
end

function RemindSettingView:RefreshBattleLowFpsTipReminder()
	self.battleLowFpsTgl_.isOn = self.settingData_.battle_low_fps_tips == 1

	self.battleLowFpsCon_:GetController("default0"):SetSelectedIndex(self.settingData_.battle_low_fps_tips)
end

function RemindSettingView:CheckDataChange(arg_52_1)
	if self.tmpSettingData_ and not table.equal(self.tmpSettingData_, self.settingData_, "all") then
		return true
	end

	if self:CheckCoopChange() then
		return true
	end

	return false
end

function RemindSettingView:CheckCoopChange()
	for iter_53_0 = 1, 3 do
		if (CooperationData:GetInviteRestrict(iter_53_0) and 2 or 1) ~= self.tmpCoopData_[iter_53_0] then
			return true
		end
	end

	return false
end

function RemindSettingView:SaveData()
	if self:CheckDataChange() then
		SDKTools.SendMessageToSDK("remind_setting", {
			signin_push_setting = self.settingData_.activity_sign_reminder,
			insider_push_setting = self.settingData_.month_card_reminder,
			dundun_push_setting = self.settingData_.fatigue_full_reminder
		})

		if self.settingData_.fatigue_full_reminder == 0 then
			TimerReminderData:CancelReminder(TimerReminderConst.FATIGUE)
		end

		ReminderAction:SettingMotify(self.settingData_.activity_sign_reminder, self.settingData_.month_card_reminder)
	end

	if self:CheckCoopChange() then
		self.tmpSettingData_ = deepClone(self.settingData_)
		self.tmpCoopData_ = {}

		for iter_54_0 = 1, 3 do
			table.insert(self.tmpCoopData_, iter_54_0, CooperationData:GetInviteRestrict(iter_54_0) and 2 or 1)
		end
	end
end

function RemindSettingView:RecoverTmpData()
	if self:CheckDataChange() then
		SettingAction.ChangeRemindSetting("allData", self.tmpSettingData_)
	end

	if self:CheckCoopChange() then
		CooperationAction.SetInviteRestrictByList(self.tmpCoopData_)
	end
end

function RemindSettingView:Dispose()
	self.hander_ = nil

	self:RemoveAllListeners()
	RemindSettingView.super.Dispose(self)
end

return RemindSettingView
