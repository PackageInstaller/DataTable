local var_0_0 = class("HeroClueDetailView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return HeroClueTools.GetClueDetailViewUIName(arg_1_0.params_.activityID)
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
	arg_5_0:AddBtnListener(arg_5_0.exitBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.activityID_ = arg_7_0.params_.activityID
	arg_7_0.clueID_ = arg_7_0.params_.clueID

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = HeroClueCfg[arg_8_0.clueID_]
	local var_8_1 = HeroClueData:GetUnlockClueDataDic()[arg_8_0.clueID_]

	if var_8_1 then
		if var_8_1.level == 1 then
			arg_8_0.clueNameText_.text = GetTips("ACTIVITY_HERO_CLUE_NICK_TITLE")
			arg_8_0.clueDescText_.text = GetTips("ACTIVITY_HERO_CLUE_NICK_TITLE")
		elseif var_8_1.level == 2 then
			arg_8_0.clueNameText_.text = var_8_0.name
			arg_8_0.clueDescText_.text = GetTips("ACTIVITY_HERO_CLUE_NICK_TITLE")
		else
			arg_8_0.clueNameText_.text = var_8_0.name
			arg_8_0.clueDescText_.text = var_8_0.desc
		end
	end
end

return var_0_0
