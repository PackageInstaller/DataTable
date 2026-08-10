local var_0_0 = class("SpringWelfareTaskRewardItem", ReduxView)
local var_0_1 = import("game.tools.ItemTools")

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.commonItem_ = CommonItem.New(arg_2_0.gameObject_)
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0.commonItem_:Dispose()
	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.InitUI(arg_4_0)
	return
end

function var_0_0.AddListeners(arg_5_0)
	return
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.commonItem_:RefreshData(formatReward(arg_6_1))
	arg_6_0.commonItem_:RegistCallBack(function()
		ShowPopItem(POP_ITEM, arg_6_1)
	end)
	SetActive(arg_6_0.gameObject_, true)
end

function var_0_0.UpdateCommonItemAni(arg_8_0)
	arg_8_0.commonItem_:UpdateAnimator()
end

function var_0_0.Show(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.ShowSelect(arg_10_0, arg_10_1)
	arg_10_0.commonItem_:ShowSelect(arg_10_1 and 1 or 0)
end

return var_0_0
