local CultureGravureView = class("CultureGravureView", ReduxView)

function CultureGravureView:UIName()
	return "Widget/System/Hero/HeroCultureGravureUI"
end

function CultureGravureView:UIParent()
	return manager.ui.uiMain.transform
end

function CultureGravureView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CultureGravureView:InitUI()
	self:BindCfgUI()

	self.roleImg_.immediate = true
	self.stateController_ = ControllerUtil.GetController(self.gameObject_.transform, "state")
	self.teachController_ = ControllerUtil.GetController(self.gameObject_.transform, "teach")
	self.tabController_ = {}
	self.titelBtnList_ = {}

	for iter_4_0 = 1, 6 do
		self.tabController_[iter_4_0] = ControllerUtil.GetController(self["tab_" .. iter_4_0], "name")
		self.titelBtnList_[iter_4_0] = self["titleBtn_" .. iter_4_0]
	end

	self.arrowController_ = self.arrowCon_:GetController("arrow1")
	self.btnController_ = self.recommendCon_:GetController("name")
	self.clickPopHandler = handler(self, self.PopInfo)
	self.equiptList_ = LuaList.New(handler(self, self.IndexEquiptItem), self.equiptListGo_, CultureGravureEquiptItem)
	self.servantList_ = LuaList.New(handler(self, self.IndexServantItem), self.servanListGo_, CultureGravureServantItem)
	self.astroList_ = LuaList.New(handler(self, self.IndexAstroItem), self.astroListGo_, CultureGravureAstroItem)
	self.teamRecommendList_ = {}
	self.transitionList_ = LuaList.New(handler(self, self.IndexTransitionItem), self.transitionListGo_, CultureGravureTransitionItem)
	self.equipSkillList_ = LuaList.New(handler(self, self.IndexEquipSkillItem), self.equipSkillListGo_, CultureGravureEquipSkillItem)

	if _G.CHANNEL_MASTER_ID == 1 or _G.CHANNEL_MASTER_ID == 1 or _G.CHANNEL_MASTER_ID == 15 then
		SetActive(self.forumBtn_.gameObject, true)
	else
		SetActive(self.forumBtn_.gameObject, false)
	end
end

function CultureGravureView:AddUIListener()
	self:AddBtnListener(self.recommendBtn_, nil, function()
		self.recommendType_ = self.recommendType_ == 1 and 2 or 1

		if self.recommendType_ == 1 then
			self.equiptDataList_ = CultureGravureData:GetCommonEquiptListByID(self.heroID_)
			self.recommendText_.text = GetTips("OMEGA_RECOMMEND")
		else
			self.equiptDataList_ = CultureGravureData:GetOmegaEquiptListByID(self.heroID_)
			self.recommendText_.text = GetTips("EQUIP_RECOMMEND")
		end

		self.btnController_:SetSelectedState(self.recommendType_)
		self.equiptList_:StartScroll(#self.equiptDataList_)
	end)

	for iter_5_0, iter_5_1 in ipairs(self.titelBtnList_) do
		self:AddBtnListener(iter_5_1, nil, function()
			self:ClickToggle(iter_5_0)
		end)
	end

	self:AddBtnListener(self.mask_, nil, function()
		SetActive(self.popInfoParentGo_, false)
	end)
	self:AddBtnListener(self.teachingBtn_, nil, function()
		if not manager.assetPend:CheckAssetPend("assetpend_common_daily_challenge") then
			manager.assetPend:ShowAssetPendMessageBox("assetpend_common_daily_challenge")

			return
		end

		OperationRecorder.RecordButtonTouch("hero_teach_stage")
		HeroData:SetHeroStrategyRedPoint(self.heroID_)
		BattleTeachData:SetCacheTeachHeroID(self.heroID_)

		if HeroCfg[self.heroID_] and HeroCfg[self.heroID_].study_stage and HeroCfg[self.heroID_].study_stage[1] then
			JumpTools.OpenPageByJump("/teachStage", {
				switchType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
				heroID = self.heroID_
			})
			JumpTools.OpenPageByJump("teachSectionInfo", {
				sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
				section = HeroCfg[self.heroID_].study_stage[1]
			})
		end
	end)
	self:AddBtnListener(self.forumBtn_, nil, function()
		if _G.ChannelLoginInfo and _G.ChannelLoginInfo.channelToken then
			local var_10_0 = {
				userId = PlayerData:GetPlayerInfo().userID,
				signUserId = PlayerData:GetPlayerInfo().signUserId,
				gameAppId = _G.ChannelLoginInfo.channelAppId,
				token = _G.ChannelLoginInfo.channelToken
			}

			if HeroCfg[self.heroID_] ~= nil then
				local var_10_1 = string.format("%s·%s", GetI18NText(HeroCfg[self.heroID_].name), GetI18NText(HeroCfg[self.heroID_].suffix))
				local var_10_2 = SettingData:GetCurrentLanguage()

				if var_10_2 == "fr" or var_10_2 == "de" then
					var_10_0.heroName = string.format("%s-%s", GetI18NText(HeroCfg[self.heroID_].name), GetI18NText(HeroCfg[self.heroID_].suffix))
				end
			end

			OperationAction.OpenOperationUrl("FORUM_URL_HERO", var_10_0)
		end
	end)
	self.tabScroll_.onValueChanged:AddListener(function(arg_11_0)
		self.arrowController_:SetSelectedState(arg_11_0.x >= 1 and "hide" or "show")
	end)
end

function CultureGravureView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function CultureGravureView:OnEnter()
	self.heroID_ = self.params_.heroID

	if self.params_.selectIndex then
		self.selectedListIndex_ = self.params_.selectIndex
		self.params_.selectIndex = nil
	else
		self.selectedListIndex_ = CultureGravureData:GetLastTabIndex()
	end

	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "CULTUREGRAVURE_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("FUNCTION_DESC"),
			content = GetTips("CULTUREGRAVURE_DESC")
		})
	end)

	self.heroProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	self.recommendType_ = self.recommendType_ or 1

	self:RefreshUI()
	manager.heroRaiseTrack:RefreshAstrolableState(AstrolabeConst.AnimationState.Commended)
	self:RegistEventListener(HERO_TRANSITION_CHANGE, handler(self, self.OnTransitionEquip))
