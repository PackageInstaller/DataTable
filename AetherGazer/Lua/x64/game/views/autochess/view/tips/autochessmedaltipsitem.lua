local var_0_0 = class("AutoChessMedalTipsItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.AddUIListeners(arg_3_0)
	return
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.iconController1001_ = arg_4_0.controller1001_:GetController("state")
	arg_4_0.iconController1002_ = arg_4_0.controller1002_:GetController("state")
	arg_4_0.iconController1003_ = arg_4_0.controller1003_:GetController("state")
	arg_4_0.iconController1004_ = arg_4_0.controller1004_:GetController("state")
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.id = arg_5_1

	local var_5_0 = AutoChessMedalCfg[arg_5_1]

	arg_5_0.text_.text = var_5_0.name

	arg_5_0:SetMedalIcon()

	if arg_5_2 then
		arg_5_0.iconController_:SetSelectedIndex(2)
	else
		arg_5_0.iconController_:SetSelectedIndex(0)
	end

	arg_5_0:SetActive(true)

	arg_5_0.timer_ = Timer.New(function()
		arg_5_0:SetActive(false)

		if arg_5_0.closeFunc then
			arg_5_0.closeFunc(arg_5_1, true)
		end
	end, 1.5, 1)

	arg_5_0.timer_:Start()
end

function var_0_0.SetMedalIcon(arg_7_0)
	arg_7_0.iconController_ = nil

	for iter_7_0, iter_7_1 in ipairs(AutoChessMedalCfg.all) do
		if iter_7_1 == arg_7_0.id then
			arg_7_0.iconController_ = arg_7_0["iconController" .. iter_7_1 .. "_"]

			SetActive(arg_7_0["controller" .. iter_7_1 .. "_"].gameObject, true)
		else
			SetActive(arg_7_0["controller" .. iter_7_1 .. "_"].gameObject, false)
		end
	end
end

function var_0_0.SetActive(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.SetCloseFunc(arg_9_0, arg_9_1)
	arg_9_0.closeFunc = arg_9_1
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.timer_ then
		arg_10_0.timer_:Stop()

		arg_10_0.timer_ = nil
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
