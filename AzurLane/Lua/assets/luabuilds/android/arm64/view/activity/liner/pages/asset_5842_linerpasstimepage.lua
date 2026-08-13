class = var_0_10000

local var_0_0 = "LinerPassTimePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

var_0_1.ANIM_TIME = 0.75
var_0_1.DELAY_TIME = 0.5

function var_0_1.getUIName(arg_1_0)
	return "LinerPassTimePage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.rotateTF = var_1.Find(var_2_0, "progress/Image")

	local var_2_1 = arg_2_0._tf

	arg_2_0.dayTF = var_1.Find(var_2_1, "time/day")
	setText = var_1

	var_1(arg_2_0.dayTF, "DAY")

	local var_2_2 = arg_2_0._tf

	arg_2_0.beforeDay = var_1.Find(var_2_2, "time/day_1")

	local var_2_3 = arg_2_0._tf

	arg_2_0.afterDay = var_1.Find(var_2_3, "time/day_2")

	local var_2_4 = arg_2_0._tf

	arg_2_0.pointTF = var_1.Find(var_2_4, "time/point")

	local var_2_5 = arg_2_0._tf

	arg_2_0.pointAfterTF = var_1.Find(var_2_5, "time/point_after")

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "time")
	local var_2_8 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_2_0.timeAnim = var_2_8(var_2_7, var_4(var_1_10006))

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_2_0.anim = var_2_10(var_2_9, var_4(var_1_10006))

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_2_0.animEvent = var_2_12(var_2_11, var_4(var_1_10006))

	local var_2_13 = arg_2_0.animEvent

	var_1.SetEndEvent(var_2_13, function()
		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end)

	return
end

function var_0_1.OnInit(arg_4_0)
	return
end

function var_0_1.ShowAnim(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = arg_5_1:GetDayByIdx(arg_5_3)
	local var_5_1 = arg_5_1:GetTimeByIdx(arg_5_2)
	local var_5_2 = arg_5_1
	local var_5_3 = arg_5_1.GetTimeByIdx(var_5_2, arg_5_3)
	local var_5_4 = var_5_1:GetType()

	LinerTime = var_5_2

	local var_5_5

	if var_5_4 ~= var_5_2.TYPE.STORY or not (var_5_0 - 1) then
		var_5_5 = var_5_0
	end

	setText = var_9

	local var_5_6 = arg_5_0.beforeDay

	string = var_1_10012

	var_9(var_5_6, var_1_10012.format("%02d", var_5_5))

	setText = var_9

	local var_5_7 = arg_5_0.afterDay

	string = var_12

	var_9(var_5_7, var_12.format("%02d", var_5_5))

	setText = var_9

	var_9(arg_5_0.pointTF, var_5_1:GetStartTimeDesc())

	setText = var_9

	var_9(arg_5_0.pointAfterTF, var_5_1:GetStartTimeDesc())

	local var_5_8 = var_5_1:GetTime()[1]
	local var_5_9 = var_5_3:GetTime()[1]
	local var_5_10 = var_5_5 == var_5_0 and "anim_passtime_change" or "anim_passtime_change1"
	local var_5_11 = var_5_8 > 3 and var_5_8 or var_5_8 + 24
	local var_5_12 = var_5_9 > 3 and var_5_9 or var_5_9 + 24
	local var_5_13 = var_5_11 - 8
	local var_5_14 = var_5_12 - 8

	math = var_1_10016

	local var_5_15 = var_1_10016.floor(var_5_13 * 180 / 19)

	math = var_1_10017

	local var_5_16 = var_1_10017.floor(var_5_14 * 180 / 19)

	setLocalEulerAngles = var_18

	var_18(arg_5_0.rotateTF, {
		z = -var_5_15
	})
	arg_5_0:Show()

	seriesAsync = var_18

	var_18({
		function(arg_6_0)
			local var_6_0 = arg_5_0
			local var_6_1 = var_1.managedTween

			LeanTween = var_2_10004

			var_6_1(var_6_0, var_2_10004.delayedCall, function()
				arg_6_0()

				return
			end, 0.4, nil)

			return
		end,
		function(arg_8_0)
			if var_5_15 > var_5_16 then
				local var_8_0 = arg_5_0
				local var_8_1 = var_1.managedTween

				LeanTween = var_2_10004

				var_8_1(var_8_0, var_2_10004.delayedCall, function()
					setLocalEulerAngles = var_3_10000

					var_3_10000(arg_5_0.rotateTF, {
						z = -var_5_16
					})
					arg_8_0()

					setText = var_0

					local var_9_0 = arg_5_0.afterDay

					string = var_3

					var_0(var_9_0, var_3.format("%02d", var_5_0))

					setText = var_0

					local var_9_1 = arg_5_0.pointAfterTF
					local var_9_2 = var_5_3

					var_0(var_9_1, var_3.GetStartTimeDesc(var_9_2))

					local var_9_3 = arg_5_0.timeAnim

					var_0.Play(var_9_3, var_5_10)

					return
				end, var_0_1.ANIM_TIME, nil)
			else
				local var_8_2 = arg_5_0
				local var_8_3 = var_1.managedTween

				LeanTween = var_2_10004

				local var_8_4 = var_2_10004.value
				local var_8_5

				go = var_2_10006

				local var_8_6 = var_8_3(var_8_2, var_8_4, var_8_5, var_2_10006(arg_5_0.rotateTF), var_5_15, var_5_16, var_0_1.ANIM_TIME)
				local var_8_7 = var_1.setOnUpdate

				System = var_8_4

				local var_8_8 = var_8_7(var_8_6, var_8_4.Action_float(function(arg_10_0)
					setLocalEulerAngles = var_3_10001

					var_3_10001(arg_5_0.rotateTF, {
						z = -arg_10_0
					})

					return
				end))
				local var_8_9 = var_1.setEase

				LeanTweenType = var_4

				local var_8_10 = var_8_9(var_8_8, var_4.easeInOutCubic)
				local var_8_11 = var_1.setOnComplete

				System = var_4

				var_8_11(var_8_10, var_4.Action(function()
					arg_8_0()

					return
				end))

				setText = var_8_11

				local var_8_12 = arg_5_0.afterDay

				string = var_4

				var_8_11(var_8_12, var_4.format("%02d", var_5_0))

				setText = var_8_11

				local var_8_13 = arg_5_0.pointAfterTF
				local var_8_14 = var_5_3

				var_8_11(var_8_13, var_4.GetStartTimeDesc(var_8_14))

				local var_8_15 = arg_5_0.timeAnim

				var_1.Play(var_8_15, var_5_10)
			end

			return
		end,
		function(arg_12_0)
			local var_12_0 = arg_5_0
			local var_12_1 = var_1.managedTween

			LeanTween = var_2_10004

			var_12_1(var_12_0, var_2_10004.delayedCall, function()
				arg_12_0()

				return
			end, var_0_1.DELAY_TIME, nil)

			return
		end
	}, function()
		if arg_5_4 then
			arg_5_4()
		end

		local var_14_0 = arg_5_0.anim

		var_0.Play(var_14_0, "anim_passtime_out")

		return
	end)

	return
end

function var_0_1.Show(arg_15_0)
	var_0_1.super.Show(arg_15_0)

	pg = var_1

	local var_15_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_15_0, arg_15_0._tf)

	return
end

function var_0_1.Hide(arg_16_0)
	var_0_1.super.Hide(arg_16_0)

	pg = var_1

	local var_16_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_16_0, arg_16_0._tf)

	return
end

function var_0_1.OnDestroy(arg_17_0)
	return
end

return var_0_1
