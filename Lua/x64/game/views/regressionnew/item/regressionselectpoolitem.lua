local var_0_0 = class("RegressionSelectPoolItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selectController_ = arg_2_0.controller_:GetController("select")

	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		if arg_2_0.callback_ then
			arg_2_0.callback_(arg_2_0.index)
		end
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.index = arg_4_1

	local var_4_0 = DrawPoolCfg[arg_4_2].unoption_up_items[1][1]

	arg_4_0.iconImg_.sprite = getSpriteViaConfig("HeroItemshead", var_4_0)
end

function var_0_0.RegistCallBack(arg_5_0, arg_5_1)
	arg_5_0.callback_ = arg_5_1
end

function var_0_0.UpdateSelectState(arg_6_0, arg_6_1)
	arg_6_0.selectController_:SetSelectedState(arg_6_1 and "true" or "false")
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
