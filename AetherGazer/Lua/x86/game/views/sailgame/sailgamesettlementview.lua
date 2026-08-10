local var_0_0 = class("SailGameSettlementView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ""
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
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		JumpTools.OpenPageByJump("/sailMain", {
			activityID = arg_5_0.activityID_
		})
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.activityID_ = arg_7_0.params_.activityID

	local var_7_0 = 0
	local var_7_1 = SailGameData:GetCurGameData(arg_7_0.activityID_).eventList

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		var_7_0 = var_7_0 + iter_7_1.rewardNum
	end

	arg_7_0.rewardNumText_.text = var_7_0
	arg_7_0.rewardIcon_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id)
end

return var_0_0
