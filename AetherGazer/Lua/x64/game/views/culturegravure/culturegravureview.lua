local var_0_0 = class("CultureGravureView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero/HeroCultureGravureUI"
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

	arg_4_0.roleImg_.immediate = true
	arg_4_0.stateController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "state")
	arg_4_0.teachController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "teach")
	arg_4_0.tabController_ = {}
	arg_4_0.titelBtnList_ = {}

	for iter_4_0 = 1, 6 do
		arg_4_0.tabController_[iter_4_0] = ControllerUtil.GetController(arg_4_0["tab_" .. iter_4_0], "name")
		arg_4_0.titelBtnList_[iter_4_0] = arg_4_0["titleBtn_" .. iter_4_0]
	end

	arg_4_0.arrowController_ = arg_4_0.arrowCon_:GetController("arrow1")
	arg_4_0.btnController_ = arg_4_0.recommendCon_:GetController("name")
	arg_4_0.clickPopHandler = handler(arg_4_0, arg_4_0.PopInfo)
	arg_4_0.equiptList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexEquiptItem), arg_4_0.equiptListGo_, CultureGravureEquiptItem)
	arg_4_0.servantList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexServantItem), arg_4_0.servanListGo_, CultureGravureServantItem)
	arg_4_0.astroList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexAstroItem), arg_4_0.astroListGo_, CultureGravureAstroItem)
	arg_4_0.teamRecommendList_ = {}
	arg_4_0.transitionList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexTransitionItem), arg_4_0.transitionListGo_, CultureGravureTransitionItem)
	arg_4_0.equipSkillList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexEquipSkillItem), arg_4_0.equipSkillListGo_, CultureGravureEquipSkillItem)

	if _G.CHANNEL_MASTER_ID == 1 or _G.CHANNEL_MASTER_ID == 1 or _G.CHANNEL_MASTER_ID == 15 then
		SetActive(arg_4_0.forumBtn_.gameObject, true)
	else
		SetActive(arg_4_0.forumBtn_.gameObject, false)
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.recommendBtn_, nil, function()
		arg_5_0.recommendType_ = arg_5_0.recommendType_ == 1 and 2 or 1

		if arg_5_0.recommendType_ == 1 then
			arg_5_0.equiptDataList_ = CultureGravureData:GetCommonEquiptListByID(arg_5_0.heroID_)
			arg_5_0.recommendText_.text = GetTips("OMEGA_RECOMMEND")
		else
			arg_5_0.equiptDataList_ = CultureGravureData:GetOmegaEquiptListByID(arg_5_0.heroID_)
			arg_5_0.recommendText_.text = GetTips("EQUIP_RECOMMEND")
		end

		arg_5_0.btnController_:SetSelectedState(arg_5_0.recommendType_)
		arg_5_0.equiptList_:StartScroll(#arg_5_0.equiptDataList_)
	end)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.titelBtnList_) do
		arg_5_0:AddBtnListener(iter_5_1, nil, function()
			arg_5_0:ClickToggle(iter_5_0)
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.mask_, nil, function()
		SetActive(arg_5_0.popInfoParentGo_, false)
	end)
	arg_5_0:AddBtnListener(arg_5_0.teachingBtn_, nil, function()
		local var_9_0 = "assetpend_common_daily_challenge"

		if not manager.assetPend:CheckAssetPend(var_9_0) then
			manager.assetPend:ShowAssetPendMessageBox(var_9_0)

			return
		end

		OperationRecorder.RecordButtonTouch("hero_teach_stage")
		HeroData:SetHeroStrategyRedPoint(arg_5_0.heroID_)

		local var_9_1 = HeroCfg[arg_5_0.heroID_]

		BattleTeachData:SetCacheTeachHeroID(arg_5_0.heroID_)

		if var_9_1 and var_9_1.study_stage and var_9_1.study_stage[1] then
			JumpTools.OpenPageByJump("/teachStage", {
				switchType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
				heroID = arg_5_0.heroID_
			})
			JumpTools.OpenPageByJump("teachSectionInfo", {
				sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
				section = var_9_1.study_stage[1]
			})
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.forumBtn_, nil, function()
		if _G.ChannelLoginInfo and _G.ChannelLoginInfo.channelToken then
			local var_10_0 = {
				userId = PlayerData:GetPlayerInfo().userID,
				signUserId = PlayerData:GetPlayerInfo().signUserId,
				gameAppId = _G.ChannelLoginInfo.channelAppId,
				token = _G.ChannelLoginInfo.channelToken
			}
			local var_10_1 = HeroCfg[arg_5_0.heroID_]

			if var_10_1 ~= nil then
				local var_10_2 = string.format("%s·%s", GetI18NText(var_10_1.name), GetI18NText(var_10_1.suffix))
				local var_10_3 = SettingData:GetCurrentLanguage()

				if var_10_3 == "fr" or var_10_3 == "de" then
					var_10_2 = string.format("%s-%s", GetI18NText(var_10_1.name), GetI18NText(var_10_1.suffix))
				end

				var_10_0.heroName = var_10_2
			end

			OperationAction.OpenOperationUrl("FORUM_URL_HERO", var_10_0)
		end
	end)
	arg_5_0.tabScroll_.onValueChanged:AddListener(function(arg_11_0)
		arg_5_0.arrowController_:SetSelectedState(arg_11_0.x >= 1 and "hide" or "show")
	end)
