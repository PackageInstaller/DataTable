local var_0_0 = class("NewOrleansLoginPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.showItemTpl = arg_1_0.bg:Find("ShowItem")
	arg_1_0.showItemContainer = arg_1_0.bg:Find("ItemShowList")
	arg_1_0.itemList = UIItemList.New(arg_1_0.showItemContainer, arg_1_0.showItemTpl)

	setActive(arg_1_0.showItemTpl, false)

	arg_1_0.item = arg_1_0.bg:Find("item")
	arg_1_0.items = arg_1_0.bg:Find("items")
	arg_1_0.uilist = UIItemList.New(arg_1_0.items, arg_1_0.item)

	setActive(arg_1_0.item, false)

	arg_1_0.stepText = arg_1_0.bg:Find("step_text")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.linkActivity = getProxy(ActivityProxy):getActivityById(arg_2_0.activity:getConfig("config_client").act_id)
	arg_2_0.nday = 0
	arg_2_0.taskProxy = getProxy(TaskProxy)
	arg_2_0.taskGroup = arg_2_0.linkActivity:getConfig("config_data")
	arg_2_0.config = pg.activity_7_day_sign[arg_2_0.activity:getConfig("config_id")]
	arg_2_0.Day = #arg_2_0.config.front_drops
	arg_2_0.curDay = 0

	return updateActivityTaskStatus(arg_2_0.linkActivity)
end

function var_0_0.OnFirstFlush(arg_3_0)
	arg_3_0.uilist:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = arg_4_2:Find("item")
			local var_4_1 = arg_3_0.taskProxy:getTaskById(arg_3_0.taskGroup[arg_3_0.nday][arg_4_1 + 1]) or arg_3_0.taskProxy:getFinishTaskById(arg_3_0.taskGroup[arg_3_0.nday][arg_4_1 + 1])

			assert(var_4_1, "without this task by id: " .. arg_3_0.taskGroup[arg_3_0.nday][arg_4_1 + 1])

			local var_4_2 = var_4_1:getConfig("award_display")[1]

			updateDrop(var_4_0, {
				type = var_4_2[1],
				id = var_4_2[2],
				count = var_4_2[3]
			})
			onButton(arg_3_0, var_4_0, function()
				arg_3_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)

			local var_4_3 = var_4_1:getProgress()
			local var_4_4 = var_4_1:getConfig("target_num")

			setText(arg_4_2:Find("description"), var_4_1:getConfig("desc"))
			setText(arg_4_2:Find("progressText"), var_4_3 .. "/" .. var_4_4)
			setSlider(arg_4_2:Find("progress"), 0, var_4_4, var_4_3)

			local var_4_5 = arg_4_2:Find("go_btn")
			local var_4_6 = arg_4_2:Find("get_btn")
			local var_4_7 = arg_4_2:Find("got_btn")
			local var_4_8 = var_4_1:getTaskStatus()

			setActive(var_4_5, var_4_8 == 0)
			setActive(var_4_6, var_4_8 == 1)
			setActive(var_4_7, var_4_8 == 2)
			onButton(arg_3_0, var_4_5, function()
				arg_3_0:emit(ActivityMediator.ON_TASK_GO, var_4_1)

				return
			end, SFX_PANEL)
			onButton(arg_3_0, var_4_6, function()
				arg_3_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_4_1)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_3_0.itemList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventInit then
			updateDrop(arg_8_2, {
				type = arg_3_0.config.front_drops[arg_8_1 + 1][1],
				id = arg_3_0.config.front_drops[arg_8_1 + 1][2],
				count = arg_3_0.config.front_drops[arg_8_1 + 1][3]
			})
			onButton(arg_3_0, arg_8_2, function()
				arg_3_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		elseif arg_8_0 == UIItemList.EventUpdate then
			setActive(arg_8_2:Find("icon_mask"), arg_8_1 < arg_3_0.curDay)
		end

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_10_0)
	arg_10_0.nday = arg_10_0.linkActivity.data3

	local var_10_0 = arg_10_0.linkActivity:getConfig("config_client").story

	if checkExist(var_10_0, {
		arg_10_0.nday
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_10_0[arg_10_0.nday][1])
	end

	if arg_10_0.stepText then
		setText(arg_10_0.stepText, tostring(arg_10_0.nday))
	end

	arg_10_0.uilist:align(#arg_10_0.taskGroup[arg_10_0.nday])

	arg_10_0.curDay = arg_10_0.activity.data1

	arg_10_0.itemList:align(arg_10_0.Day)

	return
end

function var_0_0.OnDestroy(arg_11_0)
	return
end

return var_0_0
