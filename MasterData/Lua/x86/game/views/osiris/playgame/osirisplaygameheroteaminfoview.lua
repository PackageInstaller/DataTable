local OsirisPlayGameHeroTeamInfoView = class("OsirisPlayGameHeroTeamInfoView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function OsirisPlayGameHeroTeamInfoView:UIName()
	return "Widget/System/Formation/Activity_Osiris/FormationChallengeActivityOsirisHeroUI"
end

function OsirisPlayGameHeroTeamInfoView:InitUI()
	self.super.InitUI(self)

	self.heroItemList_ = {}
end

function OsirisPlayGameHeroTeamInfoView:InitSubView()
	self.heroHeadList_ = LuaList.New(handler(self, self.HeadRenderer), self.uiListGo_, self:GetHeroHeadClass())
	self.filterView_ = self:GetFilterClass().New(self.filterGo_)

	self.filterView_:SetExtraSorter(handler(self, self.ExtraSorter))
	self.filterView_:SetListChangeHandler(handler(self, self.OnListChange))

	self.autoClearFilter_ = true
	self.heroInfoView_ = self:GetHeroInfoViewClass().New(self, self.heroInfoGo_)
end

function OsirisPlayGameHeroTeamInfoView:InitController()
	self.super.InitController(self)

	self.supportController_ = self.controller_:GetController("default2")
end

function OsirisPlayGameHeroTeamInfoView:OnEnter()
	OsirisPlayGameData:InitTempHeroData()
	self.super.OnEnter(self)
end

function OsirisPlayGameHeroTeamInfoView:ProcessBaseParams()
	self.super.ProcessBaseParams(self)

	self.canUseMultiMode_ = false
end

function OsirisPlayGameHeroTeamInfoView:UpdateHeroInfoView()
	self.heroInfoView_:SetProxy(self.selectHeroData_.heroViewProxy)
	self.heroInfoView_:SetHeroInfo((self:GetHeroViewProxyData()))
	self.heroInfoView_:UpdateView()
	self:RefreshSimilarityUI()
end

function OsirisPlayGameHeroTeamInfoView:OnExit()
	self.super.OnExit(self)
end

function OsirisPlayGameHeroTeamInfoView:Dispose()
	for iter_9_0, iter_9_1 in ipairs(self.heroItemList_) do
		iter_9_1:Dispose()
	end

	self.heroItemList_ = nil

	OsirisPlayGameHeroTeamInfoView.super.Dispose(self)
end

function OsirisPlayGameHeroTeamInfoView:RefreshUI()
	self.super.RefreshUI(self)
	self:RefreshSimilarityUI()
end

function OsirisPlayGameHeroTeamInfoView:RefreshSingleModeUI()
	self.super.RefreshSingleModeUI(self)

	if self.params_.selectHeroPos == 1 then
		self.supportController_:SetSelectedIndex(0)
	else
		self.supportController_:SetSelectedIndex(1)
		self:RefreshSimilarityUI()
	end
end

function OsirisPlayGameHeroTeamInfoView:RefreshSimilarityUI()
	if self.selectHeroData_ and self.selectHeroData_.id ~= 0 then
		if ActivityGeneralityCharactorCfg[self.selectHeroData_.id].qte_skill > 0 then
			self.skillIcon_.sprite = getSprite("Atlas/" .. self.selectHeroData_.id, ActivityGeneralityQteCfg[ActivityGeneralityCharactorCfg[self.selectHeroData_.id].qte_skill].icon)
		end

		self.skillDescText_.text = GetI18NText((ActivityGeneralityQteCfg[ActivityGeneralityCharactorCfg[self.selectHeroData_.id].qte_skill] or nil) and (ActivityGeneralityQteCfg[ActivityGeneralityCharactorCfg[self.selectHeroData_.id].qte_skill].desc or ""))

		for iter_12_0, iter_12_1 in ipairs(ActivityGeneralityCharactorCfg[self.selectHeroData_.id].generality) do
			self.heroItemList_[iter_12_0] = self.heroItemList_[iter_12_0] or OsirisPlayGameSimilarityItem.New((Object.Instantiate(self.similarityItemGo_, self.similarityTrs_)))

			self.heroItemList_[iter_12_0]:HideAffixInfo()
			self.heroItemList_[iter_12_0]:SetData(iter_12_1, self.params_.sectionProxy.stageID, iter_12_0)
			self.heroItemList_[iter_12_0]:RegisterClickFunc(function(arg_13_0)
				for iter_13_0 = 1, #self.heroItemList_ do
					if iter_13_0 ~= arg_13_0 then
						self.heroItemList_[iter_13_0]:HideAffixInfo()
					end
				end
			end)
		end

		for iter_12_2 = #ActivityGeneralityCharactorCfg[self.selectHeroData_.id].generality + 1, #self.heroItemList_ do
			if self.heroItemList_[iter_12_2] then
				self.heroItemList_[iter_12_2]:Show(false)
			end
		end
	end
end

function OsirisPlayGameHeroTeamInfoView:GetHeroList()
	local var_14_0 = OsirisPlayGameData:GetCurHeroDataType()
	local var_14_1 = {}

	for iter_14_0, iter_14_1 in pairs((OsirisPlayGameTempHeroData:GetHeroList())) do
		if var_14_0 == ActivityGeneralityCharactorCfg[iter_14_1].charactor_type then
			table.insert(var_14_1, iter_14_1)
		end
	end

	return var_14_1
end

function OsirisPlayGameHeroTeamInfoView:GetTrialHeroList()
	local var_15_0 = OsirisPlayGameData:GetCurHeroDataType()
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in pairs((OsirisPlayGameTempHeroData:GetTrialHeroList())) do
		if var_15_0 == ActivityGeneralityCharactorCfg[ActivityGeneralityCharactorCfg.get_id_list_by_charactor_id[iter_15_1][1]].charactor_type then
			table.insert(var_15_1, iter_15_1)
		end
	end

	return var_15_1
end

function OsirisPlayGameHeroTeamInfoView:GetHeroViewProxyData()
	return (self.selectHeroData_.heroViewProxy:GetHeroData(self.selectHeroData_.id, self.selectHeroData_.trialID))
end

function OsirisPlayGameHeroTeamInfoView:GetHeroHeadClass()
	return OsirisPlayGameSectionHeroTeamHeadItem
end

function OsirisPlayGameHeroTeamInfoView:HeadRenderer(arg_18_1, arg_18_2)
	local var_18_0 = self.heroDataList_[arg_18_1].id
	local var_18_1 = self.heroDataList_[arg_18_1].trialID

	arg_18_2:SetSectionHeroData(self.heroDataList_[arg_18_1])
	arg_18_2:RegisterClickListener(function()
		if self.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE then
			self:SingleModeSelectHero(self.heroDataList_[arg_18_1])
		else
			self:MultiModeChangeTeam(self.heroDataList_[arg_18_1])
		end
	end)
	arg_18_2:SetHeroLock(self:IsHeroLock(var_18_0, var_18_1))
	arg_18_2:SetSelected(arg_18_2.heroId_ == self.selectHeroData_.id and arg_18_2.trialID_ == self.selectHeroData_.trialID)

	if self.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE then
		arg_18_2:SetInTeamFlag(self:IsInTeam(var_18_0, var_18_1))
		arg_18_2:SetMultiPos(false)
	else
		arg_18_2:SetInTeamFlag(false)
		arg_18_2:SetMultiPos(self:IsInTeam(var_18_0, var_18_1))
	end

	arg_18_2:SetOsiris((self:GetValid(var_18_0, ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[self.sectionProxy_.stageID][1]].generality)))