end

function var_0_0.OnTop(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.heroID_ = arg_13_0.params_.heroID

	if arg_13_0.params_.selectIndex then
		arg_13_0.selectedListIndex_ = arg_13_0.params_.selectIndex
		arg_13_0.params_.selectIndex = nil
	else
		arg_13_0.selectedListIndex_ = CultureGravureData:GetLastTabIndex()
	end

	manager.windowBar:RegistInfoCallBack(function()
		local var_14_0 = GetTips("CULTUREGRAVURE_DESC")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "CULTUREGRAVURE_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("FUNCTION_DESC"),
			content = var_14_0
		})
	end)

	arg_13_0.heroProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	arg_13_0.recommendType_ = arg_13_0.recommendType_ or 1

	arg_13_0:RefreshUI()
	manager.heroRaiseTrack:RefreshAstrolableState(AstrolabeConst.AnimationState.Commended)
	arg_13_0:RegistEventListener(HERO_TRANSITION_CHANGE, handler(arg_13_0, arg_13_0.OnTransitionEquip))
end

function var_0_0.RefreshUI(arg_15_0)
	local var_15_0 = HeroCfg[arg_15_0.heroID_]

	arg_15_0.nameText_.text = var_15_0.name
	arg_15_0.suffixText_.text = var_15_0.suffix
	arg_15_0.roleImg_.spriteSync = "TextureConfig/Character/Portrait/" .. arg_15_0.heroID_
	arg_15_0.raceImg_.sprite = getSprite("Atlas/SystemGroupAtlas", string.format("com_white_icon_group_%s_c", var_15_0.race))
	arg_15_0.rareImg_.sprite = getSprite("Atlas/SystemHeroGradeAtlas", "star_" .. var_15_0.rare)

	arg_15_0.teachController_:SetSelectedState(tostring(HeroData:GetHeroStrategyRedPoint(arg_15_0.heroID_)))
	arg_15_0:RefreshList(arg_15_0.selectedListIndex_)

	arg_15_0.typeImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_15_0.heroID_)

	arg_15_0:RefreshChargeType()
	arg_15_0:RefreshRangeType()
	SetActive(arg_15_0.astroBtn, not HeroTools.IsSpHero(arg_15_0.heroID_))
end

function var_0_0.ClickToggle(arg_16_0, arg_16_1)
	if arg_16_1 == arg_16_0.selectedListIndex_ then
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

	arg_16_0:RefreshList(arg_16_1)
end

