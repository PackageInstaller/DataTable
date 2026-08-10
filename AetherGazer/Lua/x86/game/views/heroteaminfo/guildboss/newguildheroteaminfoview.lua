local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("NewGuildHeroTeamInfoView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Formation/GuildBoss/FormationGuildBossHeroUI"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_1.Init(arg_3_0)
	local var_3_0 = arg_3_0.gameObject_

	arg_3_0:InitProxy()

	arg_3_0.gameObject_ = arg_3_0.realGo_
	arg_3_0.transform_ = arg_3_0.realGo_.transform

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.gameObject_ = var_3_0
	arg_3_0.transform_ = var_3_0.transform
end

function var_0_1.InitProxy(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_1.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:InitController()
	arg_5_0:InitSubView()
end

function var_0_1.InitController(arg_6_0)
	var_0_1.super.InitController(arg_6_0)

	arg_6_0.nameDisplayController = arg_6_0.controller_:GetController("nameDisplay")
end

function var_0_1.InitSubView(arg_7_0)
	arg_7_0.selfHeroList_ = LuaList.New(handler(arg_7_0, arg_7_0.indexSelfHeroItem), arg_7_0.uiListGo_, SectionHeroTeamHeadItem)
	arg_7_0.assistantHeroList_ = LuaList.New(handler(arg_7_0, arg_7_0.indexAssistantItem), arg_7_0.assitUIListGo_, NewGuildBossAssistantHeadItemView)
	arg_7_0.toggleController1_ = ControllerUtil.GetController(arg_7_0.myHeroToggleBtn_.transform, "select")
	arg_7_0.toggleController2_ = ControllerUtil.GetController(arg_7_0.helpHeroToggleBtn_.transform, "select")
	arg_7_0.filterView_ = NewHeroListFilterView.New(arg_7_0.filterGo_)

	arg_7_0.filterView_:SetExtraSorter(function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = arg_7_0:IsInSelfTeam(arg_8_0.id) and 1 or 0
		local var_8_1 = arg_7_0:IsInSelfTeam(arg_8_1.id) and 1 or 0

		if var_8_0 ~= var_8_1 then
			return true, var_8_1 < var_8_0
		end

		return false, false
	end)
	arg_7_0.filterView_:SetListChangeHandler(handler(arg_7_0, arg_7_0.OnListChange))

	arg_7_0.assistFilterView_ = NewGuildBossAssistHeroFilterView.New(arg_7_0.assistHeroFilterGo_)

	arg_7_0.assistFilterView_:SetExtraSorter(function(arg_9_0, arg_9_1)
		local var_9_0 = GuildData:CheckCurrentHeroIDIsAssistant(arg_9_0.assist_hero_id) and 1 or 0
		local var_9_1 = GuildData:CheckCurrentHeroIDIsAssistant(arg_9_1.assist_hero_id) and 1 or 0

		if var_9_0 ~= var_9_1 then
			return true, var_9_1 < var_9_0
		end

		return false, false
	end)
	arg_7_0.assistFilterView_:SetListChangeHandler(handler(arg_7_0, arg_7_0.OnAssistListChange))
end

function var_0_1.OnEnter(arg_10_0)
	var_0_1.super.OnEnter(arg_10_0)
	arg_10_0:AddEventListeners()
	arg_10_0.assistFilterView_:OnEnter(HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.FOREIGN))
end

function var_0_1.SubViewOnEnter(arg_11_0)
	var_0_1.super.SubViewOnEnter(arg_11_0)

	if arg_11_0.assistFilterView_ then
		arg_11_0.assistFilterView_:Reset(true)
	end
end

function var_0_1.RefreshHeroDataList(arg_12_0)
	local var_12_0 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.GUILD_BOSS)

	arg_12_0.params_.heroList = var_12_0:GetCurHeroInfoList()
end

function var_0_1.RefreshUI(arg_13_0)
	arg_13_0:RefreshMultiModeBtn()
	arg_13_0:RefreshHeroList()
end

