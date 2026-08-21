local var_0_0 = class("ActivityHeroEnhanceTalentDetailView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.expanded_ = false
	arg_1_0.selected_ = false

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.talentItem_ = ActivityHeroEnhanceTalentItem.New(arg_2_0.curTalentGo_)
	arg_2_0.lineController_ = arg_2_0.controller_:GetController("line")

	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0.talentItem_:SetClickHandler(function(arg_4_0)
		arg_3_0:OnClickTalent(true, arg_4_0, 0)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.cfgId_ = arg_5_1
	arg_5_0.stage_ = arg_5_2
	arg_5_0.talentIdList_ = arg_5_3
end

function var_0_0.SetSelected(arg_6_0, arg_6_1)
	arg_6_0.selected_ = arg_6_1
end

function var_0_0.SelectIdx(arg_7_0, arg_7_1)
	arg_7_0.selectIdx_ = arg_7_1

	arg_7_0:RefreshUI_SelectState()
end

function var_0_0.SetClickHandler(arg_8_0, arg_8_1)
	arg_8_0.onClickTalenCallback_ = arg_8_1
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = ActivityHeroEnhanceCfg[arg_9_0.cfgId_]
	local var_9_1 = arg_9_0.talentIdList_[1]
	local var_9_2 = ActivityHeroEnhanceTools.IsTalentLock(var_9_0.activity_id, var_9_1)
	local var_9_3 = var_9_0.activity_id

	arg_9_0.talentItem_:SetData(var_9_3, var_9_1)
	arg_9_0.talentItem_:SetSelected(arg_9_0.selected_)
	arg_9_0.talentItem_:SetLock(var_9_2)
	arg_9_0.talentItem_:SetFirstAddFlag(ActivityHeroEnhanceTools.IsCfgTalentStageFirstCanAdd(var_9_0, arg_9_0.stage_))
	arg_9_0.talentItem_:RefreshUI()
	arg_9_0.lineController_:SetSelectedState(var_9_2 and "weak" or "normal")
end

function var_0_0.RefreshUI_SelectState(arg_10_0)
	arg_10_0.talentItem_:SetSelected(arg_10_0.selected_)
	arg_10_0.talentItem_:RefreshUI()
end

function var_0_0.OnClickTalent(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_0.onClickTalenCallback_ then
		arg_11_0.onClickTalenCallback_(arg_11_1, arg_11_0.stage_, arg_11_2, arg_11_3)
	end
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.talentItem_:Dispose()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
