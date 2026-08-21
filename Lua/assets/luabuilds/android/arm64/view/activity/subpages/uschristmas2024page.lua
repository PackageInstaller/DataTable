local var_0_0 = class("USChristmas2024Page", import("view.base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.item = arg_1_0.bg:Find("item")
	arg_1_0.items = arg_1_0.bg:Find("items")
	arg_1_0.uilist = UIItemList.New(arg_1_0.items, arg_1_0.item)
	arg_1_0.awardNum = arg_1_0.bg:Find("awardNum")
	arg_1_0.linkBtn = arg_1_0.bg:Find("linkBtn")

	setActive(arg_1_0.item, false)

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.nday = 0
	arg_2_0.activityTaskProxy = getProxy(ActivityTaskProxy)
	arg_2_0.taskGroup = arg_2_0.activity:getConfig("config_data")

	return
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
	local var_5_1 = arg_5_0.taskGroup[arg_5_0.nday][arg_5_1 + 1]
	local var_5_2
	local var_5_3 = false

	for iter_5_0, iter_5_1 in ipairs((arg_5_0.activityTaskProxy:getTaskById(arg_5_0.activity.id))) do
		if iter_5_1.id == arg_5_0.taskGroup[arg_5_0.nday][arg_5_1 + 1] then
			var_5_2 = iter_5_1

			break
		end
	end

	if not var_5_2 then
		for iter_5_2, iter_5_3 in ipairs((arg_5_0.activityTaskProxy:getFinishTaskById(arg_5_0.activity.id))) do
			if iter_5_3.id == arg_5_0.taskGroup[arg_5_0.nday][arg_5_1 + 1] then
				var_5_2 = iter_5_3
				var_5_3 = true

				break
			end
		end
	end

	assert(var_5_2, "without this task by id: " .. arg_5_0.taskGroup[arg_5_0.nday][arg_5_1 + 1])
	updateDrop(var_5_0, (Drop.Create(var_5_2:getConfig("award_display")[1])))
	onButton(arg_5_0, var_5_0, function()
		arg_5_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_5_4 = var_5_2:getProgress()
	local var_5_5 = var_5_2:getConfig("target_num")

	setText(arg_5_2:Find("description"), var_5_2:getConfig("desc"))

	local var_5_6, var_5_7 = arg_5_0:GetProgressColor()
	local var_5_8

	var_5_8 = var_5_6 and setColorStr(var_5_4, var_5_6) or var_5_4

	local var_5_9

	var_5_9 = var_5_7 and setColorStr("/" .. var_5_5, var_5_7) or "/" .. var_5_5

	setText(arg_5_2:Find("progressText"), var_5_8 .. var_5_9)
	setSlider(arg_5_2:Find("progress"), 0, var_5_5, var_5_4)

	local var_5_10 = arg_5_2:Find("go_btn")
	local var_5_11 = arg_5_2:Find("get_btn")
	local var_5_12 = arg_5_2:Find("got_btn")
	local var_5_13 = var_5_2:getTaskStatus()

	setActive(var_5_10, not var_5_3 and var_5_13 == 0)
	setActive(var_5_11, not var_5_3 and var_5_13 == 1)
	setActive(var_5_12, var_5_3)
	onButton(arg_5_0, var_5_10, function()
		arg_5_0:emit(ActivityMediator.ON_TASK_GO, var_5_2)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, var_5_11, function()
		local var_8_0 = var_5_2:getConfig("award_display")
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
			arg_5_0:emit(ActivityMediator.ON_ACTIVITY_TASK_SUBMIT, {
				activityId = arg_5_0.activity.id,
				id = var_5_1
			})

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_11_0)
	arg_11_0.nday = arg_11_0.activity:GetCurrentDay()

	local var_11_0 = 0
	local var_11_1 = getProxy(ActivityProxy):getActivityById(arg_11_0.activity:getConfig("config_client").link_act_id)

	if var_11_1 then
		var_11_0 = var_11_1.data1
	end

	setText(arg_11_0.awardNum, var_11_0)
	onButton(arg_11_0, arg_11_0.linkBtn, function()
		Application.OpenURL(arg_11_0.activity:getConfig("config_client").url)

		return
	end, SFX_PANEL)
	arg_11_0.uilist:align(#arg_11_0.taskGroup[arg_11_0.nday])

	return
end

function var_0_0.OnDestroy(arg_13_0)
	eachChild(arg_13_0.items, function(arg_14_0)
		Destroy(arg_14_0)

		return
	end)

	return
end

function var_0_0.GetProgressColor(arg_15_0)
	return nil
end

return var_0_0