end

function OsirisPlayGameHeroTeamInfoView:ProcessHeroDataList(arg_20_1, arg_20_2, arg_20_3)
	if self.customHeroList_[self.params_.selectHeroPos][1] then
		self:ProcessCustomHeroData(arg_20_1, arg_20_2)
	else
		self:ProcessOwnHeroData(arg_20_1, arg_20_3)
		self:ProcessTrialHeroData(arg_20_1, arg_20_2)
	end
end

function OsirisPlayGameHeroTeamInfoView:GetValid(arg_21_1, arg_21_2)
	for iter_21_0, iter_21_1 in ipairs(ActivityGeneralityCharactorCfg[arg_21_1].generality) do
		if arg_21_2 == iter_21_1 then
			return true
		end
	end

	return false
end

function OsirisPlayGameHeroTeamInfoView:ExtraSorter(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0, var_22_1, var_22_2 = SectionSelectHeroTools.IsInTeam(arg_22_1.id, arg_22_1.trialID, self.heroTeam_, self.heroTrialList_)
	local var_22_3, var_22_4, var_22_5 = SectionSelectHeroTools.IsInTeam(arg_22_2.id, arg_22_2.trialID, self.heroTeam_, self.heroTrialList_)

	if var_22_0 ~= var_22_3 then
		if var_22_0 and not var_22_3 then
			return true, true
		elseif not var_22_0 and var_22_3 then
			return true, false
		else
			return true, var_22_2 < var_22_5
		end
	end

	local var_22_6 = ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[self.stageID_][1]].generality
	local var_22_9 = ActivityGeneralityCharactorCfg[arg_22_2.trialID ~= 0 and ActivityGeneralityCharactorCfg.get_id_list_by_charactor_id[arg_22_2.trialID][1] or arg_22_2.id].generality

	arg_22_1.generality = 0
	arg_22_2.generality = 0

	for iter_22_0, iter_22_1 in ipairs(ActivityGeneralityCharactorCfg[arg_22_1.trialID ~= 0 and ActivityGeneralityCharactorCfg.get_id_list_by_charactor_id[arg_22_1.trialID][1] or arg_22_1.id].generality) do
		if var_22_6 == iter_22_1 then
			arg_22_1.generality = 1
		end
	end

	for iter_22_2, iter_22_3 in ipairs(var_22_9) do
		if var_22_6 == iter_22_3 then
			arg_22_2.generality = 1
		end
	end

	if arg_22_1.trialID ~= 0 and arg_22_2.trialID ~= 0 then
		if arg_22_1.generality ~= arg_22_2.generality then
			return true, arg_22_1.generality > arg_22_2.generality
		else
			return true, arg_22_1.trialID > arg_22_2.trialID
		end
	elseif arg_22_1.trialID ~= 0 and arg_22_2.trialID == 0 or arg_22_1.trialID == 0 and arg_22_2.trialID ~= 0 then
		if arg_22_1.generality ~= arg_22_2.generality then
			return true, arg_22_1.generality > arg_22_2.generality
		else
			return true, arg_22_1.trialID > arg_22_2.trialID
		end
	elseif arg_22_1.generality ~= arg_22_2.generality then
		return true, arg_22_1.generality > arg_22_2.generality
	else
		local var_22_10 = HeroData:IsFavorite(arg_22_1.id) and HeroData:IsFavorite(arg_22_1.id) or 0
		local var_22_11 = HeroData:IsFavorite(arg_22_2.id) and HeroData:IsFavorite(arg_22_2.id) or 0

		if var_22_10 ~= var_22_11 then
			return true, var_22_11 < var_22_10
		else
			local var_22_12 = getHeroPower(arg_22_1.id, false)
			local var_22_13 = getHeroPower(arg_22_2.id, false)

			if var_22_12 ~= var_22_13 then
				if arg_22_4 == "desc" then
					return true, var_22_13 < var_22_12
				else
					return true, var_22_12 < var_22_13
				end
			else
				return true, arg_22_1.id > arg_22_2.id
			end
		end
	end

	return false, false
end

function OsirisPlayGameHeroTeamInfoView:Reset()
	if not self.params_.isBack then
		if self.filterView_ and self.autoClearFilter_ then
			self.filterView_:Reset(true)
			CommonFilterData:ClearFilter(Filter_Root_Define.Osiris_Hero_Filter_List.filter_id)
		end

		self:ResetSelectMode()
	end
end

function OsirisPlayGameHeroTeamInfoView:GetFilterClass()
	return OsirisPlayGameHeroListFilterView
end

function OsirisPlayGameHeroTeamInfoView:GetHeroInfoViewClass()
	return OsirisPlayGameHeroInfoView
end

return OsirisPlayGameHeroTeamInfoView
