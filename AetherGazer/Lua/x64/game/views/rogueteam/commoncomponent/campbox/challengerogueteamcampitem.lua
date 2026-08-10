local var_0_0 = class("ChallengeRogueTeamCampItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.activeController_ = arg_1_0.controllerEx_:GetController("active")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.RefreshState(arg_4_0, arg_4_1)
	arg_4_0.activeController_:SetSelectedState(tostring(arg_4_1))
end

function var_0_0.StopPlayAnimator(arg_5_0)
	arg_5_0.animator_.enabled = false

	SetActive(arg_5_0.effectGo_, false)
end

function var_0_0.StartPalyAnimator(arg_6_0)
	arg_6_0.animator_.enabled = true

	SetActive(arg_6_0.effectGo_, true)
end

return var_0_0
