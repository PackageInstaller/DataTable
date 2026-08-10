local var_0_0 = class("BlisterScoreItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.scoreController_ = arg_1_0.waterControllerexcollection_:GetController("water")
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	return
end

function var_0_0.SetPosition(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	arg_3_0:ResetAnimate(0)

	local var_3_0 = manager.ui.mainCameraCom_
	local var_3_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_3_2 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_3_0, Vector3.New(arg_3_1, arg_3_2, arg_3_3))
	local var_3_3, var_3_4 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_3_0.transform_.parent, var_3_2, var_3_1, nil)

	arg_3_0.transform_.localPosition = var_3_4

	local var_3_5 = GameSetting.activity_bubble_splash_point.value[1] + (arg_3_4 - 1) * GameSetting.activity_bubble_combo_point.value[1]

	arg_3_0.textText_.text = "+" .. var_3_5
	arg_3_0.text2Text_.text = "+" .. var_3_5
	arg_3_0.text3Text_.text = "+" .. var_3_5

	if arg_3_0.waterAni_ then
		AnimatorTools.PlayAnimationWithCallback(arg_3_0.waterAni_, "Fx_text_cx", function()
			arg_3_0.isAniPlaying_ = false

			arg_3_5()
		end)
	end

	local var_3_6 = GameSetting.blister_socre_level.value or {}
	local var_3_7 = 1

	for iter_3_0, iter_3_1 in ipairs(var_3_6) do
		if iter_3_1 < var_3_5 then
			var_3_7 = iter_3_0 + 1
		end
	end

	arg_3_0.scoreController_:SetSelectedState("state" .. var_3_7)
end

function var_0_0.ResetAnimate(arg_5_0, arg_5_1)
	if arg_5_0.waterAni_ then
		arg_5_0.waterAni_:Play("Fx_text_cx", 0, arg_5_1)
	end
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	if arg_6_0.gameObject_ then
		SetActive(arg_6_0.gameObject_, arg_6_1)
	end
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
	AnimatorTools.Stop()
end

return var_0_0
