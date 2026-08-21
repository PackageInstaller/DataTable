local var_0_0 = class("GuideFindUIPlayer", import(".GuidePlayer"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.topContainer = arg_1_1:Find("top")
	arg_1_0.fingerTF = arg_1_1:Find("top/finger")
	arg_1_0.fingerXyz = arg_1_0.fingerTF:Find("Xyz")
	arg_1_0.fingerAnim = arg_1_0.fingerXyz:GetComponent(typeof(Animator))

	return
end

function var_0_0.OnExecution(arg_2_0, arg_2_1, arg_2_2)
	seriesAsync({
		function(arg_3_0)
			arg_2_0:DuplicateNode(arg_2_1, arg_3_0)

			return
		end
	}, arg_2_2)

	return
end

function var_0_0.DuplicateNode(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1:GetEventUI()

	arg_4_0:ClearFingerTimer()
	arg_4_0:SearchUI(arg_4_1:GetEventUI(), function(arg_5_0)
		if not arg_5_0 and var_4_0.notfoundSkip then
			arg_4_2()

			return
		end

		local var_5_0

		if not arg_5_0 then
			pg.NewGuideMgr.GetInstance():Stop()

			do return end

			var_5_0 = arg_5_0
		end

		local var_5_1 = arg_4_0.uiDuplicator:Duplicate(arg_5_0, var_4_0.settings)

		if var_4_0.childIndex then
			var_5_0 = var_5_0:GetChild(var_4_0.childIndex)
			var_5_1 = var_5_1:GetChild(var_4_0.childIndex)
		elseif var_4_0.eventPath then
			var_5_0 = GameObject.Find(var_4_0.eventPath) or arg_5_0
		end

		arg_4_0.fingerTimer = Timer.New(function()
			arg_4_0:UpdateFinger(var_5_1, var_4_0)

			return
		end, 0.05, -1)

		arg_4_0.fingerTimer:Start()
		arg_4_0.fingerTimer:func()

		arg_4_0.eventTrigger = GuideEventTrigger.New(var_4_0.triggerData.type, var_5_1, var_5_0, var_4_0.triggerData.arg, arg_4_2)

		return
	end)

	return
end

function var_0_0.NextOne(arg_7_0)
	if arg_7_0.eventTrigger then
		arg_7_0.eventTrigger:Trigger()
	end

	return
end

function var_0_0.UpdateFinger(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1.pivot - Vector2(0.5, 0.5)
	local var_8_1 = Vector2(arg_8_1.sizeDelta.x * var_8_0.x, arg_8_1.sizeDelta.y * var_8_0.y)

	SetActive(arg_8_0.fingerTF, not arg_8_2.fingerPos or not arg_8_2.fingerPos.hideFinger)

	local var_8_2 = Vector2(arg_8_1.sizeDelta.x / 2, -arg_8_1.sizeDelta.y / 2) - var_8_1

	if arg_8_2.scale then
		local var_8_3 = 1 / arg_8_2.scale or 1

		arg_8_0.fingerTF.localScale = Vector3(var_8_3, var_8_3, 1)

		local var_8_4 = arg_8_2.fingerPos and Vector3(arg_8_2.fingerPos.posX, arg_8_2.fingerPos.posY, 0) or Vector3(var_8_2.x, var_8_2.y, 0)
		local var_8_5 = Vector3(0, 0, 0)

		if arg_8_2.fingerPos then
			local var_8_6 = arg_8_2.fingerPos.rotateX or 0
			local var_8_7 = arg_8_2.fingerPos.rotateY or 0
			local var_8_8 = arg_8_2.fingerPos.rotateZ or 0

			var_8_5 = Vector3(var_8_6, var_8_7, var_8_8)
		end

		arg_8_0.fingerTF.localPosition = arg_8_0.topContainer:InverseTransformPoint((arg_8_1.parent:TransformPoint(arg_8_1.localPosition + var_8_4)))
		arg_8_0.fingerTF.localEulerAngles = var_8_5

		if arg_8_2.slipAnim and not LeanTween.isTweening(arg_8_0.fingerXyz.gameObject) then
			arg_8_0.fingerAnim.enabled = false

			LeanTween.value(arg_8_0.fingerXyz.gameObject, 0, -200, 1):setOnUpdate(System.Action_float(function(arg_9_0)
				arg_8_0.fingerXyz.localPosition = Vector3(arg_9_0, 0, 0)

				return
			end)):setRepeat(-1)
		elseif not arg_8_2.slipAnim and LeanTween.isTweening(arg_8_0.fingerXyz.gameObject) then
			LeanTween.cancel(arg_8_0.fingerXyz.gameObject)
		else
			arg_8_0.fingerXyz.localPosition = Vector3.zero
		end

		return
	end
end

function var_0_0.ClearFingerTimer(arg_10_0)
	if arg_10_0.fingerTimer then
		arg_10_0.fingerTimer:Stop()

		arg_10_0.fingerTimer = nil
	end

	return
end

function var_0_0.OnClear(arg_11_0)
	if arg_11_0.eventTrigger then
		arg_11_0.eventTrigger:Clear()

		arg_11_0.eventTrigger = nil
	end

	setActive(arg_11_0.fingerTF, false)

	arg_11_0.fingerTF.localScale = Vector3(1, 1, 1)

	arg_11_0:ClearFingerTimer()
	LeanTween.cancel(arg_11_0.fingerXyz.gameObject)

	arg_11_0.fingerXyz.localPosition = Vector3.zero
	arg_11_0.fingerAnim.enabled = true

	return
end

return var_0_0
