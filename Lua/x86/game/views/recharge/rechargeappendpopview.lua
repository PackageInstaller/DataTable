local var_0_0 = class("RechargeAppendPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Recharge/items/RechargeTotalRechargePopUI"
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

	arg_4_0.rewardList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.itemListGo_, CommonItemView)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = clone(ItemTemplateData)

	var_5_0.id = arg_5_0.rewardDataList_[arg_5_1].id
	var_5_0.number = arg_5_0.rewardDataList_[arg_5_1].num

	function var_5_0.clickFun()
		ShowPopItem(POP_ITEM, {
			var_5_0.id,
			var_5_0.number
		})
	end

	arg_5_2:SetData(var_5_0)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.btnConfirm_, nil, function()
		PayAction.GetTotalRechargeBonus(arg_7_0.params_.appendRewardIdList, true)
		arg_7_0:Back()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.rewardDataList_ = mergeReward(formatRewardCfgList(arg_9_0.params_.appendRewardList))

	arg_9_0.rewardList_:StartScroll(#arg_9_0.rewardDataList_)

	arg_9_0.descText_.text = GetTips("VERSION_RECHARGE_POP_TIPS")
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.rewardList_ then
		arg_10_0.rewardList_:Dispose()
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
