local var_0_0 = class("AccumulativeGachaItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.drawstateController_ = arg_1_0.itemControllerexcollection_:GetController("drawstate")
	arg_1_0.showController_ = arg_1_0.itemControllerexcollection_:GetController("show")
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.data = arg_2_1

	arg_2_0.showController_:SetSelectedState("state" .. tostring(3))

	if not arg_2_0.commonItemView_ then
		arg_2_0.commonItemView_ = CommonItemView.New(arg_2_0.commonItem_)
	end

	local var_2_0 = formatReward(ActivityPointRewardCfg[arg_2_1.id].reward_item_list[1])

	CommonTools.SetCommonData(arg_2_0.commonItemView_, {
		id = var_2_0.id,
		number = var_2_0.num,
		clickFun = function(arg_3_0)
			ShowPopItem(POP_ITEM, {
				arg_3_0.id,
				arg_3_0.number
			})
		end
	}, arg_2_0.CommonData1)

	arg_2_0.processText_.text = ActivityPointRewardCfg[arg_2_1.id].need

	arg_2_0.drawstateController_:SetSelectedState(tostring(arg_2_1.state + 1))
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bg01Btn_, nil, function()
		local var_6_0 = ActivityPointRewardCfg[arg_5_0.data.id]

		if var_6_0 and ActivityAccumulativeData:GetNum() < var_6_0.need then
			ShowTips("ACTIVITY_ACCUMULATIVE_TIPS")

			return
		end

		ActivityAccumulativeAction.GetAccumulateReward(arg_5_0.data.id)
	end)
end

function var_0_0.RefreshBtnState(arg_7_0)
	return
end

function var_0_0.AddTimer(arg_8_0)
	return
end

return var_0_0
