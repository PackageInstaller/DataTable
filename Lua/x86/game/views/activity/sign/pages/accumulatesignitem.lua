local var_0_0 = class("AccumulateSignItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.statusController_ = arg_2_0.mainControllerEx_:GetController("status")
	arg_2_0.itemController_ = arg_2_0.mainControllerEx_:GetController("quantity")
	arg_2_0.commonItem1_ = CommonItemView.New(arg_2_0.commonItemGo_1)
	arg_2_0.commonItem2_ = CommonItemView.New(arg_2_0.commonItemGo_2)
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.mainBtn_, nil, function()
		if arg_3_0.state_ == 0 then
			arg_3_0.onclick_(arg_3_0.accumulateID_)
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.accumulateID_ = arg_5_1
	arg_5_0.onclick_ = arg_5_2
	arg_5_0.cfg_ = AccumulateLoginCfg[arg_5_0.accumulateID_]
	arg_5_0.rewards_ = arg_5_0.cfg_.reward
	arg_5_0.state_ = AccumulateSignData:GetRewardState(arg_5_0.accumulateID_)

	arg_5_0:UpdateView()
end

function var_0_0.UpdateView(arg_6_0)
	if #arg_6_0.rewards_ == 1 then
		arg_6_0.itemController_:SetSelectedIndex(0)

		local var_6_0 = {
			id = arg_6_0.rewards_[1][1],
			number = arg_6_0.rewards_[1][2],
			clickFun = function(arg_7_0)
				ShowPopItem(POP_ITEM, {
					arg_7_0.id
				})
			end
		}

		arg_6_0.commonItem1_:SetData(var_6_0)
	else
		arg_6_0.itemController_:SetSelectedIndex(1)

		local var_6_1 = {
			id = arg_6_0.rewards_[1][1],
			number = arg_6_0.rewards_[1][2],
			clickFun = function(arg_8_0)
				ShowPopItem(POP_ITEM, {
					arg_8_0.id
				})
			end
		}

		arg_6_0.commonItem1_:SetData(var_6_1)

		local var_6_2 = {
			id = arg_6_0.rewards_[2][1],
			number = arg_6_0.rewards_[2][2],
			clickFun = function(arg_9_0)
				ShowPopItem(POP_ITEM, {
					arg_9_0.id
				})
			end
		}

		arg_6_0.commonItem2_:SetData(var_6_2)
	end

	arg_6_0.statusController_:SetSelectedIndex(arg_6_0.state_)

	arg_6_0.mainText_.text = string.format(GetTips("CUMULATIVE_LOGIN_TARGET"), arg_6_0.cfg_.num)
	arg_6_0.sliderImg_.fillAmount = AccumulateSignData:GetProgress(arg_6_0.accumulateID_)
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()

	if arg_11_0.commonItem1_ then
		arg_11_0.commonItem1_:Dispose()

		arg_11_0.commonItem1_ = nil
	end

	if arg_11_0.commonItem2_ then
		arg_11_0.commonItem2_:Dispose()

		arg_11_0.commonItem2_ = nil
	end

	arg_11_0.super.Dispose(arg_11_0)
end

return var_0_0