end

function CultureGravureView:RefreshUI()
	self.nameText_.text = HeroCfg[self.heroID_].name
	self.suffixText_.text = HeroCfg[self.heroID_].suffix
	self.roleImg_.spriteSync = "TextureConfig/Character/Portrait/" .. self.heroID_
	self.raceImg_.sprite = getSprite("Atlas/SystemGroupAtlas", string.format("com_white_icon_group_%s_c", HeroCfg[self.heroID_].race))
	self.rareImg_.sprite = getSprite("Atlas/SystemHeroGradeAtlas", "star_" .. HeroCfg[self.heroID_].rare)

	self.teachController_:SetSelectedState(tostring(HeroData:GetHeroStrategyRedPoint(self.heroID_)))
	self:RefreshList(self.selectedListIndex_)

	self.typeImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(self.heroID_)

	self:RefreshChargeType()
	self:RefreshRangeType()
	SetActive(self.astroBtn, not HeroTools.IsSpHero(self.heroID_))
end

function CultureGravureView:ClickToggle(arg_16_1)
	if arg_16_1 == self.selectedListIndex_ then
		return
	end

	if arg_16_1 == 1 then
		OperationRecorder.RecordButtonTouch("hero_teach_page_equip")
	elseif arg_16_1 == 2 then
		OperationRecorder.RecordButtonTouch("hero_teach_page_weapon")
	elseif arg_16_1 == 3 then
		OperationRecorder.RecordButtonTouch("hero_teach_page_astrolabe")
	elseif arg_16_1 == 4 then
		OperationRecorder.RecordButtonTouch("hero_teach_page_equipskill")
	elseif arg_16_1 == 5 then
		OperationRecorder.RecordButtonTouch("hero_teach_page_equipenchant")
	elseif arg_16_1 == 6 then
		OperationRecorder.RecordButtonTouch("hero_teach_page_team")
	end

	self:RefreshList(arg_16_1)
end

