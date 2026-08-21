local var_0_0 = class("HoloLivePtPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.taskProxy = getProxy(TaskProxy)
	arg_1_0.activityProxy = getProxy(ActivityProxy)
	arg_1_0.circleTF = arg_1_0._tf:Find("CircleImg/Circle")
	arg_1_0.startBtn = arg_1_0._tf:Find("CircleImg/StartBtn")
	arg_1_0.helpBtn1 = arg_1_0._tf:Find("HelpBtn")
	arg_1_0.taskPanel = arg_1_0._tf:Find("AD")

	onButton(arg_1_0, arg_1_0.startBtn, function()
		if arg_1_0.isTurning then
			return
		end

		arg_1_0:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_1_0.activity.id
		})

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.helpBtn1, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.hololive_goodmorning.tip
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnDataSetting(arg_4_0)
	arg_4_0.activityStartTime = arg_4_0.activity.data1
	arg_4_0.isGotFinalAward = arg_4_0.activity.data2
	arg_4_0.progressStep = arg_4_0.activity.data3
	arg_4_0.configID = arg_4_0.activity:getConfig("config_id")
	arg_4_0.configData = pg.activity_event_turning[arg_4_0.configID]
	arg_4_0.groupNum = arg_4_0.configData.total_num
	arg_4_0.maxday = math.clamp(pg.TimeMgr.GetInstance():DiffDay(arg_4_0.activityStartTime, pg.TimeMgr.GetInstance():GetServerTime()) + 1, 1, arg_4_0.configData.total_num)

	print("init data on setting:", tostring(arg_4_0.maxday), tostring(arg_4_0.isGotFinalAward), tostring(arg_4_0.progressStep), tostring(arg_4_0.activity.data4))

	return
end

function var_0_0.OnFirstFlush(arg_5_0)
	arg_5_0.curIndex = arg_5_0.activity.data4

	if arg_5_0.curIndex ~= 0 then
		arg_5_0.curShipGroupID = arg_5_0.configData.groupid_list[arg_5_0.curIndex]
		arg_5_0.curTaskIDList = arg_5_0.configData.task_table[arg_5_0.curIndex]
		arg_5_0.curStoryID = arg_5_0.configData.story_list[arg_5_0.curIndex]
	end

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	if arg_6_0.curIndex == 0 and arg_6_0.activity.data4 > 0 then
		arg_6_0.curIndex = arg_6_0.activity.data4
		arg_6_0.curShipGroupID = arg_6_0.configData.groupid_list[arg_6_0.curIndex]
		arg_6_0.curTaskIDList = arg_6_0.configData.task_table[arg_6_0.curIndex]
		arg_6_0.curStoryID = arg_6_0.configData.story_list[arg_6_0.curIndex]

		print("before rotate", tostring(arg_6_0.curShipGroupID), tostring(arg_6_0.curIndex), tostring(arg_6_0.curStoryID))
		arg_6_0:rotate()
	elseif arg_6_0.activity.data4 > 0 then
		if arg_6_0.activity.data4 <= arg_6_0.groupNum then
			arg_6_0.curIndex = arg_6_0.activity.data4
			arg_6_0.curShipGroupID = arg_6_0.configData.groupid_list[arg_6_0.curIndex]
			arg_6_0.curTaskIDList = arg_6_0.configData.task_table[arg_6_0.curIndex]
			arg_6_0.curStoryID = arg_6_0.configData.story_list[arg_6_0.curIndex]

			print("direct update", tostring(arg_6_0.curShipGroupID), tostring(arg_6_0.curIndex), tostring(arg_6_0.curStoryID))
			arg_6_0:updateTaskPanel()
		end
	elseif arg_6_0.activity.data4 == 0 then
		arg_6_0.curIndex = 0
		arg_6_0.curShipGroupID = nil
		arg_6_0.curTaskIDList = nil
		arg_6_0.curStoryID = nil

		setActive(arg_6_0.taskPanel, false)

		if arg_6_0.progressStep > arg_6_0.groupNum then
			arg_6_0:lockTurnTable()
		end
	end

	arg_6_0:checkAward()

	return
end

