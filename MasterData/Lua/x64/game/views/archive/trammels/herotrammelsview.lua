local HeroTrammelsView = class("HeroTrammelsView", ReduxView)

function HeroTrammelsView:UIName()
	return "Widget/System/Hero_coop/HeroCoopUI"
end

function HeroTrammelsView:UIParent()
	return manager.ui.uiMain.transform
end

function HeroTrammelsView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroTrammelsView:InitUI()
	self:BindCfgUI()

	self.select_net = 1
	self.comboId = 1
	self.threeTeamskillController = ControllerUtil.GetController(self.transform_, "threeTeamskill")
	self.pageController = ControllerUtil.GetController(self.transform_, "page")
	self.storyController = ControllerUtil.GetController(self.transform_, "story")
	self.showComboController = ControllerUtil.GetController(self.transform_, "showCombo")
	self.lvupController = ControllerUtil.GetController(self.m_comboInfoTrans, "lvup")
	self.comboMaxLvController = ControllerUtil.GetController(self.m_comboInfoTrans, "comboMaxLv")
	self.attrList = LuaList.New(handler(self, self.IndexAttrItem), self.m_attrList, HeroTrammelsAttrItem)
	self.netMissionList = LuaList.New(handler(self, self.IndexNetMissionItem), self.m_netMissionList, HeroTrammelsNetMissionItem)
	self.netPartnerList = LuaList.New(handler(self, self.IndexNetPartnerItem), self.m_netPartnerList, HeroTrammelsNetPartnerItem)
	self.comboMissionList = LuaList.New(handler(self, self.IndexComboMissionItem), self.m_comboMissionList, HeroTrammelsComboMissionItem)

	local var_4_0 = handler(self, self.SwitchNetClick)

	self.switchNetItems = {}

	for iter_4_0 = 1, 5 do
		local var_4_1 = HeroTrammelsSwitchNetItem.New(Object.Instantiate(self.m_netSwitchGo, self.m_netSwitchContent), iter_4_0)

		var_4_1:RegistCallBack(var_4_0)
		table.insert(self.switchNetItems, var_4_1)
	end

	self.comboClickHanle = handler(self, self.ComboClick)
	self.comboItems = {}
	self.partnerClickHandle = handler(self, self.PartnerClick)
end

function HeroTrammelsView:AddUIListener()
	self:AddBtnListener(nil, self.m_netBtn, function()
		self.pageController:SetSelectedIndex(0)
	end)
	self:AddBtnListener(nil, self.m_comboBtn, function()
		self.pageController:SetSelectedIndex(1)
	end)
	self:AddBtnListener(nil, self.m_storyBtn, function()
		manager.story:StartStoryById(self.storyId, function(arg_9_0)
			if not ArchiveData:GetRelationStoryRead(self.relationId) then
				ArchiveAction.QueryRelationStoryReward(self.relationId)
			end
		end)
	end)
	self:AddBtnListener(nil, self.m_coopBtn, function()
		local var_10_0 = self:GetComboSkillId(self.heroId, self.targetId)

		if table.indexof(ComboSkillTools.GetHeroComboSkill(self.heroId), var_10_0) then
			self.comboId = var_10_0
		end

		self:RefreshCombo()
		self.pageController:SetSelectedIndex(1)
	end)
	self:AddBtnListener(nil, self.m_comboUpLevelBtn, function()
		local var_11_0

		if self.comboId == 0 then
			do return end

			var_11_0 = ComboSkillData:GetCurComboSkillLevel(self.comboId)
		end

		if var_11_0 < ComboSkillTools.GetMaxComboSkillLevel(self.comboId) then
			local var_11_1 = true

			for iter_11_0, iter_11_1 in ipairs(ComboSkillLevelCfg.get_id_list_by_level[var_11_0]) do
				if not ComboSkillTools.CheckComboSkillUpContion(iter_11_1, self.comboId) then
					var_11_1 = false

					break
				end
			end

			if var_11_1 then
				ComboSkillAction.QueryUpgradeComboSkillLevel(self.comboId)
			else
				ShowTips("HERO_COMBO_SKILL_LEVEL_UP_FAIL")
			end
		end
	end)
	self:AddBtnListener(nil, self.m_targetHeroBtn, function()
		JumpTools.OpenPageByJump("/newHero", {
			isEnter = true,
			hid = self.targetId
		}, ViewConst.SYSTEM_ID.PLAYER_INFO)
	end)
