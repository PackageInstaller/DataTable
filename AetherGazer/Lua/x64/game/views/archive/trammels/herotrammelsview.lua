local var_0_0 = class("HeroTrammelsView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_coop/HeroCoopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.select_net = 1
	arg_4_0.comboId = 1
	arg_4_0.threeTeamskillController = ControllerUtil.GetController(arg_4_0.transform_, "threeTeamskill")
	arg_4_0.pageController = ControllerUtil.GetController(arg_4_0.transform_, "page")
	arg_4_0.storyController = ControllerUtil.GetController(arg_4_0.transform_, "story")
	arg_4_0.showComboController = ControllerUtil.GetController(arg_4_0.transform_, "showCombo")
	arg_4_0.lvupController = ControllerUtil.GetController(arg_4_0.m_comboInfoTrans, "lvup")
	arg_4_0.comboMaxLvController = ControllerUtil.GetController(arg_4_0.m_comboInfoTrans, "comboMaxLv")
	arg_4_0.attrList = LuaList.New(handler(arg_4_0, arg_4_0.IndexAttrItem), arg_4_0.m_attrList, HeroTrammelsAttrItem)
	arg_4_0.netMissionList = LuaList.New(handler(arg_4_0, arg_4_0.IndexNetMissionItem), arg_4_0.m_netMissionList, HeroTrammelsNetMissionItem)
	arg_4_0.netPartnerList = LuaList.New(handler(arg_4_0, arg_4_0.IndexNetPartnerItem), arg_4_0.m_netPartnerList, HeroTrammelsNetPartnerItem)
	arg_4_0.comboMissionList = LuaList.New(handler(arg_4_0, arg_4_0.IndexComboMissionItem), arg_4_0.m_comboMissionList, HeroTrammelsComboMissionItem)

	local var_4_0 = handler(arg_4_0, arg_4_0.SwitchNetClick)

	arg_4_0.switchNetItems = {}

	for iter_4_0 = 1, 5 do
		local var_4_1 = Object.Instantiate(arg_4_0.m_netSwitchGo, arg_4_0.m_netSwitchContent)
		local var_4_2 = HeroTrammelsSwitchNetItem.New(var_4_1, iter_4_0)

		var_4_2:RegistCallBack(var_4_0)
		table.insert(arg_4_0.switchNetItems, var_4_2)
	end

	arg_4_0.comboClickHanle = handler(arg_4_0, arg_4_0.ComboClick)
	arg_4_0.comboItems = {}
	arg_4_0.partnerClickHandle = handler(arg_4_0, arg_4_0.PartnerClick)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_netBtn, function()
		arg_5_0.pageController:SetSelectedIndex(0)
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_comboBtn, function()
		arg_5_0.pageController:SetSelectedIndex(1)
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_storyBtn, function()
		manager.story:StartStoryById(arg_5_0.storyId, function(arg_9_0)
			if not ArchiveData:GetRelationStoryRead(arg_5_0.relationId) then
				ArchiveAction.QueryRelationStoryReward(arg_5_0.relationId)
			end
		end)
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_coopBtn, function()
		local var_10_0 = ComboSkillTools.GetHeroComboSkill(arg_5_0.heroId)
		local var_10_1 = arg_5_0:GetComboSkillId(arg_5_0.heroId, arg_5_0.targetId)

		if table.indexof(var_10_0, var_10_1) then
			arg_5_0.comboId = var_10_1
		end

		arg_5_0:RefreshCombo()
		arg_5_0.pageController:SetSelectedIndex(1)
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_comboUpLevelBtn, function()
		if arg_5_0.comboId == 0 then
			return
		end

		local var_11_0 = ComboSkillTools.GetMaxComboSkillLevel(arg_5_0.comboId)
		local var_11_1 = ComboSkillData:GetCurComboSkillLevel(arg_5_0.comboId)

		if var_11_1 < var_11_0 then
			local var_11_2 = ComboSkillLevelCfg.get_id_list_by_level[var_11_1]
			local var_11_3 = true

			for iter_11_0, iter_11_1 in ipairs(var_11_2) do
				if not ComboSkillTools.CheckComboSkillUpContion(iter_11_1, arg_5_0.comboId) then
					var_11_3 = false

					break
				end
			end

			if var_11_3 then
				ComboSkillAction.QueryUpgradeComboSkillLevel(arg_5_0.comboId)
			else
				ShowTips("HERO_COMBO_SKILL_LEVEL_UP_FAIL")
			end
		end
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_targetHeroBtn, function()
		JumpTools.OpenPageByJump("/newHero", {
			isEnter = true,
			hid = arg_5_0.targetId
		}, ViewConst.SYSTEM_ID.PLAYER_INFO)
	end)
end

