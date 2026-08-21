local var_0_0 = class("SenrankaguraTaskPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.taskProxy = getProxy(TaskProxy)
	arg_1_0.activityProxy = getProxy(ActivityProxy)

	arg_1_0:findUI()

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.configID = arg_2_0.activity:getConfig("config_id")
	arg_2_0.configData = pg.activity_event_turning[arg_2_0.configID]
	arg_2_0.groupNum = arg_2_0.configData.total_num

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	return
end

function var_0_0.OnUpdateFlush(arg_4_0)
	local var_4_0 = arg_4_0:getCurIndex()

	if arg_4_0.markClickPos and arg_4_0.markClickPos > 0 then
		print("有操作再更新任务面板")
		arg_4_0:openTaskAni()
	elseif var_4_0 > 0 then
		if arg_4_0.activity.data4 <= arg_4_0.groupNum then
			print("直接更新任务面板")
			arg_4_0:updateTaskPanel()
			setActive(arg_4_0.posPanel, false)
			setActive(arg_4_0.taskPanel, true)
		end
	elseif var_4_0 == 0 then
		arg_4_0:updatePosPanel()
		setActive(arg_4_0.posPanel, true)
		setActive(arg_4_0.taskPanel, false)

		if arg_4_0:getStep() > arg_4_0.groupNum then
			-- block empty
		end
	end

	arg_4_0:check()
	arg_4_0:updateLogText()

	return
end

function var_0_0.onDestroy(arg_5_0)
	return
end

function var_0_0.findUI(arg_6_0)
	local var_6_0 = arg_6_0._tf:Find("IconList")

	arg_6_0.nameList = {
		"feiniao",
		"banjiu",
		"yan",
		"xuequan",
		"xuebugui",
		"zi",
		"xishao"
	}
	arg_6_0.paintingList = {
		"asuka",
		"ikaruga",
		"homura",
		"yumi",
		"fubuki",
		"murasaki",
		"yuuyaki"
	}
	arg_6_0.iconSpriteDict = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.nameList) do
		local var_6_1 = getImageSprite((var_6_0:Find(iter_6_1)))

		arg_6_0.iconSpriteDict[iter_6_0] = var_6_1
		arg_6_0.iconSpriteDict[iter_6_1] = var_6_1
	end

	local var_6_2 = arg_6_0._tf:Find("HXList")

	arg_6_0.hxSpriteDict = {}

	for iter_6_2, iter_6_3 in ipairs({
		"feiniao",
		"yan",
		"xuequan",
		"xuebugui",
		"xishao"
	}) do
		arg_6_0.hxSpriteDict[iter_6_3] = getImageSprite((var_6_2:Find(iter_6_3)))
	end

	arg_6_0.hxPosDict = {
		feiniao = {
			x = -47,
			y = -7
		},
		yan = {
			x = 24,
			y = -176
		},
		xuequan = {
			x = -92,
			y = -126
		},
		xuebugui = {
			x = 5,
			y = 22
		},
		xishao = {
			x = -86,
			y = -21
		}
	}
	arg_6_0.paintingPosDict = {
		feiniao = {
			x = 42,
			y = -22
		},
		banjiu = {
			x = 23,
			y = -8
		},
		yan = {
			x = -11,
			y = 20
		},
		xuequan = {
			x = 39,
			y = 30
		},
		xuebugui = {
			x = 26,
			y = 12
		},
		zi = {
			x = 46,
			y = 36
		},
		xishao = {
			x = 20,
			y = -1
		}
	}
	arg_6_0.posPanel = arg_6_0._tf:Find("PosPanel")
	arg_6_0.finalLockTF = arg_6_0.posPanel:Find("FinalAward/Lock")
	arg_6_0.finalGotTF = arg_6_0.posPanel:Find("FinalAward/Got")
	arg_6_0.posTFList = {}

	local var_6_3 = arg_6_0.posPanel:Find("PosList")

	for iter_6_4 = 1, #arg_6_0.nameList do
		local var_6_4 = var_6_3:Find(iter_6_4)

		table.insert(arg_6_0.posTFList, var_6_4)
		onButton(arg_6_0, var_6_4:Find("Get"), function()
			local var_7_0 = arg_6_0:getStep()

			if var_7_0 < arg_6_0:getCurDayCount() and var_7_0 < arg_6_0.groupNum then
				arg_6_0.markClickPos = iter_6_4

				arg_6_0:selectPos(iter_6_4)
			end

			return
		end, SFX_PANEL)
	end

	arg_6_0.taskPanel = arg_6_0._tf:Find("TaskPanel")
	arg_6_0.paintingTF = arg_6_0.taskPanel:Find("PaintingPanel/Main/Painting")
	arg_6_0.paintingHXTF = arg_6_0.taskPanel:Find("PaintingPanel/Main/HX")
	arg_6_0.progressTFList = {}

	local var_6_5 = arg_6_0.taskPanel:Find("Progress")

	for iter_6_5 = 1, #arg_6_0.nameList do
		arg_6_0.progressTFList[iter_6_5] = var_6_5:Find(iter_6_5)
	end

	arg_6_0.taskTFList = {}
	arg_6_0.taskTFList[1] = arg_6_0.taskPanel:Find("Task1")
	arg_6_0.taskTFList[2] = arg_6_0.taskPanel:Find("Task2")
	arg_6_0.logText = arg_6_0._tf:Find("LogText")

	return
