class = var_0_10000

local var_0_0 = "GuideFindUIPlayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GuidePlayer"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.topContainer = arg_1_1:Find("top")
	arg_1_0.fingerTF = arg_1_1:Find("top/finger")

	local var_1_0 = arg_1_0.fingerTF

	arg_1_0.fingerXyz = var_2.Find(var_1_0, "Xyz")

	local var_1_1 = arg_1_0.fingerXyz
	local var_1_2 = var_2.GetComponent

	typeof = var_5
	Animator = var_1_10007
	arg_1_0.fingerAnim = var_1_2(var_1_1, var_5(var_1_10007))

	return
end

function var_0_1.OnExecution(arg_2_0, arg_2_1, arg_2_2)
	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_3_0)
			local var_3_0 = arg_2_0

			var_1.DuplicateNode(var_3_0, arg_2_1, arg_3_0)

			return
		end
	}, arg_2_2)

	return
end

function var_0_1.DuplicateNode(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1:GetEventUI()

	arg_4_0:ClearFingerTimer()
	arg_4_0:SearchUI(var_4_0, function(arg_5_0)
		if not arg_5_0 and var_4_0.notfoundSkip then
			arg_4_2()

			return
		end

		if not arg_5_0 then
			pg = var_2_10001

			local var_5_0 = var_2_10001.NewGuideMgr.GetInstance()

			var_1.Stop(var_5_0)

			return
		end

		local var_5_1 = arg_4_0.uiDuplicator
		local var_5_2, var_5_3 = var_1.Duplicate(var_5_1, arg_5_0, var_4_0.settings), arg_5_0

		if var_4_0.childIndex then
			var_5_3 = var_5_3:GetChild(var_4_0.childIndex)
			var_5_2 = var_5_2:GetChild(var_4_0.childIndex)
		elseif var_4_0.eventPath then
			GameObject = var_4
			var_5_3 = var_4.Find(var_4_0.eventPath) or arg_5_0
		end

		local var_5_4 = arg_4_0

		Timer = var_5
		var_5_4.fingerTimer = var_5.New(function()
			local var_6_0 = arg_4_0

			var_0.UpdateFinger(var_6_0, var_5_2, var_4_0)

			return
		end, 0.05, -1)

		local var_5_5 = arg_4_0.fingerTimer

		var_4.Start(var_5_5)

		local var_5_6 = arg_4_0.fingerTimer

		var_4.func(var_5_6)

		local var_5_7 = var_4_0.triggerData
		local var_5_8 = arg_4_0

		GuideEventTrigger = var_5_6
		var_5_8.eventTrigger = var_5_6.New(var_5_7.type, var_5_2, var_5_3, var_5_7.arg, arg_4_2)

		return
	end)

	return
end

function var_0_1.NextOne(arg_7_0)
	if arg_7_0.eventTrigger then
		local var_7_0 = arg_7_0.eventTrigger

		var_1.Trigger(var_7_0)
	end

	return
end

function var_0_1.UpdateFinger(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1.pivot

	Vector2 = var_1_10004

	local var_8_1 = var_8_0 - var_1_10004(0.5, 0.5)

	Vector2 = var_4

	local var_8_2 = var_4(arg_8_1.sizeDelta.x * var_8_1.x, arg_8_1.sizeDelta.y * var_8_1.y)

	SetActive = var_1_10005

	var_1_10005(arg_8_0.fingerTF, not arg_8_2.fingerPos or not arg_8_2.fingerPos.hideFinger)

	Vector2 = var_1_10005

	local var_8_3 = var_1_10005(arg_8_1.sizeDelta.x / 2, -arg_8_1.sizeDelta.y / 2) - var_8_2
	local var_8_4

	if not arg_8_2.scale or not (1 / arg_8_2.scale) then
		var_8_4 = 1
	end

	local var_8_5 = arg_8_0.fingerTF

	Vector3 = var_8
	var_8_5.localScale = var_8(var_8_4, var_8_4, 1)

	if arg_8_2.fingerPos then
		Vector3 = var_8_6

		local var_8_6

		if not var_8_6(arg_8_2.fingerPos.posX, arg_8_2.fingerPos.posY, 0) then
			Vector3 = var_8_6
			var_8_6 = var_8_6(var_8_3.x, var_8_3.y, 0)
		end

		Vector3 = var_8

		local var_8_7 = var_8(0, 0, 0)

		if arg_8_2.fingerPos then
			Vector3 = var_9

			local var_8_8

			if not arg_8_2.fingerPos.rotateX then
				var_8_8 = 0
			end

			local var_8_9

			if not arg_8_2.fingerPos.rotateY then
				var_8_9 = 0
			end

			local var_8_10

			if not arg_8_2.fingerPos.rotateZ then
				var_8_10 = 0
			end

			var_8_7 = var_9(var_8_8, var_8_9, var_8_10)
		end

		local var_8_11 = arg_8_1.localPosition + var_8_6
		local var_8_12 = arg_8_1.parent
		local var_8_13 = var_10.TransformPoint(var_8_12, var_8_11)
		local var_8_14 = arg_8_0.topContainer
		local var_8_15 = var_11.InverseTransformPoint(var_8_14, var_8_13)

		arg_8_0.fingerTF.localPosition = var_8_15
		arg_8_0.fingerTF.localEulerAngles = var_8_7

		if arg_8_2.slipAnim then
			LeanTween = var_12

			if not var_12.isTweening(arg_8_0.fingerXyz.gameObject) then
				local var_8_16 = arg_8_0.fingerAnim

				var_8_16.enabled = false
				LeanTween = var_8_16

				local var_8_17 = var_8_16.value(arg_8_0.fingerXyz.gameObject, 0, -200, 1)
				local var_8_18 = var_12.setOnUpdate

				System = var_15

				local var_8_19 = var_8_18(var_8_17, var_15.Action_float(function(arg_9_0)
					local var_9_0 = arg_8_0.fingerXyz

					Vector3 = var_2_10002
					var_9_0.localPosition = var_2_10002(arg_9_0, 0, 0)

					return
				end))

				var_12.setRepeat(var_8_19, -1)

				goto label_8_0
			end
		end

		if not arg_8_2.slipAnim then
			LeanTween = var_12

			if var_12.isTweening(arg_8_0.fingerXyz.gameObject) then
				LeanTween = var_12

				var_12.cancel(arg_8_0.fingerXyz.gameObject)

				goto label_8_0
			end
		end

		do
			local var_8_20 = arg_8_0.fingerXyz

			Vector3 = var_8_14
			var_8_20.localPosition = var_8_14.zero
		end

		::label_8_0::

		return
	end
end

function var_0_1.ClearFingerTimer(arg_10_0)
	if arg_10_0.fingerTimer then
		local var_10_0 = arg_10_0.fingerTimer

		var_1.Stop(var_10_0)

		arg_10_0.fingerTimer = nil
	end

	return
end

function var_0_1.OnClear(arg_11_0)
	if arg_11_0.eventTrigger then
		local var_11_0 = arg_11_0.eventTrigger

		var_1.Clear(var_11_0)

		arg_11_0.eventTrigger = nil
	end

	setActive = var_1

	var_1(arg_11_0.fingerTF, false)

	local var_11_1 = arg_11_0.fingerTF

	Vector3 = var_1_10002
	var_11_1.localScale = var_1_10002(1, 1, 1)

	arg_11_0:ClearFingerTimer()

	LeanTween = var_1

	var_1.cancel(arg_11_0.fingerXyz.gameObject)

	local var_11_2 = arg_11_0.fingerXyz

	Vector3 = var_2
	var_11_2.localPosition = var_2.zero
	arg_11_0.fingerAnim.enabled = true

	return
end

return var_0_1
