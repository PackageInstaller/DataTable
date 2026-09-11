local var_0_0 = {}

manager.net:Bind(73005, function(arg_1_0)
	ArchiveData:InitTrustGiftDisplaceCount(arg_1_0)
end)
manager.net:Bind(73007, function(arg_2_0)
	ArchiveData:InitRelationStory(arg_2_0)
end)
manager.notify:RegistListener(ZERO_REFRESH, function()
	ArchiveData:ClearTrustGiftDisplaceCount()
	manager.notify:CallUpdateFunc(HERO_TRUST_ITEM_DISPLACE)
end)

function var_0_0.QueryExChangeTrustItem(arg_4_0, arg_4_1)
	manager.net:SendWithLoadingNew(73010, {
		use_item_list = arg_4_0,
		reward_item_list = arg_4_1
	}, 73011, var_0_0.OnExChangeTrustItemBack)
end

function var_0_0:OnExChangeTrustItemBack(arg_5_1)
	if isSuccess(self.result) then
		local var_5_0 = {}

		for iter_5_0, iter_5_1 in pairs(arg_5_1.reward_item_list) do
			table.insert(var_5_0, {
				id = iter_5_1.id,
				num = iter_5_1.num
			})
			ArchiveData:UpdateTrustGiftDisplaceCount(iter_5_1.id, iter_5_1.num)
		end

		getReward(var_5_0)
		manager.notify:CallUpdateFunc(HERO_TRUST_ITEM_DISPLACE)
	else
		ShowTips(self.result)
	end
end

function var_0_0.QuerySendTrustItem(arg_6_0, arg_6_1)
	manager.net:SendWithLoadingNew(73012, {
		hero_id = arg_6_0,
		item_list = arg_6_1
	}, 73013, var_0_0.OnSendTrustItemBack)
end

function var_0_0:OnSendTrustItemBack(arg_7_1)
	if isSuccess(self.result) then
		manager.notify:CallUpdateFunc(HERO_TRUST_UPDATE)
		var_0_0.CheckHeroTrustUpLvRedPoint(arg_7_1.hero_id)
	else
		ShowTips(self.result)
	end
end

function var_0_0.QueryUpgradeTrustLevel(arg_8_0)
	manager.net:SendWithLoadingNew(73014, {
		hero_id = arg_8_0
	}, 73015, var_0_0.OnUpgradeTrustLevelBack)
end

function var_0_0:OnUpgradeTrustLevelBack(arg_9_1)
	if isSuccess(self.result) then
		getReward2(self.reward_list)
		HeroData:UpgradeTrustLevel(arg_9_1.hero_id)
		manager.notify:CallUpdateFunc(HERO_TRUST_UPDATE)
		var_0_0.CheckAllRelationRedPoint(arg_9_1.hero_id)
	else
		ShowTips(self.result)
	end
end

function var_0_0.QueryUnlockTrust(arg_10_0)
	manager.net:SendWithLoadingNew(73020, {
		hero_id = arg_10_0
	}, 73021, var_0_0.OnUnlockTrustBack)
end

function var_0_0:OnUnlockTrustBack(arg_11_1)
	if isSuccess(self.result) then
		HeroData:UnlockTrust(arg_11_1.hero_id, self.mood)
		manager.notify:CallUpdateFunc(HERO_TRUST_UPDATE)
		var_0_0.CheckAllRelationRedPoint(arg_11_1.hero_id)
	else
		ShowTips(self.result)
	end
end

function var_0_0.QueryUnlockRelationNet(arg_12_0, arg_12_1)
	manager.net:SendWithLoadingNew(73016, {
		id = arg_12_0,
		group_index = arg_12_1
	}, 73017, var_0_0.OnUnlockRelationNetBack)
end

function var_0_0:OnUnlockRelationNetBack(arg_13_1)
	if isSuccess(self.result) then
		HeroData:UnlockRelationNet(HeroRelationNetCfg[arg_13_1.id].hero_id, HeroRelationNetCfg[arg_13_1.id].index, arg_13_1.group_index)
		manager.notify:CallUpdateFunc(HERO_RELATION_NET_UNLOCK)
		var_0_0.CheckHeroRelationUnLockRedPoint(HeroRelationNetCfg[arg_13_1.id].hero_id)
	else
		ShowTips(self.result)
	end
end

function var_0_0.QueryRelationStoryReward(arg_14_0)
	manager.net:SendWithLoadingNew(73022, {
		id = arg_14_0
	}, 73023, var_0_0.OnRelationStoryRewardBack)
end

