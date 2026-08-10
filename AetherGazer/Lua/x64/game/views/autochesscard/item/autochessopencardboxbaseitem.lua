local var_0_0 = class("AutoChessOpenCardBoxBaseItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.GuideLineController_ = arg_3_0.controller_:GetController("default0")
	arg_3_0.LightController_ = arg_3_0.controller_:GetController("light")
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0)
	return
end

function var_0_0.SetGuideState(arg_6_0, arg_6_1)
	arg_6_0.GuideLineController_:SetSelectedState(arg_6_1)
end

function var_0_0.PlayAnim(arg_7_0, arg_7_1)
	if arg_7_1 then
		AnimatorTools.PlayAnimatorWithCallback(arg_7_0.anim_, "Activity_Unpack_CardAni_Open", arg_7_1, false, 0, 0)
	else
		arg_7_0.anim_:Play("Activity_Unpack_CardAni_Open", 0, 0)
	end
end

function var_0_0.SetActive(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.SetLightState(arg_9_0, arg_9_1)
	arg_9_0.LightController_:SetSelectedState(arg_9_1 and "show" or "hide")
end

function var_0_0.StopTimer(arg_10_0)
	AnimatorTools.Stop()
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0.anim_:Rebind()
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:StopTimer()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