function var_0_0.OnTop(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_14_0)
	HeroTools.SetHeroNewTagRed(arg_14_0.params_.heroId, "unlockRelation", table.concat({
		RedPointConst.HERO_REALTION,
		"_",
		arg_14_0.params_.heroId
	}), false)

	arg_14_0.heroId = arg_14_0.params_.heroId
	arg_14_0.comboId = 0

	local var_14_0 = HeroCfg[arg_14_0.heroId]

	arg_14_0.m_heroName.text = var_14_0.name
	arg_14_0.m_heroIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_14_0.heroId)

	local var_14_1 = ArchiveData:GetTrustLevel(arg_14_0.heroId)

	if arg_14_0.select_net == nil then
		arg_14_0.select_net = 1
	else
		arg_14_0.select_net = math.min(var_14_1, arg_14_0.select_net)
	end

	local var_14_2 = HeroRelationNetCfg.get_id_list_by_hero_id[arg_14_0.heroId][arg_14_0.select_net]

	arg_14_0.targetId = HeroRelationNetCfg[var_14_2].intimate[1]

	arg_14_0.pageController:SetSelectedIndex(0)

	if arg_14_0.params_.page then
		arg_14_0.pageController:SetSelectedIndex(arg_14_0.params_.page)

		arg_14_0.params_.page = nil
	end

	if arg_14_0.params_.comboId then
		arg_14_0.comboId = arg_14_0.params_.comboId
		arg_14_0.params_.comboId = nil
	end

	arg_14_0:RefreshAttr()
	arg_14_0:Refresh()
	arg_14_0:RefreshRedPoint()
	manager.redPoint:bindUIandKey(arg_14_0.m_comboBtn.transform, string.format("%s_%s", RedPointConst.HERO_RELATION_COMBO_SKILL, arg_14_0.heroId))
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(arg_15_0.m_comboBtn.transform)
end

function var_0_0.RefreshAttr(arg_16_0)
	local var_16_0 = HeroData:GetHeroData(arg_16_0.heroId).relation
	local var_16_1
	local var_16_2

	var_16_2, arg_16_0.relationAttrData = var_16_0:GetRelationNetAttr()

	table.sort(arg_16_0.relationAttrData, function(arg_17_0, arg_17_1)
		return arg_17_0[1] < arg_17_1[1]
	end)
	arg_16_0.attrList:StartScroll(#arg_16_0.relationAttrData)
end

function var_0_0.Refresh(arg_18_0)
	local var_18_0 = HeroCfg[arg_18_0.targetId]

	arg_18_0.m_targetHeroName.text = var_18_0.name
	arg_18_0.m_targetHeroIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_18_0.targetId)

	local var_18_1 = ArchiveTools.GetRelationConfig(arg_18_0.heroId, arg_18_0.targetId)

	arg_18_0.m_relationLab.text = var_18_1 and var_18_1.relation_des or ""

	if var_18_1 and var_18_1.story_id ~= 0 and IsConditionAchieved(var_18_1.story_condtion_id, {
		heroId = arg_18_0.heroId
	}) then
		arg_18_0.storyId = var_18_1.story_id
		arg_18_0.relationId = var_18_1.id

		arg_18_0.storyController:SetSelectedIndex(1)

		if not ArchiveData:GetRelationStoryRead(var_18_1.id) then
			manager.redPoint:SetRedPointIndependent(arg_18_0.m_storyBtn.transform, true)
		else
			manager.redPoint:SetRedPointIndependent(arg_18_0.m_storyBtn.transform, false)
		end
	else
		arg_18_0.storyController:SetSelectedIndex(0)
	end

	arg_18_0:RefreshNet()

	local var_18_2 = arg_18_0:GetComboSkillId(arg_18_0.heroId, arg_18_0.targetId)

	if var_18_2 ~= 0 then
		local var_18_3 = ComboSkillData:GetCurComboSkillLevel(var_18_2)

		arg_18_0.m_skillLevel.text = GetTips("LEVEL") .. var_18_3

		local var_18_4 = ComboSkillCfg[var_18_2]

		if #var_18_4.cooperate_role_ids == 3 then
			arg_18_0.threeTeamskillController:SetSelectedIndex(1)

			for iter_18_0, iter_18_1 in ipairs(var_18_4.cooperate_role_ids) do
				if iter_18_1 ~= arg_18_0.heroId and iter_18_1 ~= arg_18_0.targetId then
					arg_18_0.m_thirdHeroIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. iter_18_1)

					break
				end
			end
		else
			arg_18_0.threeTeamskillController:SetSelectedIndex(0)
		end

		arg_18_0.showComboController:SetSelectedIndex(1)
	else
		arg_18_0.showComboController:SetSelectedIndex(0)
	end

	local var_18_5 = ComboSkillTools.GetHeroComboSkill(arg_18_0.heroId)
	local var_18_6 = #var_18_5

	if var_18_6 == 0 then
		arg_18_0.pageController:SetSelectedIndex(0)
	else
		for iter_18_2 = 1, var_18_6 do
			if not arg_18_0.comboItems[iter_18_2] then
				local var_18_7 = Object.Instantiate(arg_18_0.m_comboSkillItem, arg_18_0.m_comboSkillContent)
				local var_18_8 = HeroTrammelsComboItem.New(var_18_7, iter_18_2)

				var_18_8:RegistCallBack(arg_18_0.comboClickHanle)

				arg_18_0.comboItems[iter_18_2] = var_18_8
			end

			arg_18_0.comboItems[iter_18_2]:SetActive(true)

			local var_18_9 = var_18_5[iter_18_2]

			arg_18_0.comboItems[iter_18_2]:SetData(var_18_9)
		end

		for iter_18_3 = var_18_6 + 1, #arg_18_0.comboItems do
			arg_18_0.comboItems[iter_18_3]:SetActive(false)
		end

		arg_18_0:RefreshCombo()
	end