function var_0_0.onDestroy(arg_7_0)
	LeanTween.cancel(go(arg_7_0.circleTF))

	return
end

function var_0_0.rotate(arg_8_0)
	arg_8_0.isTurning = true

	LeanTween.value(go(arg_8_0.circleTF), 0, 360 - 360 / pg.activity_event_turning[arg_8_0.activity:getConfig("config_id")].total_num * ({
		6,
		0,
		4,
		2,
		5,
		3,
		1
	})[arg_8_0.curIndex] + 8 * 360, 4):setEase(LeanTweenType.easeInOutCirc):setOnUpdate(System.Action_float(function(arg_9_0)
		arg_8_0.circleTF.localEulerAngles = Vector3(0, 0, -arg_9_0)

		return
	end)):setOnComplete(System.Action(function()
		pg.NewStoryMgr.GetInstance():Play(arg_8_0.curStoryID, function()
			arg_8_0:updateTaskPanel()

			return
		end, true, true)

		arg_8_0.isTurning = false

		return
	end))

	return
end

function var_0_0.updateTaskPanel(arg_12_0)
	arg_12_0.charImg = arg_12_0.taskPanel:Find("CharImg")
	arg_12_0.nameImg = arg_12_0.charImg:Find("NameImg")
	arg_12_0.dayText = arg_12_0.taskPanel:Find("ProgressImg/day")
	arg_12_0.taskItemTpl = arg_12_0.taskPanel:Find("item")
	arg_12_0.taskItemContainer = arg_12_0.taskPanel:Find("items")
	arg_12_0.backBtn = arg_12_0.taskPanel:Find("BackBtn")
	arg_12_0.countText = arg_12_0.backBtn:Find("RedPoint/Text")
	arg_12_0.helpBtn2 = arg_12_0.taskPanel:Find("HelpBtn")

	LoadSpriteAtlasAsync("ui/activityuipage/hololivemorningpage", "img_char_" .. arg_12_0.curShipGroupID, function(arg_13_0)
		if arg_12_0.curShipGroupID == 17 then
			rtf(arg_12_0.charImg).sizeDelta = Vector2(1058, 714)

			setImageSprite(arg_12_0.charImg, arg_13_0)
		elseif arg_12_0.curShipGroupID == 19 then
			rtf(arg_12_0.charImg).sizeDelta = Vector2(1122, 714)

			setImageSprite(arg_12_0.charImg, arg_13_0)
		elseif arg_12_0.curShipGroupID == 21 then
			rtf(arg_12_0.charImg).sizeDelta = Vector2(1044, 714)

			setImageSprite(arg_12_0.charImg, arg_13_0)
		else
			setImageSprite(arg_12_0.charImg, arg_13_0, true)
		end

		return
	end)
	LoadSpriteAtlasAsync("ui/activityuipage/hololivemorningpage", "img_name_" .. arg_12_0.curShipGroupID, function(arg_14_0)
		setImageSprite(arg_12_0.nameImg, arg_14_0, true)

		return
	end)
	setText(arg_12_0.dayText, arg_12_0.progressStep .. "/" .. arg_12_0.configData.total_num)

	arg_12_0.taskUIItemList = UIItemList.New(arg_12_0.taskItemContainer, arg_12_0.taskItemTpl)

	arg_12_0.taskUIItemList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			local var_15_0 = arg_15_2:Find("item")
			local var_15_1 = arg_12_0.taskProxy:getTaskById(arg_12_0.curTaskIDList[arg_15_1 + 1]) or arg_12_0.taskProxy:getFinishTaskById(arg_12_0.curTaskIDList[arg_15_1 + 1])

			assert(var_15_1, "without this task by id: " .. arg_12_0.curTaskIDList[arg_15_1 + 1])

			local var_15_2 = var_15_1:getConfig("award_display")[1]

			updateDrop(var_15_0, {
				type = var_15_2[1],
				id = var_15_2[2],
				count = var_15_2[3]
			})
			onButton(arg_12_0, var_15_0, function()
				arg_12_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)

			local var_15_3 = var_15_1:getProgress()
			local var_15_4 = var_15_1:getConfig("target_num")

			setText(arg_15_2:Find("description"), var_15_1:getConfig("desc") .. "(" .. var_15_3 .. "/" .. var_15_4 .. ")")
			setSlider(arg_15_2:Find("progress"), 0, var_15_4, var_15_3)

			local var_15_5 = arg_15_2:Find("go_btn")
			local var_15_6 = arg_15_2:Find("get_btn")
			local var_15_7 = arg_15_2:Find("got_btn")
			local var_15_8 = var_15_1:getTaskStatus()

			setActive(var_15_5, var_15_8 == 0)
			setActive(var_15_6, var_15_8 == 1)
			setActive(var_15_7, var_15_8 == 2)
			onButton(arg_12_0, var_15_5, function()
				arg_12_0:emit(ActivityMediator.ON_TASK_GO, var_15_1)

				return
			end, SFX_PANEL)
			onButton(arg_12_0, var_15_6, function()
				arg_12_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_15_1)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_12_0.taskUIItemList:align(#arg_12_0.curTaskIDList)

	local var_12_0 = true

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.curTaskIDList) do
		local var_12_1 = arg_12_0.taskProxy:getTaskById(iter_12_1) or arg_12_0.taskProxy:getFinishTaskById(iter_12_1)

		if var_12_1:getTaskStatus() ~= 2 then
			var_12_0 = false

			break
		end
	end

	if var_12_0 then
		local var_12_2 = pg.activity_event_turning[arg_12_0.activity:getConfig("config_id")].story_task[arg_12_0.progressStep][1]

		print("story", tostring(var_12_2))

		if var_12_2 then
			pg.NewStoryMgr.GetInstance():Play(var_12_2, nil)
		end
	end

	if arg_12_0.maxday <= arg_12_0.progressStep then
		var_12_0 = false
	end

	setActive(arg_12_0.backBtn, var_12_0)

	if var_12_0 then
		setText(arg_12_0.countText, tostring(arg_12_0.maxday - arg_12_0.progressStep))
	end

	setActive(arg_12_0.taskPanel, true)
	onButton(arg_12_0, arg_12_0.backBtn, function()
		arg_12_0:resetIndex()

		return
	end, SFX_CANCEL)
	onButton(arg_12_0, arg_12_0.helpBtn2, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.hololive_goodmorning.tip
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.checkAward(arg_21_0)
	if arg_21_0.isGotFinalAward == 0 and arg_21_0.progressStep == arg_21_0.groupNum then
		if arg_21_0.curTaskIDList then
			local var_21_0 = true

			for iter_21_0, iter_21_1 in ipairs(arg_21_0.curTaskIDList) do
				local var_21_1 = arg_21_0.taskProxy:getTaskById(iter_21_1) or arg_21_0.taskProxy:getFinishTaskById(iter_21_1)

				if var_21_1:getTaskStatus() ~= 2 then
					var_21_0 = false

					break
				end
			end

			if var_21_0 and arg_21_0.activity.data4 ~= 0 and arg_21_0.activity.data3 == arg_21_0.groupNum then
				arg_21_0:emit(ActivityMediator.EVENT_OPERATION, {
					cmd = 2,
					activity_id = arg_21_0.activity.id
				})
			end
		else
			arg_21_0:emit(ActivityMediator.EVENT_OPERATION, {
				cmd = 1,
				activity_id = arg_21_0.activity.id
			})
		end
	end

	return
end

function var_0_0.resetIndex(arg_22_0)
	arg_22_0:emit(ActivityMediator.EVENT_OPERATION, {
		cmd = 2,
		activity_id = arg_22_0.activity.id
	})

	return
end

function var_0_0.lockTurnTable(arg_23_0)
	arg_23_0.finalTip = arg_23_0._tf:Find("FinalTip")
	arg_23_0.finalLock = arg_23_0._tf:Find("CircleImg/FinalLock")

	setActive(arg_23_0.finalTip, true)
	setActive(arg_23_0.finalLock, true)

	arg_23_0.tipImg = arg_23_0._tf:Find("TipImg")

	setActive(arg_23_0.tipImg, false)

	return
end

return var_0_0
