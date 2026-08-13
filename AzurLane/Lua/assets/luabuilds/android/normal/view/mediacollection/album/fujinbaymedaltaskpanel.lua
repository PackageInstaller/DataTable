class = var_0_10000

local var_0_0 = "FujinBayMedalTaskPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MedalTaskPanel"))

function var_0_1.UpdateList(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.UIlist

	var_2.make(var_1_0, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = arg_1_1[arg_2_1 + 1]
			local var_2_1 = arg_2_2:Find("frame/slider")
			local var_2_2 = var_4.GetComponent

			typeof = var_6
			Slider = var_2_10007

			local var_2_3 = var_2_2(var_2_1, var_6(var_2_10007))
			local var_2_4 = arg_2_2:Find("frame/progress")
			local var_2_5 = arg_2_2:Find("frame/progress_1")
			local var_2_6 = arg_2_2:Find("frame/awards")
			local var_2_7 = arg_2_2:Find("frame/desc")
			local var_2_8 = arg_2_2:Find("frame/get_btn")
			local var_2_9 = arg_2_2:Find("frame/got_btn")
			local var_2_10 = arg_2_2
			local var_2_11 = arg_2_2.Find(var_2_10, "frame/go_btn")

			setText = var_2_10

			var_2_10(var_2_7, var_2_0:getConfig("desc"))

			local var_2_12 = arg_1_0
			local var_2_13, var_2_14 = var_12.getTaskProgress(var_2_12, var_2_0)
			local var_2_15 = arg_1_0
			local var_2_16, var_2_17 = var_14.getTaskTarget(var_2_15, var_2_0)

			var_2_3.value = var_2_13 / var_2_16
			setText = var_16

			var_16(var_2_4, var_2_14)

			setText = var_16

			var_16(var_2_5, "/" .. var_2_17)

			local var_2_18 = var_2_4
			local var_2_19 = var_2_4.GetComponent

			typeof = var_18
			Text = var_19

			local var_2_20 = var_2_19(var_2_18, var_18(var_19))
			local var_2_21 = var_2_5
			local var_2_22 = var_2_5.GetComponent

			typeof = var_19
			Text = var_2_10020

			local var_2_23 = var_2_22(var_2_21, var_19(var_2_10020))
			local var_2_24 = var_2_20.preferredWidth
			local var_2_25 = var_2_23.preferredWidth

			Vector2 = var_2_10020
			var_2_4.sizeDelta = var_2_10020(var_2_24, var_2_4.sizeDelta.y)
			Vector2 = var_20
			var_2_5.sizeDelta = var_20(var_2_25, var_2_5.sizeDelta.y)

			local var_2_26 = var_2_5.anchoredPosition.x - var_2_25 * var_2_5.pivot.x - var_2_24 * (1 - var_2_4.pivot.x)

			Vector2 = var_22
			var_2_4.anchoredPosition = var_22(var_2_26, var_2_4.anchoredPosition.y)

			local var_2_27 = var_2_6:GetChild(0)
			local var_2_28 = arg_1_0

			var_23.updateAwards(var_2_28, var_2_0:getConfig("award_display"), var_2_6, var_2_27)

			setActive = var_23

			var_23(var_2_9, var_2_0:getTaskStatus() == 2)

			setActive = var_23

			var_23(var_2_8, var_2_0:getTaskStatus() == 1)

			setActive = var_23

			var_23(var_2_11, var_2_0:getTaskStatus() == 0)

			onButton = var_23

			local var_2_29 = arg_1_0
			local var_2_30 = var_2_11

			local function var_2_31()
				local var_3_0 = arg_1_0._parent
				local var_3_1 = var_0.emit

				MedalAlbumTemplateMediator = var_3_10002

				var_3_1(var_3_0, var_3_10002.ON_TASK_GO, var_2_0)

				return
			end

			SFX_PANEL = var_27

			var_23(var_2_29, var_2_30, var_2_31, var_27)

			onButton = var_23

			local var_2_32 = arg_1_0
			local var_2_33 = var_2_8

			local function var_2_34()
				local var_4_0 = arg_1_0._parent
				local var_4_1 = var_0.emit

				MedalAlbumTemplateMediator = var_3_10002

				var_4_1(var_4_0, var_3_10002.ON_TASK_SUBMIT, var_2_0)

				return
			end

			SFX_PANEL = var_27

			var_23(var_2_32, var_2_33, var_2_34, var_27)
		end

		return
	end)

	local var_1_1 = arg_1_0.UIlist

	var_2.align(var_1_1, #arg_1_1)

	if arg_1_0._parent.TASK_ANIM and arg_1_0._parent.TASK_ENTER_ANIM_Time and arg_1_0._parent.TASK_Time then
		findTF = var_2

		local var_1_2 = var_2(arg_1_0._tf, "panel/list").transform.childCount

		onDelayTick = var_3

		var_3(function()
			for iter_5_0 = 0, var_1_2 - 1 do
				findTF = var_2_10004

				local var_5_0 = var_2_10004(arg_1_0._tf, "panel/list")

				var_2_10004 = var_2_10004.GetChild(var_5_0, iter_5_0)
				onDelayTick = var_5_0

				var_5_0(function()
					if arg_1_0._parent.exited then
						return
					end

					quickPlayAnimation = var_0

					var_0(var_2_10004, arg_1_0._parent.TASK_ANIM)

					return
				end, arg_1_0._parent.TASK_Time * (iter_5_0 + 1))
			end

			return
		end, arg_1_0._parent.TASK_ENTER_ANIM_Time)
	end

	return
end

return var_0_1
