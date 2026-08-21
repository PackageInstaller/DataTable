local var_0_0 = class("SailFishingResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdFishingSettlementUI"
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
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		SailGameTools.GoToGameView(arg_5_0.activityID_)
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.activityID_ = arg_7_0.params_.activityID
	arg_7_0.score_ = arg_7_0.params_.score

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_8_0.activityID_]

	for iter_8_0 = #var_8_0, 1, -1 do
		local var_8_1 = var_8_0[iter_8_0]

		if ActivityPointRewardCfg[var_8_1].need <= arg_8_0.score_ then
			arg_8_0.rewardCfg_ = ActivityPointRewardCfg[var_8_1].reward_item_list[1]

			break
		end
	end

	arg_8_0.scoreText_.text = arg_8_0.score_

	local var_8_2 = ItemTools.getItemSprite(arg_8_0.rewardCfg_[1])

	if var_8_2 then
		arg_8_0.rewardIcon_.sprite = var_8_2
	end

	arg_8_0.rewardNumText_.text = arg_8_0.rewardCfg_[2]
end

return var_0_0
