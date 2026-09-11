local NewGuildHeroTeamInfoView = class("NewGuildHeroTeamInfoView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function NewGuildHeroTeamInfoView:UIName()
	return "Widget/System/Formation/GuildBoss/FormationGuildBossHeroUI"
end

function NewGuildHeroTeamInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function NewGuildHeroTeamInfoView:Init()
	self:InitProxy()

	self.gameObject_ = self.realGo_
	self.transform_ = self.realGo_.transform

	self:InitUI()
	self:AddUIListener()

	self.gameObject_ = self.gameObject_
	self.transform_ = self.gameObject_.transform
end

function NewGuildHeroTeamInfoView:InitProxy()
	self:BindCfgUI()
end

function NewGuildHeroTeamInfoView:InitUI()
	self:BindCfgUI()
	self:InitController()
	self:InitSubView()
end

function NewGuildHeroTeamInfoView:InitController()
	NewGuildHeroTeamInfoView.super.InitController(self)

	self.nameDisplayController = self.controller_:GetController("nameDisplay")
end

function NewGuildHeroTeamInfoView:InitSubView()
	self.selfHeroList_ = LuaList.New(handler(self, self.indexSelfHeroItem), self.uiListGo_, SectionHeroTeamHeadItem)
	self.assistantHeroList_ = LuaList.New(handler(self, self.indexAssistantItem), self.assitUIListGo_, NewGuildBossAssistantHeadItemView)
	self.toggleController1_ = ControllerUtil.GetController(self.myHeroToggleBtn_.transform, "select")
	self.toggleController2_ = ControllerUtil.GetController(self.helpHeroToggleBtn_.transform, "select")
	self.filterView_ = NewHeroListFilterView.New(self.filterGo_)

	self.filterView_:SetExtraSorter(function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = self:IsInSelfTeam(arg_8_0.id) and 1 or 0
		local var_8_1 = self:IsInSelfTeam(arg_8_1.id) and 1 or 0

		if var_8_0 ~= var_8_1 then
			return true, var_8_1 < var_8_0
		end

		return false, false
	end)
	self.filterView_:SetListChangeHandler(handler(self, self.OnListChange))

	self.assistFilterView_ = NewGuildBossAssistHeroFilterView.New(self.assistHeroFilterGo_)

	self.assistFilterView_:SetExtraSorter(function(arg_9_0, arg_9_1)
		local var_9_0 = GuildData:CheckCurrentHeroIDIsAssistant(arg_9_0.assist_hero_id) and 1 or 0
		local var_9_1 = GuildData:CheckCurrentHeroIDIsAssistant(arg_9_1.assist_hero_id) and 1 or 0

		if var_9_0 ~= var_9_1 then
			return true, var_9_1 < var_9_0
		end

		return false, false
	end)
	self.assistFilterView_:SetListChangeHandler(handler(self, self.OnAssistListChange))
end

function NewGuildHeroTeamInfoView:OnEnter()
	NewGuildHeroTeamInfoView.super.OnEnter(self)
	self:AddEventListeners()
	self.assistFilterView_:OnEnter(HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.FOREIGN))
end

function NewGuildHeroTeamInfoView:SubViewOnEnter()
	NewGuildHeroTeamInfoView.super.SubViewOnEnter(self)

	if self.assistFilterView_ then
		self.assistFilterView_:Reset(true)
	end
end

function NewGuildHeroTeamInfoView:RefreshHeroDataList()
	self.params_.heroList = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.GUILD_BOSS):GetCurHeroInfoList()
end

function NewGuildHeroTeamInfoView:RefreshUI()
	self:RefreshMultiModeBtn()
	self:RefreshHeroList()
end

function NewGuildHeroTeamInfoView:RefreshHeroList()
	if self.params_.heroList[self.params_.selectHeroPos] and self.params_.heroList[self.params_.selectHeroPos].heroId ~= 0 then
		if self.params_.heroList[self.params_.selectHeroPos].type == 1 then
			self:SelectIndex(1)
		else
			self:SelectIndex(2)
		end
	else
		self:SelectIndex(1)
	end
end

