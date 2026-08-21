local var_0_0 = class("ActivityHeroEnhanceHeroView_4_5", ReduxView)

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
	arg_10_0.talentID_ = nil

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
	arg_13_0.middleView_:SetData(arg_13_0.cfgId_)
	arg_13_0.middleView_:RefreshUI()
	arg_13_0:UpdateRedPointUI(false)
end

function var_0_0.SelectGroup(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = ActivityHeroEnhanceCfg[arg_14_0.cfgId_]
	local var_14_1 = ActivityHeroEnhanceTools.GetCfgTalentListByStage(var_14_0, arg_14_1)

	if arg_14_2 == nil then
		arg_14_2 = ActivityHeroEnhanceTools.GetTalentListActivatedIdx(arg_14_0.activityId_, var_14_1)

		if arg_14_2 <= 0 then
			if arg_14_0.lastGroupIdx_ == arg_14_1 then
				arg_14_2 = arg_14_0.lastTalentIdx_ and arg_14_0.lastTalentIdx_ or 1
			else
				arg_14_2 = 1
			end
		end
	end

	arg_14_0.middleView_:SelectGroupIdx(arg_14_1, arg_14_2)
	arg_14_0.middleView_:RefreshUI_SelectState()
	arg_14_0:SelectTalent(var_14_1[arg_14_2])

	arg_14_0.lastGroupIdx_ = arg_14_1
	arg_14_0.lastTalentIdx_ = arg_14_2
end

function var_0_0.SelectTalent(arg_15_0, arg_15_1)
	if arg_15_0.talentID_ == arg_15_1 then
		return
	end

	arg_15_0.talentID_ = arg_15_1

	arg_15_0.detailView_:SetData(arg_15_0.activityId_, arg_15_1)
	arg_15_0.detailView_:RefreshUI()
	arg_15_0:PlayEnterAni()
end

function var_0_0.OnClickBgBtn(arg_16_0)
	arg_16_0.middleView_:SelectGroupIdx(0)
	arg_16_0.middleView_:RefreshUI_SelectState()
	arg_16_0:PlayExitAni()

	arg_16_0.lastGroupIdx_ = nil
	arg_16_0.lastTalentIdx_ = nil
end

function var_0_0.JumpToSection(arg_17_0, arg_17_1)
	arg_17_0.section_CfgId_ = nil

	JumpTools.OpenPageByJump("/activityHeroEnhanceSection_4_5", {
		activityID = arg_17_0.params_.activityID,
		cfgId = arg_17_1
	})
end

function var_0_0.PlayEnterAni(arg_18_0)
	arg_18_0.isEntered_ = true

	arg_18_0.statusController_:SetSelectedState("detail")
	SetActive(arg_18_0.talentDetailGo_, true)
end

function var_0_0.PlayExitAni(arg_19_0)
	arg_19_0.isEntered_ = false

	arg_19_0.statusController_:SetSelectedState("main")
	SetActive(arg_19_0.talentDetailGo_, false)
end

function var_0_0.Back(arg_20_0)
	if arg_20_0.isEntered_ then
		arg_20_0:OnClickBgBtn()
	end

	if arg_20_0.section_CfgId_ then
		arg_20_0:JumpToSection(arg_20_0.section_CfgId_)
	else
		var_0_0.super.Back(arg_20_0)
	end
end

function var_0_0.UpdateRedPointUI(arg_21_0, arg_21_1)
	return
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0.middleView_:Dispose()
	arg_22_0.detailView_:Dispose()
	var_0_0.super.Dispose(arg_22_0)
end

function var_0_0.OnNewDay(arg_23_0)
	arg_23_0:RefreshUI()
end

function var_0_0.OnActivityHeroEnhanceDataInit(arg_24_0)
	arg_24_0:OnNewDay()
end

return var_0_0