end

function HeroTrammelsView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function HeroTrammelsView:OnEnter()
	HeroTools.SetHeroNewTagRed(self.params_.heroId, "unlockRelation", table.concat({
		RedPointConst.HERO_REALTION,
		"_",
		self.params_.heroId
	}), false)

	self.heroId = self.params_.heroId
	self.comboId = 0
	self.m_heroName.text = HeroCfg[self.heroId].name
	self.m_heroIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. self.heroId)
	self.select_net = self.select_net == nil and 1 or math.min(ArchiveData:GetTrustLevel(self.heroId), self.select_net)
	self.targetId = HeroRelationNetCfg[HeroRelationNetCfg.get_id_list_by_hero_id[self.heroId][self.select_net]].intimate[1]

	self.pageController:SetSelectedIndex(0)

	if self.params_.page then
		self.pageController:SetSelectedIndex(self.params_.page)

		self.params_.page = nil
	end

	if self.params_.comboId then
		self.comboId = self.params_.comboId
		self.params_.comboId = nil
	end

	self:RefreshAttr()
	self:Refresh()
	self:RefreshRedPoint()
	manager.redPoint:bindUIandKey(self.m_comboBtn.transform, string.format("%s_%s", RedPointConst.HERO_RELATION_COMBO_SKILL, self.heroId))
end

function HeroTrammelsView:OnExit()
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(self.m_comboBtn.transform)
end

function HeroTrammelsView:RefreshAttr()
	local var_16_1

	var_16_1, self.relationAttrData = HeroData:GetHeroData(self.heroId).relation:GetRelationNetAttr()

	table.sort(self.relationAttrData, function(arg_17_0, arg_17_1)
		return arg_17_0[1] < arg_17_1[1]
	end)
	self.attrList:StartScroll(#self.relationAttrData)
end

function HeroTrammelsView:Refresh()
	self.m_targetHeroName.text = HeroCfg[self.targetId].name
	self.m_targetHeroIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. self.targetId)

	local var_18_0 = ArchiveTools.GetRelationConfig(self.heroId, self.targetId)

	if var_18_0 then
		self.m_relationLab.text = var_18_0.relation_des or ""
	end

	if var_18_0 and var_18_0.story_id ~= 0 and IsConditionAchieved(var_18_0.story_condtion_id, {
		heroId = self.heroId
	}) then
		self.storyId = var_18_0.story_id
		self.relationId = var_18_0.id

		self.storyController:SetSelectedIndex(1)

		if not ArchiveData:GetRelationStoryRead(var_18_0.id) then
			manager.redPoint:SetRedPointIndependent(self.m_storyBtn.transform, true)
		else
			manager.redPoint:SetRedPointIndependent(self.m_storyBtn.transform, false)
		end
	else
		self.storyController:SetSelectedIndex(0)
	end

	self:RefreshNet()

	local var_18_1 = self:GetComboSkillId(self.heroId, self.targetId)

	if var_18_1 ~= 0 then
		self.m_skillLevel.text = GetTips("LEVEL") .. ComboSkillData:GetCurComboSkillLevel(var_18_1)

		if #ComboSkillCfg[var_18_1].cooperate_role_ids == 3 then
			self.threeTeamskillController:SetSelectedIndex(1)

			for iter_18_0, iter_18_1 in ipairs(ComboSkillCfg[var_18_1].cooperate_role_ids) do
				if iter_18_1 ~= self.heroId and iter_18_1 ~= self.targetId then
					self.m_thirdHeroIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. iter_18_1)

					break
				end
			end
		else
			self.threeTeamskillController:SetSelectedIndex(0)
		end

		self.showComboController:SetSelectedIndex(1)
	else
		self.showComboController:SetSelectedIndex(0)
	end

	local var_18_2 = ComboSkillTools.GetHeroComboSkill(self.heroId)

	if #var_18_2 == 0 then
		self.pageController:SetSelectedIndex(0)
	else
		for iter_18_2 = 1, #var_18_2 do
			if not self.comboItems[iter_18_2] then
				local var_18_3 = HeroTrammelsComboItem.New(Object.Instantiate(self.m_comboSkillItem, self.m_comboSkillContent), iter_18_2)

				var_18_3:RegistCallBack(self.comboClickHanle)

				self.comboItems[iter_18_2] = var_18_3
			end

			self.comboItems[iter_18_2]:SetActive(true)
			self.comboItems[iter_18_2]:SetData(var_18_2[iter_18_2])
		end

		for iter_18_3 = #var_18_2 + 1, #self.comboItems do
			self.comboItems[iter_18_3]:SetActive(false)
		end

		self:RefreshCombo()
	end
