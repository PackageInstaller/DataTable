local var_0_0 = class("TangramGameDecodeItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.clickState = false
	arg_2_0.stateController = arg_2_0.controller:GetController("state")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn, nil, function()
		arg_4_0.clickState = not arg_4_0.clickState

		if arg_4_0.clickState then
			arg_4_0.stateController:SetSelectedState("true")
		else
			arg_4_0.stateController:SetSelectedState("false")
		end

		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(arg_4_0.tipsID, arg_4_0.clickState, arg_4_0)
		end
	end)
end

function var_0_0.AddClickItem(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.clickFunc = arg_6_1
	end
end

function var_0_0.SetChooseIndex(arg_7_0, arg_7_1)
	arg_7_0.chooseIndex = arg_7_1

	arg_7_0:RefreshChooseState()
end

function var_0_0.RefreshUI(arg_8_0, arg_8_1)
	arg_8_0.tipsID = arg_8_1
	arg_8_0.desc.text = GetTips(arg_8_1)
end

function var_0_0.RefreshChooseState(arg_9_0)
	arg_9_0.numText.text = arg_9_0.chooseIndex
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
