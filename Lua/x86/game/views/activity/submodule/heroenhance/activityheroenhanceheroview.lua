local var_0_0 = class("ActivityHeroEnhanceHeroView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivityHeroEnhanceTools.GetHeroUIName(arg_1_0.params_.activityID)
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

	arg_4_0.heroList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexHeroItem), arg_4_0.heroUiListGo_, ActivityHeroEnhanceHeroItem)
	arg_4_0.middleView_ = ActivityHeroEnhanceTalentView.New(arg_4_0.talentUIGo_)
	arg_4_0.detailView_ = ActivityHeroEnhanceTalentDetailView.New(arg_4_0.talentDetailGo_)
	arg_4_0.statusController_ = arg_4_0.controller_:GetController("status")

	arg_4_0.statusController_:SetSelectedState("main")
	SetActive(arg_4_0.talentDetailGo_, false)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(nil, arg_5_0.goBtn_, function()
		arg_5_0:OnClickGoBtn()
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.bgBtn_, function()
		arg_5_0:OnClickBgBtn()
	end)
	arg_5_0.middleView_:SetClickTalentHandler(function(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
		if arg_8_2 then
			arg_5_0:SelectGroup(arg_8_1)
		else
			arg_8_0:SelectIdx(arg_8_5)
			arg_5_0:SelectTalent(arg_8_4)

			arg_5_0.lastTalentIdx_ = arg_8_5
		end
	end)
	arg_5_0.detailView_:SetClickBtnHandler(function(arg_9_0, arg_9_1)
		if arg_9_0 then
			arg_5_0:OnClickUseTalent(arg_9_1)
		else
			arg_5_0:OnClickDropTalent(arg_9_1)
		end
	end)
end

function var_0_0.OnEnter(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_10_0:Back()
	end)

	arg_10_0.activityId_ = arg_10_0.params_.activityID
	arg_10_0.cfgIdList_ = ActivityHeroEnhanceTools.GetCfgIdList(arg_10_0.activityId_)

	if not arg_10_0.cfgId_ then
		if var_0_0.enterBattleCfgId_ then
			arg_10_0.cfgId_ = var_0_0.enterBattleCfgId_
			var_0_0.enterBattleCfgId_ = nil

			local var_10_0 = table.indexof(arg_10_0.cfgIdList_, arg_10_0.cfgId_)

			arg_10_0:SelectHero(var_10_0)
		else
			arg_10_0.cfgId_ = arg_10_0.cfgIdList_[1]
		end
	end

	local var_10_1 = arg_10_0.params_.stageToView
	local var_10_2 = arg_10_0.params_.talentIdToView

	if var_10_2 or var_10_1 then
		arg_10_0.cfgId_ = arg_10_0.params_.cfgId

		local var_10_3 = ActivityHeroEnhanceCfg[arg_10_0.cfgId_]
		local var_10_4 = ActivityHeroEnhanceTools.GetCfgTalentListByStage(var_10_3, var_10_1)

		var_10_2 = var_10_2 or var_10_4[1]

		local var_10_5 = table.indexof(var_10_4, var_10_2)

		arg_10_0:SelectGroup(var_10_1, var_10_5)

		arg_10_0.params_.talentIdToView = nil
		arg_10_0.params_.stageToView = nil
		arg_10_0.params_.cfgId = nil
		arg_10_0.section_CfgId_ = arg_10_0.cfgId_
		arg_10_0.cfgIdList_ = {
			arg_10_0.section_CfgId_
		}
	else
		arg_10_0:OnClickBgBtn()
	end

	arg_10_0:RefreshUI()
	arg_10_0.middleView_:OnEnter()
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
	arg_12_0:UpdateRedPointUI(true)
	arg_12_0.middleView_:OnExit()

	arg_12_0.lastGroupIdx_ = nil
	arg_12_0.lastTalentIdx_ = nil
end

function var_0_0.RefreshUI(arg_13_0)
	arg_13_0.heroList_:StartScroll(#arg_13_0.cfgIdList_)
end

function var_0_0.IndexHeroItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.cfgIdList_[arg_14_1]

	arg_14_2:SetData(var_14_0)
	arg_14_2:SetClickHandler(function(arg_15_0)
		arg_14_0:OnClickHero(arg_14_1, arg_14_2, arg_15_0)
	end)

	local var_14_1, var_14_2 = arg_14_0.heroList_:GetHeadAndTail()
	local var_14_3 = arg_14_1 == var_14_2

	if arg_14_0:GetHeroSelectIdx() == nil and arg_14_1 == 1 then
		var_14_3 = false

		arg_14_0:SelectHero(1)
	end

	arg_14_2:SetSelected(arg_14_0:GetHeroSelectIdx() == arg_14_1)
	arg_14_2:RefreshUI()

	if var_14_3 then
		arg_14_0:UpdateRedPointUI(false)
	end
end

function var_0_0.OnClickHero(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0.cfgIdList_[arg_16_1]
	local var_16_1 = ActivityHeroEnhanceCfg[var_16_0]

	if ActivityHeroEnhanceTools.IsCfgHeroLock(var_16_1) then
		return
	end

	arg_16_0:SelectHero(arg_16_1)

	if arg_16_0.lastGroupIdx_ and arg_16_0.lastTalentIdx_ then
		arg_16_0:SelectGroup(arg_16_0.lastGroupIdx_, arg_16_0.lastTalentIdx_)
	end
end

function var_0_0.SelectHero(arg_17_0, arg_17_1)
	arg_17_0:SetHeroSelectIdx(arg_17_1)

	local var_17_0 = arg_17_0.cfgIdList_[arg_17_1]
	local var_17_1 = ActivityHeroEnhanceCfg[var_17_0]

	arg_17_0.cfgId_ = var_17_0
	arg_17_0.heroId_ = var_17_1.hero_id

	arg_17_0.middleView_:SetData(var_17_0)
	arg_17_0.middleView_:RefreshUI()

	for iter_17_0, iter_17_1 in pairs(arg_17_0.heroList_:GetItemList()) do
		iter_17_1:SetSelected(arg_17_0:GetHeroSelectIdx() == iter_17_0)
		iter_17_1:RefreshUI()
	end

	arg_17_0:UpdateRedPointUI(false)
end

function var_0_0.OnClickUseTalent(arg_18_0, arg_18_1)
	ActivityHeroEnhanceAction.ActivateTalent(arg_18_0.activityId_, arg_18_0.heroId_, arg_18_1, function()
		arg_18_0.middleView_:RefreshUI()
		arg_18_0.detailView_:RefreshUI()
	end)
end

function var_0_0.OnClickDropTalent(arg_20_0, arg_20_1)
	ActivityHeroEnhanceAction.DeactivateTalent(arg_20_0.activityId_, arg_20_1, function()
		arg_20_0.middleView_:RefreshUI()
		arg_20_0.detailView_:RefreshUI()
	end)
end

function var_0_0.SelectGroup(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = ActivityHeroEnhanceCfg[arg_22_0.cfgId_]
	local var_22_1 = ActivityHeroEnhanceTools.GetCfgTalentListByStage(var_22_0, arg_22_1)

	if arg_22_2 == nil then
		arg_22_2 = ActivityHeroEnhanceTools.GetTalentListActivatedIdx(arg_22_0.activityId_, var_22_1)

		if arg_22_2 <= 0 then
			if arg_22_0.lastGroupIdx_ == arg_22_1 then
				arg_22_2 = arg_22_0.lastTalentIdx_ and arg_22_0.lastTalentIdx_ or 1
			else
				arg_22_2 = 1
			end
		end
	end

	arg_22_0.middleView_:SelectGroupIdx(arg_22_1, arg_22_2)
	arg_22_0.middleView_:RefreshUI_SelectState()
	arg_22_0:SelectTalent(var_22_1[arg_22_2])

	arg_22_0.lastGroupIdx_ = arg_22_1
	arg_22_0.lastTalentIdx_ = arg_22_2
end

function var_0_0.SelectTalent(arg_23_0, arg_23_1)
	arg_23_0.detailView_:SetData(arg_23_0.activityId_, arg_23_1)
	arg_23_0.detailView_:RefreshUI()
	arg_23_0:PlayEnterAni()
end

function var_0_0.OnClickBgBtn(arg_24_0)
	arg_24_0.middleView_:SelectGroupIdx(0)
	arg_24_0.middleView_:RefreshUI_SelectState()
	arg_24_0:PlayExitAni()

	arg_24_0.lastGroupIdx_ = nil
	arg_24_0.lastTalentIdx_ = nil
end

function var_0_0.OnClickGoBtn(arg_25_0)
	local var_25_0 = arg_25_0.cfgIdList_[arg_25_0:GetHeroSelectIdx()]

	arg_25_0:JumpToSection(var_25_0)

	local var_25_1 = arg_25_0.activityId_
	local var_25_2 = ActivityTools.GetRedPointKey(var_25_1) .. var_25_1
	local var_25_3 = ActivityHeroEnhanceCfg[var_25_0].hero_id
	local var_25_4 = string.format("%s_%d_%s", RedPointConst.ACTIVITY_HERO_ENHANCE_STAGE_REWARD, var_25_3, var_25_2)

	ActivityHeroEnhanceAction.BanRedPoint(var_25_1, var_25_4)
end

function var_0_0.JumpToSection(arg_26_0, arg_26_1)
	arg_26_0.section_CfgId_ = nil

	JumpTools.OpenPageByJump("/activityHeroEnhanceSection", {
		activityID = arg_26_0.params_.activityID,
		cfgId = arg_26_1
	})
end

function var_0_0.PlayEnterAni(arg_27_0)
	arg_27_0.isEntered_ = true

	arg_27_0.statusController_:SetSelectedState("detail")
	SetActive(arg_27_0.talentDetailGo_, true)
end

function var_0_0.PlayExitAni(arg_28_0)
	arg_28_0.isEntered_ = false

	arg_28_0.statusController_:SetSelectedState("main")
	SetActive(arg_28_0.talentDetailGo_, false)
end

function var_0_0.Back(arg_29_0)
	if arg_29_0.isEntered_ then
		arg_29_0:OnClickBgBtn()
	elseif arg_29_0.section_CfgId_ then
		arg_29_0:JumpToSection(arg_29_0.section_CfgId_)
	else
		var_0_0.super.Back(arg_29_0)
	end
end

function var_0_0.UpdateRedPointUI(arg_30_0, arg_30_1)
	if arg_30_0.redPointHistory_ then
		for iter_30_0, iter_30_1 in pairs(arg_30_0.redPointHistory_) do
			manager.redPoint:unbindUIandKey(iter_30_0, iter_30_1)
		end
	end

	arg_30_0.redPointHistory_ = {}

	if arg_30_1 then
		return
	end

	local var_30_0 = arg_30_0.activityId_
	local var_30_1 = ActivityHeroEnhanceCfg.get_id_list_by_activity_id[var_30_0]
	local var_30_2 = ActivityTools.GetRedPointKey(var_30_0) .. var_30_0

	for iter_30_2, iter_30_3 in ipairs(var_30_1) do
		local var_30_3 = ActivityHeroEnhanceCfg[iter_30_3].hero_id
		local var_30_4 = string.format("%s_%d_%s", RedPointConst.ACTIVITY_HERO_ENHANCE_STAGE_REWARD, var_30_3, var_30_2)

		if var_30_3 == arg_30_0.heroId_ then
			arg_30_0.redPointHistory_[arg_30_0.goBtn_.transform] = var_30_4
		end

		local var_30_5 = arg_30_0:GetHeroItemByCfgId(iter_30_3)

		if var_30_5 then
			local var_30_6 = var_30_5:GetRedPointTransform()

			arg_30_0.redPointHistory_[var_30_6] = var_30_4
		end
	end

	for iter_30_4, iter_30_5 in pairs(arg_30_0.redPointHistory_) do
		manager.redPoint:bindUIandKey(iter_30_4, iter_30_5)
	end
end

function var_0_0.GetHeroItemByCfgId(arg_31_0, arg_31_1)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.heroList_:GetItemList()) do
		if iter_31_1:GetCfgId() == arg_31_1 then
			return iter_31_1
		end
	end

	return nil
end

function var_0_0.GetHeroSelectIdx(arg_32_0)
	if arg_32_0.section_CfgId_ and arg_32_0.heroSelectIdx_ then
		return 1
	end

	return arg_32_0.heroSelectIdx_
end

function var_0_0.SetHeroSelectIdx(arg_33_0, arg_33_1)
	if arg_33_0.section_CfgId_ then
		if not arg_33_0.heroSelectIdx_ then
			local var_33_0 = ActivityHeroEnhanceTools.GetCfgIdList(arg_33_0.activityId_)

			arg_33_0.heroSelectIdx_ = table.indexof(var_33_0, arg_33_0.section_CfgId_)
		end

		return
	end

	arg_33_0.heroSelectIdx_ = arg_33_1
end

function var_0_0.Dispose(arg_34_0)
	arg_34_0.middleView_:Dispose()
	arg_34_0.detailView_:Dispose()
	arg_34_0.heroList_:Dispose()
	var_0_0.super.Dispose(arg_34_0)
end

function var_0_0.OnNewDay(arg_35_0)
	arg_35_0:RefreshUI()
end

function var_0_0.OnActivityHeroEnhanceDataInit(arg_36_0)
	arg_36_0:OnNewDay()
end

return var_0_0
