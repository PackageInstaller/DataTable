local var_0_0 = class("JiujiuYoyoPage", import("...base.BaseActivityPage"))
local var_0_1 = PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_CHT

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.helpBtn = arg_1_0.bg:Find("help_btn")
	arg_1_0.taskBtn = arg_1_0.bg:Find("task_btn")
	arg_1_0.taskRedDot = arg_1_0.taskBtn:Find("red_dot")
	arg_1_0.ticketNumTF = arg_1_0.bg:Find("ticket_num")
	arg_1_0.rollingCountTF = arg_1_0.bg:Find("rolling_count")
	arg_1_0.rollingBlink = arg_1_0.bg:Find("blink")

	if var_0_1 then
		arg_1_0.awardTpl = arg_1_0.bg:Find("item_jp")
		arg_1_0.awardContainter = arg_1_0.bg:Find("award_list_jp")
	else
		arg_1_0.awardTpl = arg_1_0.bg:Find("item")
		arg_1_0.awardContainter = arg_1_0.bg:Find("award_list")
	end

	arg_1_0.awardUIList = UIItemList.New(arg_1_0.awardContainter, arg_1_0.awardTpl)
	arg_1_0.finalGot = arg_1_0.bg:Find("final_got_jp")
	arg_1_0.rollingAni = arg_1_0.bg:Find("rolling_mask")
	arg_1_0.rollingSpine = arg_1_0.rollingAni:Find("rolling"):GetComponent("SpineAnimUI")
	arg_1_0.rollingGraphic = arg_1_0.rollingAni:Find("rolling"):GetComponent("SkeletonGraphic")
	arg_1_0.forbidMask = arg_1_0.bg:Find("forbid_mask")
	arg_1_0.taskWindow = arg_1_0._tf:Find("TaskWindow")
	arg_1_0.closeBtn = arg_1_0.taskWindow:Find("panel/close_btn")
	arg_1_0.taskTpl = arg_1_0.taskWindow:Find("panel/scrollview/item")
	arg_1_0.taskContainter = arg_1_0.taskWindow:Find("panel/scrollview/items")
	arg_1_0.taskUIList = UIItemList.New(arg_1_0.taskContainter, arg_1_0.taskTpl)

	arg_1_0:register()

	return
end

function var_0_0.register(arg_2_0)
	arg_2_0:bind(ActivityMediator.ON_SHAKE_BEADS_RESULT, function(arg_3_0, arg_3_1)
		arg_2_0:displayResult(arg_3_1.awards, arg_3_1.number, function()
			arg_3_1.callback()

			return
		end)

		return
	end)

	return
end

function var_0_0.OnDataSetting(arg_5_0)
	arg_5_0.taskProxy = getProxy(TaskProxy)
	arg_5_0.taskList = pg.activity_template[arg_5_0.activity:getConfig("config_client").taskActID].config_data
	arg_5_0.startTime = arg_5_0.activity:getStartTime()
	arg_5_0.totalNumList = {}
	arg_5_0.remainNumList = {}
	arg_5_0.remainTotalNum = 0
	arg_5_0.awardList = {}
	arg_5_0.finalAward = arg_5_0.activity:getConfig("config_client").finalAward
	arg_5_0.awardConifg = arg_5_0.activity:getConfig("config_client").award
	arg_5_0.beadsConfig = arg_5_0.activity:getConfig("config_data")[1]

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.beadsConfig) do
		arg_5_0.awardList[iter_5_1[1]] = arg_5_0.awardConifg[iter_5_1[1]]
		arg_5_0.totalNumList[iter_5_1[1]] = iter_5_1[2]
	end

	return
end

function var_0_0.OnFirstFlush(arg_6_0)
	onButton(arg_6_0, arg_6_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("tips_shakebeads")
		})

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.taskBtn, function()
		arg_6_0:openTask()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.closeBtn, function()
		arg_6_0:closeTask()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.taskWindow:Find("mask"), function()
		arg_6_0:closeTask()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.rollingBlink, function()
		if arg_6_0.ticketNum <= 0 then
			return
		end

		arg_6_0:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_6_0.activity.id
		})

		return
	end, SFX_PANEL)
	setActive(arg_6_0.taskRedDot, false)

	if LeanTween.isTweening(arg_6_0.rollingBlink) then
		LeanTween.cancel(arg_6_0.rollingBlink)
	end

	setImageAlpha(arg_6_0.rollingBlink, 1)
	blinkAni(arg_6_0.rollingBlink, 0.5)

	return
end