function NewGuildHeroTeamInfoView:indexAssistantItem(arg_15_1, arg_15_2)
	arg_15_2:SetSectionHeroData(self.assistantDataList_[arg_15_1])
	arg_15_2:SetSelected(self.selectedAssistHeroData_ ~= nil and arg_15_2:GetHeroId() == self.selectedAssistHeroData_.assist_hero_id and arg_15_2:GetOwnerId() == self.selectedAssistHeroData_.member_id)
	arg_15_2:SetTeamMark(self:IsHeroInTeam(arg_15_2:GetHeroId(), arg_15_2:GetOwnerId()) > -1, GetTips("IN_TEAM"))
	arg_15_2:RegisterClickListener(function()
		self:SelectAssistantHero(arg_15_1)
	end)
end

function NewGuildHeroTeamInfoView:indexSelfHeroItem(arg_17_1, arg_17_2)
	local var_17_0 = self.heroDataList_[arg_17_1].id

	arg_17_2:SetSectionHeroData(self.heroDataList_[arg_17_1], self.trialHeroList_)
	arg_17_2:SetSelected(arg_17_2.heroId_ == self.selectHeroData_.id)
	arg_17_2:RegisterClickListener(function()
		self:SelectSelfHero(self.heroDataList_[arg_17_1])
	end)
	arg_17_2:SetTeamMark(self:IsInSelfTeam(var_17_0), GetTips("IN_TEAM"))
end