function var_0_0.RefreshList(arg_17_0, arg_17_1)
	if arg_17_1 == 1 then
		PlayerAction.CheckRecommendEquip(arg_17_0.heroID_)
	end

	arg_17_0.stateController_:SetSelectedState(arg_17_1)

	for iter_17_0 = 1, 6 do
		arg_17_0.tabController_[iter_17_0]:SetSelectedState(tostring(iter_17_0 == arg_17_1))
	end

	if arg_17_1 == 1 then
		arg_17_0.btnController_:SetSelectedState(arg_17_0.recommendType_)

		arg_17_0.recommendText_.text = arg_17_0.recommendType_ == 1 and GetTips("OMEGA_RECOMMEND") or GetTips("EQUIP_RECOMMEND")

		if arg_17_0.recommendType_ == 2 then
			arg_17_0.equiptDataList_ = CultureGravureData:GetOmegaEquiptListByID(arg_17_0.heroID_)
		else
			arg_17_0.equiptDataList_ = CultureGravureData:GetCommonEquiptListByID(arg_17_0.heroID_)
		end

		arg_17_0.equiptList_:StartScroll(#arg_17_0.equiptDataList_)
		arg_17_0.stateController_:SetSelectedState(1)
	elseif arg_17_1 == 2 then
		arg_17_0.servantDataList_ = CultureGravureData:GetServantListByID(arg_17_0.heroID_)

		arg_17_0.servantList_:StartScroll(#arg_17_0.servantDataList_)
	elseif arg_17_1 == 3 then
		arg_17_0.astroDataList_ = deepClone(CultureGravureData:GetAstroListByID(arg_17_0.heroID_))

		arg_17_0.astroList_:StartScroll(#arg_17_0.astroDataList_)
	elseif arg_17_1 == 4 then
		arg_17_0.teamDataList_ = CultureGravureData:GetTeamListByID(arg_17_0.heroID_)

		arg_17_0:RefreshTeamRecommend()
	elseif arg_17_1 == 5 then
		arg_17_0.transitionDataList_ = CultureGravureData:GetTransitionListByID(arg_17_0.heroID_)
		arg_17_0.transitionInfoList = {}

		for iter_17_1, iter_17_2 in pairs(arg_17_0.heroProxy_:GetHeroTransitionInfoList(arg_17_0.heroID_)) do
			arg_17_0.transitionInfoList[iter_17_2.slot_id] = iter_17_2
		end

		arg_17_0.transitionList_:StartScroll(#arg_17_0.transitionDataList_)
	elseif arg_17_1 == 6 then
		arg_17_0.equipSkillDataList_ = CultureGravureData:GetEquipSkillListByID(arg_17_0.heroID_)

		arg_17_0.equipSkillList_:StartScroll(#arg_17_0.equipSkillDataList_)
	end

	arg_17_0.selectedListIndex_ = arg_17_1

	SetActive(arg_17_0.descTextGo_, arg_17_0.selectedListIndex_ ~= 2)

	arg_17_0.showPopInfo_ = false
end

function var_0_0.IndexEquiptItem(arg_18_0, arg_18_1, arg_18_2)
	arg_18_2:SetData(arg_18_1, arg_18_0.equiptDataList_[arg_18_1], arg_18_0.heroID_)
end

function var_0_0.IndexServantItem(arg_19_0, arg_19_1, arg_19_2)
	arg_19_2:SetData(arg_19_1, arg_19_0.servantDataList_[arg_19_1], arg_19_0.heroID_)

	if arg_19_1 == 1 then
		arg_19_2:SetRecommendController(2)
	end
end

function var_0_0.IndexAstroItem(arg_20_0, arg_20_1, arg_20_2)
	arg_20_2:SetClickCallBack(arg_20_0.clickPopHandler)
	arg_20_2:SetData(arg_20_1, arg_20_0.astroDataList_[arg_20_1], arg_20_0.heroID_)
end

function var_0_0.IndexTransitionItem(arg_21_0, arg_21_1, arg_21_2)
	arg_21_2:SetClickCallBack(arg_21_0.clickPopHandler)
	arg_21_2:SetData(arg_21_0.transitionDataList_[arg_21_1], arg_21_1, arg_21_0.transitionInfoList[arg_21_1], arg_21_0.heroID_)
end

function var_0_0.IndexEquipSkillItem(arg_22_0, arg_22_1, arg_22_2)
	arg_22_2:SetData(arg_22_0.equipSkillDataList_[arg_22_1])
end

function var_0_0.OnTransitionEquip(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.transitionDataList_ = CultureGravureData:GetTransitionListByID(arg_23_0.heroID_)

	arg_23_0.transitionList_:StartScrollByPosition(#arg_23_0.transitionDataList_, arg_23_0.transitionList_:GetScrolledPosition())

	if arg_23_2 then
		ShowTips(GetTips("EXCLUSIVE_SKILL_LOAD"))
	end
end

function var_0_0.OnEquipSwap(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0.equiptList_:StartScroll(#arg_24_0.equiptDataList_)
end

function var_0_0.OnEquipQuickDressOn(arg_25_0, arg_25_1, arg_25_2)
	for iter_25_0 = 1, 6 do
		if arg_25_2.use_equip_list[iter_25_0] then
			HeroAction.HeroChangeEquip(arg_25_2.hero_id, arg_25_2.use_equip_list[iter_25_0].equip_id, arg_25_2.use_equip_list[iter_25_0].pos)
		end
	end

	arg_25_0.equiptList_:StartScroll(#arg_25_0.equiptDataList_)
	ShowTips("SUCCESS_EQUIP_PROPOSAL")
end

function var_0_0.OnServantReplace(arg_26_0)
	ShowTips("SUCCESS_EQUIP_SERVANT")
	arg_26_0.servantList_:StartScroll(#arg_26_0.servantDataList_)
end

function var_0_0.RefreshRangeType(arg_27_0)
	arg_27_0.rangeTypeText_.text = CharactorParamCfg[arg_27_0.heroID_].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
end

function var_0_0.RefreshChargeType(arg_28_0)
	arg_28_0.chargeType_.text = HeroTools.GetChargeTextByType(HeroCfg[arg_28_0.heroID_].mechanism_type[1])
end

function var_0_0.OnAstrolabeEquip(arg_29_0)
	ShowTips("ASTROLABE_BIND")
	arg_29_0.astroList_:StartScroll(#arg_29_0.astroDataList_)
end

function var_0_0.OnExit(arg_30_0)
	manager.windowBar:HideBar()
	CultureGravureData:SetLastTabIndex(arg_30_0.selectedListIndex_)

	arg_30_0.roleImg_.spriteSync = nil

	SetActive(arg_30_0.popInfoParentGo_, false)

	arg_30_0.showPopInfo_ = false

	manager.redPoint:unbindUIandKey(arg_30_0.teachingBtn_.transform)

	arg_30_0.tabScroll_.horizontalNormalizedPosition = 0

	arg_30_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_31_0)
	if arg_31_0.astroList_ then
		arg_31_0.astroList_:Dispose()
	end

	if arg_31_0.servantList_ then
		arg_31_0.servantList_:Dispose()
	end

	if arg_31_0.equiptList_ then
		arg_31_0.equiptList_:Dispose()
	end

	if arg_31_0.transitionList_ then
		arg_31_0.transitionList_:Dispose()
	end

	if arg_31_0.equipSkillList_ then
		arg_31_0.equipSkillList_:Dispose()
	end

	if arg_31_0.teamRecommendList_ then
		for iter_31_0, iter_31_1 in pairs(arg_31_0.teamRecommendList_) do
			iter_31_1:Dispose()
		end

		arg_31_0.teamRecommendList_ = nil
	end

	arg_31_0:RemoveAllEventListener()
	var_0_0.super.Dispose(arg_31_0)
end

function var_0_0.PopInfo(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
	SetActive(arg_32_0.popInfoParentGo_, true)

	arg_32_0.showPopInfo_ = true
	arg_32_0.popNameText_.text = GetI18NText(arg_32_1)
	arg_32_0.popDescText_.text = GetI18NText(arg_32_2)

	local var_32_0 = 700
	local var_32_1 = arg_32_0.textViewTrs_.gameObject:GetComponent(typeof(ContentSizeFitter))

	var_32_1.enabled = true

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_0.popDescText_.transform)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_0.textContentTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_0.textViewTrs_)

	local var_32_2 = arg_32_0.popDescText_.transform.sizeDelta.y
	local var_32_3 = arg_32_0.textParentTrs_.gameObject:GetComponent(typeof(ScrollRect))

	if var_32_0 < var_32_2 then
		var_32_1.enabled = false
		var_32_3.enabled = true
		arg_32_0.textViewTrs_.transform.sizeDelta = Vector2(arg_32_0.textContentTrs_.sizeDelta.x, var_32_0)
	else
		var_32_1.enabled = true
		var_32_3.enabled = false
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_0.textParentTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_0.popContentTrs_)

	local var_32_4 = arg_32_0.middleTrs_:InverseTransformPoint(arg_32_3)
	local var_32_5 = Vector3(var_32_4.x, var_32_4.y, 0)
	local var_32_6 = arg_32_0.middleTrs_:TransformPoint(var_32_5)
	local var_32_7 = arg_32_0.popInfoParentTrs_:InverseTransformPoint(var_32_6)

	arg_32_0.popInfoTrs_.localPosition = var_32_7

	local var_32_8 = arg_32_0.popBottomTrs_:TransformPoint(Vector3(0, 0, 0))
	local var_32_9 = arg_32_0.popInfoParentTrs_:InverseTransformPoint(var_32_8)
	local var_32_10 = arg_32_0.safePlaceTrs_.rect.height / 2
	local var_32_11 = arg_32_0.textParentTrs_.rect.width / 4
	local var_32_12 = arg_32_0.popInfoParentTrs_:InverseTransformPoint(arg_32_4.position).x

	var_32_12 = arg_32_5 and var_32_12 + var_32_11 or var_32_12 - var_32_11

	local var_32_13 = 0

	if var_32_10 < -var_32_9.y then
		var_32_13 = -var_32_9.y - var_32_10
	end

	arg_32_0.popInfoTrs_.localPosition = Vector3(var_32_12, var_32_7.y + var_32_13, var_32_7.z)
end

function var_0_0.RefreshTeamRecommend(arg_33_0)
	for iter_33_0, iter_33_1 in ipairs(arg_33_0.teamDataList_) do
		local var_33_0 = arg_33_0.teamRecommendList_[iter_33_0]

		if not var_33_0 then
			local var_33_1 = GameObject.Instantiate(arg_33_0.teamItemGo_, arg_33_0.teamContent_)

			var_33_0 = CultureGravureTeamItem.New(var_33_1)

			var_33_0:RegisterTeamClick(handler(arg_33_0, arg_33_0.OnClickTeamItem))
			var_33_0:SetEquipClickCallBack(arg_33_0.clickPopHandler)

			arg_33_0.teamRecommendList_[iter_33_0] = var_33_0
		end

		var_33_0:SetData(iter_33_1)
		SetActive(var_33_0.gameObject_, true)
	end

	for iter_33_2 = #arg_33_0.teamDataList_ + 1, #arg_33_0.teamRecommendList_ do
		SetActive(arg_33_0.teamRecommendList_[iter_33_2].gameObject_, false)
	end
end

function var_0_0.OnClickTeamItem(arg_34_0, arg_34_1)
	if arg_34_0.showPopInfo_ and arg_34_0.selectedTeamItem_ == arg_34_1 then
		arg_34_0.showPopInfo_ = false

		return
	end

	if arg_34_0.selectedTeamItem_ then
		if arg_34_0.selectedTeamItem_ == arg_34_1 then
			arg_34_0.selectedTeamItem_:IsShowDetail()

			return
		else
			arg_34_0.selectedTeamItem_:IsShowDetail(false)
		end
	end

	arg_34_0.selectedTeamItem_ = arg_34_1

	arg_34_0.selectedTeamItem_:IsShowDetail(true)
end

return var_0_0
