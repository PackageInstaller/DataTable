local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("OsirisPlayGameHeroTeamInfoView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Formation/Activity_Osiris/FormationChallengeActivityOsirisHeroUI"
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0.super.InitUI(arg_2_0)

	arg_2_0.heroItemList_ = {}
end

function var_0_1.InitSubView(arg_3_0)
	arg_3_0.heroHeadList_ = LuaList.New(handler(arg_3_0, arg_3_0.HeadRenderer), arg_3_0.uiListGo_, arg_3_0:GetHeroHeadClass())
	arg_3_0.filterView_ = arg_3_0:GetFilterClass().New(arg_3_0.filterGo_)

	arg_3_0.filterView_:SetExtraSorter(handler(arg_3_0, arg_3_0.ExtraSorter))
	arg_3_0.filterView_:SetListChangeHandler(handler(arg_3_0, arg_3_0.OnListChange))

	arg_3_0.autoClearFilter_ = true
	arg_3_0.heroInfoView_ = arg_3_0:GetHeroInfoViewClass().New(arg_3_0, arg_3_0.heroInfoGo_)
end

function var_0_1.InitController(arg_4_0)
	arg_4_0.super.InitController(arg_4_0)

	arg_4_0.supportController_ = arg_4_0.controller_:GetController("default2")
end

function var_0_1.OnEnter(arg_5_0)
	OsirisPlayGameData:InitTempHeroData()
	arg_5_0.super.OnEnter(arg_5_0)
end

function var_0_1.ProcessBaseParams(arg_6_0)
	arg_6_0.super.ProcessBaseParams(arg_6_0)

	arg_6_0.canUseMultiMode_ = false
end

function var_0_1.UpdateHeroInfoView(arg_7_0)
	local var_7_0 = arg_7_0.selectHeroData_.id
	local var_7_1 = arg_7_0:GetHeroViewProxyData()

	arg_7_0.heroInfoView_:SetProxy(arg_7_0.selectHeroData_.heroViewProxy)
	arg_7_0.heroInfoView_:SetHeroInfo(var_7_1)
	arg_7_0.heroInfoView_:UpdateView()
	arg_7_0:RefreshSimilarityUI()
end

function var_0_1.OnExit(arg_8_0)
	arg_8_0.super.OnExit(arg_8_0)
end

function var_0_1.Dispose(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.heroItemList_) do
		iter_9_1:Dispose()
	end

	arg_9_0.heroItemList_ = nil

	var_0_1.super.Dispose(arg_9_0)
end

function var_0_1.RefreshUI(arg_10_0)
	arg_10_0.super.RefreshUI(arg_10_0)
	arg_10_0:RefreshSimilarityUI()
end

function var_0_1.RefreshSingleModeUI(arg_11_0)
	arg_11_0.super.RefreshSingleModeUI(arg_11_0)

	if arg_11_0.params_.selectHeroPos == 1 then
		arg_11_0.supportController_:SetSelectedIndex(0)
	else
		arg_11_0.supportController_:SetSelectedIndex(1)
		arg_11_0:RefreshSimilarityUI()
	end
end

function var_0_1.RefreshSimilarityUI(arg_12_0)
	local var_12_0 = arg_12_0.selectHeroData_

	if var_12_0 and var_12_0.id ~= 0 then
		local var_12_1 = ActivityGeneralityCharactorCfg[var_12_0.id].qte_skill

		if var_12_1 > 0 then
			local var_12_2 = ActivityGeneralityQteCfg[var_12_1].icon

			arg_12_0.skillIcon_.sprite = getSprite("Atlas/" .. var_12_0.id, var_12_2)
		end

		arg_12_0.skillDescText_.text = GetI18NText(ActivityGeneralityQteCfg[var_12_1] and ActivityGeneralityQteCfg[var_12_1].desc or "")

		local var_12_3 = ActivityGeneralityCharactorCfg[var_12_0.id].generality
		local var_12_4 = arg_12_0.params_.sectionProxy.stageID

		for iter_12_0, iter_12_1 in ipairs(var_12_3) do
			if not arg_12_0.heroItemList_[iter_12_0] then
				local var_12_5 = Object.Instantiate(arg_12_0.similarityItemGo_, arg_12_0.similarityTrs_)

				arg_12_0.heroItemList_[iter_12_0] = OsirisPlayGameSimilarityItem.New(var_12_5)
			end

			arg_12_0.heroItemList_[iter_12_0]:HideAffixInfo()
			arg_12_0.heroItemList_[iter_12_0]:SetData(iter_12_1, var_12_4, iter_12_0)
			arg_12_0.heroItemList_[iter_12_0]:RegisterClickFunc(function(arg_13_0)
				for iter_13_0 = 1, #arg_12_0.heroItemList_ do
					if iter_13_0 ~= arg_13_0 then
						arg_12_0.heroItemList_[iter_13_0]:HideAffixInfo()
					end
				end
			end)
		end

		for iter_12_2 = #var_12_3 + 1, #arg_12_0.heroItemList_ do
			if arg_12_0.heroItemList_[iter_12_2] then
				arg_12_0.heroItemList_[iter_12_2]:Show(false)
			end
		end
	end
end

function var_0_1.GetHeroList(arg_14_0)
	local var_14_0 = OsirisPlayGameTempHeroData:GetHeroList()
	local var_14_1 = OsirisPlayGameData:GetCurHeroDataType()
	local var_14_2 = {}

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		if var_14_1 == ActivityGeneralityCharactorCfg[iter_14_1].charactor_type then
			table.insert(var_14_2, iter_14_1)
		end
	end

	return var_14_2
end

function var_0_1.GetTrialHeroList(arg_15_0)
	local var_15_0 = OsirisPlayGameTempHeroData:GetTrialHeroList()
	local var_15_1 = OsirisPlayGameData:GetCurHeroDataType()
	local var_15_2 = {}

	for iter_15_0, iter_15_1 in pairs(var_15_0) do
		local var_15_3 = ActivityGeneralityCharactorCfg.get_id_list_by_charactor_id[iter_15_1][1]

		if var_15_1 == ActivityGeneralityCharactorCfg[var_15_3].charactor_type then
			table.insert(var_15_2, iter_15_1)
		end
	end

	return var_15_2
end

function var_0_1.GetHeroViewProxyData(arg_16_0)
	local var_16_0 = arg_16_0.selectHeroData_.id

	return (arg_16_0.selectHeroData_.heroViewProxy:GetHeroData(var_16_0, arg_16_0.selectHeroData_.trialID))
end

function var_0_1.GetHeroHeadClass(arg_17_0)
	return OsirisPlayGameSectionHeroTeamHeadItem
end

function var_0_1.HeadRenderer(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.heroDataList_[arg_18_1].id
	local var_18_1 = arg_18_0.heroDataList_[arg_18_1].trialID

	arg_18_2:SetSectionHeroData(arg_18_0.heroDataList_[arg_18_1])
	arg_18_2:RegisterClickListener(function()
		if arg_18_0.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE then
			arg_18_0:SingleModeSelectHero(arg_18_0.heroDataList_[arg_18_1])
		else
			arg_18_0:MultiModeChangeTeam(arg_18_0.heroDataList_[arg_18_1])
		end
	end)
	arg_18_2:SetHeroLock(arg_18_0:IsHeroLock(var_18_0, var_18_1))
	arg_18_2:SetSelected(arg_18_2.heroId_ == arg_18_0.selectHeroData_.id and arg_18_2.trialID_ == arg_18_0.selectHeroData_.trialID)

	if arg_18_0.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE then
		arg_18_2:SetInTeamFlag(arg_18_0:IsInTeam(var_18_0, var_18_1))
		arg_18_2:SetMultiPos(false)
	else
		arg_18_2:SetInTeamFlag(false)
		arg_18_2:SetMultiPos(arg_18_0:IsInTeam(var_18_0, var_18_1))
	end

	local var_18_2 = arg_18_0.sectionProxy_.stageID
	local var_18_3 = ActivityGeneralityStageCfg.get_id_list_by_stage_id[var_18_2][1]
	local var_18_4 = ActivityGeneralityStageCfg[var_18_3].generality
	local var_18_5 = arg_18_0:GetValid(var_18_0, var_18_4)

	arg_18_2:SetOsiris(var_18_5)
end

function var_0_1.ProcessHeroDataList(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_0.customHeroList_[arg_20_0.params_.selectHeroPos][1] then
		arg_20_0:ProcessCustomHeroData(arg_20_1, arg_20_2)
	else
		arg_20_0:ProcessOwnHeroData(arg_20_1, arg_20_3)
		arg_20_0:ProcessTrialHeroData(arg_20_1, arg_20_2)
	end
end

function var_0_1.GetValid(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = ActivityGeneralityCharactorCfg[arg_21_1].generality

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if arg_21_2 == iter_21_1 then
			return true
		end
	end

	return false
end

function var_0_1.ExtraSorter(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0, var_22_1, var_22_2 = SectionSelectHeroTools.IsInTeam(arg_22_1.id, arg_22_1.trialID, arg_22_0.heroTeam_, arg_22_0.heroTrialList_)
	local var_22_3, var_22_4, var_22_5 = SectionSelectHeroTools.IsInTeam(arg_22_2.id, arg_22_2.trialID, arg_22_0.heroTeam_, arg_22_0.heroTrialList_)

	if var_22_0 ~= var_22_3 then
		if var_22_0 and not var_22_3 then
			return true, true
		elseif not var_22_0 and var_22_3 then
			return true, false
		else
			return true, var_22_2 < var_22_5
		end
	end

	local var_22_6 = ActivityGeneralityStageCfg.get_id_list_by_stage_id[arg_22_0.stageID_][1]
	local var_22_7 = ActivityGeneralityStageCfg[var_22_6].generality
	local var_22_8 = 0
	local var_22_9 = 0

	if arg_22_1.trialID ~= 0 then
		var_22_8 = ActivityGeneralityCharactorCfg.get_id_list_by_charactor_id[arg_22_1.trialID][1]
	else
		var_22_8 = arg_22_1.id
	end

	local var_22_10 = ActivityGeneralityCharactorCfg[var_22_8].generality

	if arg_22_2.trialID ~= 0 then
		var_22_9 = ActivityGeneralityCharactorCfg.get_id_list_by_charactor_id[arg_22_2.trialID][1]
	else
		var_22_9 = arg_22_2.id
	end

	local var_22_11 = ActivityGeneralityCharactorCfg[var_22_9].generality

	arg_22_1.generality = 0
	arg_22_2.generality = 0

	for iter_22_0, iter_22_1 in ipairs(var_22_10) do
		if var_22_7 == iter_22_1 then
			arg_22_1.generality = 1
		end
	end

	for iter_22_2, iter_22_3 in ipairs(var_22_11) do
		if var_22_7 == iter_22_3 then
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
		local var_22_12 = HeroData:IsFavorite(arg_22_1.id) and HeroData:IsFavorite(arg_22_1.id) or 0
		local var_22_13 = HeroData:IsFavorite(arg_22_2.id) and HeroData:IsFavorite(arg_22_2.id) or 0

		if var_22_12 ~= var_22_13 then
			return true, var_22_13 < var_22_12
		else
			local var_22_14 = getHeroPower(arg_22_1.id, false)
			local var_22_15 = getHeroPower(arg_22_2.id, false)

			if var_22_14 ~= var_22_15 then
				if arg_22_4 == "desc" then
					return true, var_22_15 < var_22_14
				else
					return true, var_22_14 < var_22_15
				end
			else
				return true, arg_22_1.id > arg_22_2.id
			end
		end
	end

	return false, false
end

function var_0_1.Reset(arg_23_0)
	if not arg_23_0.params_.isBack then
		if arg_23_0.filterView_ and arg_23_0.autoClearFilter_ then
			arg_23_0.filterView_:Reset(true)
			CommonFilterData:ClearFilter(Filter_Root_Define.Osiris_Hero_Filter_List.filter_id)
		end

		arg_23_0:ResetSelectMode()
	end
end

function var_0_1.GetFilterClass(arg_24_0)
	return OsirisPlayGameHeroListFilterView
end

function var_0_1.GetHeroInfoViewClass(arg_25_0)
	return OsirisPlayGameHeroInfoView
end

return var_0_1
