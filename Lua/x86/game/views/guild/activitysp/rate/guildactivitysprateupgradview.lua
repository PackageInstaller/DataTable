local var_0_0 = class("GuildActivitySPRateUpgradView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/GuildActivitySPUI/GuildActivitySPUpgradeSuccessUI"
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
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.rateID_ = arg_7_0.params_.rateID

	local var_7_0 = ActivityClubSPLevelSettingCfg[arg_7_0.rateID_]

	arg_7_0.rateText_.text = var_7_0.user_level
	arg_7_0.domainMaxCount_.text = string.format(GetTips("CLUB_ACTIVITY_MAX_CAT"), #var_7_0.dispatch or 0)
	arg_7_0.heroMaxCount_.text = string.format(GetTips("CLUB_ACTIVITY_MAX_HERO"), var_7_0.max_hero)
end

return var_0_0
