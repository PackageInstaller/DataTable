local var_0_0 = class("TangramRegionItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.statusController_ = ControllerUtil.GetController(arg_1_0.transform_, "status")
	arg_1_0.rotateAxis_ = Vector3.New(0, 0, -1)
end

function var_0_0.OnExit(arg_2_0)
	arg_2_0:StopLeanTween()
	arg_2_0:StopAnim()
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:StopLeanTween()
	arg_3_0:StopAnim()
	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.activityID_ = arg_4_1

	arg_4_0:StopAnim()
end

function var_0_0.GetPuzzleContent(arg_5_0)
	return arg_5_0.puzzleContentTrans_
end

function var_0_0.SetTransParent(arg_6_0, arg_6_1)
	arg_6_0.originParent_ = arg_6_0.transform_.parent

	arg_6_0.transform_:SetParent(arg_6_1)
end

function var_0_0.RecoverTrans(arg_7_0)
	if arg_7_0.originAngle_ then
		arg_7_0.transform_:SetLocalEulerAngleOrigin(arg_7_0.originAngle_)
	end

	arg_7_0.originAngle_ = nil

	if arg_7_0.originParent_ then
		arg_7_0.transform_:SetParent(arg_7_0.originParent_)

		arg_7_0.originParent_ = nil
	end
end

function var_0_0.PlayAutoPutAnim(arg_8_0, arg_8_1)
	SetActive(arg_8_0.rewardAnimGo_, true)
	arg_8_0:PlayAnim(arg_8_0.animator_, "JigsawPuzzleUI_regionItem", function()
		SetActive(arg_8_0.rewardAnimGo_, false)

		if arg_8_1 then
			arg_8_1()
		end
	end)
end

function var_0_0.PlayRewardAnim(arg_10_0, arg_10_1)
	SetActive(arg_10_0.rewardAnimGo_, true)
	arg_10_0:PlayAnim(arg_10_0.animator_, "JigsawPuzzleUI_regionItem", function()
		SetActive(arg_10_0.rewardAnimGo_, false)

		if arg_10_1 then
			arg_10_1()
		end
	end)
end

function var_0_0.StopAnim(arg_12_0)
	if arg_12_0.animtimer_ then
		arg_12_0.animtimer_:Stop()

		arg_12_0.animtimer_ = nil
	end

	arg_12_0.animator_.enabled = false

	SetActive(arg_12_0.rewardAnimGo_, false)
end

function var_0_0.Rotate(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.originAngle_ = arg_13_0.transform_:GetLocalEulerAngleOrigin()

	arg_13_0:StopLeanTween()

	arg_13_0.rotateLeanTween_ = LeanTween.rotateAroundLocal(arg_13_0.gameObject_, arg_13_0.rotateAxis_, arg_13_1, 0.5):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
		arg_13_0:StopLeanTween()

		if arg_13_2 then
			arg_13_2()
		end
	end))
end

function var_0_0.StopLeanTween(arg_15_0)
	if arg_15_0.rotateLeanTween_ then
		arg_15_0.rotateLeanTween_:setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_15_0.rotateLeanTween_.id)

		arg_15_0.rotateLeanTween_ = nil
	end
end

function var_0_0.PlayAnim(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if not arg_16_1 then
		if arg_16_3 then
			arg_16_3()
		end

		return
	end

	arg_16_1.enabled = true

	arg_16_1:Play(arg_16_2, -1, 0)
	arg_16_1:Update(0)

	if arg_16_0.animtimer_ then
		arg_16_0.animtimer_:Stop()

		arg_16_0.animtimer_ = nil
	end

	arg_16_0.animtimer_ = Timer.New(function()
		local var_17_0 = arg_16_1:GetCurrentAnimatorStateInfo(0)

		if var_17_0:IsName(arg_16_2) and var_17_0.normalizedTime >= 1 then
			if arg_16_0.animtimer_ ~= nil then
				arg_16_0.animtimer_:Stop()

				arg_16_0.animtimer_ = nil
			end

			SetActive(arg_16_0.maskGo_, false)

			if arg_16_3 then
				arg_16_3()
			end
		end
	end, 0.033, -1)

	arg_16_0.animtimer_:Start()
end

return var_0_0
