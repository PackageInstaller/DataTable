local var_0_0 = class("Chuixue7daySkinPage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.step_txt = arg_1_0.bg:Find("step_text")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	arg_2_0.uilist:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = arg_3_2:Find("item")
			local var_3_1 = arg_2_0.taskProxy:getTaskById(arg_2_0.taskGroup[arg_2_0.nday][arg_3_1 + 1]) or arg_2_0.taskProxy:getFinishTaskById(arg_2_0.taskGroup[arg_2_0.nday][arg_3_1 + 1])

			assert(var_3_1, "without this task by id: " .. arg_2_0.taskGroup[arg_2_0.nday][arg_3_1 + 1])

			local var_3_2 = var_3_1:getConfig("award_display")[1]

			updateDrop(var_3_0, {
				type = var_3_2[1],
				id = var_3_2[2],
				count = var_3_2[3]
			})
			onButton(arg_2_0, var_3_0, function()
				arg_2_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)

			local var_3_3 = var_3_1:getProgress()
			local var_3_4 = var_3_1:getConfig("target_num")

			setText(arg_3_2:Find("description"), var_3_1:getConfig("desc"))
			setText(arg_3_2:Find("progressText"), var_3_3 .. "/" .. var_3_4)
			setSlider(arg_3_2:Find("progress"), 0, var_3_4, var_3_3)

			local var_3_5 = arg_3_2:Find("go_btn")
			local var_3_6 = arg_3_2:Find("get_btn")
			local var_3_7 = arg_3_2:Find("got_btn")
			local var_3_8 = var_3_1:getTaskStatus()

			setActive(var_3_5, var_3_8 == 0)
			setActive(var_3_6, var_3_8 == 1)
			setActive(var_3_7, var_3_8 == 2)
			onButton(arg_2_0, var_3_5, function()
				arg_2_0:emit(ActivityMediator.ON_TASK_GO, var_3_1)

				return
			end, SFX_PANEL)
			onButton(arg_2_0, var_3_6, function()
				arg_2_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_3_1)

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_7_0)
	var_0_0.super.OnUpdateFlush(arg_7_0)
	setText(arg_7_0.step_txt, setColorStr(arg_7_0.nday, "#89FF59FF") .. "/" .. #arg_7_0.taskGroup)

	return
end

return var_0_0
