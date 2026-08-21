local var_0_0 = class("PermanentYamashiroSkinPage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	arg_1_0.uilist:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			local var_2_0 = arg_2_2:Find("item")
			local var_2_1 = arg_1_0.taskProxy:getTaskById(arg_1_0.taskGroup[arg_1_0.nday][arg_2_1 + 1]) or arg_1_0.taskProxy:getFinishTaskById(arg_1_0.taskGroup[arg_1_0.nday][arg_2_1 + 1])

			assert(var_2_1, "without this task by id: " .. arg_1_0.taskGroup[arg_1_0.nday][arg_2_1 + 1])

			local var_2_2 = var_2_1:getConfig("award_display")[1]

			updateDrop(var_2_0, {
				type = var_2_2[1],
				id = var_2_2[2],
				count = var_2_2[3]
			})
			onButton(arg_1_0, var_2_0, function()
				arg_1_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)

			local var_2_3 = var_2_1:getProgress()
			local var_2_4 = var_2_1:getConfig("target_num")

			setText(arg_2_2:Find("description"), var_2_1:getConfig("desc"))
			setText(arg_2_2:Find("progressText"), setColorStr(var_2_3, "#36AF41FF") .. "/" .. var_2_4)
			setSlider(arg_2_2:Find("progress"), 0, var_2_4, var_2_3)

			local var_2_5 = arg_2_2:Find("go_btn")
			local var_2_6 = arg_2_2:Find("get_btn")
			local var_2_7 = arg_2_2:Find("got_btn")
			local var_2_8 = var_2_1:getTaskStatus()

			setActive(var_2_5, var_2_8 == 0)
			setActive(var_2_6, var_2_8 == 1)
			setActive(var_2_7, var_2_8 == 2)
			onButton(arg_1_0, var_2_5, function()
				arg_1_0:emit(ActivityMediator.ON_TASK_GO, var_2_1)

				return
			end, SFX_PANEL)
			onButton(arg_1_0, var_2_6, function()
				arg_1_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_2_1)

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	var_0_0.super.OnUpdateFlush(arg_6_0)
	setText(arg_6_0.dayTF, setColorStr(tostring(arg_6_0.nday), "#36AF41FF") .. "/" .. #arg_6_0.activity:getConfig("config_data"))

	return
end

return var_0_0