function NewGuildHeroTeamInfoView:OnListChange(arg_19_1, arg_19_2)
	self.heroDataList_ = arg_19_2

	if self.currentIndex_ ~= 1 then
		return
	end

	self.selfHeroList_:StartScroll(#self.heroDataList_)

	if #self.heroDataList_ > 0 then
		local var_19_0 = self:ChooseSelfFirstSelectIndex()

		self.selectHeroData_ = var_19_0 and self.heroDataList_[var_19_0] or self.heroDataList_[1]

		self:SelectSelfHero(self.selectHeroData_)
	else
		self:SelectEmptyAssistHero()
	end
end

function NewGuildHeroTeamInfoView:OnAssistListChange(arg_20_1)
	self.assistantDataList_ = arg_20_1

	self.assistantHeroList_:StartScroll(#self.assistantDataList_)

	if self.selectedAssistHeroData_ == nil then
		if #self.assistantDataList_ > 0 then
			self:SelectAssistantHero((self:ChooseAssistFirstSelectIndex()))
		else
			self:SelectEmptyAssistHero()
		end
	else
		local var_20_0 = -1

		for iter_20_0, iter_20_1 in ipairs(self.assistantDataList_) do
			if iter_20_1 ~= nil and iter_20_1.assist_hero_id == self.selectedAssistHeroID_ and iter_20_1.member_id == self.selectedAssistHeroData_.member_id then
				var_20_0 = iter_20_0

				break
			end
		end

		if var_20_0 ~= -1 then
			self:SelectAssistantHero(var_20_0)
		else
			self:SelectEmptyAssistHero()
		end
	end
end

function NewGuildHeroTeamInfoView:ChooseSelfFirstSelectIndex()
	if self.params_.heroList[self.params_.selectHeroPos] and self.params_.heroList[self.params_.selectHeroPos].heroId ~= 0 and self.params_.heroList[self.params_.selectHeroPos].type == 1 then
		for iter_21_0, iter_21_1 in ipairs(self.heroDataList_) do
			if iter_21_1.id == self.params_.heroList[self.params_.selectHeroPos].heroId then
				return iter_21_0
			end
		end

		return 1
	end

	for iter_21_2, iter_21_3 in ipairs(self.heroDataList_) do
		if not self:IsInSelfTeam(iter_21_3.id) then
			return iter_21_2
		end
	end

	return 1
end

function NewGuildHeroTeamInfoView:ChooseAssistFirstSelectIndex()
	if self.params_.heroList[self.params_.selectHeroPos] and self.params_.heroList[self.params_.selectHeroPos].heroId ~= 0 and self.params_.heroList[self.params_.selectHeroPos].type == 2 then
		local var_22_0

		for iter_22_0, iter_22_1 in ipairs(self.assistantDataList_) do
			if self.params_.heroList[self.params_.selectHeroPos].info.assist_hero_id == iter_22_1.assist_hero_id and self.params_.heroList[self.params_.selectHeroPos].info.member_id == iter_22_1.member_id then
				var_22_0 = iter_22_0

				break
			end
		end

		return var_22_0
	end

	return 1
end

function NewGuildHeroTeamInfoView:SelectSelfHero(arg_23_1)
	self.selectHeroData_ = arg_23_1

	self:RefreshSingleModeHeadItem()
	self:UpdateSelfHeroView()
end

function NewGuildHeroTeamInfoView:RefreshSingleModeHeadItem()
	for iter_24_0, iter_24_1 in pairs(self.selfHeroList_:GetItemList()) do
		iter_24_1:SetSelected(iter_24_1.heroId_ == self.selectHeroData_.id)
	end
end

function NewGuildHeroTeamInfoView:SelectEmptyAssistHero()
	self.fightPowerText_.text = "--"
	self.nameText_.text = "--"
	self.subNameText_.text = "--"

	self.infoBtnController_:SetSelectedState("off")

	self.joinBtn_.interactable = false

	self.joinBtnController_:SetSelectedState("cantAdd")
end

function NewGuildHeroTeamInfoView:SelectAssistantHero(arg_26_1)
	self.selectedAssistHeroID_ = self.assistantDataList_[arg_26_1].assist_hero_id
	self.selectedAssistHeroData_ = self.assistantDataList_[arg_26_1]

	self.assistantHeroList_:Refresh()
	self:UpdateAssistHeroView()
end

function NewGuildHeroTeamInfoView:UpdateSelfHeroView()
	local var_27_0 = self.selectHeroData_.id
	local var_27_1 = self.selectHeroData_.heroViewProxy:GetHeroBattleUsingSkinInfo(self.selectHeroData_.id, {
		self.selectHeroData_.trialID
	}).id

	self.fightPowerText_.text = getHeroPower(self.selectHeroData_.id, false)
	self.nameText_.text = GetI18NText(HeroCfg[var_27_0].name)
	self.subNameText_.text = HeroTools.GetHeroName(var_27_0)

	if self.selectHeroData_.heroViewProxy:IsHeroOath(var_27_0) then
		if self.selectHeroData_.heroViewProxy:HasCustomNickName(var_27_0) then
			self.nameDisplayController:SetSelectedState("oathCustomName")
		else
			self.nameDisplayController:SetSelectedState("oath")
		end
	else
		self.nameDisplayController:SetSelectedState("normal")
	end

	self.infoBtnController_:SetSelectedState("on")
	self:UpdateJoin(var_27_0)
	self:LoadHeroModel(var_27_1)
	self:ProcessCamera(var_27_1)
end

function NewGuildHeroTeamInfoView:UpdateJoin(arg_28_1, arg_28_2)
	self.joinBtn_.interactable = true

	self.joinBtnController_:SetSelectedState("add")

	if self:IsOnlyCaptainToRemove() then
		self.joinBtn_.interactable = false

		self.joinBtnController_:SetSelectedState("cantRemove")
	elseif self:IsHeroInTeam(arg_28_1, arg_28_2) > -1 then
		self.joinBtnController_:SetSelectedState("out")
	end
end

function NewGuildHeroTeamInfoView:IsOnlyCaptainToRemove()
	if self.params_.selectHeroPos ~= 1 then
		return false
	end

	local var_29_0 = self.params_.heroList

	if self.params_.heroList[1] ~= nil and var_29_0[2] == nil and var_29_0[3] == nil then
		if self.currentIndex_ ~= var_29_0[1].type then
			return false
		end

		if var_29_0[1].type == 1 then
			if self.selectHeroData_.id == var_29_0[1].heroId then
				return true
			end
		elseif var_29_0[1].type == 2 and self.selectedAssistHeroID_ == var_29_0[1].info.assist_hero_id and self.selectedAssistHeroData_.member_id == var_29_0[1].info.member_id then
			return true
		end
	end

	return false
end

function NewGuildHeroTeamInfoView:GetSelectedAssistHeroNickName(arg_30_1)
	local var_30_0 = nullable(self.selectedAssistHeroData_, "hero_oath_display", "nick")

	if var_30_0 == "" then
		return nil
	end

	return var_30_0
end

function NewGuildHeroTeamInfoView:IsSelectAssistHeroOath()
	return nullable(self.selectedAssistHeroData_, "hero_oath_display", "oath")
end

function NewGuildHeroTeamInfoView:UpdateAssistHeroView()
	local var_32_0 = self.selectedAssistHeroData_.assist_hero_skin

	if self.selectedAssistHeroData_.assist_hero_skin == 0 then
		var_32_0 = self.selectedAssistHeroData_.assist_hero_id
	end

	local var_32_1 = self.selectedAssistHeroID_

	self.fightPowerText_.text = self.selectedAssistHeroData_.fight_capacity
	self.nameText_.text = GetI18NText(HeroCfg[var_32_1].name)
	self.subNameText_.text = GetI18NText(HeroTools.GetHeroName(var_32_1, function(arg_33_0)
		return self:GetSelectedAssistHeroNickName(arg_33_0)
	end))

	if self:IsSelectAssistHeroOath() then
		if self:GetSelectedAssistHeroNickName(var_32_1) ~= nil then
			self.nameDisplayController:SetSelectedState("oathCustomName")
		else
			self.nameDisplayController:SetSelectedState("oath")
		end
	else
		self.nameDisplayController:SetSelectedState("normal")
	end

	self.infoBtnController_:SetSelectedState("on")
	self:UpdateJoin(self.selectedAssistHeroData_.assist_hero_id, self.selectedAssistHeroData_.member_id)
	self:LoadAssistHeroModel(var_32_0, self.selectedAssistHeroData_)
	self:ProcessCamera(var_32_0)
end

function NewGuildHeroTeamInfoView:LoadAssistHeroModel(arg_34_1, arg_34_2)
	local var_34_0 = self.params_.selectHeroPos or 1

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

function NewGuildHeroTeamInfoView:AddUIListener()
	self:AddBtnListener(self.infoBtn_, nil, function()
		if self.currentIndex_ == 1 then
			self:Go("/newHero", {
				isEnter = true,
				isTemp = false,
				hid = self.selectHeroData_.id,
				tempHeroList = {}
			})
		else
			if self.selectedAssistHeroData_ == nil then
				return
			end

			ForeignInfoAction:TryToCheckForeignHeroInfo(self.selectedAssistHeroData_.member_id, self.selectedAssistHeroID_, 2, function()
				JumpTools.OpenPageByJump("/foreignHero", {
					isForeign = true,
					isEnter = true,
					notShowBar = true,
					hid = self.selectedAssistHeroID_,
					type = HeroConst.HERO_DATA_TYPE.FOREIGN
				}, ViewConst.SYSTEM_ID.PLAYER_INFO)
			end)
		end
	end)
	self:AddBtnListener(self.joinBtn_, nil, function()
		if self:IsOnlyCaptainToRemove() then
			return
		end

		if self.currentIndex_ == 1 then
			local var_39_0
			local var_39_1 = self:IsHeroInTeam(self.selectHeroData_.id)
			local var_39_2

			if var_39_1 > -1 then
				var_39_0 = nil
				var_39_2 = var_39_1
			else
				var_39_0 = self.selectHeroData_.id
				var_39_2 = self.params_.selectHeroPos
			end

			if var_39_0 then
				local var_39_3 = self:GetHeroIdPosOfTeam(var_39_0)

				if var_39_3 ~= -1 and var_39_1 == -1 and var_39_3 ~= self.params_.selectHeroPos then
					ShowTips("TEAM_REPEAT_HERO")

					return
				end
			end

			self:OnGuildBossSelfHeroChange(var_39_2, var_39_0)
		else
			if self.selectedAssistHeroData_ == nil then
				return
			end

			local var_39_4
			local var_39_5 = self:IsHeroInTeam(self.selectedAssistHeroID_, self.selectedAssistHeroData_.member_id)
			local var_39_6

			if var_39_5 > -1 then
				var_39_4 = nil
				var_39_6 = var_39_5
			else
				var_39_4 = self.selectedAssistHeroData_
				var_39_6 = self.params_.selectHeroPos
			end

			if var_39_4 ~= nil then
				for iter_39_0, iter_39_1 in ipairs(self.params_.heroList) do
					if iter_39_0 ~= self.params_.selectHeroPos and iter_39_1.type == 2 and iter_39_1.assist_hero_id ~= var_39_4.assist_hero_id then
						ShowTips("CLUB_BOSS_ASSIST_MORE_THAN_ONE_TIP")

						return
					end
				end

				local var_39_7 = self:GetHeroIdPosOfTeam(var_39_4.assist_hero_id)

				if var_39_7 ~= -1 and var_39_5 == -1 and var_39_7 ~= self.params_.selectHeroPos then
					ShowTips("TEAM_REPEAT_HERO")

					return
				end
			end

			self:OnGuildBossAssistantHeroChange(var_39_6, var_39_4)
		end

		self:Back()
	end)
	self:AddBtnListener(self.myHeroToggleBtn_, nil, function()
		self:SelectIndex(1)
	end)
	self:AddBtnListener(self.helpHeroToggleBtn_, nil, function()
		self:SelectIndex(2)
	end)
end

function NewGuildHeroTeamInfoView:SelectIndex(arg_42_1)
	self.currentIndex_ = arg_42_1

	if arg_42_1 == 1 then
		SetActive(self.filterGo_, true)
		SetActive(self.assistHeroFilterGo_, false)
		self.toggleController1_:SetSelectedState("true")
		self.toggleController2_:SetSelectedState("false")
		self.assistFilterView_:SetAvailable(false)
		self.filterView_:SetAvailable(true)
		self.filterView_:Reset(true)
		self.filterView_:SetHeroIdList((HeroTools.Sort(HeroData:GetHeroListExcept({
			0
		}))))
	else
		SetActive(self.filterGo_, false)
		SetActive(self.assistHeroFilterGo_, true)
		self.toggleController1_:SetSelectedState("false")
		self.toggleController2_:SetSelectedState("true")
		self.filterView_:SetAvailable(false)
		self.assistFilterView_:SetAvailable(true)
		self.assistFilterView_:Reset(true)
		self.assistFilterView_:SetHeroIdList(GuildData:GetAssistantBriefList())
	end
end

function NewGuildHeroTeamInfoView:AddEventListeners()
	self:RegistEventListener(GUILD_ASSIST_BRIEF_UPDATE, function()
		if self.assistantHeroList_ == nil then
			return
		end
	end)
	self:RegistEventListener(GUILD_EXIT, function()
		self:Go("/home")
	end)
end

function NewGuildHeroTeamInfoView:OnTop()
	self:UpdateBar()
end

function NewGuildHeroTeamInfoView:OnBehind()
	manager.windowBar:HideBar()
end

function NewGuildHeroTeamInfoView:UpdateBar()
	self:ShowDefaultBar()
	manager.windowBar:RegistBackCallBack(function()
		self:Back(1, {
			isSorted = true
		})
	end)
end

function NewGuildHeroTeamInfoView:IsInSelfTeam(arg_50_1)
	for iter_50_0, iter_50_1 in pairs(self.params_.heroList) do
		if iter_50_1.type == 1 and iter_50_1.heroId == arg_50_1 then
			return true
		end
	end

	return false
end

function NewGuildHeroTeamInfoView:IsHeroInTeam(arg_51_1, arg_51_2)
	if arg_51_2 then
		for iter_51_0, iter_51_1 in pairs(self.params_.heroList) do
			if iter_51_1.type == 2 and iter_51_1.info.assist_hero_id == arg_51_1 and iter_51_1.info.member_id == arg_51_2 then
				return iter_51_0
			end
		end

		return -1
	else
		for iter_51_2, iter_51_3 in pairs(self.params_.heroList) do
			if iter_51_3.type == 1 and iter_51_3.heroId == arg_51_1 then
				return iter_51_2
			end
		end

		return -1
	end
end

function NewGuildHeroTeamInfoView:GetHeroIdPosOfTeam(arg_52_1)
	for iter_52_0, iter_52_1 in pairs(self.params_.heroList) do
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

function NewGuildHeroTeamInfoView:OnHeroSort(arg_53_1, arg_53_2, arg_53_3, arg_53_4, arg_53_5)
	if self.currentIndex_ == 1 then
		self.filterView_:RefreshSort(arg_53_1, arg_53_2, arg_53_3, arg_53_4, arg_53_5)
	else
		self.assistFilterView_:RefreshSort(arg_53_1, arg_53_2, arg_53_3, arg_53_4, arg_53_5)
	end

	HeroData:SaveSortValue(arg_53_1, arg_53_2, arg_53_3, arg_53_4, arg_53_5)
end

function NewGuildHeroTeamInfoView:OnExit()
	if self.filterView_ and self.filterView_.OnExit then
		self.filterView_:OnExit()
	end

	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
	manager.loadScene:SetSceneActive(SceneConst.SCENE_NAME.reserve, false)
	SectionSelectHeroScene.GetInstance():DestroyModels()

	if self.heroDataList_ and #self.heroDataList_ <= 0 then
		HeroData:ResetSortValue()
		self.filterView_:Reset()
	end

	if self.assistantDataList_ and #self.assistantDataList_ <= 0 then
		HeroData:ResetSortValue()
		self.assistFilterView_:Reset()
	end
end

function NewGuildHeroTeamInfoView:OnMainHomeViewTop()
	if self.filterView_ then
		self.filterView_:Reset(true)
	end

	if self.assistFilterView_ then
		self.assistFilterView_:Reset(true)
	end
end

function NewGuildHeroTeamInfoView:Dispose()
	if self.assistantHeroList_ then
		self.assistantHeroList_:Dispose()

		self.assistantHeroList_ = nil
	end

	if self.selfHeroList_ then
		self.selfHeroList_:Dispose()

		self.selfHeroList_ = nil
	end

	if self.filterView_ then
		self.filterView_:Dispose()

		self.filterView_ = nil
	end

	if self.assistFilterView_ then
		self.assistFilterView_:Dispose()

		self.assistFilterView_ = nil
	end

	NewGuildHeroTeamInfoView.super.Dispose(self)
end

function NewGuildHeroTeamInfoView:OnGuildBossSelfHeroChange(arg_57_1, arg_57_2)
	if arg_57_2 == nil then
		arg_57_2 = 0
	end

	if arg_57_2 == 0 then
		for iter_57_0 = arg_57_1, 2 do
			self.params_.heroList[iter_57_0] = self.params_.heroList[iter_57_0 + 1]
		end

		self.params_.heroList[3] = nil
	else
		local var_57_0 = self.params_.heroList[1]

		if self.params_.heroList[1] ~= nil and var_57_0.type == 1 and var_57_0.heroId == arg_57_2 and self.params_.heroList[arg_57_1] == nil then
			return
		end

		self.params_.heroList[arg_57_1] = arg_57_2 ~= nil and arg_57_2 > 0 and {
			type = 1,
			heroId = arg_57_2
		} or nil
	end

	self:GuildBossChangeHeroTeam(self.params_.heroList)
end

function NewGuildHeroTeamInfoView:OnGuildBossAssistantHeroChange(arg_58_1, arg_58_2)
	if arg_58_2 == nil then
		for iter_58_0 = arg_58_1, 2 do
			self.params_.heroList[iter_58_0] = self.params_.heroList[iter_58_0 + 1]
		end

		self.params_.heroList[3] = nil
	else
		local var_58_0 = self.params_.heroList[1]

		if self.params_.heroList[1] ~= nil and var_58_0.type == 2 and var_58_0.info.assist_hero_id == arg_58_2.assist_hero_id and var_58_0.info.member_id == arg_58_2.member_id and self.params_.heroList[arg_58_1] == nil then
			return
		end

		self.params_.heroList[arg_58_1] = arg_58_2 ~= nil and {
			type = 2,
			info = arg_58_2
		} or nil
	end

	self:GuildBossChangeHeroTeam(self.params_.heroList)
end

function NewGuildHeroTeamInfoView:GuildBossChangeHeroTeam(arg_59_1)
	local var_59_0 = {}
	local var_59_1 = {}
	local var_59_2 = 1

	for iter_59_0 = 1, 3 do
		if arg_59_1[iter_59_0] and arg_59_1[iter_59_0].heroId ~= 0 then
			if arg_59_1[iter_59_0].type == 1 then
				var_59_0[var_59_2] = arg_59_1[iter_59_0].heroId
			elseif arg_59_1[iter_59_0].type == 2 then
				var_59_0[var_59_2] = arg_59_1[iter_59_0].info.assist_hero_id
				var_59_1[var_59_2] = arg_59_1[iter_59_0].info.member_id
			end

			var_59_2 = var_59_2 + 1
		end
	end

	local var_59_3 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.GUILD_BOSS)

	var_59_3:SetHeroList(self.params_.reserveParams, var_59_0, {
		0,
		0,
		0
	})
	var_59_3:SetOwnerID(var_59_1)
end

return NewGuildHeroTeamInfoView
