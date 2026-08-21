local var_0_0 = class("FujinBayMedalTaskPanel", import(".MedalTaskPanel"))

function var_0_0.UpdateList(arg_1_0, arg_1_1)
	arg_1_0.UIlist:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			local var_2_0 = arg_1_1[arg_2_1 + 1]
			local var_2_1 = arg_2_2:Find("frame/progress")
			local var_2_2 = arg_2_2:Find("frame/progress_1")
			local var_2_3 = arg_2_2:Find("frame/awards")
			local var_2_4 = arg_2_2:Find("frame/get_btn")
			local var_2_5 = arg_2_2:Find("frame/got_btn")
			local var_2_6 = arg_2_2:Find("frame/go_btn")

			setText(arg_2_2:Find("frame/desc"), arg_1_1[arg_2_1 + 1]:getConfig("desc"))

			local var_2_7, var_2_8 = arg_1_0:getTaskProgress(var_2_0)
			local var_2_9, var_2_10 = arg_1_0:getTaskTarget(var_2_0)

			arg_2_2:Find("frame/slider"):GetComponent(typeof(Slider)).value = var_2_7 / var_2_9

			setText(var_2_1, var_2_8)
			setText(var_2_2, "/" .. var_2_10)

			local var_2_11 = var_2_1:GetComponent(typeof(Text)).preferredWidth
			local var_2_12 = var_2_2:GetComponent(typeof(Text)).preferredWidth

			var_2_1.sizeDelta = Vector2(var_2_11, var_2_1.sizeDelta.y)
			var_2_2.sizeDelta = Vector2(var_2_12, var_2_2.sizeDelta.y)
			var_2_1.anchoredPosition = Vector2(var_2_2.anchoredPosition.x - var_2_12 * var_2_2.pivot.x - var_2_11 * (1 - var_2_1.pivot.x), var_2_1.anchoredPosition.y)

			arg_1_0:updateAwards(var_2_0:getConfig("award_display"), var_2_3, (var_2_3:GetChild(0)))
			setActive(var_2_5, var_2_0:getTaskStatus() == 2)
			setActive(var_2_4, var_2_0:getTaskStatus() == 1)
			setActive(var_2_6, var_2_0:getTaskStatus() == 0)
			onButton(arg_1_0, var_2_6, function()
				arg_1_0._parent:emit(MedalAlbumTemplateMediator.ON_TASK_GO, var_2_0)

				return
			end, SFX_PANEL)
			onButton(arg_1_0, var_2_4, function()
				arg_1_0._parent:emit(MedalAlbumTemplateMediator.ON_TASK_SUBMIT, var_2_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_1_0.UIlist:align(#arg_1_1)

	if arg_1_0._parent.TASK_ANIM and arg_1_0._parent.TASK_ENTER_ANIM_Time and arg_1_0._parent.TASK_Time then
		local var_1_0 = findTF(arg_1_0._tf, "panel/list").transform.childCount

		onDelayTick(function()
			for iter_5_0 = 0, var_1_0 - 1 do
				local var_5_0 = findTF(arg_1_0._tf, "panel/list"):GetChild(iter_5_0)

				onDelayTick(function()
					if arg_1_0._parent.exited then
						return
					end

					quickPlayAnimation(var_5_0, arg_1_0._parent.TASK_ANIM)

					return
				end, arg_1_0._parent.TASK_Time * (iter_5_0 + 1))
			end

			return
		end, arg_1_0._parent.TASK_ENTER_ANIM_Time)
	end

	return
end

return var_0_0