end

function var_0_0.updatePosPanel(arg_8_0)
	local var_8_0 = arg_8_0.activity.data1_list

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.posTFList) do
		local var_8_1 = var_8_0[iter_8_0] > 0
		local var_8_2 = iter_8_1:Find("Got")

		setImageSprite(var_8_2:Find("Icon"), arg_8_0.iconSpriteDict[var_8_0[iter_8_0]], true)
		setActive(var_8_2, var_8_1)
	end

	local var_8_3 = arg_8_0:isGotFinalAward()

	setActive(arg_8_0.finalGotTF, var_8_3)
	setActive(arg_8_0.finalLockTF, not var_8_3)

	return
end

function var_0_0.updateTaskPanel(arg_9_0)
	arg_9_0:updateTaskList()
	arg_9_0:updateProgress()
	arg_9_0:updatePainting()

	return
end

function var_0_0.updateTaskList(arg_10_0)
	local var_10_0 = arg_10_0:getCurTaskIDList()

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.taskTFList) do
		local var_10_1 = arg_10_0.taskProxy:getTaskVO(var_10_0[iter_10_0])

		setText(iter_10_1:Find("Desc"), var_10_1:getConfig("desc"))

		local var_10_2 = var_10_1:getProgress()
		local var_10_3 = var_10_1:getConfig("target_num")
		local var_10_4 = iter_10_1:Find("ProgressBar")

		setText(iter_10_1:Find("ProgressText"), var_10_2 .. "/" .. var_10_3)
		setSlider(var_10_4, 0, var_10_3, var_10_2)

		local var_10_5 = var_10_1:getTaskStatus()
		local var_10_6 = iter_10_1:Find("GetBtn")
		local var_10_7 = iter_10_1:Find("GotBtn")
		local var_10_8 = iter_10_1:Find("GoBtn")

		setActive(var_10_8, var_10_5 == 0)
		setActive(var_10_6, var_10_5 == 1)
		setActive(var_10_7, var_10_5 == 2)
		onButton(arg_10_0, var_10_8, function()
			arg_10_0:emit(ActivityMediator.ON_TASK_GO, var_10_1)

			return
		end, SFX_PANEL)
		onButton(arg_10_0, var_10_6, function()
			arg_10_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_10_1)

			return
		end, SFX_PANEL)

		local var_10_9 = var_10_1:getConfig("award_display")[1]
		local var_10_10 = iter_10_1:Find("Icon")

		updateDrop(var_10_10, {
			type = var_10_9[1],
			id = var_10_9[2],
			count = var_10_9[3]
		})
		onButton(arg_10_0, var_10_10, function()
			arg_10_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)

		if arg_10_0:isFinishedCurTaskList() then
			local var_10_11 = arg_10_0.configData.story_task[arg_10_0:getStep()][1]

			print("story", tostring(var_10_11))

			if var_10_11 then
				pg.NewStoryMgr.GetInstance():Play(var_10_11, nil)
			end
		end
	end

	return
end

