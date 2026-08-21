local var_0_0 = class("JiuJiuExpeditionPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.slider = arg_1_0.bg:Find("slider")
	arg_1_0.step = arg_1_0.bg:Find("step")
	arg_1_0.progress = arg_1_0.bg:Find("progress")
	arg_1_0.awardTF = arg_1_0.bg:Find("award")
	arg_1_0.battleBtn = arg_1_0.bg:Find("battle_btn")
	arg_1_0.getBtn = arg_1_0.bg:Find("get_btn")
	arg_1_0.gotBtn = arg_1_0.bg:Find("got_btn")
	arg_1_0.help = arg_1_0.bg:Find("help")
	arg_1_0.book = arg_1_0.bg:Find("book")
	arg_1_0.startGame = arg_1_0.bg:Find("startGame")
	arg_1_0.desc = arg_1_0.bg:Find("desc")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.taskIDList = _.flatten((arg_2_0.activity:getConfig("config_data")))
	arg_2_0.dropList = {}
	arg_2_0.descs = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.taskIDList) do
		table.insert(arg_2_0.dropList, Clone(pg.task_data_template[iter_2_1].award_display[1]))
		table.insert(arg_2_0.descs, pg.task_data_template[iter_2_1].desc)
	end

	return updateActivityTaskStatus(arg_2_0.activity)
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.battleBtn, function()
		if arg_3_0.curTaskVO then
			arg_3_0:emit(ActivityMediator.ON_TASK_GO, arg_3_0.curTaskVO)
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.getBtn, function()
		arg_3_0:emit(ActivityMediator.ON_TASK_SUBMIT, arg_3_0.curTaskVO)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.help, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.jiujiu_expedition_help.tip
		})

		return
	end, SFX_PANEL)

	if PLATFORM_CODE ~= PLATFORM_JP then
		setActive(arg_3_0.book, false)
	else
		local var_3_0, var_3_1, var_3_2, var_3_3 = JiuJiuExpeditionCollectionMediator.GetCollectionData()

		setActive(findTF(arg_3_0.book, "tip"), var_3_3 < var_3_2)
		onButton(arg_3_0, arg_3_0.book, function()
			arg_3_0:emit(ActivityMediator.OPEN_LAYER, Context.New({
				viewComponent = JiuJiuExpeditionCollectionLayer,
				mediator = JiuJiuExpeditionCollectionMediator
			}))

			return
		end, SFX_PANEL)
	end

	onButton(arg_3_0, arg_3_0.startGame, function()
		arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.JIUJIU_EXPEDITION)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_9_0)
	local var_9_0, var_9_1 = getActivityTask(arg_9_0.activity)

	arg_9_0.curTaskVO = var_9_1

	setText(arg_9_0.desc, arg_9_0.curTaskVO:getConfig("desc"))

	local var_9_2 = var_9_1:getConfig("award_display")[1]

	updateDrop(arg_9_0.awardTF, {
		type = var_9_2[1],
		id = var_9_2[2],
		count = var_9_2[3]
	})
	onButton(arg_9_0, arg_9_0.awardTF, function()
		arg_9_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_9_3 = var_9_1:getProgress()
	local var_9_4 = var_9_1:getConfig("target_num")
	local var_9_5 = var_9_4 <= var_9_3 and setColorStr(var_9_3, COLOR_GREEN) or var_9_3

	setText(arg_9_0.progress, var_9_5 .. "/" .. var_9_4)
	setSlider(arg_9_0.slider, 0, var_9_4, var_9_3)

	local var_9_6 = table.indexof(arg_9_0.taskIDList, var_9_0, 1)

	setText(arg_9_0.step, var_9_6 .. "/" .. #arg_9_0.taskIDList)

	local var_9_7 = var_9_1:getTaskStatus()

	setActive(arg_9_0.battleBtn, var_9_7 == 0)
	setActive(arg_9_0.getBtn, var_9_7 == 1)
	setActive(arg_9_0.gotBtn, var_9_7 == 2)

	arg_9_0.finishedIndex = var_9_7 == 2 and var_9_6 or var_9_6 - 1

	return
end

function var_0_0.OnDestroy(arg_11_0)
	return
end

return var_0_0
