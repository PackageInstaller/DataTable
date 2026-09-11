local CommonHeroSkillAttributeFilter = require("game.views.common.Filter.CommonHeroSkillAttributeFilter")
local ChallengeRogueTeamHeroSelectView = class("ChallengeRogueTeamHeroSelectView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function ChallengeRogueTeamHeroSelectView:UIName()
	return "Widget/System/Formation/FormationChallengeRogueTeamHeroUIVariant"
end

function ChallengeRogueTeamHeroSelectView:Init()
	self:BindCfgUI()

	self.tabItemList_ = {}
	self.heroList_ = LuaList.New(handler(self, self.HeadRenderer), self.heroUIListGo_, ChallengeRogueTeamHeroItem)

	self:InitSubView()
	self:InitController()
	self:AddUIListener()

	self.btnController_ = self.controller_:GetController("btn")
	self.emptyController_ = self.panelController_:GetController("empty")

	self:InitTapView()
end

function ChallengeRogueTeamHeroSelectView:OnEnter()
	if self.params_.isBack and self.stopCountimeFlag_ then
		ChallengeRogueTeamAction.OnPlayingState(ChallengeRogueTeamConst.PLAYING_STATE.ENTER, function()
			self.stopCountimeFlag_ = false
		end)
	end

	if self.params_.isEnter then
		self.recruitedList_ = {}
		self.selectHeroData_ = {
			id = 0,
			trialID = 0
		}
		self.enterScrollPosition_ = nil

		self:ResetTap()
	else
		self.selectHeroData_ = self.params_.curSelectHeroData
	end

	self.cacheBattlePower_ = {}
	self.recruitNumLimit_ = math.max(ChallengeRogueTeamData:AttributeGetValue(8), 1)

	for iter_3_0, iter_3_1 in ipairs(self.heroList_:GetItemList()) do
		iter_3_1:SetRecruited(false)
	end

	self.recruitedNumText_.text = string.format(GetTips("CHALLENGE_ROGUE_RECRUITED_NUM"), self.recruitNumLimit_)

	self:ProcessParams()
	self:SubViewOnEnter()
	self:GetHeroTeam()
	self:RefreshHeroDataList()
	self:RefreshSelectTab()

	if not self.params_.isEnter then
		self:SelectHero(self.selectHeroData_)
	else
		self:RefreshHeroList()
	end

	if self.enterScrollPosition_ then
		self.heroList_:StartScrollByPosition(#self.heroDataList_, self.enterScrollPosition_)
	else
		self.heroList_:StartScroll(#self.heroDataList_, 1)
	end

	manager.rogueTeamInGameInfoBox:ShowBox()

	self.params_.isBack = false
end

function ChallengeRogueTeamHeroSelectView:ProcessProxyParams()
	self.heroDataType_ = HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM
	self.params_.sectionProxy = self.params_.sectionProxy or SectionSelectHeroTools.GetProxy(self.params_, self.reserveParams_, self.heroDataType_)
	self.sectionProxy_ = self.params_.sectionProxy
	self.heroViewProxy_ = self.sectionProxy_:GetHeroViewProxy()
	self.heroViewProxyDic_ = {}
	self.heroViewProxyDic_[self.heroDataType_] = self.heroViewProxy_
end

function ChallengeRogueTeamHeroSelectView:RefreshSelectTab()
	self.tapView_:Refresh()
end

function ChallengeRogueTeamHeroSelectView:HeadRenderer(arg_7_1, arg_7_2)
	arg_7_2:SetSectionHeroData(arg_7_1, self.heroDataList_[arg_7_1])
	arg_7_2:SetSelected(arg_7_2.heroId_ == self.selectHeroData_.id and arg_7_2.trialID_ == self.selectHeroData_.trialID)

	if arg_7_2.trialID_ ~= 0 then
		arg_7_2:SetRecruited(table.indexof(self.recruitedList_, arg_7_2.trialID_))
	else
		arg_7_2:SetRecruited(table.indexof(self.recruitedList_, arg_7_2.heroId_))
	end

	arg_7_2:RegisterClickListener(function(arg_8_0)
		if self.recruitNumLimit_ > 1 then
			if #self.recruitedList_ >= self.recruitNumLimit_ and not table.indexof(self.recruitedList_, self.heroDataList_[arg_8_0].id) and not table.indexof(self.recruitedList_, self.heroDataList_[arg_8_0].trialID) then
				ShowTips("CHALLENGE_ROGUE_TEAM_RECRUIT_LIMIT")

				return
			end
		elseif not table.isEmpty(self.recruitedList_) then
			self:AddHeroToRecruitList(self.selectHeroData_)
		end

		self:AddHeroToRecruitList(self.heroDataList_[arg_8_0])
		self:SelectHero(self.heroDataList_[arg_8_0])

		self.selectHeroData_ = self.heroDataList_[arg_8_0]

		for iter_8_0, iter_8_1 in pairs(self.heroList_:GetItemList()) do
			if self.selectHeroData_.trialID ~= 0 then
				if iter_8_1.trialID_ == self.selectHeroData_.trialID then
					self.selectItem_ = iter_8_1
				end
			elseif iter_8_1.heroId_ == self.selectHeroData_.id then
				self.selectItem_ = iter_8_1
			end

			if iter_8_1.trialID_ ~= 0 then
				iter_8_1:SetRecruited(table.indexof(self.recruitedList_, iter_8_1.trialID_))
			else
				iter_8_1:SetRecruited(table.indexof(self.recruitedList_, iter_8_1.heroId_))
			end
		end

		self.emptyController_:SetSelectedState(tostring(self.selectHeroData_.id == 0))
	end)
	arg_7_2:RegisterLookListener(function(arg_9_0, arg_9_1)
		self:OnInfoBtnClick(arg_9_0, arg_9_1)
	end)
end

function ChallengeRogueTeamHeroSelectView:RefreshHeroList()
	for iter_10_0, iter_10_1 in pairs(self.heroList_:GetItemList()) do
		iter_10_1:SetSelected("false")
	end

	self.emptyController_:SetSelectedState("true")
end

function ChallengeRogueTeamHeroSelectView:AddHeroToRecruitList(arg_11_1)
	local var_11_0 = arg_11_1.type == HeroConst.HERO_DATA_TYPE.TRIAL and table.indexof(self.recruitedList_, arg_11_1.trialID) or table.indexof(self.recruitedList_, arg_11_1.id)

	if not var_11_0 and #self.recruitedList_ < self.recruitNumLimit_ then
		local var_11_1 = false

		for iter_11_0, iter_11_1 in ipairs(self.recruitedList_) do
			if (not HeroCfg[iter_11_1] and HeroStandardSystemCfg[iter_11_1].hero_id or iter_11_1) == arg_11_1.id then
				var_11_1 = iter_11_0

				break
			end
		end

		if var_11_1 then
			table.remove(self.recruitedList_, var_11_1)
		end

		table.insert(self.recruitedList_, (arg_11_1.trialID ~= 0 or nil) and (arg_11_1.trialID or arg_11_1.id))
	elseif var_11_0 then
		table.remove(self.recruitedList_, var_11_0)
	end

	if #self.recruitedList_ > 0 then
		self.btnController_:SetSelectedState("01")
	else
		self.btnController_:SetSelectedState("0")
	end
end

function ChallengeRogueTeamHeroSelectView:SelectHero(arg_12_1)
	self.selectHeroData_ = arg_12_1

	for iter_12_0, iter_12_1 in pairs(self.heroList_:GetItemList()) do
		if self.selectHeroData_.trialID ~= 0 then
			iter_12_1:SetSelected(iter_12_1.trialID_ == self.selectHeroData_.trialID)
		else
			iter_12_1:SetSelected(iter_12_1.trialID_ == 0 and iter_12_1.heroId_ == self.selectHeroData_.id)
		end
	end

	self:RefreshInfoBtn()
	self:UpdateHeroView()
	self:RefreshJoinBtn()
end

function ChallengeRogueTeamHeroSelectView:UpdateHeroView()
	if self.selectHeroData_ and self.selectHeroData_.id ~= 0 and self.selectHeroData_.heroViewProxy then
		local var_13_0 = self.selectHeroData_.heroViewProxy:GetHeroUsingSkinInfo(self.selectHeroData_.id, {
			self.selectHeroData_.trialID
		}).id

		self.heroInfoView_:SetProxy(self.selectHeroData_.heroViewProxy)
		self.heroInfoView_:SetHeroInfo((self.selectHeroData_.heroViewProxy:GetHeroData(self.selectHeroData_.id, {
			self.selectHeroData_.trialID
		})))
		self.heroInfoView_:UpdateView()
	end

	self.emptyController_:SetSelectedState(tostring(not self.selectHeroData_ or self.selectHeroData_.id == 0 or not self.selectHeroData_.heroViewProxy))
end

function ChallengeRogueTeamHeroSelectView:InitSubView()
	self.filterView_ = self:GetFilterClass().New(self.filterGo_)

	self.filterView_:SetExtraSorter(handler(self, self.ExtraSorter))

	self.autoClearFilter_ = true
	self.heroInfoView_ = ChallengeRogueTeamSectionHeroInfoView.New(self, self.heroInfoGo_)
end

function ChallengeRogueTeamHeroSelectView:GetHeroList()
	local var_15_0 = {}
	local var_15_1 = ChallengeRogueTeamData:GetHeroList()
	local var_15_2 = ChallengeRogueTeamData:GetUnlockTrailHeroList()

	for iter_15_0, iter_15_1 in pairs(HeroData:GetHeroList()) do
		local var_15_3 = 0

		for iter_15_2, iter_15_3 in pairs(ChallengeRogueTeamData:GetTrialHeroList()) do
			if HeroStandardSystemCfg[iter_15_3].hero_id == iter_15_1.id then
				var_15_3 = iter_15_3
			end
		end

		if not var_15_1[iter_15_1.id] and not var_15_2[var_15_3] then
			var_15_0[iter_15_1.id] = iter_15_1
		end
	end

	return (HeroTools.Sort(var_15_0))
end

function ChallengeRogueTeamHeroSelectView:GetTrialHeroList()
	local var_16_0 = {}
	local var_16_1 = ChallengeRogueTeamData:GetUnlockTrailHeroList()
	local var_16_2 = ChallengeRogueTeamData:GetHeroList()

	for iter_16_0, iter_16_1 in pairs(ChallengeRogueTeamData:GetTrialHeroList()) do
		if not var_16_1[iter_16_1] and not var_16_2[HeroStandardSystemCfg[iter_16_1].hero_id] then
			table.insert(var_16_0, iter_16_1)
		end
	end

	return var_16_0
end

function ChallengeRogueTeamHeroSelectView:RefreshHeroDataList()
	local var_17_0 = {}

	if not self.params_.isBack then
		self.allTrialIDList_ = {}
		self.customHeroList_, self.canSwitchResctrictHeroList_ = SectionSelectHeroTools.GetRestrictHeroList(self.params_.stageType, self.params_.stageID)
		self.curCanSwitchRestrictHero_ = self.canSwitchResctrictHeroList_[self.params_.selectHeroPos] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID

		local var_17_3, var_17_4 = SectionSelectHeroTools.GetRestrictHeroPosDic(self.params_.stageType, self.params_.stageID)

		if self.customHeroList_[self.params_.selectHeroPos][1] then
			self:ProcessCustomHeroData(var_17_0, var_17_4)
		else
			self:ProcessOwnHeroData(var_17_0, var_17_3)
			self:ProcessTrialHeroData(var_17_0, var_17_4)
		end

		for iter_17_0, iter_17_1 in pairs(self.heroViewProxyDic_) do
			iter_17_1:SetTempHeroList(self.allTrialIDList_)
		end

		self.allHeroDataList_ = var_17_0
		self.heroDataList_ = self:FilterHeroDataList(self.allHeroDataList_)
	else
		self.heroDataList_ = self.sortedHeroList_
	end
end

function ChallengeRogueTeamHeroSelectView:FilterHeroDataList(arg_18_1)
	local var_18_0 = {}

	if self.isAll_ then
		var_18_0 = arg_18_1
	else
		for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
			local var_18_1 = HeroCfg[iter_18_1.id]
			local var_18_2 = false

			if iter_18_1.type == HeroConst.HERO_DATA_TYPE.TRIAL then
				if table.indexof(self.recruitedList_, iter_18_1.trialID) then
					var_18_2 = true
				end
			elseif table.indexof(self.recruitedList_, iter_18_1.id) then
				var_18_2 = true
			end

			if var_18_1.ATK_attribute[1] == self.selectTapID_ or var_18_2 then
				table.insert(var_18_0, iter_18_1)
			end
		end
	end

	self:SortHeroList(var_18_0)

	self.sortedHeroList_ = deepClone(var_18_0)

	return var_18_0
end

function ChallengeRogueTeamHeroSelectView:SortHeroList(arg_19_1)
	table.sort(arg_19_1, function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0.type == HeroConst.HERO_DATA_TYPE.TRIAL
		local var_20_1 = arg_20_1.type == HeroConst.HERO_DATA_TYPE.TRIAL
		local var_20_2
		local var_20_3

		var_20_2 = arg_20_0.type == HeroConst.HERO_DATA_TYPE.TRIAL and (table.indexof(self.recruitedList_, arg_20_0.trialID) or 999) or table.indexof(self.recruitedList_, arg_20_0.id) or 999
		var_20_3 = var_20_1 and (table.indexof(self.recruitedList_, arg_20_1.trialID) or 999) or table.indexof(self.recruitedList_, arg_20_1.id) or 999

		if var_20_2 ~= var_20_3 then
			return var_20_2 < var_20_3
		end

		if var_20_0 ~= var_20_1 and (not var_20_0 or not var_20_1) then
			return var_20_0 ~= false
		end

		local var_20_4
		local var_20_5

		if var_20_0 then
			var_20_4 = self.cacheBattlePower_[arg_20_0.trialID] or TempHeroData:GetBattlePower(arg_20_0.trialID)
			self.cacheBattlePower_[arg_20_0.trialID] = var_20_4
		else
			var_20_4 = self.cacheBattlePower_[arg_20_0.id] or arg_20_0.heroViewProxy:GetBattlePower(arg_20_0.id)
			self.cacheBattlePower_[arg_20_0.id] = var_20_4
		end

		if var_20_1 then
			var_20_5 = self.cacheBattlePower_[arg_20_1.trialID] or TempHeroData:GetBattlePower(arg_20_1.trialID)
			self.cacheBattlePower_[arg_20_1.trialID] = var_20_5
		else
			var_20_5 = self.cacheBattlePower_[arg_20_1.id] or arg_20_1.heroViewProxy:GetBattlePower(arg_20_1.id)
			self.cacheBattlePower_[arg_20_1.id] = var_20_5
		end

		if var_20_4 ~= var_20_5 then
			return var_20_5 < var_20_4
		end

		if arg_20_0.star ~= arg_20_0.star then
			return arg_20_0.star > arg_20_1.star
		end

		if HeroCfg[arg_20_0.id].rare ~= HeroCfg[arg_20_1.id].rare then
			return HeroCfg[arg_20_0.id].rare > HeroCfg[arg_20_1.id].rare
		end

		if arg_20_0.exp ~= arg_20_1.exp then
			return arg_20_0.exp > arg_20_1.ext
		end

		return arg_20_0.id < arg_20_1.id
	end)
end

function ChallengeRogueTeamHeroSelectView:OnInfoBtnClick(arg_21_1, arg_21_2)
	self.stopCountimeFlag_ = true

	ChallengeRogueTeamAction.OnPlayingState(ChallengeRogueTeamConst.PLAYING_STATE.EXIT, function()
		return
	end)
	ChallengeRogueTeamData:HeroSetLockState(false)

	local var_21_0 = "/newHero"
	local var_21_1 = {
		isEnter = true
	}

	if arg_21_1.tempID ~= 0 then
		var_21_1.hid = arg_21_1.tempID or arg_21_1.id
	end

	var_21_1.type = arg_21_2 or arg_21_1.tempID ~= 0 and HeroConst.HERO_DATA_TYPE.TRIAL
	var_21_1.tempHeroList = self:GetValidTrailList(arg_21_1.tempID)

	self:Go(var_21_0, var_21_1)

	self.enterScrollPosition_ = self.heroList_:GetScrolledPosition()
end

function ChallengeRogueTeamHeroSelectView:GetValidTrailList(arg_23_1)
	local var_23_0 = {}

	if arg_23_1 ~= 0 then
		for iter_23_0, iter_23_1 in pairs(self.allTrialIDList_) do
			if not HeroTools.IsNPC(HeroStandardSystemCfg[iter_23_1].hero_id) and not HeroTools.NeedHideInfo(HeroStandardSystemCfg[iter_23_1].hero_id) then
				table.insert(var_23_0, iter_23_1)
			end
		end
	end

	return var_23_0
end

function ChallengeRogueTeamHeroSelectView:OnJoinClick()
	if #self.recruitedList_ < self.recruitNumLimit_ then
		ShowMessageBox({
			isTop = true,
			content = GetTips("ROGUE_TEAM_FORGIVE_RECRUIT"),
			OkCallback = function()
				self:RecruitHero()
			end,
			CancelCallback = function()
				return
			end
		})
	else
		self:RecruitHero()
	end

	ChallengeRogueTeamData:HeroSetLockState(true)
end

function ChallengeRogueTeamHeroSelectView:RecruitHero()
	local var_27_0 = {}
	local var_27_1 = {}

	for iter_27_0, iter_27_1 in ipairs(self.recruitedList_) do
		if HeroStandardSystemCfg[iter_27_1] then
			table.insert(var_27_0, HeroStandardSystemCfg[iter_27_1].hero_id)
			table.insert(var_27_1, iter_27_1)
		else
			table.insert(var_27_0, iter_27_1)
			table.insert(var_27_1, 0)
		end
	end

	ChallengeRogueTeamAction.HeroRecruit(var_27_0, var_27_1, function()
		ChallengeRogueTeamData:ClearUnOperateData()
		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		self:Back()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
	end)
end

function ChallengeRogueTeamHeroSelectView:OnExit()
	ChallengeRogueTeamHeroSelectView.super.OnExit(self)

	self.params_.isEnter = false
	self.cacheBattlePower_ = {}

	manager.rogueTeamInGameInfoBox:HideBox()
	manager.rogueTeamMapPreviewBtnBar:HideBar()
end

function ChallengeRogueTeamHeroSelectView:Dispose()
	self.tapView_:Dispose()

	self.stopCountimeFlag_ = false

	ChallengeRogueTeamHeroSelectView.super.Dispose(self)

	if self.tabItemList_ then
		for iter_30_0, iter_30_1 in ipairs(self.tabItemList_) do
			iter_30_1:Dispose()
		end

		self.tabItemList_ = nil
	end

	if self.heroList_ then
		self.heroList_:Dispose()

		self.heroList_ = nil
	end
end

function ChallengeRogueTeamHeroSelectView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ROGUE_TEAM_HERO_DESC")
	manager.rogueTeamMapPreviewBtnBar:ShowBar()
	manager.rogueTeamMapPreviewBtnBar:ShowState(ChallengeRogueTeamConst.MAP_BTN_WINDOW.OTHER)
	ChallengeRogueTeamTools.RegistWindowBarClick()
end

function ChallengeRogueTeamHeroSelectView:InitTapView()
	self.tapTypeList_ = {
		HeroConst.HERO_ATTACK_TYPE.ALL,
		HeroConst.HERO_ATTACK_TYPE.PYISICS,
		HeroConst.HERO_ATTACK_TYPE.WIND,
		HeroConst.HERO_ATTACK_TYPE.FLAME,
		HeroConst.HERO_ATTACK_TYPE.THUNDER,
		HeroConst.HERO_ATTACK_TYPE.DARK,
		HeroConst.HERO_ATTACK_TYPE.LIGHT,
		HeroConst.HERO_ATTACK_TYPE.FREEZE,
		HeroConst.HERO_ATTACK_TYPE.WATER,
		HeroConst.HERO_ATTACK_TYPE.RANDOM
	}
	self.tapView_ = CommonHeroSkillAttributeFilter.New(self.tapGo_)

	self.tapView_:SetAttributeIdList(self.tapTypeList_)
	self.tapView_:SetSelectAttributeCallback(handler(self, self.OnSelectTap))
end

function ChallengeRogueTeamHeroSelectView:ResetTap()
	self.selectTapID_ = 1

	self.tapView_:Reset()
end

function ChallengeRogueTeamHeroSelectView:OnSelectTap(arg_34_1, arg_34_2)
	self.selectTapID_ = arg_34_1
	self.isAll_ = arg_34_2
	self.heroDataList_ = self:FilterHeroDataList(self.allHeroDataList_)

	self.heroList_:StartScroll(#self.heroDataList_)
end

return ChallengeRogueTeamHeroSelectView