function var_0_0:OnRelationStoryRewardBack(arg_15_1)
	if isSuccess(self.result) then
		ArchiveData:UpdateRelationStory(arg_15_1.id)

		local var_15_0 = HeroRelationCfg[arg_15_1.id]

		getReward2(self.reward_list)
		Debug.Log((self.reward_list or nil) and (#self.reward_list or "???"))
		manager.notify:CallUpdateFunc(HERO_RELATION_STORY_REWARD)
		var_0_0.CheckHeroRelationStoryRedPoint(var_15_0.main_hero_id)
	else
		ShowTips(self.result)
	end
end

function var_0_0.SendSetWallPaper(arg_16_0, arg_16_1, arg_16_2)
	manager.net:SendWithLoadingNew(71106, {
		archive_id = arg_16_0,
		type = arg_16_2,
		id = arg_16_1
	}, 71107, var_0_0.OnSendSetWallPaperBack)
	ArchiveData:SetSelectPictrue(arg_16_0, arg_16_1, arg_16_2)
end

function var_0_0:OnSendSetWallPaperBack(arg_17_1)
	if not isSuccess(self.result) then
		ShowTips(self.result)
	else
		manager.notify:Invoke(UPDATE_WALLPAPER)
	end
end

function var_0_0.SendViewArchiveStory(arg_18_0, arg_18_1)
	manager.net:SendWithLoadingNew(71108, {
		hero_id = arg_18_1
	}, 71109, function(arg_19_0)
		if isSuccess(arg_19_0.result) then
			if arg_19_0.reward_list then
				getReward2(arg_19_0.reward_list or {})
			end

			ArchiveData:SetArchiveStoryRead(arg_18_0, arg_18_1)
		else
			ShowTips(arg_19_0.result)
		end

		HeroAction.UpdateSuperStoryRedPoint()
		manager.notify:Invoke(UPDATE_ANDOTE)
	end)
end

function var_0_0.SendViewSuperHeart(arg_20_0, arg_20_1)
	manager.net:SendWithLoadingNew(71114, {
		archive_id = arg_20_0,
		index = arg_20_1
	}, 71115, var_0_0.OnSendViewSuperHeartBack)
end

function var_0_0:OnSendViewSuperHeartBack(arg_21_1)
	if isSuccess(self.result) then
		-- block empty
	else
		ShowTips(self.result)
	end
end

manager.net:Bind(71111, function(arg_22_0)
	if arg_22_0.hero_id_list then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0.hero_id_list) do
			ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[iter_22_1][1]).hero_story_list[iter_22_1] = {
				is_viewed = false,
				hero_id = iter_22_1
			}
		end
	end
end)
manager.net:Bind(71113, function(arg_23_0)
	if arg_23_0.archive_id and arg_23_0.index_list then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0.index_list) do
			ArchiveData:GetArchive(arg_23_0.archive_id).super_heart_link_list[iter_23_1] = {
				is_viewed = false,
				index = iter_23_1
			}
		end
	end
end)

function var_0_0.CheckAllRelationRedPoint(arg_24_0)
	ArchiveAction.CheckHeroRelationUnLockRedPoint(arg_24_0)
	ArchiveAction.CheckHeroRelationStoryRedPoint(arg_24_0)
	ArchiveAction.CheckHeroTrustUpLvRedPoint(arg_24_0)
	ArchiveAction.CheckComboSkillRedPoint(arg_24_0)
end

function var_0_0.CheckHeroRelationUnLockRedPoint(arg_25_0)
	if not HeroTools.GetHeroIsUnlock(arg_25_0) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_REALTION_UNLOCK, arg_25_0), 0)

		return
	end

	local var_25_0 = HeroRelationNetCfg.get_id_list_by_hero_id[arg_25_0] or {}
	local var_25_1 = ArchiveData:GetTrustLevel(arg_25_0)

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if var_25_1 >= HeroRelationNetCfg[iter_25_1].index then
			for iter_25_2, iter_25_3 in ipairs(HeroRelationNetCfg[iter_25_1].relation_upgrade_group) do
				if not HeroData:GetHeroData(arg_25_0).relation:GetIsUnlock(HeroRelationNetCfg[iter_25_1].index, iter_25_2) and ArchiveTools.CheckRelationUpgradeCondition(HeroRelationUpgradeCfg[iter_25_3].condition_id, HeroRelationNetCfg[iter_25_1].intimate) then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_REALTION_UNLOCK, arg_25_0), 1)

					return
				end
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_REALTION_UNLOCK, arg_25_0), 0)
end

