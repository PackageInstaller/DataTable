class = var_0_10000

local var_0_0 = "AnniversaryScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AnniversaryUI"
end

function var_0_1.setActivity(arg_2_0, arg_2_1)
	arg_2_0.activityVO = arg_2_1

	local var_2_0 = arg_2_0.activityVO
	local var_2_1

	if not var_2.getConfig(var_2_0, "config_data") then
		var_2_1 = {}
	end

	arg_2_0.configData = var_2_1
	arg_2_0.date = arg_2_0.activityVO.data3
	arg_2_0.currTaskId = arg_2_0.activityVO.data2

	return
end

function var_0_1.setTaskList(arg_3_0, arg_3_1)
	arg_3_0.taskVOs = arg_3_1

	return
end

function var_0_1.getTaskById(arg_4_0, arg_4_1)
	local var_4_0 = -1

	ipairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(arg_4_0.configData) do
		pairs = var_1_10008

		for iter_4_2, iter_4_3 in var_1_10008(iter_4_1) do
			if arg_4_1 == iter_4_3 then
				var_4_0 = iter_4_0
			end
		end
	end

	if var_4_0 ~= -1 then
		if var_4_0 < arg_4_0.date then
			Task = var_3

			local var_4_1 = var_3.New({
				submit_time = 2,
				id = arg_4_1
			})

			var_3.progress = var_3.getConfig(var_4_1, "target_num")

			return var_3
		else
			return arg_4_0.taskVOs[arg_4_1]
		end
	end

	return
end

