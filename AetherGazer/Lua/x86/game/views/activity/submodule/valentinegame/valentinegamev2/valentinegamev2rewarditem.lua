local var_0_0 = class("ValentineGameV2RewardItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.commonItem_ = CommonItem.New(arg_3_0.commonItemGo_)
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	local var_4_0 = rewardToItemTemplate(formatReward(arg_4_1))

	arg_4_0.commonItem_:RefreshData(var_4_0)
	arg_4_0.commonItem_:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, arg_5_0)
	end)
end

function var_0_0.Dispose(arg_6_0)
	if arg_6_0.commonItem_ then
		arg_6_0.commonItem_:Dispose()

		arg_6_0.commonItem_ = nil
	end

	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