function var_0_0.OnUpdateFlush(arg_12_0)
	arg_12_0.curDay = pg.TimeMgr.GetInstance():DiffDay(arg_12_0.startTime, pg.TimeMgr.GetInstance():GetServerTime()) + 1
	arg_12_0.ticketNum = arg_12_0.activity.data1
	arg_12_0.hasNumList = arg_12_0.activity.data1KeyValueList[1]
	arg_12_0.remainTotalNum = 0

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.beadsConfig) do
		arg_12_0.hasNumList[iter_12_1[1]] = arg_12_0.hasNumList[iter_12_1[1]] or 0
		arg_12_0.remainNumList[iter_12_1[1]] = arg_12_0.totalNumList[iter_12_1[1]] - arg_12_0.hasNumList[iter_12_1[1]]
		arg_12_0.remainTotalNum = arg_12_0.remainTotalNum + arg_12_0.remainNumList[iter_12_1[1]]
	end

	setText(arg_12_0.ticketNumTF, arg_12_0.ticketNum)
	setText(arg_12_0.rollingCountTF, arg_12_0.remainTotalNum)
	setActive(arg_12_0.rollingBlink, arg_12_0.ticketNum > 0)
	arg_12_0:initAwardList()
	arg_12_0:initTaskWindow()

	arg_12_0.isFirst = PlayerPrefs.GetInt("jiujiuyoyo_first_" .. getProxy(PlayerProxy):getData().id)

	if arg_12_0.isFirst == 0 then
		setActive(arg_12_0.taskRedDot, true)
	end

	if #arg_12_0.finishItemList > 0 then
		arg_12_0:openTask()
	end

	local var_12_1 = var_0_1 and arg_12_0.activity.data2 == 1

	var_12_0(arg_12_0.finalGot, var_12_1)
	arg_12_0:CheckFinalAward()

	return
end

function var_0_0.initAwardList(arg_13_0)
	arg_13_0.awardUIList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			local var_14_0 = arg_14_1 + 1
			local var_14_1 = arg_13_0.remainNumList[arg_14_1 + 1]

			if arg_13_0.remainNumList[arg_14_1 + 1] == 0 then
				setTextColor(arg_14_2:Find("num"), Color.New(0.55, 0.55, 0.55, 1))
				setOutlineColor(arg_14_2:Find("num"), Color.New(0.26, 0.26, 0.26, 1))
			end

			setText(arg_14_2:Find("num"), var_14_1 .. "/" .. arg_13_0.totalNumList[arg_14_1 + 1])
			setActive(arg_14_2:Find("got"), var_14_1 == 0)

			local var_14_2 = arg_14_2:Find("award_mask/award")

			updateDrop(var_14_2, {
				type = arg_13_0.awardList[var_14_0][1],
				id = arg_13_0.awardList[var_14_0][2],
				count = arg_13_0.awardList[var_14_0][3] * var_14_1
			})
			onButton(arg_13_0, var_14_2, function()
				arg_13_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_13_0.awardUIList:align(#arg_13_0.awardList)

	return
end

function var_0_0.initTaskWindow(arg_16_0)
	arg_16_0.finishItemList = {}
	arg_16_0.finishTaskVOList = {}

	arg_16_0.taskUIList:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			local var_17_0 = arg_17_1 + 1
			local var_17_1 = arg_17_2:Find("award/award")
			local var_17_2 = arg_16_0.taskProxy:getTaskById(arg_16_0.taskList[arg_17_1 + 1]) or arg_16_0.taskProxy:getFinishTaskById(arg_16_0.taskList[arg_17_1 + 1])

			assert(var_17_2, "without this task by id: " .. arg_16_0.taskList[arg_17_1 + 1])

			local var_17_3 = var_17_2:getProgress()
			local var_17_4 = var_17_2:getConfig("target_num")
			local var_17_5 = var_17_2:getTaskStatus()
			local var_17_6 = var_17_2:getConfig("award_display")[1]
			local var_17_7 = var_17_0 > arg_16_0.curDay

			setText(arg_17_2:Find("description"), (var_17_2:getConfig("desc")))
			setText(arg_17_2:Find("progress/progressText"), var_17_3 .. "/" .. var_17_4)
			setSlider(arg_17_2:Find("progress"), 0, var_17_4, var_17_3)
			updateDrop(var_17_1, {
				type = var_17_6[1],
				id = var_17_6[2],
				count = var_17_6[3]
			})
			onButton(arg_16_0, arg_17_2:Find("award/Image"), function()
				arg_16_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)

			local var_17_8 = arg_17_2:Find("go_btn")
			local var_17_9 = arg_17_2:Find("get_btn")

			setActive(var_17_8, var_17_5 == 0)
			setActive(var_17_9, var_17_5 == 1)
			onButton(arg_16_0, var_17_8, function()
				arg_16_0:emit(ActivityMediator.ON_TASK_GO, var_17_2)

				return
			end, SFX_PANEL)
			onButton(arg_16_0, var_17_9, function()
				arg_16_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_17_2)

				return
			end, SFX_PANEL)
			setActive(arg_17_2:Find("finnal"), var_17_5 == 2 and not var_17_7)
			setText(arg_17_2:Find("lock/tip"), i18n("unlock_tips", var_17_0))
			setActive(arg_17_2:Find("lock"), var_17_7)

			if var_17_5 == 1 and not var_17_7 then
				table.insert(arg_16_0.finishItemList, arg_17_2)
				table.insert(arg_16_0.finishTaskVOList, var_17_2)
			end
		end

		return
	end)
	arg_16_0.taskUIList:align(#arg_16_0.taskList)

	return
end

function var_0_0.closeTask(arg_21_0)
	setActive(arg_21_0.taskWindow, false)

	return
end

function var_0_0.openTask(arg_22_0)
	setActive(arg_22_0.taskWindow, true)

	if arg_22_0.isFirst == 0 then
		PlayerPrefs.SetInt("jiujiuyoyo_first_" .. getProxy(PlayerProxy):getData().id, 1)
		setActive(arg_22_0.taskRedDot, false)
	end

	arg_22_0.hasClickTask = true

	eachChild(arg_22_0.taskContainter, function(arg_23_0)
		if isActive(arg_23_0:Find("finnal")) then
			arg_23_0:SetAsLastSibling()
		end

		return
	end)

	if #arg_22_0.finishItemList > 0 then
		arg_22_0:autoFinishTask()
	end

	return
end

function var_0_0.autoFinishTask(arg_24_0)
	local var_24_0 = 0.01
	local var_24_1 = 0.5

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.finishItemList) do
		local var_24_2 = GetOrAddComponent(iter_24_1, typeof(CanvasGroup))

		arg_24_0:managedTween(LeanTween.delayedCall, function()
			iter_24_1:SetAsFirstSibling()
			LeanTween.value(go(iter_24_1), 1, 0, var_24_1):setOnUpdate(System.Action_float(function(arg_26_0)
				var_24_2.alpha = arg_26_0

				return
			end)):setOnComplete(System.Action(function()
				var_24_2.alpha = 1

				setActive(iter_24_1:Find("finnal"), true)
				iter_24_1:SetAsLastSibling()

				return
			end))

			return
		end, var_24_0, nil)

		var_24_0 = var_24_0 + 0.5 + 0.1
	end

	arg_24_0:managedTween(LeanTween.delayedCall, function()
		pg.m02:sendNotification(GAME.SUBMIT_TASK_ONESTEP, {
			resultList = arg_24_0.finishTaskVOList
		})

		return
	end, var_24_0, nil)

	return
