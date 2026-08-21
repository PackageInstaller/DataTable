local var_0_0 = class("WorldInPicturePage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.item = arg_1_0.bg:Find("items/item")
	arg_1_0.items = arg_1_0.bg:Find("items")
	arg_1_0.uilist = UIItemList.New(arg_1_0.items, arg_1_0.item)
	arg_1_0.help = arg_1_0._tf:Find("AD/help")
	arg_1_0.start = arg_1_0._tf:Find("AD/start")
	arg_1_0.dayTF = arg_1_0.bg:Find("Text")
	arg_1_0.tip = arg_1_0._tf:Find("AD/tip")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.help, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.worldinpicture_task_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.start, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.WORLDINPICTURE)

		return
	end, SFX_PANEL)

	arg_2_0.miniGameAct = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_WORLDINPICTURE)

	return
end

function var_0_0.UpdateTask(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2:Find("item")
	local var_5_1 = arg_5_0.taskProxy:getTaskById(arg_5_0.taskGroup[arg_5_0.nday][arg_5_1 + 1]) or arg_5_0.taskProxy:getFinishTaskById(arg_5_0.taskGroup[arg_5_0.nday][arg_5_1 + 1])

	assert(var_5_1, "without this task by id: " .. arg_5_0.taskGroup[arg_5_0.nday][arg_5_1 + 1])

	local var_5_2 = var_5_1:getConfig("award_display")[1]

	updateDrop(var_5_0, {
		type = var_5_2[1],
		id = var_5_2[2],
		count = var_5_2[3]
	})
	onButton(arg_5_0, var_5_0, function()
		arg_5_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_5_3 = var_5_1:getProgress()
	local var_5_4 = var_5_1:getConfig("target_num")

	setText(arg_5_2:Find("description"), var_5_1:getConfig("desc"))
	setSlider(arg_5_2:Find("progress"), 0, var_5_4, var_5_3)

	local var_5_5 = arg_5_2:Find("go_btn")
	local var_5_6 = arg_5_2:Find("get_btn")
	local var_5_7 = arg_5_2:Find("got_btn")
	local var_5_8 = var_5_1:getTaskStatus()

	setActive(var_5_5, var_5_8 == 0)
	setActive(var_5_6, var_5_8 == 1)
	setActive(var_5_7, var_5_8 == 2)
	onButton(arg_5_0, var_5_5, function()
		arg_5_0:emit(ActivityMediator.ON_TASK_GO, var_5_1)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, var_5_6, function()
		arg_5_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_5_1)

		return
	end, SFX_PANEL)
	setText(arg_5_2:Find("progressText"), "<color=#789143>" .. var_5_3 .. "</color><color=#a3876f>/" .. var_5_4 .. "</color>")

	return
end

function var_0_0.OnUpdateFlush(arg_9_0)
	var_0_0.super.OnUpdateFlush(arg_9_0)
	setActive(arg_9_0.tip, arg_9_0.miniGameAct and not arg_9_0.miniGameAct:isEnd() and arg_9_0.miniGameAct:readyToAchieve())

	return
end

return var_0_0
