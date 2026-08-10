local var_0_0 = class("ActivityHeroEnhancePopView_4_5", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivityHeroEnhanceTools.GetTalentPopUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(nil, arg_5_0.bgBtn_, function()
		JumpTools.Back(nil, {
			isPopBack = true
		})
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.talentId_ = arg_7_0.params_.talentID

	arg_7_0:RefreshUI()
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = TalentTreeCfg[arg_9_0.talentId_]

	arg_9_0.talentImg_.sprite = getAffixSprite({
		var_9_0.affix_id
	})
	arg_9_0.nameText_.text = GetI18NText(var_9_0.name)
	arg_9_0.descText_.text = GetI18NText(var_9_0.desc)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
