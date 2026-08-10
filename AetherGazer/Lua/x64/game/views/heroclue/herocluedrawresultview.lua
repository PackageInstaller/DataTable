local var_0_0 = class("HeroClueDrawResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return HeroClueTools.GetDrawResultViewUIName(arg_1_0.params_.activityID)
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
	arg_5_0:AddBtnListener(arg_5_0.backMask_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.activityID_ = arg_7_0.params_.activityID
	arg_7_0.rewardList_ = arg_7_0.params_.rewardList
	arg_7_0.clueID_ = arg_7_0.rewardList_[1]

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = HeroClueCfg[arg_8_0.clueID_]

	arg_8_0.clueIcon_.sprite = pureGetSpriteWithoutAtlas(var_8_0.icon_path)
	arg_8_0.clueName_.text = string.format(GetTips("ACTIVITY_HERO_CLUE_UNLOCK"), var_8_0.name)

	local var_8_1 = HeroClueData:GetUnlockClueDataDic()[arg_8_0.clueID_]
	local var_8_2 = #var_8_0.level
	local var_8_3 = var_8_1.level

	arg_8_0.progressText_.text = string.format(GetTips("ACTIVITY_HERO_CLUE_COLLECT"), var_8_3, var_8_2)
end

return var_0_0
