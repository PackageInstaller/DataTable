local var_0_0 = class("NewEducateRoundTipPanel", import("view.base.BaseSubView"))

var_0_0.SHOW_TIME = 5

function var_0_0.getUIName(arg_1_0)
	return "NewEducateRoundTipPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.rootTF = arg_2_0._tf:Find("root")
	arg_2_0.assessWindow = arg_2_0.rootTF:Find("assess")

	setActive(arg_2_0.assessWindow, false)

	arg_2_0.assessTF = arg_2_0.assessWindow:Find("content/assess/Text")
	arg_2_0.targetTF = arg_2_0.assessWindow:Find("content/target/Text")
	arg_2_0.roundWindow = arg_2_0.rootTF:Find("round")

	setActive(arg_2_0.roundWindow, false)

	arg_2_0.roundTF = arg_2_0.roundWindow:Find("calendar/week/Text")
	arg_2_0.roundAnim = arg_2_0.roundWindow:GetComponent(typeof(Animation))
	arg_2_0.roundAnimEvent = arg_2_0.roundWindow:GetComponent(typeof(DftAniEvent))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.assessWindow, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_5_0, arg_5_1)
	var_0_0.super.Show(arg_5_0)

	arg_5_0.callback = arg_5_1

	arg_5_0:OverlayPanel(arg_5_0._tf, {
		groupDelta = 1
	})

	local var_5_0 = arg_5_0.contextData.char:GetRoundData()
	local var_5_1 = var_5_0.round
	local var_5_2 = 0
	local var_5_3 = 0

	if var_5_0:IsEndless() then
		local var_5_4, var_5_5, var_5_6 = var_5_0:GetEndlessProgressInfos()

		var_5_3 = var_5_6
	else
		var_5_1, var_5_2, var_5_3 = var_5_0:GetProgressInfo()
	end

	setText(arg_5_0.assessTF, i18n("child2_assess_tip", var_5_2))
	setText(arg_5_0.targetTF, i18n("child2_assess_tip_target", var_5_3))
	setText(arg_5_0.roundTF, i18n("child2_cur_round", var_5_0:IsTemp() and var_5_1 or var_5_1 - 1))
	seriesAsync({
		function(arg_6_0)
			arg_5_0.roundAnimEvent:SetEndEvent(function()
				arg_5_0.roundAnimEvent:SetEndEvent(nil)
				setActive(arg_5_0.roundWindow, false)
				arg_6_0()

				return
			end)
			arg_5_0.roundAnimEvent:SetTriggerEvent(function()
				arg_5_0.roundAnimEvent:SetTriggerEvent(nil)

				local var_8_0 = var_0 and i18n("child2_cur_round_temp") or i18n("child2_cur_round", var_5_1)

				setText(arg_5_0.roundTF, var_8_0)

				return
			end)
			setActive(arg_5_0.roundWindow, true)

			return
		end,
		function(arg_9_0)
			if var_5_0:IsShowAssessTip() then
				setActive(arg_5_0.assessWindow, true)
				onDelayTick(function()
					if not arg_5_0._tf or not arg_5_0:isShowing() then
						return
					end

					setActive(arg_5_0.assessWindow, false)
					arg_9_0()

					return
				end, var_0_0.SHOW_TIME)
			else
				arg_9_0()
			end

			return
		end
	}, function()
		arg_5_0:Hide()

		return
	end)

	return
end

function var_0_0.Hide(arg_12_0)
	arg_12_0:UnOverlayPanel(arg_12_0._tf)
	existCall(arg_12_0.callback)

	arg_12_0.callback = nil

	var_0_0.super.Hide(arg_12_0)

	return
end

function var_0_0.OnDestroy(arg_13_0)
	return
end

return var_0_0