function var_0_1.init(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.backBtn = var_1.Find(var_5_0, "bg/top/back")

	local var_5_1 = arg_5_0._tf

	arg_5_0.mainPanel = var_1.Find(var_5_1, "bg/main")

	local var_5_2 = arg_5_0.mainPanel

	arg_5_0.scrollRect = var_1.Find(var_5_2, "scroll_rect")

	local var_5_3 = arg_5_0.mainPanel

	arg_5_0.taskGorupContainer = var_1.Find(var_5_3, "scroll_rect/content")
	arg_5_0.taskGorupTpl = arg_5_0:getTpl("taskGroup", arg_5_0.taskGorupContainer)
	Vector2 = var_1
	arg_5_0.offset = var_1(arg_5_0.taskGorupTpl.rect.width / 2 + 30, arg_5_0.taskGorupTpl.rect.height / 2 + 30)

	local var_5_4 = arg_5_0.taskGorupContainer

	arg_5_0.taskGroupDesc = var_1.Find(var_5_4, "taskGroup_desc")

	local var_5_5 = arg_5_0._tf

	arg_5_0.bottomPanel = var_1.Find(var_5_5, "bg/bottom")

	local var_5_6 = arg_5_0.bottomPanel

	arg_5_0.bottomTaskGroups = var_1.Find(var_5_6, "taskGroups")
	arg_5_0.bottomBTpl = arg_5_0:getTpl("bottom_task_tpl", arg_5_0.bottomTaskGroups)
	arg_5_0.startPosition = arg_5_0.taskGorupContainer.localPosition
	arg_5_0.titles = {}

	return
end

function var_0_1.didEnter(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.backBtn

	local function var_6_2()
		local var_7_0 = arg_6_0

		var_0.emit(var_7_0, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10005)
	arg_6_0:initScrollRect()

	return
end

local var_0_2 = 2

function var_0_1.getRow(arg_8_0, arg_8_1)
	math = var_1_10002

	return var_1_10002.floor(arg_8_1 / var_0_2) * 2 + arg_8_1 % var_0_2
end

function var_0_1.initScrollRect(arg_9_0)
	local var_9_0 = arg_9_0.configData
	local var_9_1 = arg_9_0:getRow(#var_9_0)

	arg_9_0.taskGroupTFs = {}

	for iter_9_0 = 0, var_9_1 - 1 do
		for iter_9_1 = 0, var_0_2 - 1 do
			local var_9_2 = arg_9_0.offset.x * iter_9_1
			local var_9_3 = arg_9_0.offset.y * iter_9_0 * -1

			if iter_9_0 % 2 == 0 == (iter_9_1 % 2 == 0) then
				cloneTplTo = var_1_10015
				var_1_10015 = var_1_10015(arg_9_0.taskGorupTpl, arg_9_0.taskGorupContainer)
				Vector2 = var_16
				var_1_10015.localPosition = var_16(var_9_2, var_9_3)
				table = var_16

				var_16.insert(arg_9_0.taskGroupTFs, var_1_10015)
			end
		end
	end

	arg_9_0:updateTaskGroups()

	math = var_3
	arg_9_0.dateIndex = var_3.max(arg_9_0.date, 1)

	arg_9_0:addVerticalDrag(arg_9_0.scrollRect, function()
		if arg_9_0.dateIndex + 1 > #var_9_0 then
			return
		end

		local var_10_0 = arg_9_0

		var_1.moveToTaskGroup(var_10_0, var_0)

		return
	end, function()
		if arg_9_0.dateIndex - 1 < 1 then
			return
		end

		local var_11_0 = arg_9_0

		var_1.moveToTaskGroup(var_11_0, var_0)

		return
	end)
	arg_9_0:moveToTaskGroup(arg_9_0.dateIndex, true)
	arg_9_0:initBottomPanel()

	return
end

function var_0_1.initBottomPanel(arg_12_0)
	arg_12_0.bottomTaskGroupTFs = {}
	ipairs = var_1

	for iter_12_0, iter_12_1 in var_1(arg_12_0.configData) do
		cloneTplTo = var_1_10006
		var_1_10006 = var_1_10006(arg_12_0.bottomBTpl, arg_12_0.bottomTaskGroups)
		arg_12_0.bottomTaskGroupTFs[iter_12_0] = var_1_10006

		arg_12_0:updateBottomTaskGroup(iter_12_0)
	end

	return
end

function var_0_1.updateBottomTaskGroup(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.bottomTaskGroupTFs[arg_13_1]

	GetSpriteFromAtlas = var_1_10003

	local var_13_1 = var_1_10003("ui/anniversaryui_atlas", "h_part" .. arg_13_1)

	GetSpriteFromAtlas = var_4

	local var_13_2 = var_4("ui/anniversaryui_atlas", "part" .. arg_13_1)
	local var_13_3 = var_13_0
	local var_13_4 = var_13_0.GetComponent

	typeof = var_7
	Image = var_1_10008
	var_13_4(var_13_3, var_7(var_1_10008)).sprite = var_13_2

	local var_13_5 = var_13_0:Find("Image")
	local var_13_6 = var_5.GetComponent

	typeof = var_7
	Image = var_1_10008
	var_13_6(var_13_5, var_7(var_1_10008)).sprite = var_13_1

	local var_13_7 = arg_13_0.configData[arg_13_1]

	_ = var_13_5

	local var_13_8 = var_13_5.all(var_13_7, function(arg_14_0)
		local var_14_0 = arg_13_0
		local var_14_1

		var_14_1 = var_1.getTaskById(var_14_0, arg_14_0) and var_1:isReceive()

		return var_14_1
	end)

	triggerToggle = var_7

	var_7(var_13_0, var_13_8)

	return
end

function var_0_1.updateTaskGroups(arg_15_0)
	ipairs = var_1_10001

	for iter_15_0, iter_15_1 in var_1_10001(arg_15_0.configData) do
		if arg_15_0.taskGroupTFs[iter_15_0] then
			arg_15_0:updateTaskGroup(var_6, iter_15_0, iter_15_1)
		end
	end

	return
end

function var_0_1.updateTaskGroup(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_1:Find("mask_lock")
	local var_16_1 = arg_16_1
	local var_16_2 = arg_16_1.Find(var_16_1, "mask_prev_unfinish")

	GetSpriteFromAtlas = var_16_1

	local var_16_3 = var_16_1("ui/anniversaryui_atlas", "lihui" .. arg_16_2)
	local var_16_4 = arg_16_1:Find("icon")
	local var_16_5 = var_7.GetComponent

	typeof = var_9
	Image = var_1_10010
	var_16_5(var_16_4, var_9(var_1_10010)).sprite = var_16_3

	local var_16_6 = arg_16_2 > arg_16_0.date
	local var_16_7 = false
	local var_16_8 = false

	if var_16_6 then
		local var_16_9 = arg_16_0.activityVO.data1 + (arg_16_2 - 1) * 0

		pg = var_1_10012

		local var_16_10 = var_1_10012.TimeMgr.GetInstance()

		var_16_8 = var_16_9 <= var_12.GetServerTime(var_16_10)
		pg = var_12

		local var_16_11 = var_12.TimeMgr.GetInstance()
		local var_16_12 = var_12.STimeDescC(var_16_11, var_16_9, "%m/%d")

		setText = var_16_11

		var_16_11(var_16_0:Find("Text"), var_16_12)
	else
		_ = var_1_10010
		var_16_7 = var_1_10010.all(arg_16_3, function(arg_17_0)
			local var_17_0 = arg_16_0
			local var_17_1

			var_17_1 = var_1.getTaskById(var_17_0, arg_17_0) and var_1:isReceive()

			return var_17_1
		end)
	end

	setActive = var_1_10010

	var_1_10010(var_16_0, var_16_6 and not var_16_8)

	setActive = var_1_10010

	var_1_10010(var_16_2, var_16_6 and var_16_8)

	setActive = var_1_10010

	var_1_10010(arg_16_1:Find("completed"), var_16_7)

	return
end

function var_0_1.updateTaskGroupDesc(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.configData[arg_18_1]
	local var_18_1 = arg_18_0.taskGroupDesc
	local var_18_2 = var_3.Find(var_18_1, "main/desc")
	local var_18_3 = var_3.Find(var_18_2, "Image")
	local var_18_4 = var_4.GetComponent

	typeof = var_6
	Image = var_1_10007

	local var_18_5 = var_18_4(var_18_3, var_6(var_1_10007))
	local var_18_6

	if arg_18_0.titles[arg_18_1] then
		var_18_6 = arg_18_0.titles[arg_18_1]
	else
		GetSpriteFromAtlas = var_6
		var_18_6 = var_6("ui/anniversaryui_atlas", "title" .. arg_18_1)
	end

	var_18_5.sprite = var_18_6

	local var_18_7 = arg_18_0.taskGroupDesc
	local var_18_8 = var_6.Find(var_18_7, "main/task_list")
	local var_18_9 = var_6.Find(var_18_8, "task_tpl")

	setText = var_18_8

	local var_18_10 = var_3

	i18n = var_1_10010

	var_18_8(var_18_10, var_1_10010("anniversary_task_title_" .. arg_18_1))

	local function var_18_11(arg_19_0, arg_19_1)
		local var_19_0 = arg_18_0
		local var_19_1

		if not var_2.getTaskById(var_19_0, arg_19_1) then
			Task = var_19_0
			var_19_1 = var_19_0.New({
				id = arg_19_1
			})
		end

		setText = var_19_0

		var_19_0(arg_19_0:Find("name"), var_19_1:getConfig("name"))

		setText = var_19_0

		var_19_0(arg_19_0:Find("desc"), var_19_1:getConfig("desc"))

		onButton = var_19_0

		local var_19_2 = arg_18_0
		local var_19_3 = arg_19_0:Find("confirm_btn")

		local function var_19_4()
			local var_20_0 = var_19_1

			if var_0.isReceive(var_20_0) then
				-- block empty
			else
				local var_20_1 = var_19_1

				if not var_0.isFinish(var_20_1) then
					local var_20_2 = arg_18_0
					local var_20_3 = var_0.emit

					AnniversaryMediator = var_3_10002

					var_20_3(var_20_2, var_3_10002.TO_TASK, var_19_1)
				else
					local var_20_4 = var_19_1

					if var_0.isFinish(var_20_4) then
						local var_20_5 = arg_18_0
						local var_20_6 = var_0.emit

						AnniversaryMediator = var_3_10002

						var_20_6(var_20_5, var_3_10002.ON_SUBMIT_TASK, arg_19_1)
					end
				end
			end

			return
		end

		SFX_PANEL = var_7

		var_19_0(var_19_2, var_19_3, var_19_4, var_7)

		setActive = var_19_0

		var_19_0(arg_19_0:Find("confirm_btn/go"), not var_19_1:isFinish())

		setActive = var_19_0

		var_19_0(arg_19_0:Find("confirm_btn/finished"), var_19_1:isReceive())

		setActive = var_19_0

		local var_19_5 = arg_19_0:Find("confirm_btn/get")
		local var_19_6

		if var_19_1:isFinish() then
			var_19_6 = not var_19_1:isReceive()
		end

		var_19_0(var_19_5, var_19_6)

		local var_19_7 = arg_19_0:Find("icon")
		local var_19_8 = var_19_1:getConfig("award_display")[1]

		updateDrop = var_6

		var_6(var_19_7, {
			type = var_19_8[1],
			id = var_19_8[2],
			count = var_19_8[3]
		})

		onButton = var_6

		local var_19_9 = arg_18_0
		local var_19_10 = var_19_7

		local function var_19_11()
			local var_21_0
			local var_21_1 = var_19_8[1]

			DROP_TYPE_RESOURCE = var_3_10002

			if var_21_1 == var_3_10002 then
				id2ItemId = var_21_1
				var_21_0 = var_21_1(var_19_8[2])
			else
				local var_21_2 = var_19_8[1]

				DROP_TYPE_ITEM = var_3_10002

				if var_21_2 == var_3_10002 then
					var_21_0 = var_19_8[2]
				end
			end

			if var_21_0 then
				local var_21_3 = arg_18_0

				var_1.emit(var_21_3, var_0_1.ON_ITEM, var_21_0)
			end

			return
		end

		SFX_PANEL = var_2_10010

		var_6(var_19_9, var_19_10, var_19_11, var_2_10010)

		local var_19_12 = arg_19_0:Find("slider")
		local var_19_13 = var_6.GetComponent

		typeof = var_8
		Slider = var_19_11
		var_19_13(var_19_12, var_8(var_19_11)).value = var_19_1:getProgress() / var_19_1:getConfig("target_num")
		setText = var_7

		var_7(arg_19_0:Find("slider/Text"), var_19_1:getProgress() .. "/" .. var_19_1:getConfig("target_num"))

		return
	end

	UIItemList = var_18_10
	arg_18_0.ulist = var_18_10.New(var_6, var_18_9)

	local var_18_12 = arg_18_0.ulist

	var_9.make(var_18_12, function(arg_22_0, arg_22_1, arg_22_2)
		UIItemList = var_2_10003

		if arg_22_0 == var_2_10003.EventUpdate then
			var_18_11(arg_22_2, var_18_0[arg_22_1 + 1])
		end

		return
	end)

	local var_18_13 = arg_18_0.ulist

	var_9.align(var_18_13, #var_18_0)

	return
end

function var_0_1.moveToTaskGroup(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if arg_23_3 then
		LeanTween = var_1_10004
		var_1_10004 = var_1_10004.cancel
		go = var_1_10005

		var_1_10004(var_1_10005(arg_23_0.taskGroupDesc))

		LeanTween = var_1_10004
		var_1_10004 = var_1_10004.cancel
		go = var_1_10005

		var_1_10004(var_1_10005(arg_23_0.taskGorupContainer))

		goto label_23_0
	end

	LeanTween = var_1_10004

	local var_23_0 = var_1_10004.isTweening

	go = var_1_10005

	if not var_23_0(var_1_10005(arg_23_0.taskGroupDesc)) then
		LeanTween = var_4

		do
			local var_23_1 = var_4.isTweening

			go = var_5

			if var_23_1(var_5(arg_23_0.taskGorupContainer)) then
				return
			end
		end

		::label_23_0::

		local function var_23_2()
			arg_23_0.dateIndex = arg_23_1

			return
		end

		if arg_23_1 > arg_23_0.date then
			var_1_10006 = arg_23_0

			local var_23_3 = arg_23_0.getRow(var_1_10006, arg_23_1)

			var_1_10006 = arg_23_0.startPosition.y + (var_23_3 - 1) * arg_23_0.offset.y

			local var_23_4 = arg_23_0.taskGorupContainer.localPosition.x

			LeanTween = var_8

			local var_23_5 = var_8.moveLocal

			go = var_1_10009

			local var_23_6 = var_1_10009(arg_23_0.taskGorupContainer)

			Vector3 = var_10

			local var_23_7 = var_23_5(var_23_6, var_10(var_23_4, var_1_10006, 0), 0.2)
			local var_23_8 = var_8.setOnComplete

			System = var_10

			var_23_8(var_23_7, var_10.Action(var_23_2))

			local var_23_9 = arg_23_0.taskGroupDesc

			Vector3 = var_23_7
			var_23_9.localScale = var_23_7(0, 1, 1)
			arg_23_0.overStep = true

			if arg_23_0.dateIndex then
				triggerToggle = var_8

				var_8(arg_23_0.taskGroupTFs[arg_23_0.dateIndex], false)
			end
		else
			if arg_23_2 or arg_23_0.overStep then
				local var_23_10 = arg_23_0.taskGroupDesc

				Vector3 = var_1_10006
				var_23_10.localScale = var_1_10006(0, 1, 1)

				arg_23_0:openAnim(arg_23_1, var_23_2)
				arg_23_0:updateTaskGroupDesc(arg_23_1)
			elseif arg_23_0.dateIndex then
				arg_23_0:closeAnim(arg_23_0.dateIndex, function()
					local var_25_0 = arg_23_0

					var_0.openAnim(var_25_0, arg_23_1, var_23_2)

					arg_23_0.dateIndex = arg_23_1

					local var_25_1 = arg_23_0

					var_0.updateTaskGroupDesc(var_25_1, arg_23_0.dateIndex)

					return
				end)
			end

			arg_23_0.overStep = nil
		end

		return
	end
end

function var_0_1.openAnim(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = {}

	assert = var_1_10004

	var_1_10004(arg_26_1, "index can not be nil" .. arg_26_1)

	local var_26_1 = arg_26_0.taskGroupTFs[arg_26_1]
	local var_26_2 = arg_26_0:getRow(arg_26_1)
	local var_26_3 = arg_26_0.startPosition.y + (var_26_2 - 1) * arg_26_0.offset.y
	local var_26_4 = arg_26_0.taskGorupContainer.localPosition.x

	table = var_8

	var_8.insert(var_26_0, function(arg_27_0)
		LeanTween = var_2_10001

		local var_27_0 = var_2_10001.moveLocal

		go = var_2_10002

		local var_27_1 = var_2_10002(arg_26_0.taskGorupContainer)

		Vector3 = var_3

		local var_27_2 = var_27_0(var_27_1, var_3(var_26_4, var_26_3, 0), 0.2)
		local var_27_3 = var_1.setOnComplete

		System = var_3

		var_27_3(var_27_2, var_3.Action(arg_27_0))

		return
	end)

	table = var_8

	var_8.insert(var_26_0, function(arg_28_0)
		triggerToggle = var_2_10001

		var_2_10001(var_26_1, true)

		local var_28_0 = var_26_1.eulerAngles.x
		local var_28_1 = var_26_1.eulerAngles.z

		LeanTween = var_3

		local var_28_2 = var_3.rotate

		go = var_2_10004

		local var_28_3 = var_2_10004(var_26_1)

		Vector3 = var_5

		local var_28_4 = var_28_2(var_28_3, var_5(var_28_0, 0, var_28_1), 0.2)
		local var_28_5 = var_3.setFrom

		Vector3 = var_5

		local var_28_6 = var_28_5(var_28_4, var_5(var_28_0, -180, var_28_1))
		local var_28_7 = var_3.setOnComplete

		System = var_5

		var_28_7(var_28_6, var_5.Action(arg_28_0))

		return
	end)

	table = var_8

	var_8.insert(var_26_0, function(arg_29_0)
		LeanTween = var_2_10001

		local var_29_0 = var_2_10001.scale
		local var_29_1 = arg_26_0.taskGroupDesc

		Vector3 = var_2_10003

		local var_29_2 = var_29_0(var_29_1, var_2_10003(1, 1, 1), 0.2)
		local var_29_3 = var_1.setFrom

		Vector3 = var_3

		local var_29_4 = var_29_3(var_29_2, var_3(0, 1, 1))
		local var_29_5 = var_1.setOnComplete

		System = var_3

		var_29_5(var_29_4, var_3.Action(arg_29_0))

		arg_26_0.taskGroupDesc.position = var_26_1.position

		local var_29_6 = arg_26_0.taskGroupDesc

		var_1.SetAsLastSibling(var_29_6)

		local var_29_7 = var_26_1

		var_1.SetAsLastSibling(var_29_7)

		return
	end)

	seriesAsync = var_8

	var_8(var_26_0, arg_26_2)

	return
end

function var_0_1.closeAnim(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = {}
	local var_30_1 = arg_30_0.taskGroupTFs[arg_30_1]

	table = var_1_10005

	var_1_10005.insert(var_30_0, function(arg_31_0)
		LeanTween = var_2_10001

		local var_31_0 = var_2_10001.scale
		local var_31_1 = arg_30_0.taskGroupDesc

		Vector3 = var_2_10003

		local var_31_2 = var_31_0(var_31_1, var_2_10003(0, 1, 1), 0.2)
		local var_31_3 = var_1.setFrom

		Vector3 = var_3

		local var_31_4 = var_31_3(var_31_2, var_3(1, 1, 1))
		local var_31_5 = var_1.setOnComplete

		System = var_3

		var_31_5(var_31_4, var_3.Action(arg_31_0))

		return
	end)

	table = var_5

	var_5.insert(var_30_0, function(arg_32_0)
		local var_32_0 = var_30_1.eulerAngles.x
		local var_32_1 = var_30_1.eulerAngles.z

		LeanTween = var_2_10003

		local var_32_2 = var_2_10003.rotate

		go = var_2_10004

		local var_32_3 = var_2_10004(var_30_1)

		Vector3 = var_5

		local var_32_4 = var_32_2(var_32_3, var_5(var_32_0, 0, var_32_1), 0.2)
		local var_32_5 = var_3.setFrom

		Vector3 = var_5

		local var_32_6 = var_32_5(var_32_4, var_5(var_32_0, -180, var_32_1))
		local var_32_7 = var_3.setOnComplete

		System = var_5

		var_32_7(var_32_6, var_5.Action(arg_32_0))

		return
	end)

	table = var_5

	var_5.insert(var_30_0, function(arg_33_0)
		triggerToggle = var_2_10001

		var_2_10001(var_30_1, false)
		arg_33_0()

		return
	end)

	seriesAsync = var_5

	var_5(var_30_0, arg_30_2)

	return
end

function var_0_1.addVerticalDrag(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	GetOrAddComponent = var_1_10004

	local var_34_0 = var_1_10004(arg_34_1, "EventTriggerListener")
	local var_34_1
	local var_34_2 = 0
	local var_34_3 = 50

	var_34_0:AddBeginDragFunc(function()
		var_34_2 = 0
		var_34_1 = nil

		return
	end)
	var_34_0:AddDragFunc(function(arg_36_0, arg_36_1)
		local var_36_0 = arg_36_1.position

		if not var_34_1 then
			var_34_1 = var_36_0
		end

		var_34_2 = var_36_0.y - var_34_1.y

		return
	end)
	var_34_0:AddDragEndFunc(function(arg_37_0, arg_37_1)
		if var_34_2 < -var_34_3 then
			if arg_34_3 then
				arg_34_3()
			end
		elseif var_34_2 > var_34_3 and arg_34_2 then
			arg_34_2()
		end

		return
	end)

	return
end

function var_0_1.willExit(arg_38_0)
	return
end

return var_0_1
