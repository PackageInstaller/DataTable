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
	local var_4_0 = {
		use_item_list = arg_4_0,
		reward_item_list = arg_4_1
	}

	manager.net:SendWithLoadingNew(73010, var_4_0, 73011, var_0_0.OnExChangeTrustItemBack)
end

function var_0_0.OnExChangeTrustItemBack(arg_5_0, arg_5_1)
	if isSuccess(arg_5_0.result) then
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
		ShowTips(arg_5_0.result)
	end
end

function var_0_0.QuerySendTrustItem(arg_6_0, arg_6_1)
	local var_6_0 = {
		hero_id = arg_6_0,
		item_list = arg_6_1
	}

	manager.net:SendWithLoadingNew(73012, var_6_0, 73013, var_0_0.OnSendTrustItemBack)
end

function var_0_0.OnSendTrustItemBack(arg_7_0, arg_7_1)
	if isSuccess(arg_7_0.result) then
		manager.notify:CallUpdateFunc(HERO_TRUST_UPDATE)
		var_0_0.CheckHeroTrustUpLvRedPoint(arg_7_1.hero_id)
	else
		ShowTips(arg_7_0.result)
	end
end

function var_0_0.QueryUpgradeTrustLevel(arg_8_0)
	manager.net:SendWithLoadingNew(73014, {
		hero_id = arg_8_0
	}, 73015, var_0_0.OnUpgradeTrustLevelBack)
end

function var_0_0.OnUpgradeTrustLevelBack(arg_9_0, arg_9_1)
	if isSuccess(arg_9_0.result) then
		local var_9_0 = arg_9_1.hero_id

		getReward2(arg_9_0.reward_list)
		HeroData:UpgradeTrustLevel(arg_9_1.hero_id)
		manager.notify:CallUpdateFunc(HERO_TRUST_UPDATE)
		var_0_0.CheckAllRelationRedPoint(arg_9_1.hero_id)
	else
		ShowTips(arg_9_0.result)
	end
end

function var_0_0.QueryUnlockTrust(arg_10_0)
	manager.net:SendWithLoadingNew(73020, {
		hero_id = arg_10_0
	}, 73021, var_0_0.OnUnlockTrustBack)
end

function var_0_0.OnUnlockTrustBack(arg_11_0, arg_11_1)
	if isSuccess(arg_11_0.result) then
		HeroData:UnlockTrust(arg_11_1.hero_id, arg_11_0.mood)
		manager.notify:CallUpdateFunc(HERO_TRUST_UPDATE)
		var_0_0.CheckAllRelationRedPoint(arg_11_1.hero_id)
	else
		ShowTips(arg_11_0.result)
	end
end

function var_0_0.QueryUnlockRelationNet(arg_12_0, arg_12_1)
	manager.net:SendWithLoadingNew(73016, {
		id = arg_12_0,
		group_index = arg_12_1
	}, 73017, var_0_0.OnUnlockRelationNetBack)
end

function var_0_0.OnUnlockRelationNetBack(arg_13_0, arg_13_1)
	if isSuccess(arg_13_0.result) then
		local var_13_0 = HeroRelationNetCfg[arg_13_1.id]
		local var_13_1 = var_13_0.hero_id

		HeroData:UnlockRelationNet(var_13_1, var_13_0.index, arg_13_1.group_index)
		manager.notify:CallUpdateFunc(HERO_RELATION_NET_UNLOCK)
		var_0_0.CheckHeroRelationUnLockRedPoint(var_13_0.hero_id)
	else
		ShowTips(arg_13_0.result)
	end
end

function var_0_0.QueryRelationStoryReward(arg_14_0)
	manager.net:SendWithLoadingNew(73022, {
		id = arg_14_0
	}, 73023, var_0_0.OnRelationStoryRewardBack)
end