end

function HeroTrammelsView:RefreshRedPoint()
	local var_19_0 = ArchiveData:GetTrustLevel(self.heroId)

	for iter_19_0, iter_19_1 in ipairs(self.switchNetItems) do
		if iter_19_0 <= var_19_0 and HeroRelationNetCfg.get_id_list_by_hero_id[self.heroId][iter_19_0] then
			local var_19_1 = false

			for iter_19_2, iter_19_3 in ipairs(HeroRelationNetCfg[HeroRelationNetCfg.get_id_list_by_hero_id[self.heroId][iter_19_0]].intimate) do
				local var_19_2 = ArchiveTools.GetRelationConfig(self.heroId, iter_19_3)

				if var_19_2 and var_19_2.story_id ~= 0 and not ArchiveData:GetRelationStoryRead(var_19_2.id) and IsConditionAchieved(var_19_2.story_condtion_id, {
					heroId = self.heroId
				}) then
					var_19_1 = true

					break
				end
			end

			if not var_19_1 then
				local var_19_3 = HeroData:GetHeroData(self.heroId)

				for iter_19_4, iter_19_5 in ipairs(HeroRelationNetCfg.get_id_list_by_hero_id[self.heroId] or {}) do
					if HeroRelationNetCfg[iter_19_5].index == iter_19_0 then
						for iter_19_6, iter_19_7 in ipairs(HeroRelationNetCfg[iter_19_5].relation_upgrade_group) do
							if not var_19_3.relation:GetIsUnlock(HeroRelationNetCfg[iter_19_5].index, iter_19_6) and ArchiveTools.CheckRelationUpgradeCondition(HeroRelationUpgradeCfg[iter_19_7].condition_id, HeroRelationNetCfg[iter_19_5].intimate) then
								var_19_1 = true

								break
							end
						end
					end
				end
			end

			manager.redPoint:SetRedPointIndependent(iter_19_1.transform_, var_19_1)
		else
			manager.redPoint:SetRedPointIndependent(iter_19_1.transform_, false)
		end
	end
end

