local var_0_0 = class("DormOverviewCanteenHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.heroItem = CanteenJobInfoItem.New(arg_2_0.heroObj)

	arg_2_0:AddBtnListener(arg_2_0.btn, nil, function()
		arg_2_0:OnClick()
	end)
end

function var_0_0.OnClick(arg_4_0)
	JumpTools.OpenPageByJump("/restaurantJobSetView", {
		jobType = arg_4_0.job
	})
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1)
	arg_5_0.job = arg_5_1

	arg_5_0.heroItem:RefreshUI(arg_5_1)
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.heroItem:Dispose()
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
