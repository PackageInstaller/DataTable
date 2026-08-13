class = var_0_10000

local var_0_0 = "NewEducateRoundTipPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

var_0_1.SHOW_TIME = 5

function var_0_1.getUIName(arg_1_0)
	return "NewEducateRoundTipPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.rootTF = var_1.Find(var_2_0, "root")

	local var_2_1 = arg_2_0.rootTF

	arg_2_0.assessWindow = var_1.Find(var_2_1, "assess")
	setActive = var_1

	var_1(arg_2_0.assessWindow, false)

	local var_2_2 = arg_2_0.assessWindow

	arg_2_0.assessTF = var_1.Find(var_2_2, "content/assess/Text")

	local var_2_3 = arg_2_0.assessWindow

	arg_2_0.targetTF = var_1.Find(var_2_3, "content/target/Text")

	local var_2_4 = arg_2_0.rootTF

	arg_2_0.roundWindow = var_1.Find(var_2_4, "round")
	setActive = var_1

	var_1(arg_2_0.roundWindow, false)

	local var_2_5 = arg_2_0.roundWindow

	arg_2_0.roundTF = var_1.Find(var_2_5, "calendar/week/Text")

	local var_2_6 = arg_2_0.roundWindow
	local var_2_7 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_2_0.roundAnim = var_2_7(var_2_6, var_3(var_1_10004))

	local var_2_8 = arg_2_0.roundWindow
	local var_2_9 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_2_0.roundAnimEvent = var_2_9(var_2_8, var_3(var_1_10004))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.assessWindow

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

function var_0_1.Show(arg_5_0, arg_5_1)
	var_0_1.super.Show(arg_5_0)

	arg_5_0.callback = arg_5_1

	arg_5_0:OverlayPanel(arg_5_0._tf, {
		groupDelta = 1
	})

	local var_5_0 = arg_5_0.contextData.char
	local var_5_1 = var_2.GetRoundData(var_5_0).round
	local var_5_2 = 0
	local var_5_3 = 0
	local var_5_4

	if var_2:IsEndless() then
		local var_5_5

		var_5_4, var_5_5, var_1_10008 = var_2:GetEndlessProgressInfos()
		var_5_3 = var_1_10008
	else
		local var_5_6

		var_5_4, var_5_6, var_1_10008 = var_2:GetProgressInfo()
		var_5_3 = var_1_10008
		var_5_2 = var_5_6
		var_5_1 = var_5_4
	end

	setText = var_5_4

	local var_5_7 = arg_5_0.assessTF

	i18n = var_1_10008

	var_5_4(var_5_7, var_1_10008("child2_assess_tip", var_5_2))

	setText = var_5_4

	local var_5_8 = arg_5_0.targetTF

	i18n = var_8

	var_5_4(var_5_8, var_8("child2_assess_tip_target", var_5_3))

	local var_5_9 = var_2
	local var_5_10 = var_2.IsTemp(var_5_9)

	setText = var_5_9

	local var_5_11 = arg_5_0.roundTF

	i18n = var_9

	var_5_9(var_5_11, var_9("child2_cur_round", var_5_10 and var_5_1 or var_5_1 - 1))

	seriesAsync = var_5_9

	var_5_9({
		function(arg_6_0)
			local var_6_0 = arg_5_0.roundAnimEvent

			var_1.SetEndEvent(var_6_0, function()
				local var_7_0 = arg_5_0.roundAnimEvent

				var_0.SetEndEvent(var_7_0, nil)

				setActive = var_0

				var_0(arg_5_0.roundWindow, false)
				arg_6_0()

				return
			end)

			local var_6_1 = arg_5_0.roundAnimEvent

			var_1.SetTriggerEvent(var_6_1, function()
				local var_8_0 = arg_5_0.roundAnimEvent

				var_0.SetTriggerEvent(var_8_0, nil)

				if var_5_10 then
					i18n = var_8_1

					local var_8_1

					if not var_8_1("child2_cur_round_temp") then
						i18n = var_8_1
						var_8_1 = var_8_1("child2_cur_round", var_5_1)
					end

					setText = var_8_0

					var_8_0(arg_5_0.roundTF, var_8_1)

					return
				end
			end)

			setActive = var_1

			var_1(arg_5_0.roundWindow, true)

			return
		end,
		function(arg_9_0)
			local var_9_0 = var_0

			if var_1.IsShowAssessTip(var_9_0) then
				setActive = var_1

				var_1(arg_5_0.assessWindow, true)

				onDelayTick = var_1

				var_1(function()
					if arg_5_0._tf then
						local var_10_0 = arg_5_0

						if not var_0.isShowing(var_10_0) then
							return
						end

						setActive = var_0

						var_0(arg_5_0.assessWindow, false)
						arg_9_0()

						return
					end
				end, var_0_1.SHOW_TIME)
			else
				arg_9_0()
			end

			return
		end
	}, function()
		local var_11_0 = arg_5_0

		var_0.Hide(var_11_0)

		return
	end)

	return
end

function var_0_1.Hide(arg_12_0)
	arg_12_0:UnOverlayPanel(arg_12_0._tf)

	existCall = var_1

	var_1(arg_12_0.callback)

	arg_12_0.callback = nil

	var_0_1.super.Hide(arg_12_0)

	return
end

function var_0_1.OnDestroy(arg_13_0)
	return
end

return var_0_1