function HeroTrammelsView:RefreshNet()
	local var_20_0 = ArchiveData:GetTrustLevel(self.heroId)

	for iter_20_0, iter_20_1 in ipairs(self.switchNetItems) do
		local var_20_1 = 1

		if iter_20_0 == self.select_net then
			var_20_1 = 2
		elseif var_20_0 < iter_20_0 then
			var_20_1 = 0
		end

		iter_20_1:SetData(var_20_1)
	end

	self.m_indexLab.text = "0" .. self.select_net

	if HeroRelationNetCfg.get_id_list_by_hero_id[self.heroId][self.select_net] then
		self.netMissionData = HeroRelationNetCfg[HeroRelationNetCfg.get_id_list_by_hero_id[self.heroId][self.select_net]].relation_upgrade_group
		self.netPartnerData = HeroRelationNetCfg[HeroRelationNetCfg.get_id_list_by_hero_id[self.heroId][self.select_net]].intimate

		self.netMissionList:StartScroll(#self.netMissionData)
		self.netPartnerList:StartScroll(#self.netPartnerData)
	else
		self.netMissionList:StartScroll(0)
		self.netPartnerList:StartScroll(0)
	end
end

function HeroTrammelsView:RefreshCombo()
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in ipairs(self.comboItems) do
		iter_21_1:RefreshState(self.comboId)

		if self.comboId == iter_21_1:GetComboId() then
			var_21_0 = iter_21_0
		end
	end

	if self.comboId == 0 then
		SetActive(self.m_comboSkillInfoGo, false)
	else
		SetActive(self.m_comboSkillInfoGo, true)

		local var_21_1 = ComboSkillData:GetCurComboSkillLevel(self.comboId)

		self.m_comboDes.text = GetCfgDescription(HeroSkillCfg[ComboSkillCfg[self.comboId].skill_id].desc[1], var_21_1, 2, ComboSkillCfg[self.comboId].maxLevel)

		if var_21_1 < ComboSkillTools.GetMaxComboSkillLevel(self.comboId) then
			self.comboMissionData = ComboSkillLevelCfg.get_id_list_by_level[var_21_1]

			self.comboMissionList:StartScroll(#self.comboMissionData)
			self.comboMaxLvController:SetSelectedIndex(1)
			self.lvupController:SetSelectedIndex(1)

			self.m_comboUpLevelDes.text = GetTipsF("HERO_COMBO_SKILL_LEVEL_UP_BUTTON_LAB", "")
		else
			self.comboMaxLvController:SetSelectedIndex(0)
			self.lvupController:SetSelectedIndex(0)
		end

		self.m_comboSkillInfoGo.transform:SetSiblingIndex(var_21_0 + 1)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_comboSkillContent)
end

function HeroTrammelsView:Dispose()
	for iter_22_0, iter_22_1 in ipairs(self.switchNetItems) do
		iter_22_1:Dispose()
	end

	self.switchNetItems = {}

	for iter_22_2, iter_22_3 in ipairs(self.comboItems) do
		iter_22_3:Dispose()
	end

	self.comboItems = {}

	self.attrList:Dispose()
	self.netMissionList:Dispose()
	self.netPartnerList:Dispose()
	self.comboMissionList:Dispose()
	HeroTrammelsView.super.Dispose(self)
end

function HeroTrammelsView:SwitchNetClick(arg_23_1)
	if arg_23_1 == self.select_net then
		return
	end

	if arg_23_1 > ArchiveData:GetTrustLevel(self.heroId) then
		ShowTips(GetTipsF("HERO_RELATION_UNLOCK_TRUST_LV", ArchiveTools.GetTrustLvDes(arg_23_1)))

		return
	end

	self.select_net = arg_23_1

	self:RefreshNet()
end

function HeroTrammelsView:PartnerClick(arg_24_1)
	if arg_24_1 == self.targetId then
		return
	end

	self.targetId = arg_24_1

	self:Refresh()
end

function HeroTrammelsView:ComboClick(arg_25_1)
	self.comboId = arg_25_1 == self.comboId and 0 or arg_25_1

	self:RefreshCombo()
end

function HeroTrammelsView:GetComboSkillId(arg_26_1, arg_26_2)
	for iter_26_0, iter_26_1 in ipairs(ComboSkillTools.GetHeroComboSkill(arg_26_1) or {}) do
		if table.keyof(ComboSkillCfg[iter_26_1].cooperate_role_ids, arg_26_2) then
			return iter_26_1
		end
	end

	return 0
end

function HeroTrammelsView:IndexAttrItem(arg_27_1, arg_27_2)
	arg_27_2:SetData(self.relationAttrData[arg_27_1])
end

function HeroTrammelsView:IndexNetMissionItem(arg_28_1, arg_28_2)
	arg_28_2:SetData(self.netMissionData[arg_28_1], self.select_net, arg_28_1, self.heroId, self.netPartnerData)
end

function HeroTrammelsView:IndexNetPartnerItem(arg_29_1, arg_29_2)
	arg_29_2:SetData(self.netPartnerData[arg_29_1], self.targetId, self.heroId)
	arg_29_2:RegistCallBack(self.partnerClickHandle)
end

function HeroTrammelsView:IndexComboMissionItem(arg_30_1, arg_30_2)
	arg_30_2:SetData(self.comboMissionData[arg_30_1], self.comboId)
end

function HeroTrammelsView:OnHeroRelationNetUnlock()
	self.netMissionList:Refresh()
	self:RefreshAttr()
	self:RefreshRedPoint()
end

function HeroTrammelsView:OnHeroComboSkillLevelUp()
	self:Refresh()
	ArchiveAction.CheckComboSkillRedPoint(self.heroId)
end

function HeroTrammelsView:OnHeroRelationStoryReward()
	manager.redPoint:SetRedPointIndependent(self.m_storyBtn.transform, false)
	self:RefreshRedPoint()
	self.netPartnerList:Refresh()
end

return HeroTrammelsView