function CultureGravureView:RefreshList(arg_17_1)
	if arg_17_1 == 1 then
		PlayerAction.CheckRecommendEquip(self.heroID_)
	end

	self.stateController_:SetSelectedState(arg_17_1)

	for iter_17_0 = 1, 6 do
		self.tabController_[iter_17_0]:SetSelectedState(tostring(iter_17_0 == arg_17_1))
	end

	if arg_17_1 == 1 then
		self.btnController_:SetSelectedState(self.recommendType_)

		self.recommendText_.text = self.recommendType_ == 1 and GetTips("OMEGA_RECOMMEND") or GetTips("EQUIP_RECOMMEND")
		self.equiptDataList_ = self.recommendType_ == 2 and CultureGravureData:GetOmegaEquiptListByID(self.heroID_) or CultureGravureData:GetCommonEquiptListByID(self.heroID_)

		self.equiptList_:StartScroll(#self.equiptDataList_)
		self.stateController_:SetSelectedState(1)
	elseif arg_17_1 == 2 then
		self.servantDataList_ = CultureGravureData:GetServantListByID(self.heroID_)

		self.servantList_:StartScroll(#self.servantDataList_)
	elseif arg_17_1 == 3 then
		self.astroDataList_ = deepClone(CultureGravureData:GetAstroListByID(self.heroID_))

		self.astroList_:StartScroll(#self.astroDataList_)
	elseif arg_17_1 == 4 then
		self.teamDataList_ = CultureGravureData:GetTeamListByID(self.heroID_)

		self:RefreshTeamRecommend()
	elseif arg_17_1 == 5 then
		self.transitionDataList_ = CultureGravureData:GetTransitionListByID(self.heroID_)
		self.transitionInfoList = {}

		for iter_17_1, iter_17_2 in pairs(self.heroProxy_:GetHeroTransitionInfoList(self.heroID_)) do
			self.transitionInfoList[iter_17_2.slot_id] = iter_17_2
		end

		self.transitionList_:StartScroll(#self.transitionDataList_)
	elseif arg_17_1 == 6 then
		self.equipSkillDataList_ = CultureGravureData:GetEquipSkillListByID(self.heroID_)

		self.equipSkillList_:StartScroll(#self.equipSkillDataList_)
	end

	self.selectedListIndex_ = arg_17_1

	SetActive(self.descTextGo_, self.selectedListIndex_ ~= 2)

	self.showPopInfo_ = false
end

function CultureGravureView:IndexEquiptItem(arg_18_1, arg_18_2)
	arg_18_2:SetData(arg_18_1, self.equiptDataList_[arg_18_1], self.heroID_)
end

function CultureGravureView:IndexServantItem(arg_19_1, arg_19_2)
	arg_19_2:SetData(arg_19_1, self.servantDataList_[arg_19_1], self.heroID_)

	if arg_19_1 == 1 then
		arg_19_2:SetRecommendController(2)
	end
end

function CultureGravureView:IndexAstroItem(arg_20_1, arg_20_2)
	arg_20_2:SetClickCallBack(self.clickPopHandler)
	arg_20_2:SetData(arg_20_1, self.astroDataList_[arg_20_1], self.heroID_)
end

function CultureGravureView:IndexTransitionItem(arg_21_1, arg_21_2)
	arg_21_2:SetClickCallBack(self.clickPopHandler)
	arg_21_2:SetData(self.transitionDataList_[arg_21_1], arg_21_1, self.transitionInfoList[arg_21_1], self.heroID_)
end

function CultureGravureView:IndexEquipSkillItem(arg_22_1, arg_22_2)
	arg_22_2:SetData(self.equipSkillDataList_[arg_22_1])
end

function CultureGravureView:OnTransitionEquip(arg_23_1, arg_23_2)
	self.transitionDataList_ = CultureGravureData:GetTransitionListByID(self.heroID_)

	self.transitionList_:StartScrollByPosition(#self.transitionDataList_, self.transitionList_:GetScrolledPosition())

	if arg_23_2 then
		ShowTips(GetTips("EXCLUSIVE_SKILL_LOAD"))
	end
end

function CultureGravureView:OnEquipSwap(arg_24_1, arg_24_2)
	self.equiptList_:StartScroll(#self.equiptDataList_)
end

function CultureGravureView:OnEquipQuickDressOn(arg_25_1, arg_25_2)
	for iter_25_0 = 1, 6 do
		if arg_25_2.use_equip_list[iter_25_0] then
			HeroAction.HeroChangeEquip(arg_25_2.hero_id, arg_25_2.use_equip_list[iter_25_0].equip_id, arg_25_2.use_equip_list[iter_25_0].pos)
		end
	end

	self.equiptList_:StartScroll(#self.equiptDataList_)
	ShowTips("SUCCESS_EQUIP_PROPOSAL")
end

function CultureGravureView:OnServantReplace()
	ShowTips("SUCCESS_EQUIP_SERVANT")
	self.servantList_:StartScroll(#self.servantDataList_)
end

function CultureGravureView:RefreshRangeType()
	self.rangeTypeText_.text = CharactorParamCfg[self.heroID_].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
end

function CultureGravureView:RefreshChargeType()
	self.chargeType_.text = HeroTools.GetChargeTextByType(HeroCfg[self.heroID_].mechanism_type[1])
end

function CultureGravureView:OnAstrolabeEquip()
	ShowTips("ASTROLABE_BIND")
	self.astroList_:StartScroll(#self.astroDataList_)
end

function CultureGravureView:OnExit()
	manager.windowBar:HideBar()
	CultureGravureData:SetLastTabIndex(self.selectedListIndex_)

	self.roleImg_.spriteSync = nil

	SetActive(self.popInfoParentGo_, false)

	self.showPopInfo_ = false

	manager.redPoint:unbindUIandKey(self.teachingBtn_.transform)

	self.tabScroll_.horizontalNormalizedPosition = 0

	self:RemoveAllEventListener()
end

function CultureGravureView:Dispose()
	if self.astroList_ then
		self.astroList_:Dispose()
	end

	if self.servantList_ then
		self.servantList_:Dispose()
	end

	if self.equiptList_ then
		self.equiptList_:Dispose()
	end

	if self.transitionList_ then
		self.transitionList_:Dispose()
	end

	if self.equipSkillList_ then
		self.equipSkillList_:Dispose()
	end

	if self.teamRecommendList_ then
		for iter_31_0, iter_31_1 in pairs(self.teamRecommendList_) do
			iter_31_1:Dispose()
		end

		self.teamRecommendList_ = nil
	end

	self:RemoveAllEventListener()
	CultureGravureView.super.Dispose(self)
end

function CultureGravureView:PopInfo(arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
	SetActive(self.popInfoParentGo_, true)

	self.showPopInfo_ = true
	self.popNameText_.text = GetI18NText(arg_32_1)
	self.popDescText_.text = GetI18NText(arg_32_2)

	local var_32_0 = self.textViewTrs_.gameObject:GetComponent(typeof(ContentSizeFitter))

	var_32_0.enabled = true

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.popDescText_.transform)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.textContentTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.textViewTrs_)

	local var_32_1 = self.textParentTrs_.gameObject:GetComponent(typeof(ScrollRect))

	if 700 < self.popDescText_.transform.sizeDelta.y then
		var_32_0.enabled = false
		var_32_1.enabled = true
		self.textViewTrs_.transform.sizeDelta = Vector2(self.textContentTrs_.sizeDelta.x, 700)
	else
		var_32_0.enabled = true
		var_32_1.enabled = false
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.textParentTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.popContentTrs_)

	local var_32_2 = self.middleTrs_:InverseTransformPoint(arg_32_3)
	local var_32_3 = self.popInfoParentTrs_:InverseTransformPoint((self.middleTrs_:TransformPoint((Vector3(var_32_2.x, var_32_2.y, 0)))))

	self.popInfoTrs_.localPosition = var_32_3

	local var_32_4 = self.popInfoParentTrs_:InverseTransformPoint((self.popBottomTrs_:TransformPoint(Vector3(0, 0, 0))))
	local var_32_5 = self.safePlaceTrs_.rect.height / 2
	local var_32_6 = self.popInfoParentTrs_:InverseTransformPoint(arg_32_4.position).x

	var_32_6 = arg_32_5 and var_32_6 + self.textParentTrs_.rect.width / 4 or var_32_6 - self.textParentTrs_.rect.width / 4
	self.popInfoTrs_.localPosition = Vector3(var_32_6, var_32_3.y + ((var_32_5 < -var_32_4.y or nil) and -var_32_4.y - var_32_5), var_32_3.z)
end

function CultureGravureView:RefreshTeamRecommend()
	for iter_33_0, iter_33_1 in ipairs(self.teamDataList_) do
		local var_33_0 = self.teamRecommendList_[iter_33_0]

		if not self.teamRecommendList_[iter_33_0] then
			var_33_0 = CultureGravureTeamItem.New((GameObject.Instantiate(self.teamItemGo_, self.teamContent_)))

			var_33_0:RegisterTeamClick(handler(self, self.OnClickTeamItem))
			var_33_0:SetEquipClickCallBack(self.clickPopHandler)

			self.teamRecommendList_[iter_33_0] = var_33_0
		end

		var_33_0:SetData(iter_33_1)
		SetActive(var_33_0.gameObject_, true)
	end

	for iter_33_2 = #self.teamDataList_ + 1, #self.teamRecommendList_ do
		SetActive(self.teamRecommendList_[iter_33_2].gameObject_, false)
	end
end

function CultureGravureView:OnClickTeamItem(arg_34_1)
	if self.showPopInfo_ and self.selectedTeamItem_ == arg_34_1 then
		self.showPopInfo_ = false

		return
	end

	if self.selectedTeamItem_ then
		if self.selectedTeamItem_ == arg_34_1 then
			self.selectedTeamItem_:IsShowDetail()

			return
		else
			self.selectedTeamItem_:IsShowDetail(false)
		end
	end

	self.selectedTeamItem_ = arg_34_1

	self.selectedTeamItem_:IsShowDetail(true)
end

return CultureGravureView
