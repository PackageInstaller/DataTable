local var_0_0 = class("CoreVerificationModeItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.clearController_ = arg_3_0.conEx_:GetController("clear")
	arg_3_0.selectController_ = arg_3_0.conEx_:GetController("select")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		manager.notify:CallUpdateFunc(CORE_VERIFICATION_CHALLENGE_SWITCH_MODE, arg_4_0.activityId_)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:UnBindRedPoint()

	arg_6_0.activityId_ = arg_6_2

	local var_6_0 = CoreVerificationChallengeTools.GetChallengeStageCfg(arg_6_2)

	if var_6_0 then
		arg_6_0.img_.spriteAsync = string.format("%s%s", "TextureConfig/BossAttribute_new/", var_6_0.stage_img)
	end

	local var_6_1 = CoreVerificationChallengeTools.GetChallengeStage(arg_6_2)

	if var_6_1.max_challenge_value and var_6_1.max_challenge_value > 0 then
		arg_6_0.clearController_:SetSelectedState("state1")
	else
		arg_6_0.clearController_:SetSelectedState("state0")
	end

	arg_6_0:BindRedPoint()
end

function var_0_0.SetSelect(arg_7_0, arg_7_1)
	arg_7_0.selectController_:SetSelectedState(arg_7_1 and "state1" or "state0")
end

function var_0_0.BindRedPoint(arg_8_0)
	if arg_8_0.activityId_ then
		manager.redPoint:bindUIandKey(arg_8_0.transform_, string.format("%s_%s", RedPointConst.CORE_VERIFICATION_CHALLENGE_NEXT, arg_8_0.activityId_))
	end
end

function var_0_0.UnBindRedPoint(arg_9_0)
	if arg_9_0.activityId_ then
		manager.redPoint:unbindUIandKey(arg_9_0.transform_, string.format("%s_%s", RedPointConst.CORE_VERIFICATION_CHALLENGE_NEXT, arg_9_0.activityId_))
	end
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:UnBindRedPoint()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
