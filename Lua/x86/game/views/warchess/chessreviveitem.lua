local var_0_0 = class("ChessReviveItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.isOn_ = false

	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "select")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.index_ = arg_4_2
	arg_4_0.headImg_.sprite = getSpriteViaConfig("HeroLittleIcon", arg_4_1)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0.func_(arg_5_0.index_)
	end)
end

function var_0_0.RegisterListener(arg_7_0, arg_7_1)
	arg_7_0.func_ = arg_7_1
end

function var_0_0.ShowSelect(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0.controller_:SetSelectedState("sel")

		arg_8_0.isOn_ = true
	else
		arg_8_0.controller_:SetSelectedState("nor")

		arg_8_0.isOn_ = false
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