end

function var_0_0.RefreshRedPoint(arg_19_0)
	local var_19_0 = ArchiveData:GetTrustLevel(arg_19_0.heroId)

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.switchNetItems) do
		local var_19_1 = HeroRelationNetCfg.get_id_list_by_hero_id[arg_19_0.heroId][iter_19_0]

		if iter_19_0 <= var_19_0 and var_19_1 then
			local var_19_2 = HeroRelationNetCfg[var_19_1]
			local var_19_3 = false

			for iter_19_2, iter_19_3 in ipairs(var_19_2.intimate) do
				local var_19_4 = ArchiveTools.GetRelationConfig(arg_19_0.heroId, iter_19_3)

				if var_19_4 and var_19_4.story_id ~= 0 and not ArchiveData:GetRelationStoryRead(var_19_4.id) and IsConditionAchieved(var_19_4.story_condtion_id, {
					heroId = arg_19_0.heroId
				}) then
					var_19_3 = true

					break
				end
			end

			if not var_19_3 then
				local var_19_5 = HeroData:GetHeroData(arg_19_0.heroId)
				local var_19_6 = HeroRelationNetCfg.get_id_list_by_hero_id[arg_19_0.heroId] or {}

				for iter_19_4, iter_19_5 in ipairs(var_19_6) do
					local var_19_7 = HeroRelationNetCfg[iter_19_5]

					if var_19_7.index == iter_19_0 then
						for iter_19_6, iter_19_7 in ipairs(var_19_7.relation_upgrade_group) do
							local var_19_8 = HeroRelationUpgradeCfg[iter_19_7]

							if not var_19_5.relation:GetIsUnlock(var_19_7.index, iter_19_6) and ArchiveTools.CheckRelationUpgradeCondition(var_19_8.condition_id, var_19_7.intimate) then
								var_19_3 = true

								break
							end
						end
					end
				end
			end

			manager.redPoint:SetRedPointIndependent(iter_19_1.transform_, var_19_3)
		else
			manager.redPoint:SetRedPointIndependent(iter_19_1.transform_, false)
		end
	end
end