function var_0_0.OnRelationStoryRewardBack(arg_15_0, arg_15_1)
	if isSuccess(arg_15_0.result) then
		local var_15_0 = arg_15_1.id

		ArchiveData:UpdateRelationStory(var_15_0)

		local var_15_1 = HeroRelationCfg[var_15_0]

		getReward2(arg_15_0.reward_list)
		Debug.Log(arg_15_0.reward_list and #arg_15_0.reward_list or "???")
		manager.notify:CallUpdateFunc(HERO_RELATION_STORY_REWARD)
		var_0_0.CheckHeroRelationStoryRedPoint(var_15_1.main_hero_id)
	else
		ShowTips(arg_15_0.result)
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

function var_0_0.OnSendSetWallPaperBack(arg_17_0, arg_17_1)
	if not isSuccess(arg_17_0.result) then
		ShowTips(arg_17_0.result)
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

function var_0_0.OnSendViewSuperHeartBack(arg_21_0, arg_21_1)
	if isSuccess(arg_21_0.result) then
		-- block empty
	else
		ShowTips(arg_21_0.result)
	end
end

manager.net:Bind(71111, function(arg_22_0)
	if arg_22_0.hero_id_list then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0.hero_id_list) do
			local var_22_0 = HeroRecordCfg.get_id_list_by_hero_id[iter_22_1][1]

			ArchiveData:GetArchive(var_22_0).hero_story_list[iter_22_1] = {
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
		local var_25_2 = HeroRelationNetCfg[iter_25_1]

		if var_25_1 >= var_25_2.index then
			for iter_25_2, iter_25_3 in ipairs(var_25_2.relation_upgrade_group) do
				local var_25_3 = HeroRelationUpgradeCfg[iter_25_3]

				if not HeroData:GetHeroData(arg_25_0).relation:GetIsUnlock(var_25_2.index, iter_25_2) and ArchiveTools.CheckRelationUpgradeCondition(var_25_3.condition_id, var_25_2.intimate) then
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

	local var_26_0 = HeroRelationCfg.get_id_list_by_main_hero_id[arg_26_0] or {}

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		local var_26_1 = HeroRelationCfg[iter_26_1]
		local var_26_2 = var_26_1.relate_hero_id
		local var_26_3 = HeroRelationNetCfg.get_id_list_by_hero_id[arg_26_0] or {}
		local var_26_4 = 0

		for iter_26_2, iter_26_3 in ipairs(var_26_3) do
			local var_26_5 = HeroRelationNetCfg[iter_26_3]

			if table.indexof(var_26_5.intimate, var_26_2) then
				var_26_4 = var_26_5.index
			end
		end

		local var_26_6 = ArchiveData:GetTrustLevel(arg_26_0)

		if var_26_4 ~= 0 and var_26_4 <= var_26_6 then
			local var_26_7 = var_26_1.story_condtion_id

			if var_26_1.story_id ~= 0 and IsConditionAchieved(var_26_7, {
				heroId = arg_26_0
			}) and not ArchiveData:GetRelationStoryRead(var_26_1.id) then
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
	local var_29_3 = HeroTools.GetHeroOntologyID(arg_29_0)

	if ArchiveData:GetArchive(var_29_3).exp < var_0_0.GetGiftMaxExp() or var_29_0 >= HeroConst.HERO_TRUST_LV_MAX then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, arg_29_0), 0)

		return
	end

	if var_29_0 == 0 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, arg_29_0), 1)

		return
	end

	if var_29_1 >= HeroTrustLevelCfg[var_29_0].exp then
		local var_29_4 = HeroTrustCfg.get_id_list_by_hero_id[arg_29_0]

		for iter_29_0, iter_29_1 in ipairs(var_29_4) do
			local var_29_5 = HeroTrustCfg[iter_29_1]

			if var_29_0 == var_29_5.trust_level then
				local var_29_6 = true

				for iter_29_2, iter_29_3 in ipairs(var_29_5.condition_list) do
					if not IsConditionAchieved(iter_29_3, {
						heroId = arg_29_0
					}) then
						var_29_6 = false

						break
					end
				end

				if var_29_6 then
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

	local var_30_0 = ComboSkillTools.GetHeroComboSkill(arg_30_0)

	for iter_30_0, iter_30_1 in ipairs(var_30_0) do
		local var_30_1 = ComboSkillTools.GetMaxComboSkillLevel(iter_30_1)
		local var_30_2 = ComboSkillData:GetCurComboSkillLevel(iter_30_1)

		if var_30_2 < var_30_1 then
			local var_30_3 = ComboSkillLevelCfg.get_id_list_by_level[var_30_2]
			local var_30_4 = true

			for iter_30_2, iter_30_3 in ipairs(var_30_3) do
				if not ComboSkillTools.CheckComboSkillUpContion(iter_30_3, iter_30_1) then
					var_30_4 = false

					break
				end
			end

			if var_30_4 then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_RELATION_COMBO_SKILL, arg_30_0), 1)

				return
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_RELATION_COMBO_SKILL, arg_30_0), 0)
end

return var_0_0
