local var_0_0 = class("SevenDaySkinPopView_3_4", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_SevenSkinUI/SummerUI_3_4_SevenSkinPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.item_ = {}
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()

		if ItemCfg[arg_5_0.reward_[1][1]].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			getReward(formatRewardCfgList(arg_5_0.reward_))
		else
			getReward(formatRewardCfgList(arg_5_0.reward_))
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.msg_ = arg_7_0.params_.msg
	arg_7_0.reward_ = arg_7_0.params_.reward

	arg_7_0:RefreshView()
end

function var_0_0.RefreshView(arg_8_0)
	arg_8_0.content_.text = GetTips(arg_8_0.msg_.body)
	arg_8_0.name_.text = GetTips(arg_8_0.msg_.author)
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