function var_0_0.RefreshNet(arg_20_0)
	local var_20_0 = ArchiveData:GetTrustLevel(arg_20_0.heroId)

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.switchNetItems) do
		local var_20_1 = 1

		if iter_20_0 == arg_20_0.select_net then
			var_20_1 = 2
		elseif var_20_0 < iter_20_0 then
			var_20_1 = 0
		end

		iter_20_1:SetData(var_20_1)
	end

	arg_20_0.m_indexLab.text = "0" .. arg_20_0.select_net

	local var_20_2 = HeroRelationNetCfg.get_id_list_by_hero_id[arg_20_0.heroId][arg_20_0.select_net]

	if var_20_2 then
		local var_20_3 = HeroRelationNetCfg[var_20_2]

		arg_20_0.netMissionData = var_20_3.relation_upgrade_group
		arg_20_0.netPartnerData = var_20_3.intimate

		arg_20_0.netMissionList:StartScroll(#arg_20_0.netMissionData)
		arg_20_0.netPartnerList:StartScroll(#arg_20_0.netPartnerData)
	else
		arg_20_0.netMissionList:StartScroll(0)
		arg_20_0.netPartnerList:StartScroll(0)
	end
end

function var_0_0.RefreshCombo(arg_21_0)
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.comboItems) do
		iter_21_1:RefreshState(arg_21_0.comboId)

		if arg_21_0.comboId == iter_21_1:GetComboId() then
			var_21_0 = iter_21_0
		end
	end

	if arg_21_0.comboId == 0 then
		SetActive(arg_21_0.m_comboSkillInfoGo, false)
	else
		SetActive(arg_21_0.m_comboSkillInfoGo, true)

		local var_21_1 = ComboSkillTools.GetMaxComboSkillLevel(arg_21_0.comboId)
		local var_21_2 = ComboSkillData:GetCurComboSkillLevel(arg_21_0.comboId)
		local var_21_3 = ComboSkillCfg[arg_21_0.comboId]
		local var_21_4 = HeroSkillCfg[var_21_3.skill_id]

		arg_21_0.m_comboDes.text = GetCfgDescription(var_21_4.desc[1], var_21_2, 2, var_21_3.maxLevel)

		if var_21_2 < var_21_1 then
			arg_21_0.comboMissionData = ComboSkillLevelCfg.get_id_list_by_level[var_21_2]

			arg_21_0.comboMissionList:StartScroll(#arg_21_0.comboMissionData)
			arg_21_0.comboMaxLvController:SetSelectedIndex(1)
			arg_21_0.lvupController:SetSelectedIndex(1)

			arg_21_0.m_comboUpLevelDes.text = GetTipsF("HERO_COMBO_SKILL_LEVEL_UP_BUTTON_LAB", "")
		else
			arg_21_0.comboMaxLvController:SetSelectedIndex(0)
			arg_21_0.lvupController:SetSelectedIndex(0)
		end

		arg_21_0.m_comboSkillInfoGo.transform:SetSiblingIndex(var_21_0 + 1)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_0.m_comboSkillContent)
end

function var_0_0.Dispose(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.switchNetItems) do
		iter_22_1:Dispose()
	end

	arg_22_0.switchNetItems = {}

	for iter_22_2, iter_22_3 in ipairs(arg_22_0.comboItems) do
		iter_22_3:Dispose()
	end

	arg_22_0.comboItems = {}

	arg_22_0.attrList:Dispose()
	arg_22_0.netMissionList:Dispose()
	arg_22_0.netPartnerList:Dispose()
	arg_22_0.comboMissionList:Dispose()
	var_0_0.super.Dispose(arg_22_0)
end

function var_0_0.SwitchNetClick(arg_23_0, arg_23_1)
	if arg_23_1 == arg_23_0.select_net then
		return
	end

	if arg_23_1 > ArchiveData:GetTrustLevel(arg_23_0.heroId) then
		ShowTips(GetTipsF("HERO_RELATION_UNLOCK_TRUST_LV", ArchiveTools.GetTrustLvDes(arg_23_1)))

		return
	end

	arg_23_0.select_net = arg_23_1

	arg_23_0:RefreshNet()
end

function var_0_0.PartnerClick(arg_24_0, arg_24_1)
	if arg_24_1 == arg_24_0.targetId then
		return
	end

	arg_24_0.targetId = arg_24_1

	arg_24_0:Refresh()
end

function var_0_0.ComboClick(arg_25_0, arg_25_1)
	if arg_25_1 == arg_25_0.comboId then
		arg_25_0.comboId = 0
	else
		arg_25_0.comboId = arg_25_1
	end

	arg_25_0:RefreshCombo()
end

function var_0_0.GetComboSkillId(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = ComboSkillTools.GetHeroComboSkill(arg_26_1) or {}

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		local var_26_1 = ComboSkillCfg[iter_26_1]

		if table.keyof(var_26_1.cooperate_role_ids, arg_26_2) then
			return iter_26_1
		end
	end

	return 0
end

function var_0_0.IndexAttrItem(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0.relationAttrData[arg_27_1]

	arg_27_2:SetData(var_27_0)
end

function var_0_0.IndexNetMissionItem(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0.netMissionData[arg_28_1]

	arg_28_2:SetData(var_28_0, arg_28_0.select_net, arg_28_1, arg_28_0.heroId, arg_28_0.netPartnerData)
end

function var_0_0.IndexNetPartnerItem(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0.netPartnerData[arg_29_1]

	arg_29_2:SetData(var_29_0, arg_29_0.targetId, arg_29_0.heroId)
	arg_29_2:RegistCallBack(arg_29_0.partnerClickHandle)
end

function var_0_0.IndexComboMissionItem(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0.comboMissionData[arg_30_1]

	arg_30_2:SetData(var_30_0, arg_30_0.comboId)
end

function var_0_0.OnHeroRelationNetUnlock(arg_31_0)
	arg_31_0.netMissionList:Refresh()
	arg_31_0:RefreshAttr()
	arg_31_0:RefreshRedPoint()
end

function var_0_0.OnHeroComboSkillLevelUp(arg_32_0)
	arg_32_0:Refresh()
	ArchiveAction.CheckComboSkillRedPoint(arg_32_0.heroId)
end

function var_0_0.OnHeroRelationStoryReward(arg_33_0)
	manager.redPoint:SetRedPointIndependent(arg_33_0.m_storyBtn.transform, false)
	arg_33_0:RefreshRedPoint()
	arg_33_0.netPartnerList:Refresh()
end

return var_0_0
