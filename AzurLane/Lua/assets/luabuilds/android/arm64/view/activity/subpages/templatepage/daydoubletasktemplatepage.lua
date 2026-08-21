local var_0_0 = class("DayDoubleTaskTemplatePage", import("view.base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.dayTF = arg_1_0.bg:Find("total_progress/day")
	arg_1_0.item = arg_1_0.bg:Find("item")
	arg_1_0.items = arg_1_0.bg:Find("items")
	arg_1_0.uilist = UIItemList.New(arg_1_0.items, arg_1_0.item)

	setActive(arg_1_0.item, false)

	arg_1_0.progressLabel = arg_1_0.bg:Find("total_progress/label")

	setText(arg_1_0.progressLabel, i18n("Outpost_20250904_Progress"))

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.nday = 0
	arg_2_0.taskProxy = getProxy(TaskProxy)
	arg_2_0.taskGroup = arg_2_0.activity:getConfig("config_data")

	return updateActivityTaskStatus(arg_2_0.activity)
end

function var_0_0.OnFirstFlush(arg_3_0)
	arg_3_0.uilist:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateTask(arg_4_1, arg_4_2)
		end

		return
	end)

	return
end

function var_0_0.UpdateTask(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2:Find("item")
	local var_5_1 = arg_5_0.taskProxy:getTaskById(arg_5_0.taskGroup[arg_5_0.nday][arg_5_1 + 1]) or arg_5_0.taskProxy:getFinishTaskById(arg_5_0.taskGroup[arg_5_0.nday][arg_5_1 + 1])

	assert(var_5_1, "without this task by id: " .. arg_5_0.taskGroup[arg_5_0.nday][arg_5_1 + 1])
	updateDrop(var_5_0, (Drop.Create(var_5_1:getConfig("award_display")[1])))
	onButton(arg_5_0, var_5_0, function()
		arg_5_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_5_2 = var_5_1:getProgress()
	local var_5_3 = var_5_1:getConfig("target_num")

	setText(arg_5_2:Find("description"), var_5_1:getConfig("desc"))

	local var_5_4, var_5_5 = arg_5_0:GetProgressColor()
	local var_5_6

	var_5_6 = var_5_4 and setColorStr(var_5_2, var_5_4) or var_5_2

	local var_5_7

	var_5_7 = var_5_5 and setColorStr("/" .. var_5_3, var_5_5) or "/" .. var_5_3

	setText(arg_5_2:Find("progressText"), var_5_6 .. var_5_7)
	setSlider(arg_5_2:Find("progress"), 0, var_5_3, var_5_2)

	local var_5_8 = arg_5_2:Find("go_btn")
	local var_5_9 = arg_5_2:Find("get_btn")
	local var_5_10 = arg_5_2:Find("got_btn")
	local var_5_11 = var_5_1:getTaskStatus()

	setActive(var_5_8, var_5_11 == 0)
	setActive(var_5_9, var_5_11 == 1)
	setActive(var_5_10, var_5_11 == 2)
	onButton(arg_5_0, var_5_8, function()
		arg_5_0:emit(ActivityMediator.ON_TASK_GO, var_5_1)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, var_5_9, function()
		local var_8_0 = var_5_1:getConfig("award_display")
		local var_8_1 = getProxy(PlayerProxy):getRawData()
		local var_8_2 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
		local var_8_3, var_8_4 = Task.StaticJudgeOverflow(var_8_1.gold, var_8_1.oil, var_8_2, true, true, var_8_0)

		if var_8_3 then
			table.insert({}, function(arg_9_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_8_4,
					onYes = arg_9_0
				})

				return
			end)
		end

		seriesAsync({}, function()
			arg_5_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_5_1)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_11_0)
	arg_11_0.nday = arg_11_0.activity.data3

	arg_11_0:PlayStory()
	arg_11_0:UpdateProgress()
	arg_11_0.uilist:align(#arg_11_0.taskGroup[arg_11_0.nday])

	return
end

function UpdateProgress()
	if self.dayTF then
		setText(self.dayTF, self.nday .. "/" .. #self.taskGroup)
	end

	return
end

function var_0_0.PlayStory(arg_13_0)
	local var_13_0 = arg_13_0.activity:getConfig("config_client").story

	if checkExist(var_13_0, {
		arg_13_0.nday
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_13_0[arg_13_0.nday][1])
	end

	return
end

function var_0_0.OnDestroy(arg_14_0)
	eachChild(arg_14_0.items, function(arg_15_0)
		Destroy(arg_15_0)

		return
	end)

	return
end

function var_0_0.GetProgressColor(arg_16_0)
	return nil
end

return var_0_0
