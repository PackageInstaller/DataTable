local var_0_0 = class("ShioSkinRePage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.dayTF = arg_1_0.bg:Find("day")
	arg_1_0.item1TF = arg_1_0.bg:Find("item1")
	arg_1_0.item2TF = arg_1_0.bg:Find("item2")
	arg_1_0.itemTFList = {
		arg_1_0.item1TF,
		arg_1_0.item2TF
	}

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	return
end

function var_0_0.OnUpdateFlush(arg_3_0)
	arg_3_0.nday = arg_3_0.activity.data3

	if arg_3_0.dayTF then
		setText(arg_3_0.dayTF, arg_3_0.nday .. "/" .. #arg_3_0.activity:getConfig("config_data"))
	end

	local var_3_0 = arg_3_0.activity:getConfig("config_client").story

	if checkExist(var_3_0, {
		arg_3_0.nday
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_3_0[arg_3_0.nday][1])
	end

	for iter_3_0 = 1, 2 do
		local var_3_2 = arg_3_0.itemTFList[iter_3_0]:Find("item")
		local var_3_3 = arg_3_0.taskProxy:getTaskById(arg_3_0.taskGroup[arg_3_0.nday][iter_3_0]) or arg_3_0.taskProxy:getFinishTaskById(arg_3_0.taskGroup[arg_3_0.nday][iter_3_0])

		assert(var_3_3, "without this task by id: " .. arg_3_0.taskGroup[arg_3_0.nday][iter_3_0])

		local var_3_4 = var_3_3:getConfig("award_display")[1]

		updateDrop(var_3_2, {
			type = var_3_4[1],
			id = var_3_4[2],
			count = var_3_4[3]
		})
		onButton(arg_3_0, var_3_2, function()
			arg_3_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)

		local var_3_5 = var_3_3:getProgress()
		local var_3_6 = var_3_3:getConfig("target_num")

		setText(arg_3_0.itemTFList[iter_3_0]:Find("description"), var_3_3:getConfig("desc"))
		setText(arg_3_0.itemTFList[iter_3_0]:Find("progressText"), var_3_5 .. "/" .. var_3_6)
		setSlider(arg_3_0.itemTFList[iter_3_0]:Find("progress"), 0, var_3_6, var_3_5)

		local var_3_7 = arg_3_0.itemTFList[iter_3_0]:Find("go_btn")
		local var_3_8 = arg_3_0.itemTFList[iter_3_0]:Find("get_btn")
		local var_3_9 = arg_3_0.itemTFList[iter_3_0]:Find("got_btn")
		local var_3_10 = var_3_3:getTaskStatus()

		setActive(var_3_7, var_3_10 == 0)
		setActive(var_3_8, var_3_10 == 1)
		setActive(var_3_9, var_3_10 == 2)
		onButton(arg_3_0, var_3_7, function()
			arg_3_0:emit(ActivityMediator.ON_TASK_GO, var_3_3)

			return
		end, SFX_PANEL)
		onButton(arg_3_0, var_3_8, function()
			arg_3_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_3_3)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.OnDestroy(arg_7_0)
	return
end

return var_0_0
