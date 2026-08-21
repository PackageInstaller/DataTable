local var_0_0 = class("ServantCallNameTabModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:BuildContext()
	arg_2_0:AddUIListener()
end

function var_0_0.BuildContext(arg_3_0)
	arg_3_0.controller = {
		comps = arg_3_0.tabController_,
		select = {
			False = "false",
			True = "true",
			comps = arg_3_0.tabController_:GetController("select")
		}
	}
	arg_3_0.data = {
		tabIdx = 1
	}
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.tabClickBtn_, nil, function()
		arg_4_0:OnTabClick()
	end)
end

function var_0_0.SetTabIndex(arg_6_0, arg_6_1)
	arg_6_0.data.tabIdx = arg_6_1
end

function var_0_0.SetNumber(arg_7_0, arg_7_1)
	arg_7_0.callNameCountTxt_.text = arg_7_1
end

function var_0_0.SetSelect(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.controller.select.False

	if arg_8_1 then
		var_8_0 = arg_8_0.controller.select.True
	end

	arg_8_0.controller.select.comps:SetSelectedState(var_8_0)
end

function var_0_0.RegisterClickCallback(arg_9_0, arg_9_1)
	arg_9_0.data.clickCallback = arg_9_1
end

function var_0_0.OnTabClick(arg_10_0)
	local var_10_0 = arg_10_0.data.clickCallback

	if var_10_0 then
		var_10_0(arg_10_0.data.tabIdx)
	end
end

function var_0_0.OnDispose(arg_11_0)
	arg_11_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
