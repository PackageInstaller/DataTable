local var_0_0 = class("NoobMonthlyCardRechargeView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = Asset.Load(arg_1_0:GetUIName(arg_1_2))

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.type_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.statusController_ = ControllerUtil.GetController(arg_1_0.btnPanelTrans_, "status")
	arg_1_0.typeController_ = ControllerUtil.GetController(arg_1_0.transform_, "type")
end

function var_0_0.GetUIName(arg_2_0, arg_2_1)
	if arg_2_1 == 0 then
		return "Widget/System/Activitynewbie/NewbieMonthlyCardUI"
	else
		return "Widget/System/Activitynewbie/NewbieMonthlyCardUI_old"
	end
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0.commonItem_:Dispose()

	arg_3_0.commonItem_ = nil

	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.gameObject_ = nil
	arg_3_0.transform_ = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.sourceBtn_, nil, function()
		local var_5_0 = GameSetting.newbie_first_monthly_card_reward.value[2]

		JumpTools.JumpToPage2(var_5_0)
	end)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		ActivityNewbieTools.ReceiveRechargeReward(2, 0, function(arg_7_0)
			arg_4_0:RefreshStatus()
		end)
	end)
	arg_4_0:AddBtnListener(arg_4_0.signRewardBtn_, nil, function()
		local var_8_0 = GameSetting.newbie_first_monthly_card_cumulative.value[2]

		ShowPopItem(POP_ITEM, var_8_0)
	end)
end

function var_0_0.SetData(arg_9_0)
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
		end

		arg_9_0.commonItem_ = CommonItemView.New(arg_9_0.commonGo_)

		arg_9_0.commonItem_:SetData(var_9_0)
	end

	arg_9_0:RefreshStatus()

	if arg_9_0.typeController_ then
		arg_9_0.typeController_:SetSelectedIndex(arg_9_0.type_)
	end

	ActivityNewbieTools.SetSelectMonthlyRecharge()

	local var_9_1 = arg_9_0.rewardCfg_[1]

	arg_9_0.rewardDesc_.text = GetTips("FIRST_RECHARGE_MONTH_CARD_DESC")
end

function var_0_0.RefreshStatus(arg_11_0)
	local var_11_0 = ActivityNewbieTools.GetFirstMonthlyCardStatus()
	local var_11_1 = var_11_0.isRecharged
	local var_11_2 = var_11_0.heroRewardFlag

	if var_11_1 == false then
		arg_11_0.status_ = 0
	elseif var_11_2 == false then
		arg_11_0.status_ = 1
	else
		arg_11_0.status_ = 2
	end

	arg_11_0.statusController_:SetSelectedIndex(arg_11_0.status_)
end

function var_0_0.ReceiveReward(arg_12_0)
	ActivityNewbieTools.ReceiveRechargeReward(2, 0, function(arg_13_0)
		arg_12_0:RefreshStatus()
	end)
end

function var_0_0.SetActive(arg_14_0, arg_14_1)
	SetActive(arg_14_0.gameObject_, arg_14_1)
end

return var_0_0