function var_0_0.updateProgress(arg_14_0)
	local var_14_0 = arg_14_0:getStep()

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.progressTFList) do
		local var_14_1 = iter_14_1:Find("Get")
		local var_14_2 = iter_14_1:Find("Doing")

		setActive(iter_14_1:Find("Got"), iter_14_0 < var_14_0)
		setActive(var_14_1, var_14_0 < iter_14_0)
		setActive(var_14_2, iter_14_0 == var_14_0)
	end

	return
end

function var_0_0.updatePainting(arg_15_0)
	local var_15_0 = arg_15_0:getCurIndex()

	setImageSprite(arg_15_0.paintingTF, LoadSprite("activitypainting/" .. arg_15_0.paintingList[var_15_0], arg_15_0.paintingList[var_15_0]), true)
	setLocalPosition(arg_15_0.paintingTF, arg_15_0.paintingPosDict[arg_15_0.nameList[var_15_0]])

	if PLATFORM_CODE == PLATFORM_CH then
		if arg_15_0.hxPosDict[arg_15_0.nameList[var_15_0]] then
			setImageSprite(arg_15_0.paintingHXTF, arg_15_0.hxSpriteDict[arg_15_0.nameList[var_15_0]], true)
			setLocalPosition(arg_15_0.paintingHXTF, arg_15_0.hxPosDict[arg_15_0.nameList[var_15_0]])
			setActive(arg_15_0.paintingHXTF, true)
		else
			setActive(arg_15_0.paintingHXTF, false)
		end
	else
		setActive(arg_15_0.paintingHXTF, false)
	end

	return
end

function var_0_0.openTaskAni(arg_16_0)
	local var_16_0 = arg_16_0.posTFList[table.indexof(arg_16_0.activity.data1_list, arg_16_0:getCurIndex(), 1)]
	local var_16_1 = var_16_0:Find("Get")
	local var_16_2 = var_16_0:Find("Got")

	setImageAlpha(var_16_1, 1)
	setImageAlpha(var_16_2, 0)
	setActive(var_16_1, true)
	setActive(var_16_2, true)
	setActive(var_16_2:Find("Icon"), false)
	var_16_0:SetAsLastSibling()
	arg_16_0:managedTween(LeanTween.value, nil, go(var_16_0), System.Action_float(function(arg_17_0)
		setImageAlpha(var_16_1, 1 - arg_17_0)
		setImageAlpha(var_16_2, arg_17_0)

		return
	end), 0, 1, 0.5):setOnComplete((System.Action(function()
		local var_18_0 = arg_16_0.configData.story_list[arg_16_0:getCurIndex()]

		if var_18_0 then
			pg.NewStoryMgr.GetInstance():Play(var_18_0, function()
				arg_16_0:updateTaskPanel()
				setActive(arg_16_0.posPanel, false)
				setActive(arg_16_0.taskPanel, true)

				return
			end, true, true)
		else
			arg_16_0:updateTaskPanel()
			setActive(arg_16_0.posPanel, false)
			setActive(arg_16_0.taskPanel, true)
		end

		arg_16_0.markClickPos = nil

		return
	end)))

	arg_16_0.tweenTF = var_16_0

	return
end

function var_0_0.check(arg_20_0)
	if not arg_20_0:isGotFinalAward() then
		local var_20_0 = arg_20_0:getStep()

		if var_20_0 <= arg_20_0.groupNum and arg_20_0:getCurTaskIDList() and arg_20_0:isFinishedCurTaskList() then
			print("清除位置")
			arg_20_0:resetPos()
		end

		if var_20_0 == arg_20_0.groupNum and not arg_20_0:getCurTaskIDList() then
			print("领取最终奖励")
			arg_20_0:getFinalAward()
		end
	end

	return
end

function var_0_0.isGotFinalAward(arg_21_0)
	return arg_21_0.activity.data2 > 0
end

function var_0_0.getStep(arg_22_0)
	return arg_22_0.activity.data3
end

function var_0_0.getCurIndex(arg_23_0)
	return arg_23_0.activity.data4
end

function var_0_0.getCurTaskIDList(arg_24_0)
	return arg_24_0.configData.task_table[arg_24_0:getCurIndex()]
end

function var_0_0.isFinishedCurTaskList(arg_25_0)
	return _.all(arg_25_0:getCurTaskIDList(), function(arg_26_0)
		local var_26_0 = arg_25_0.taskProxy:getTaskVO(arg_26_0)

		return var_26_0:getTaskStatus() == 2
	end)