function var_0_0.CheckHeroRelationStoryRedPoint(arg_26_0)
	if not HeroTools.GetHeroIsUnlock(arg_26_0) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_RELATION_STORY, arg_26_0), 0)

		return
	end

	for iter_26_0, iter_26_1 in ipairs(HeroRelationCfg.get_id_list_by_main_hero_id[arg_26_0] or {}) do
		local var_26_1 = 0

		for iter_26_2, iter_26_3 in ipairs(HeroRelationNetCfg.get_id_list_by_hero_id[arg_26_0] or {}) do
			if table.indexof(HeroRelationNetCfg[iter_26_3].intimate, HeroRelationCfg[iter_26_1].relate_hero_id) then
				var_26_1 = HeroRelationNetCfg[iter_26_3].index
			end
		end

		if var_26_1 ~= 0 and var_26_1 <= ArchiveData:GetTrustLevel(arg_26_0) then
			if HeroRelationCfg[iter_26_1].story_id ~= 0 and IsConditionAchieved(HeroRelationCfg[iter_26_1].story_condtion_id, {
				heroId = arg_26_0
			}) and not ArchiveData:GetRelationStoryRead(HeroRelationCfg[iter_26_1].id) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_RELATION_STORY, arg_26_0), 1)

				return
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_RELATION_STORY, arg_26_0), 0)
end

function var_0_0.CheckAllHeroTrustUpLvRedPoint()
	for iter_27_0, iter_27_1 in pairs(HeroCfg.get_id_list_by_private[0]) do
		var_0_0.CheckHeroTrustUpLvRedPoint(iter_27_1)
	end
end

local var_0_1

function var_0_0.GetGiftMaxExp()
	if var_0_1 == nil then
		var_0_1 = 0

		for iter_28_0 = 1, HeroConst.HERO_LOVE_LV_MAX do
			var_0_1 = var_0_1 + GameLevelSetting[iter_28_0].hero_love_exp
		end
	end

	return var_0_1
end

function var_0_0.CheckHeroTrustUpLvRedPoint(arg_29_0)
	if not HeroRelationNetCfg.get_id_list_by_hero_id[arg_29_0] or not HeroTools.GetHeroIsUnlock(arg_29_0) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, arg_29_0), 0)

		return
	end

	local var_29_0, var_29_1, var_29_2 = ArchiveData:GetTrustLevel(arg_29_0)

	if ArchiveData:GetArchive((HeroTools.GetHeroOntologyID(arg_29_0))).exp < var_0_0.GetGiftMaxExp() or var_29_0 >= HeroConst.HERO_TRUST_LV_MAX then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, arg_29_0), 0)

		return
	end

	if var_29_0 == 0 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, arg_29_0), 1)

		return
	end

	if var_29_1 >= HeroTrustLevelCfg[var_29_0].exp then
		for iter_29_0, iter_29_1 in ipairs(HeroTrustCfg.get_id_list_by_hero_id[arg_29_0]) do
			if var_29_0 == HeroTrustCfg[iter_29_1].trust_level then
				local var_29_3 = true

				for iter_29_2, iter_29_3 in ipairs(HeroTrustCfg[iter_29_1].condition_list) do
					if not IsConditionAchieved(iter_29_3, {
						heroId = arg_29_0
					}) then
						var_29_3 = false

						break
					end
				end

				if var_29_3 then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, arg_29_0), 1)

					return
				end
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, arg_29_0), 0)
end

function var_0_0.CheckComboSkillRedPoint(arg_30_0)
	if not HeroRelationNetCfg.get_id_list_by_hero_id[arg_30_0] or not HeroTools.GetHeroIsUnlock(arg_30_0) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_RELATION_COMBO_SKILL, arg_30_0), 0)

		return
	end

	for iter_30_0, iter_30_1 in ipairs((ComboSkillTools.GetHeroComboSkill(arg_30_0))) do
		local var_30_0 = ComboSkillData:GetCurComboSkillLevel(iter_30_1)

		if var_30_0 < ComboSkillTools.GetMaxComboSkillLevel(iter_30_1) then
			local var_30_1 = true

			for iter_30_2, iter_30_3 in ipairs(ComboSkillLevelCfg.get_id_list_by_level[var_30_0]) do
				if not ComboSkillTools.CheckComboSkillUpContion(iter_30_3, iter_30_1) then
					var_30_1 = false

					break
				end
			end

			if var_30_1 then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_RELATION_COMBO_SKILL, arg_30_0), 1)

				return
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_RELATION_COMBO_SKILL, arg_30_0), 0)
end

return var_0_0
