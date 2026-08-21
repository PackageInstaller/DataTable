local var_0_0 = class("ActivityNoobTaskProgressItem", ReduxView)
local var_0_1 = {
	"uncomplete",
	"complete",
	"received"
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.stateCon_ = ControllerUtil.GetController(arg_1_0.transform_, "state")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		if arg_2_0.need_ > arg_2_0.progress_ then
			ShowPopItem(POP_ITEM, arg_2_0.rewardCfg_)

			return
		end

		ActivityNoobAction.ReceiveAccumulateReward(arg_2_0.index_)
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.needText_.text = arg_4_2[1]
	arg_4_0.rewardCfg_ = arg_4_2[2]
	arg_4_0.numText_.text = "x" .. arg_4_0.rewardCfg_[2]
	arg_4_0.index_ = arg_4_1
	arg_4_0.progress_ = arg_4_3
	arg_4_0.need_ = arg_4_2[1]

	arg_4_0:RefreshState()
end

function var_0_0.RefreshState(arg_5_0)
	local var_5_0 = arg_5_0:GetItemState()

	arg_5_0.stateCon_:SetSelectedState(var_5_0)
end

function var_0_0.GetItemState(arg_6_0)
	if arg_6_0.need_ > arg_6_0.progress_ then
		return var_0_1[1]
	elseif not ActivityNoobData:GetAccumulateReceivedList()[arg_6_0.index_] then
		return var_0_1[2]
	else
		return var_0_1[3]
	end
end

return var_0_0
