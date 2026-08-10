local var_0_0 = class("ChapterPlot19MapItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(Asset.Load(arg_1_1), arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.stateController_ = arg_1_0.controllerEx_:GetController("break")
	arg_1_0.fogController_ = arg_1_0.controllerEx_:GetController("smoke")
	arg_1_0.lineController_ = arg_1_0.controllerEx_:GetController("line")

	if arg_1_0.animator_ then
		arg_1_0.animator_.enabled = false
	end
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.gameObject_ = nil
	arg_2_0.transform_ = nil
end

function var_0_0.Show(arg_3_0, arg_3_1)
	SetActive(arg_3_0.gameObject_, arg_3_1)
end

function var_0_0.PlayAnimator(arg_4_0, arg_4_1)
	if arg_4_1 then
		arg_4_0.mainAnimator_:Play("operation_bg_vermap02", 0, 0)
	else
		arg_4_0.mainAnimator_:Play("map_noise", 0, 0)
	end

	arg_4_0.mainAnimator_:Update(0)
end

function var_0_0.SetSelectState(arg_5_0, arg_5_1)
	if arg_5_0.stateController_ == nil then
		return
	end

	arg_5_0.stateController_:SetSelectedIndex(arg_5_1)
end

function var_0_0.SetFogState(arg_6_0, arg_6_1)
	if arg_6_0.fogController_ == nil then
		return
	end

	if arg_6_1 then
		arg_6_0.fogController_:SetSelectedState("state1")
	else
		arg_6_0.fogController_:SetSelectedState("state0")
	end
end

function var_0_0.SetLineState(arg_7_0, arg_7_1)
	if arg_7_0.lineController_ == nil then
		return
	end

	if arg_7_1 then
		arg_7_0.lineController_:SetSelectedState("state0")
	else
		arg_7_0.lineController_:SetSelectedState("state1")
	end
end

function var_0_0.PlayFogAnimator(arg_8_0)
	if arg_8_0.animator_ then
		arg_8_0.animator_.enabled = true
	end
end

return var_0_0
