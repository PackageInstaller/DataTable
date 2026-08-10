local var_0_0 = import("game.views.recharge.pages.RechargePageBase")
local var_0_1 = class("RechargeFirstMonthlyCardPageView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.statusController_ = ControllerUtil.GetController(arg_1_0.btnPanelTrans_, "status")
	arg_1_0.typeController_ = ControllerUtil.GetController(arg_1_0.transform_, "type")

	local var_1_0 = ActivityNewbieTools.GetFirstRechargeStatus()
end

function var_0_1.Dispose(arg_2_0)
	if arg_2_0.commonItem_ then
		manager.redPoint:unbindUIandKey(arg_2_0.commonItem_.transform_, RedPointConst.FIRST_GEAR)
		arg_2_0.commonItem_:Dispose()

		arg_2_0.commonItem_ = nil
	end

	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.gameObject_ = nil
	arg_2_0.transform_ = nil

	var_0_1.super.Dispose(arg_2_0)
end

function var_0_1.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.sourceBtn_, nil, function()
		local var_4_0 = GameSetting.newbie_first_monthly_card_reward.value[2]

		JumpTools.JumpToPage2(var_4_0)
	end)
	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		ActivityNewbieTools.ReceiveRechargeReward(2, 0, function(arg_6_0)
			arg_3_0:RefreshStatus()
		end)
	end)
	arg_3_0:AddBtnListener(arg_3_0.signRewardBtn_, nil, function()
		local var_7_0 = GameSetting.newbie_first_monthly_card_cumulative.value[2]

		ShowPopItem(POP_ITEM, var_7_0)
	end)
end

function var_0_1.OnEnter(arg_8_0)
	arg_8_0:RefreshUI()
end

function var_0_1.RefreshUI(arg_9_0)
	arg_9_0.rewardCfg_ = GameSetting.newbie_first_monthly_card_reward.value[1]

	if not arg_9_0.commonItem_ then
		local var_9_0 = clone(ItemTemplateData)

		var_9_0.id = arg_9_0.rewardCfg_[1]
		var_9_0.number = arg_9_0.rewardCfg_[2]

		function var_9_0.clickFun(arg_10_0)
			if arg_9_0.status_ == 1 then
				arg_9_0:ReceiveReward()
			else
				ShowPopItem(POP_ITEM, arg_9_0.rewardCfg_)
			end

			saveData("FirstGear", "hasView", true)
			manager.redPoint:setTip(RedPointConst.FIRST_GEAR, 0)
		end

		arg_9_0.commonItem_ = CommonItemView.New(arg_9_0.commonGo_)

		arg_9_0.commonItem_:SetData(var_9_0)
		manager.redPoint:bindUIandKey(arg_9_0.commonItem_.transform_, RedPointConst.FIRST_GEAR)
	end

	arg_9_0:RefreshStatus()
	arg_9_0.typeController_:SetSelectedIndex(1)
	ActivityNewbieTools.SetSelectMonthlyRecharge()

	local var_9_1 = arg_9_0.rewardCfg_[1]

	arg_9_0.rewardDesc_.text = GetTips("FIRST_RECHARGE_MONTH_CARD_DESC")
end

function var_0_1.Show(arg_11_0)
	SetActive(arg_11_0.gameObject_, true)
	arg_11_0:RefreshUI()
end

function var_0_1.RefreshStatus(arg_12_0)
	local var_12_0 = ActivityNewbieTools.GetFirstMonthlyCardStatus()
	local var_12_1 = var_12_0.isRecharged
	local var_12_2 = var_12_0.heroRewardFlag

	if var_12_1 == false then
		arg_12_0.status_ = 0
	elseif var_12_2 == false then
		arg_12_0.status_ = 1
	else
		arg_12_0.status_ = 2
	end

	arg_12_0.statusController_:SetSelectedIndex(arg_12_0.status_)
end

function var_0_1.ReceiveReward(arg_13_0)
	ActivityNewbieTools.ReceiveRechargeReward(2, 0, function(arg_14_0)
		arg_13_0:RefreshStatus()
	end)
end

function var_0_1.OnExit(arg_15_0)
	saveData("FirstGear", "hasView", true)
	manager.redPoint:setTip(RedPointConst.FIRST_GEAR, 0)
end

return var_0_1