function var_0_1.RefreshHeroList(arg_14_0)
	local var_14_0 = arg_14_0.params_.heroList[arg_14_0.params_.selectHeroPos]

	if var_14_0 and var_14_0.heroId ~= 0 then
		if var_14_0.type == 1 then
			arg_14_0:SelectIndex(1)
		else
			arg_14_0:SelectIndex(2)
		end
	else
		arg_14_0:SelectIndex(1)
	end
end

function var_0_1.indexAssistantItem(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2:SetSectionHeroData(arg_15_0.assistantDataList_[arg_15_1])
	arg_15_2:SetSelected(arg_15_0.selectedAssistHeroData_ ~= nil and arg_15_2:GetHeroId() == arg_15_0.selectedAssistHeroData_.assist_hero_id and arg_15_2:GetOwnerId() == arg_15_0.selectedAssistHeroData_.member_id)
	arg_15_2:SetTeamMark(arg_15_0:IsHeroInTeam(arg_15_2:GetHeroId(), arg_15_2:GetOwnerId()) > -1, GetTips("IN_TEAM"))
	arg_15_2:RegisterClickListener(function()
		arg_15_0:SelectAssistantHero(arg_15_1)
	end)
end

function var_0_1.indexSelfHeroItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.heroDataList_[arg_17_1].id
	local var_17_1 = arg_17_0.heroDataList_[arg_17_1].trialID

	arg_17_2:SetSectionHeroData(arg_17_0.heroDataList_[arg_17_1], arg_17_0.trialHeroList_)
	arg_17_2:SetSelected(arg_17_2.heroId_ == arg_17_0.selectHeroData_.id)
	arg_17_2:RegisterClickListener(function()
		arg_17_0:SelectSelfHero(arg_17_0.heroDataList_[arg_17_1])
	end)
	arg_17_2:SetTeamMark(arg_17_0:IsInSelfTeam(var_17_0), GetTips("IN_TEAM"))
end

function var_0_1.OnListChange(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0.heroDataList_ = arg_19_2

	if arg_19_0.currentIndex_ ~= 1 then
		return
	end

	arg_19_0.selfHeroList_:StartScroll(#arg_19_0.heroDataList_)

	if #arg_19_0.heroDataList_ > 0 then
		local var_19_0 = arg_19_0:ChooseSelfFirstSelectIndex()

		if var_19_0 then
			arg_19_0.selectHeroData_ = arg_19_0.heroDataList_[var_19_0]
		else
			arg_19_0.selectHeroData_ = arg_19_0.heroDataList_[1]
		end

		arg_19_0:SelectSelfHero(arg_19_0.selectHeroData_)
	else
		arg_19_0:SelectEmptyAssistHero()
	end
end

function var_0_1.OnAssistListChange(arg_20_0, arg_20_1)
	arg_20_0.assistantDataList_ = arg_20_1

	arg_20_0.assistantHeroList_:StartScroll(#arg_20_0.assistantDataList_)

	if arg_20_0.selectedAssistHeroData_ == nil then
		if #arg_20_0.assistantDataList_ > 0 then
			local var_20_0 = arg_20_0:ChooseAssistFirstSelectIndex()

			arg_20_0:SelectAssistantHero(var_20_0)
		else
			arg_20_0:SelectEmptyAssistHero()
		end
	else
		local var_20_1 = -1

		for iter_20_0, iter_20_1 in ipairs(arg_20_0.assistantDataList_) do
			if iter_20_1 ~= nil and iter_20_1.assist_hero_id == arg_20_0.selectedAssistHeroID_ and iter_20_1.member_id == arg_20_0.selectedAssistHeroData_.member_id then
				var_20_1 = iter_20_0

				break
			end
		end

		if var_20_1 ~= -1 then
			arg_20_0:SelectAssistantHero(var_20_1)
		else
			arg_20_0:SelectEmptyAssistHero()
		end
	end
end

function var_0_1.ChooseSelfFirstSelectIndex(arg_21_0)
	local var_21_0 = arg_21_0.params_.heroList[arg_21_0.params_.selectHeroPos]

	if var_21_0 and var_21_0.heroId ~= 0 and var_21_0.type == 1 then
		local var_21_1 = var_21_0.heroId

		for iter_21_0, iter_21_1 in ipairs(arg_21_0.heroDataList_) do
			if iter_21_1.id == var_21_1 then
				return iter_21_0
			end
		end

		return 1
	end

	for iter_21_2, iter_21_3 in ipairs(arg_21_0.heroDataList_) do
		if not arg_21_0:IsInSelfTeam(iter_21_3.id) then
			return iter_21_2
		end
	end

	return 1
end

function var_0_1.ChooseAssistFirstSelectIndex(arg_22_0)
	local var_22_0 = arg_22_0.params_.heroList[arg_22_0.params_.selectHeroPos]

	if var_22_0 and var_22_0.heroId ~= 0 and var_22_0.type == 2 then
		local var_22_1

		for iter_22_0, iter_22_1 in ipairs(arg_22_0.assistantDataList_) do
			if var_22_0.info.assist_hero_id == iter_22_1.assist_hero_id and var_22_0.info.member_id == iter_22_1.member_id then
				var_22_1 = iter_22_0

				break
			end
		end

		return var_22_1
	end

	return 1
end

function var_0_1.SelectSelfHero(arg_23_0, arg_23_1)
	arg_23_0.selectHeroData_ = arg_23_1

	arg_23_0:RefreshSingleModeHeadItem()
	arg_23_0:UpdateSelfHeroView()
end

function var_0_1.RefreshSingleModeHeadItem(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.selfHeroList_:GetItemList()) do
		iter_24_1:SetSelected(iter_24_1.heroId_ == arg_24_0.selectHeroData_.id)
	end
end

function var_0_1.SelectEmptyAssistHero(arg_25_0)
	arg_25_0.fightPowerText_.text = "--"
	arg_25_0.nameText_.text = "--"
	arg_25_0.subNameText_.text = "--"

	arg_25_0.infoBtnController_:SetSelectedState("off")

	arg_25_0.joinBtn_.interactable = false

	arg_25_0.joinBtnController_:SetSelectedState("cantAdd")
end

function var_0_1.SelectAssistantHero(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.assistantDataList_[arg_26_1]

	arg_26_0.selectedAssistHeroID_ = var_26_0.assist_hero_id
	arg_26_0.selectedAssistHeroData_ = var_26_0

	arg_26_0.assistantHeroList_:Refresh()
	arg_26_0:UpdateAssistHeroView()
end

function var_0_1.UpdateSelfHeroView(arg_27_0)
	local var_27_0 = arg_27_0.selectHeroData_.id
	local var_27_1 = arg_27_0.selectHeroData_.heroViewProxy
	local var_27_2 = var_27_1:GetHeroBattleUsingSkinInfo(var_27_0, {
		arg_27_0.selectHeroData_.trialID
	}).id

	arg_27_0.fightPowerText_.text = getHeroPower(var_27_0, false)

	local var_27_3 = HeroCfg[var_27_0]

	arg_27_0.nameText_.text = GetI18NText(var_27_3.name)
	arg_27_0.subNameText_.text = HeroTools.GetHeroName(var_27_0)

	if var_27_1:IsHeroOath(var_27_0) then
		if var_27_1:HasCustomNickName(var_27_0) then
			arg_27_0.nameDisplayController:SetSelectedState("oathCustomName")
		else
			arg_27_0.nameDisplayController:SetSelectedState("oath")
		end
	else
		arg_27_0.nameDisplayController:SetSelectedState("normal")
	end

	arg_27_0.infoBtnController_:SetSelectedState("on")
	arg_27_0:UpdateJoin(var_27_0)
	arg_27_0:LoadHeroModel(var_27_2)
	arg_27_0:ProcessCamera(var_27_2)
end

function var_0_1.UpdateJoin(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0.joinBtn_.interactable = true

	arg_28_0.joinBtnController_:SetSelectedState("add")

	if arg_28_0:IsOnlyCaptainToRemove() then
		arg_28_0.joinBtn_.interactable = false

		arg_28_0.joinBtnController_:SetSelectedState("cantRemove")
	elseif arg_28_0:IsHeroInTeam(arg_28_1, arg_28_2) > -1 then
		arg_28_0.joinBtnController_:SetSelectedState("out")
	end
end

function var_0_1.IsOnlyCaptainToRemove(arg_29_0)
	if arg_29_0.params_.selectHeroPos ~= 1 then
		return false
	end

	local var_29_0 = arg_29_0.params_.heroList
	local var_29_1 = var_29_0[1] ~= nil and var_29_0[2] == nil and var_29_0[3] == nil
	local var_29_2

	if var_29_1 then
		local var_29_3 = var_29_0[1]

		if arg_29_0.currentIndex_ ~= var_29_3.type then
			return false
		end

		if var_29_3.type == 1 then
			if arg_29_0.selectHeroData_.id == var_29_3.heroId then
				return true
			end
		elseif var_29_3.type == 2 and arg_29_0.selectedAssistHeroID_ == var_29_3.info.assist_hero_id and arg_29_0.selectedAssistHeroData_.member_id == var_29_3.info.member_id then
			return true
		end
	end

	return false
end

function var_0_1.GetSelectedAssistHeroNickName(arg_30_0, arg_30_1)
	local var_30_0 = nullable(arg_30_0.selectedAssistHeroData_, "hero_oath_display", "nick")

	if var_30_0 == "" then
		return nil
	end

	return var_30_0
end

function var_0_1.IsSelectAssistHeroOath(arg_31_0)
	return nullable(arg_31_0.selectedAssistHeroData_, "hero_oath_display", "oath")
end

function var_0_1.UpdateAssistHeroView(arg_32_0)
	local var_32_0 = arg_32_0.selectedAssistHeroData_.assist_hero_skin

	if var_32_0 == 0 then
		var_32_0 = arg_32_0.selectedAssistHeroData_.assist_hero_id
	end

	local var_32_1 = arg_32_0.selectedAssistHeroID_

	arg_32_0.fightPowerText_.text = arg_32_0.selectedAssistHeroData_.fight_capacity

	local var_32_2 = HeroCfg[var_32_1]

	arg_32_0.nameText_.text = GetI18NText(var_32_2.name)
	arg_32_0.subNameText_.text = GetI18NText(HeroTools.GetHeroName(var_32_1, function(arg_33_0)
		return arg_32_0:GetSelectedAssistHeroNickName(arg_33_0)
	end))

	if arg_32_0:IsSelectAssistHeroOath() then
		if arg_32_0:GetSelectedAssistHeroNickName(var_32_1) ~= nil then
			arg_32_0.nameDisplayController:SetSelectedState("oathCustomName")
		else
			arg_32_0.nameDisplayController:SetSelectedState("oath")
		end
	else
		arg_32_0.nameDisplayController:SetSelectedState("normal")
	end

	arg_32_0.infoBtnController_:SetSelectedState("on")
	arg_32_0:UpdateJoin(arg_32_0.selectedAssistHeroData_.assist_hero_id, arg_32_0.selectedAssistHeroData_.member_id)
	arg_32_0:LoadAssistHeroModel(var_32_0, arg_32_0.selectedAssistHeroData_)
	arg_32_0:ProcessCamera(var_32_0)
end

function var_0_1.LoadAssistHeroModel(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0.params_.selectHeroPos or 1

	SectionSelectHeroScene.GetInstance():OnlyDisplayModel(var_34_0)
	SectionSelectHeroScene.GetInstance():LoadTargetModelEx(var_34_0, arg_34_1, function(arg_35_0, arg_35_1)
		if not arg_35_1 then
			SectionSelectHeroScene.GetInstance():DisposeVfx(arg_35_0)
		end

		if nullable(arg_34_2, "hero_oath_display", "oath") then
			SectionSelectHeroScene.GetInstance():AttachOathRing(arg_35_0)
		end
	end)
end

function var_0_1.AddUIListener(arg_36_0)
	arg_36_0:AddBtnListener(arg_36_0.infoBtn_, nil, function()
		if arg_36_0.currentIndex_ == 1 then
			arg_36_0:Go("/newHero", {
				isEnter = true,
				isTemp = false,
				hid = arg_36_0.selectHeroData_.id,
				tempHeroList = {}
			})
		else
			if arg_36_0.selectedAssistHeroData_ == nil then
				return
			end

			ForeignInfoAction:TryToCheckForeignHeroInfo(arg_36_0.selectedAssistHeroData_.member_id, arg_36_0.selectedAssistHeroID_, 2, function()
				JumpTools.OpenPageByJump("/foreignHero", {
					isForeign = true,
					isEnter = true,
					notShowBar = true,
					hid = arg_36_0.selectedAssistHeroID_,
					type = HeroConst.HERO_DATA_TYPE.FOREIGN
				}, ViewConst.SYSTEM_ID.PLAYER_INFO)
			end)
		end
	end)
	arg_36_0:AddBtnListener(arg_36_0.joinBtn_, nil, function()
		if arg_36_0:IsOnlyCaptainToRemove() then
			return
		end

		if arg_36_0.currentIndex_ == 1 then
			local var_39_0
			local var_39_1 = arg_36_0:IsHeroInTeam(arg_36_0.selectHeroData_.id)
			local var_39_2

			if var_39_1 > -1 then
				var_39_0 = nil
				var_39_2 = var_39_1
			else
				var_39_0 = arg_36_0.selectHeroData_.id
				var_39_2 = arg_36_0.params_.selectHeroPos
			end

			if var_39_0 then
				local var_39_3 = arg_36_0:GetHeroIdPosOfTeam(var_39_0)

				if var_39_3 ~= -1 and var_39_1 == -1 and var_39_3 ~= arg_36_0.params_.selectHeroPos then
					ShowTips("TEAM_REPEAT_HERO")

					return
				end
			end

			arg_36_0:OnGuildBossSelfHeroChange(var_39_2, var_39_0)
		else
			if arg_36_0.selectedAssistHeroData_ == nil then
				return
			end

			local var_39_4
			local var_39_5 = arg_36_0:IsHeroInTeam(arg_36_0.selectedAssistHeroID_, arg_36_0.selectedAssistHeroData_.member_id)
			local var_39_6

			if var_39_5 > -1 then
				var_39_4 = nil
				var_39_6 = var_39_5
			else
				var_39_4 = arg_36_0.selectedAssistHeroData_
				var_39_6 = arg_36_0.params_.selectHeroPos
			end

			if var_39_4 ~= nil then
				for iter_39_0, iter_39_1 in ipairs(arg_36_0.params_.heroList) do
					if iter_39_0 ~= arg_36_0.params_.selectHeroPos and iter_39_1.type == 2 and iter_39_1.assist_hero_id ~= var_39_4.assist_hero_id then
						ShowTips("CLUB_BOSS_ASSIST_MORE_THAN_ONE_TIP")

						return
					end
				end

				local var_39_7 = arg_36_0:GetHeroIdPosOfTeam(var_39_4.assist_hero_id)

				if var_39_7 ~= -1 and var_39_5 == -1 and var_39_7 ~= arg_36_0.params_.selectHeroPos then
					ShowTips("TEAM_REPEAT_HERO")

					return
				end
			end

			arg_36_0:OnGuildBossAssistantHeroChange(var_39_6, var_39_4)
		end

		arg_36_0:Back()
	end)
	arg_36_0:AddBtnListener(arg_36_0.myHeroToggleBtn_, nil, function()
		arg_36_0:SelectIndex(1)
	end)
	arg_36_0:AddBtnListener(arg_36_0.helpHeroToggleBtn_, nil, function()
		arg_36_0:SelectIndex(2)
	end)
end

function var_0_1.SelectIndex(arg_42_0, arg_42_1)
	arg_42_0.currentIndex_ = arg_42_1

	if arg_42_1 == 1 then
		SetActive(arg_42_0.filterGo_, true)
		SetActive(arg_42_0.assistHeroFilterGo_, false)
		arg_42_0.toggleController1_:SetSelectedState("true")
		arg_42_0.toggleController2_:SetSelectedState("false")

		local var_42_0 = HeroTools.Sort(HeroData:GetHeroListExcept({
			0
		}))

		arg_42_0.assistFilterView_:SetAvailable(false)
		arg_42_0.filterView_:SetAvailable(true)
		arg_42_0.filterView_:Reset(true)
		arg_42_0.filterView_:SetHeroIdList(var_42_0)
	else
		SetActive(arg_42_0.filterGo_, false)
		SetActive(arg_42_0.assistHeroFilterGo_, true)
		arg_42_0.toggleController1_:SetSelectedState("false")
		arg_42_0.toggleController2_:SetSelectedState("true")
		arg_42_0.filterView_:SetAvailable(false)
		arg_42_0.assistFilterView_:SetAvailable(true)
		arg_42_0.assistFilterView_:Reset(true)
		arg_42_0.assistFilterView_:SetHeroIdList(GuildData:GetAssistantBriefList())
	end
end

function var_0_1.AddEventListeners(arg_43_0)
	arg_43_0:RegistEventListener(GUILD_ASSIST_BRIEF_UPDATE, function()
		if arg_43_0.assistantHeroList_ == nil then
			return
		end
	end)
	arg_43_0:RegistEventListener(GUILD_EXIT, function()
		arg_43_0:Go("/home")
	end)
end

function var_0_1.OnTop(arg_46_0)
	arg_46_0:UpdateBar()
end

function var_0_1.OnBehind(arg_47_0)
	manager.windowBar:HideBar()
end

function var_0_1.UpdateBar(arg_48_0)
	arg_48_0:ShowDefaultBar()
	manager.windowBar:RegistBackCallBack(function()
		arg_48_0:Back(1, {
			isSorted = true
		})
	end)
end

function var_0_1.IsInSelfTeam(arg_50_0, arg_50_1)
	for iter_50_0, iter_50_1 in pairs(arg_50_0.params_.heroList) do
		if iter_50_1.type == 1 and iter_50_1.heroId == arg_50_1 then
			return true
		end
	end

	return false
end

function var_0_1.IsHeroInTeam(arg_51_0, arg_51_1, arg_51_2)
	if arg_51_2 then
		for iter_51_0, iter_51_1 in pairs(arg_51_0.params_.heroList) do
			if iter_51_1.type == 2 and iter_51_1.info.assist_hero_id == arg_51_1 and iter_51_1.info.member_id == arg_51_2 then
				return iter_51_0
			end
		end

		return -1
	else
		for iter_51_2, iter_51_3 in pairs(arg_51_0.params_.heroList) do
			if iter_51_3.type == 1 and iter_51_3.heroId == arg_51_1 then
				return iter_51_2
			end
		end

		return -1
	end
end

function var_0_1.GetHeroIdPosOfTeam(arg_52_0, arg_52_1)
	for iter_52_0, iter_52_1 in pairs(arg_52_0.params_.heroList) do
		if iter_52_1.type == 2 then
			if iter_52_1.info.assist_hero_id == arg_52_1 then
				return iter_52_0
			end
		elseif iter_52_1.heroId == arg_52_1 then
			return iter_52_0
		end
	end

	return -1
end

function var_0_1.OnHeroSort(arg_53_0, arg_53_1, arg_53_2, arg_53_3, arg_53_4, arg_53_5)
	if arg_53_0.currentIndex_ == 1 then
		arg_53_0.filterView_:RefreshSort(arg_53_1, arg_53_2, arg_53_3, arg_53_4, arg_53_5)
	else
		arg_53_0.assistFilterView_:RefreshSort(arg_53_1, arg_53_2, arg_53_3, arg_53_4, arg_53_5)
	end

	HeroData:SaveSortValue(arg_53_1, arg_53_2, arg_53_3, arg_53_4, arg_53_5)
end

function var_0_1.OnExit(arg_54_0)
	if arg_54_0.filterView_ and arg_54_0.filterView_.OnExit then
		arg_54_0.filterView_:OnExit()
	end

	arg_54_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	manager.loadScene:SetSceneActive(SceneConst.SCENE_NAME.reserve, false)
	SectionSelectHeroScene.GetInstance():DestroyModels()

	if arg_54_0.heroDataList_ and #arg_54_0.heroDataList_ <= 0 then
		HeroData:ResetSortValue()
		arg_54_0.filterView_:Reset()
	end

	if arg_54_0.assistantDataList_ and #arg_54_0.assistantDataList_ <= 0 then
		HeroData:ResetSortValue()
		arg_54_0.assistFilterView_:Reset()
	end
end

function var_0_1.OnMainHomeViewTop(arg_55_0)
	if arg_55_0.filterView_ then
		arg_55_0.filterView_:Reset(true)
	end

	if arg_55_0.assistFilterView_ then
		arg_55_0.assistFilterView_:Reset(true)
	end
end

function var_0_1.Dispose(arg_56_0)
	if arg_56_0.assistantHeroList_ then
		arg_56_0.assistantHeroList_:Dispose()

		arg_56_0.assistantHeroList_ = nil
	end

	if arg_56_0.selfHeroList_ then
		arg_56_0.selfHeroList_:Dispose()

		arg_56_0.selfHeroList_ = nil
	end

	if arg_56_0.filterView_ then
		arg_56_0.filterView_:Dispose()

		arg_56_0.filterView_ = nil
	end

	if arg_56_0.assistFilterView_ then
		arg_56_0.assistFilterView_:Dispose()

		arg_56_0.assistFilterView_ = nil
	end

	var_0_1.super.Dispose(arg_56_0)
end

function var_0_1.OnGuildBossSelfHeroChange(arg_57_0, arg_57_1, arg_57_2)
	if arg_57_2 == nil then
		arg_57_2 = 0
	end

	if arg_57_2 == 0 then
		for iter_57_0 = arg_57_1, 2 do
			arg_57_0.params_.heroList[iter_57_0] = arg_57_0.params_.heroList[iter_57_0 + 1]
		end

		arg_57_0.params_.heroList[3] = nil
	else
		local var_57_0 = arg_57_0.params_.heroList[1]

		if var_57_0 ~= nil and var_57_0.type == 1 and var_57_0.heroId == arg_57_2 and arg_57_0.params_.heroList[arg_57_1] == nil then
			return
		end

		if arg_57_2 ~= nil and arg_57_2 > 0 then
			arg_57_0.params_.heroList[arg_57_1] = {
				type = 1,
				heroId = arg_57_2
			}
		else
			arg_57_0.params_.heroList[arg_57_1] = nil
		end
	end

	arg_57_0:GuildBossChangeHeroTeam(arg_57_0.params_.heroList)
end

function var_0_1.OnGuildBossAssistantHeroChange(arg_58_0, arg_58_1, arg_58_2)
	if arg_58_2 == nil then
		for iter_58_0 = arg_58_1, 2 do
			arg_58_0.params_.heroList[iter_58_0] = arg_58_0.params_.heroList[iter_58_0 + 1]
		end

		arg_58_0.params_.heroList[3] = nil
	else
		local var_58_0 = arg_58_0.params_.heroList[1]

		if var_58_0 ~= nil and var_58_0.type == 2 and var_58_0.info.assist_hero_id == arg_58_2.assist_hero_id and var_58_0.info.member_id == arg_58_2.member_id and arg_58_0.params_.heroList[arg_58_1] == nil then
			return
		end

		if arg_58_2 ~= nil then
			arg_58_0.params_.heroList[arg_58_1] = {
				type = 2,
				info = arg_58_2
			}
		else
			arg_58_0.params_.heroList[arg_58_1] = nil
		end
	end

	arg_58_0:GuildBossChangeHeroTeam(arg_58_0.params_.heroList)
end

function var_0_1.GuildBossChangeHeroTeam(arg_59_0, arg_59_1)
	local var_59_0 = {}
	local var_59_1 = {
		0,
		0,
		0
	}
	local var_59_2 = {}
	local var_59_3 = 1

	for iter_59_0 = 1, 3 do
		if arg_59_1[iter_59_0] and arg_59_1[iter_59_0].heroId ~= 0 then
			local var_59_4 = arg_59_1[iter_59_0]

			if var_59_4.type == 1 then
				var_59_0[var_59_3] = var_59_4.heroId
			elseif var_59_4.type == 2 then
				var_59_0[var_59_3] = var_59_4.info.assist_hero_id
				var_59_2[var_59_3] = var_59_4.info.member_id
			end

			var_59_3 = var_59_3 + 1
		end
	end

	local var_59_5 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.GUILD_BOSS)

	var_59_5:SetHeroList(arg_59_0.params_.reserveParams, var_59_0, var_59_1)
	var_59_5:SetOwnerID(var_59_2)
end

return var_0_1