end

function var_0_0.CheckFinalAward(arg_29_0)
	if var_0_1 and arg_29_0.activity.data2 == 0 and arg_29_0.remainTotalNum == 0 then
		arg_29_0:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 2,
			activity_id = arg_29_0.activity.id
		})
	end

	return
end

function var_0_0.displayResult(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	arg_30_0:setForbidMaskStatus(true)
	setActive(arg_30_0.rollingAni, true)

	function arg_30_0.aniCallback()
		arg_30_3()

		return
	end

	arg_30_0.rollingSpine:SetActionCallBack(function(arg_32_0)
		if arg_32_0 == "finish" then
			setActive(arg_30_0.rollingAni, false)
			arg_30_3()

			arg_30_0.aniCallback = nil

			arg_30_0:setForbidMaskStatus(false)
		end

		return
	end)
	arg_30_0.rollingSpine:SetAction(tostring(arg_30_2), 0)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/zhuanzhu")
	arg_30_0:managedTween(LeanTween.delayedCall, function()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/zhengque")

		return
	end, 4, nil)

	return
end

function var_0_0.setForbidMaskStatus(arg_34_0, arg_34_1)
	if arg_34_1 then
		setActive(arg_34_0.forbidMask, true)
		pg.UIMgr.GetInstance():OverlayPanel(arg_34_0.forbidMask)
	else
		setActive(arg_34_0.forbidMask, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_34_0.forbidMask, arg_34_0.bg)
	end

	return
end

function var_0_0.canFinishTask()
	local var_35_0 = pg.TimeMgr.GetInstance():DiffDay(pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.activity_template[ActivityConst.JIUJIU_YOYO_ID].time[2]), pg.TimeMgr.GetInstance():GetServerTime()) + 1
	local var_35_1 = false
	local var_35_2 = getProxy(TaskProxy)

	for iter_35_0, iter_35_1 in pairs(pg.activity_template[pg.activity_template[ActivityConst.JIUJIU_YOYO_ID].config_client.taskActID].config_data) do
		local var_35_3 = var_35_0 < iter_35_0
		local var_35_4 = var_35_2:getTaskById(iter_35_1) or var_35_2:getFinishTaskById(iter_35_1)

		assert(var_35_4, "without this task by id: " .. iter_35_1)

		if var_35_4:getTaskStatus() == 1 and not var_35_3 then
			var_35_1 = true

			break
		end
	end

	return var_35_1
end

function var_0_0.IsShowRed()
	local var_36_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.JIUJIU_YOYO_ID).data1

	return var_36_0 > 0 or var_0_0.canFinishTask()
end

return var_0_0
