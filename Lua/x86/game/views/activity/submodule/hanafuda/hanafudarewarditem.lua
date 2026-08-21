local var_0_0 = class("HanafudaRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.itemList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.rewardList_, CommonItem)
	arg_2_0.rewardState_ = ControllerUtil.GetController(arg_2_0.transform_, "stateBtn")
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.index_ = arg_3_1
	arg_3_0.cfg_ = arg_3_2

	arg_3_0:RefreshUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.receiveBtn_, nil, function()
		KagutsuchiHanafudaAction.SendGetCombineReward(arg_5_0.cfg_.activity_id, arg_5_0.cfg_.id, arg_5_0.callback)
	end)
	arg_5_0:AddBtnListener(arg_5_0.checkBtn_, nil, function()
		if arg_5_0.checkCallBack_ then
			arg_5_0.checkCallBack_(arg_5_0.cfg_.id)
		end
	end)
end

function var_0_0.SetCallBack(arg_8_0, arg_8_1)
	arg_8_0.callback = arg_8_1
end

function var_0_0.SetCheckCallBack(arg_9_0, arg_9_1)
	arg_9_0.checkCallBack_ = arg_9_1
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0:RefreshItem()
	arg_10_0:RefreshState()
end

function var_0_0.RefreshItem(arg_11_0)
	arg_11_0.rewardCfg = arg_11_0.cfg_.reward_item_list

	arg_11_0.itemList_:StartScroll(#arg_11_0.rewardCfg)

	arg_11_0.nameText_.text = arg_11_0.cfg_.name
end

function var_0_0.IndexItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.rewardCfg[arg_12_1]

	arg_12_2:RefreshData(formatReward(var_12_0))
	arg_12_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_12_0)
	end)
end

function var_0_0.RefreshState(arg_14_0)
	local var_14_0 = HanafudaData:GetIsComplete(arg_14_0.cfg_.id)
	local var_14_1 = HanafudaData:GetIsRewarded(arg_14_0.cfg_.id)

	if not var_14_0 then
		arg_14_0.rewardState_:SetSelectedState("unfinished")
	elseif not var_14_1 then
		arg_14_0.rewardState_:SetSelectedState("complete")
	else
		arg_14_0.rewardState_:SetSelectedState("rewarded")
	end
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.itemList_ then
		arg_15_0.itemList_:Dispose()

		arg_15_0.itemList_ = nil
	end

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
