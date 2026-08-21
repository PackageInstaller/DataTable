local var_0_0 = class("LinerPassTimePage", import("view.base.BaseSubView"))

var_0_0.ANIM_TIME = 0.75
var_0_0.DELAY_TIME = 0.5

function var_0_0.getUIName(arg_1_0)
	return "LinerPassTimePage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.rotateTF = arg_2_0._tf:Find("progress/Image")
	arg_2_0.dayTF = arg_2_0._tf:Find("time/day")

	setText(arg_2_0.dayTF, "DAY")

	arg_2_0.beforeDay = arg_2_0._tf:Find("time/day_1")
	arg_2_0.afterDay = arg_2_0._tf:Find("time/day_2")
	arg_2_0.pointTF = arg_2_0._tf:Find("time/point")
	arg_2_0.pointAfterTF = arg_2_0._tf:Find("time/point_after")
	arg_2_0.timeAnim = arg_2_0._tf:Find("time"):GetComponent(typeof(Animation))
	arg_2_0.anim = arg_2_0._tf:GetComponent(typeof(Animation))
	arg_2_0.animEvent = arg_2_0._tf:GetComponent(typeof(DftAniEvent))

	arg_2_0.animEvent:SetEndEvent(function()
		arg_2_0:Hide()

		return
	end)

	return
end

function var_0_0.OnInit(arg_4_0)
	return
end

function var_0_0.ShowAnim(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = arg_5_1:GetDayByIdx(arg_5_3)
	local var_5_1 = arg_5_1:GetTimeByIdx(arg_5_2)
	local var_5_2 = arg_5_1:GetTimeByIdx(arg_5_3)

	if var_5_1:GetType() == LinerTime.TYPE.STORY then
		local var_5_3 = var_5_0 - 1 or var_5_0

		setText(arg_5_0.beforeDay, string.format("%02d", var_5_3))
		setText(arg_5_0.afterDay, string.format("%02d", var_5_3))
		setText(arg_5_0.pointTF, var_5_1:GetStartTimeDesc())
		setText(arg_5_0.pointAfterTF, var_5_1:GetStartTimeDesc())

		local var_5_4 = var_5_1:GetTime()[1]
		local var_5_5 = var_5_2:GetTime()[1]
		local var_5_6 = var_5_3 == var_5_0 and "anim_passtime_change" or "anim_passtime_change1"
		local var_5_7 = math.floor(((var_5_5 > 3 and var_5_5 or var_5_5 + 24) - 8) * 180 / 19)

		setLocalEulerAngles(arg_5_0.rotateTF, {
			z = -math.floor(((var_5_4 > 3 and var_5_4 or var_5_4 + 24) - 8) * 180 / 19)
		})
		arg_5_0:Show()
		seriesAsync({
			function(arg_6_0)
				arg_5_0:managedTween(LeanTween.delayedCall, function()
					arg_6_0()

					return
				end, 0.4, nil)

				return
			end,
			function(arg_8_0)
				if var_0 > var_5_7 then
					arg_5_0:managedTween(LeanTween.delayedCall, function()
						setLocalEulerAngles(arg_5_0.rotateTF, {
							z = -var_5_7
						})
						arg_8_0()
						setText(arg_5_0.afterDay, string.format("%02d", var_5_0))
						setText(arg_5_0.pointAfterTF, var_5_2:GetStartTimeDesc())
						arg_5_0.timeAnim:Play(var_5_6)

						return
					end, var_0_0.ANIM_TIME, nil)
				else
					arg_5_0:managedTween(LeanTween.value, nil, go(arg_5_0.rotateTF), var_0, var_5_7, var_0_0.ANIM_TIME):setOnUpdate(System.Action_float(function(arg_10_0)
						setLocalEulerAngles(arg_5_0.rotateTF, {
							z = -arg_10_0
						})

						return
					end)):setEase(LeanTweenType.easeInOutCubic):setOnComplete(System.Action(function()
						arg_8_0()

						return
					end))
					setText(arg_5_0.afterDay, string.format("%02d", var_5_0))
					setText(arg_5_0.pointAfterTF, var_5_2:GetStartTimeDesc())
					arg_5_0.timeAnim:Play(var_5_6)
				end

				return
			end,
			function(arg_12_0)
				arg_5_0:managedTween(LeanTween.delayedCall, function()
					arg_12_0()

					return
				end, var_0_0.DELAY_TIME, nil)

				return
			end
		}, function()
			if arg_5_4 then
				arg_5_4()
			end

			arg_5_0.anim:Play("anim_passtime_out")

			return
		end)

		return
	end
end

function var_0_0.Show(arg_15_0)
	var_0_0.super.Show(arg_15_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_15_0._tf)

	return
end

function var_0_0.Hide(arg_16_0)
	var_0_0.super.Hide(arg_16_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_16_0._tf)

	return
end

function var_0_0.OnDestroy(arg_17_0)
	return
end

return var_0_0