end

function var_0_0.getCurDayCount(arg_27_0)
	return pg.TimeMgr.GetInstance():DiffDay(arg_27_0.activity.data1, (pg.TimeMgr.GetInstance():GetServerTime())) + 1
end

function var_0_0.getMaxDayCount(arg_28_0)
	return (math.clamp(arg_28_0:getCurDayCount(), 1, arg_28_0.configData.total_num))
end

function var_0_0.resetPos(arg_29_0)
	arg_29_0:emit(ActivityMediator.EVENT_OPERATION, {
		cmd = 2,
		activity_id = arg_29_0.activity.id
	})

	return
end

function var_0_0.selectPos(arg_30_0, arg_30_1)
	arg_30_0:emit(ActivityMediator.EVENT_OPERATION, {
		cmd = 1,
		activity_id = arg_30_0.activity.id,
		arg1 = arg_30_1
	})

	return
end

function var_0_0.getFinalAward(arg_31_0)
	arg_31_0:emit(ActivityMediator.EVENT_OPERATION, {
		cmd = 1,
		activity_id = arg_31_0.activity.id
	})

	return
end

function var_0_0.updateLogText(arg_32_0)
	local var_32_0 = arg_32_0.activity:getConfig("config_id")
	local var_32_1 = pg.TimeMgr.GetInstance():DiffDay(arg_32_0.activity.data1, pg.TimeMgr.GetInstance():GetServerTime()) + 1
	local var_32_2 = ""

	;(function(arg_33_0)
		var_32_2 = var_32_2 .. arg_33_0 .. "\n"

		return
	end)("开始时间戳：" .. tostring(arg_32_0.activity.data1))
	;(function(arg_33_0)
		var_32_2 = var_32_2 .. arg_33_0 .. "\n"

		return
	end)("是否领取最终奖励：" .. tostring(arg_32_0.activity.data2))
	;(function(arg_33_0)
		var_32_2 = var_32_2 .. arg_33_0 .. "\n"

		return
	end)("当前进度：" .. tostring(arg_32_0.activity.data3))
	;(function(arg_33_0)
		var_32_2 = var_32_2 .. arg_33_0 .. "\n"

		return
	end)("抽到的索引：" .. tostring(arg_32_0.activity.data4))
	;(function(arg_33_0)
		var_32_2 = var_32_2 .. arg_33_0 .. "\n"

		return
	end)("抽到的位置-索引列表：" .. table.concat(arg_32_0.activity.data1_list, "-"))
	;(function(arg_33_0)
		var_32_2 = var_32_2 .. arg_33_0 .. "\n"

		return
	end)("活动开始到现在的天数：" .. tostring(var_32_1))
	;(function(arg_33_0)
		var_32_2 = var_32_2 .. arg_33_0 .. "\n"

		return
	end)("活动的最大抽取次数：" .. tostring((math.clamp(var_32_1, 1, pg.activity_event_turning[var_32_0].total_num))))
	;(function(arg_33_0)
		var_32_2 = var_32_2 .. arg_33_0 .. "\n"

		return
	end)("配置的总段数：" .. tostring(pg.activity_event_turning[var_32_0].total_num))
	;(function(arg_33_0)
		var_32_2 = var_32_2 .. arg_33_0 .. "\n"

		return
	end)("配置的GroupID列表：" .. table.concat(pg.activity_event_turning[var_32_0].groupid_list, "-"))

	if arg_32_0.activity.data4 > 0 then
		(function(arg_33_0)
			var_32_2 = var_32_2 .. arg_33_0 .. "\n"

			return
		end)("当前的GroupID：" .. tostring(pg.activity_event_turning[var_32_0][arg_32_0.activity.data4]))
		;(function(arg_33_0)
			var_32_2 = var_32_2 .. arg_33_0 .. "\n"

			return
		end)("当前的任务列表：" .. table.concat(pg.activity_event_turning[var_32_0].task_table[arg_32_0.activity.data4], "-"))
		;(function(arg_33_0)
			var_32_2 = var_32_2 .. arg_33_0 .. "\n"

			return
		end)("当前的剧情ID：" .. tostring(pg.activity_event_turning[var_32_0].story_list[arg_32_0.activity.data4]))
	end

	setText(arg_32_0.logText, "")
	print("")

	return
end

return var_0_0
