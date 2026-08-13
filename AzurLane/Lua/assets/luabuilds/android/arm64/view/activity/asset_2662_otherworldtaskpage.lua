class = var_0_10000

local var_0_0 = var_0_10000("OtherWorldTaskPage")
local var_0_1 = 3
local var_0_2 = 1
local var_0_3 = "other_world_task_type_daily"
local var_0_4 = "other_world_task_type_main"
local var_0_5 = "other_world_task_type_repeat"
local var_0_6 = "other_world_task_get_all"
local var_0_7 = "other_world_task_go"
local var_0_8 = "other_world_task_got"
local var_0_9 = "other_world_task_get"
local var_0_10 = "other_world_task_tag_main"
local var_0_11 = "other_world_task_tag_daily"
local var_0_12 = "other_world_task_tag_all"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.taskPage = arg_1_1
	arg_1_0.contextData = arg_1_2
	findTF = var_1_10005
	arg_1_0.taskItemTpl = var_1_10005(arg_1_3, "taskItemTpl")
	findTF = var_5
	arg_1_0.iconTpl = var_5(arg_1_3, "IconTpl")
	arg_1_0._event = arg_1_4
	setText = var_5
	findTF = var_7

	local var_1_0 = var_7(arg_1_0.taskItemTpl, "btnGo/text")

	i18n = var_8

	var_5(var_1_0, var_8(var_0_7))

	setText = var_5
	findTF = var_1_0

	local var_1_1 = var_1_0(arg_1_0.taskItemTpl, "btnGot/text")

	i18n = var_8

	var_5(var_1_1, var_8(var_0_8))

	setText = var_5
	findTF = var_1_1

	local var_1_2 = var_1_1(arg_1_0.taskItemTpl, "btnGet/text")

	i18n = var_8

	var_5(var_1_2, var_8(var_0_9))

	setText = var_5
	findTF = var_1_2

	local var_1_3 = var_1_2(arg_1_0.taskPage, "leftBtns/btnAll/text")

	i18n = var_8

	var_5(var_1_3, var_8(var_0_12))

	setText = var_5
	findTF = var_1_3

	local var_1_4 = var_1_3(arg_1_0.taskPage, "leftBtns/btnMain/text")

	i18n = var_8

	var_5(var_1_4, var_8(var_0_10))

	setText = var_5
	findTF = var_1_4

	local var_1_5 = var_1_4(arg_1_0.taskPage, "leftBtns/btnDaily/text")

	i18n = var_8

	var_5(var_1_5, var_8(var_0_11))

	setText = var_5
	findTF = var_1_5

	local var_1_6 = var_1_5(arg_1_0.taskPage, "leftBtns/btnAll/text_selected")

	i18n = var_8

	var_5(var_1_6, var_8(var_0_12))

	setText = var_5
	findTF = var_1_6

	local var_1_7 = var_1_6(arg_1_0.taskPage, "leftBtns/btnMain/text_selected")

	i18n = var_8

	var_5(var_1_7, var_8(var_0_10))

	setText = var_5
	findTF = var_1_7

	local var_1_8 = var_1_7(arg_1_0.taskPage, "leftBtns/btnDaily/text_selected")

	i18n = var_8

	var_5(var_1_8, var_8(var_0_11))

	setText = var_5
	findTF = var_1_8

	local var_1_9 = var_1_8(arg_1_0.taskPage, "btnGetAll/text")

	i18n = var_8

	var_5(var_1_9, var_8(var_0_6))

	setActive = var_5

	var_5(arg_1_0.taskItemTpl, false)

	setActive = var_5

	var_5(arg_1_0.iconTpl, false)

	arg_1_0.enterTaskId = nil
	arg_1_0.enterTaskIds = nil

	local var_1_10

	if arg_1_0.contextData.task_id then
		if not arg_1_0.contextData.task_id then
			var_1_10 = nil
		end

		arg_1_0.enterTaskId = var_1_10
	elseif arg_1_0.contextData.task_ids then
		if not arg_1_0.contextData.task_ids then
			var_1_10 = nil
		end

		arg_1_0.enterTaskIds = var_1_10
	end

	ActivityConst = var_1_10
	arg_1_0.activityId = var_1_10.OTHER_WORLD_TASK_ID
	arg_1_0.hideTask = {}
	pg = var_5

	local var_1_11

	if var_5.activity_template[arg_1_0.activityId] then
		pg = var_1_11

		if not var_1_11.activity_template[arg_1_0.activityId].config_client.hide_task then
			var_1_11 = {}
		end

		arg_1_0.hideTask = var_1_11
	end

	findTF = var_1_11
	arg_1_0.btnGetAll = var_1_11(arg_1_0.taskPage, "btnGetAll")
	findTF = var_5
	arg_1_0.taskTagPanel = var_5(arg_1_0.taskPage, "taskTagPanel")
	findTF = var_5
	arg_1_0.taskListPanel = var_5(arg_1_0.taskPage, "taskListPanel")
	findTF = var_5

	local var_1_12 = var_5(arg_1_0.taskPage, "taskListPanel/Content")

	arg_1_0.scrollRect = var_5.GetComponent(var_1_12, "LScrollRect")

	local var_1_13 = arg_1_0.scrollRect

	function var_1_13.onUpdateItem(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0

		var_2.onUpdateTaskItem(var_2_0, arg_2_0, arg_2_1)

		return
	end

	findTF = var_1_13
	arg_1_0.btnAll = var_1_13(arg_1_0.taskPage, "leftBtns/btnAll")
	findTF = var_5
	arg_1_0.btnDaily = var_5(arg_1_0.taskPage, "leftBtns/btnDaily")
	findTF = var_5
	arg_1_0.btnMain = var_5(arg_1_0.taskPage, "leftBtns/btnMain")
	onButton = var_5

	local var_1_14 = arg_1_0._event
	local var_1_15 = arg_1_0.btnAll

	local function var_1_16()
		local var_3_0 = arg_1_0

		var_0.clearTagBtn(var_3_0)

		setActive = var_0
		findTF = var_3_0

		var_0(var_3_0(arg_1_0.btnAll, "bg_selected"), true)

		setActive = var_0
		findTF = var_2

		var_0(var_2(arg_1_0.btnAll, "text_selected"), true)

		setActive = var_0
		findTF = var_2

		var_0(var_2(arg_1_0.btnAll, "text"), false)

		setImageColor = var_0
		findTF = var_2

		local var_3_1 = var_2(arg_1_0.btnAll, "bg")

		Color = var_3

		var_0(var_3_1, var_3.New(1, 0.9882352941176471, 0.9098039215686274, 1))

		local var_3_2 = arg_1_0

		var_0.showTaskByType(var_3_2)

		return
	end

	SFX_CONFIRM = var_10

	var_5(var_1_14, var_1_15, var_1_16, var_10)

	onButton = var_5

	local var_1_17 = arg_1_0._event
	local var_1_18 = arg_1_0.btnDaily

	local function var_1_19()
		local var_4_0 = arg_1_0

		var_0.clearTagBtn(var_4_0)

		setActive = var_0
		findTF = var_4_0

		var_0(var_4_0(arg_1_0.btnDaily, "bg_selected"), true)

		setActive = var_0
		findTF = var_2

		var_0(var_2(arg_1_0.btnDaily, "text_selected"), true)

		setActive = var_0
		findTF = var_2

		var_0(var_2(arg_1_0.btnDaily, "text"), false)

		setImageColor = var_0
		findTF = var_2

		local var_4_1 = var_2(arg_1_0.btnDaily, "bg")

		Color = var_3

		var_0(var_4_1, var_3.New(1, 0.9882352941176471, 0.9098039215686274, 1))

		local var_4_2 = arg_1_0

		var_0.showTaskByType(var_4_2, var_0_1)

		return
	end

	SFX_CONFIRM = var_10

	var_5(var_1_17, var_1_18, var_1_19, var_10)

	onButton = var_5

	local var_1_20 = arg_1_0._event
	local var_1_21 = arg_1_0.btnMain

	local function var_1_22()
		local var_5_0 = arg_1_0

		var_0.clearTagBtn(var_5_0)

		setActive = var_0
		findTF = var_5_0

		var_0(var_5_0(arg_1_0.btnMain, "bg_selected"), true)

		setActive = var_0
		findTF = var_2

		var_0(var_2(arg_1_0.btnMain, "text_selected"), true)

		setActive = var_0
		findTF = var_2

		var_0(var_2(arg_1_0.btnMain, "text"), false)

		setImageColor = var_0
		findTF = var_2

		local var_5_1 = var_2(arg_1_0.btnMain, "bg")

		Color = var_3

		var_0(var_5_1, var_3.New(1, 0.9882352941176471, 0.9098039215686274, 1))

		local var_5_2 = arg_1_0

		var_0.showTaskByType(var_5_2, var_0_2)

		return
	end

	SFX_CONFIRM = var_10

	var_5(var_1_20, var_1_21, var_1_22, var_10)

	onButton = var_5

	local var_1_23 = arg_1_0._event
	local var_1_24 = arg_1_0.btnGetAll

	local function var_1_25()
		local var_6_0 = arg_1_0.getAllTasks
		local var_6_1 = arg_1_0._event
		local var_6_2 = var_1.emit

		OtherWorldTaskMediator = var_2_10004

		var_6_2(var_6_1, var_2_10004.SUBMIT_TASK_ALL, {
			activityId = arg_1_0.activityId,
			ids = var_6_0
		})

		return
	end

	SFX_CONFIRM = var_10

	var_5(var_1_23, var_1_24, var_1_25, var_10)

	arg_1_0.iconTfs = {}
	arg_1_0.awards = {}

	arg_1_0:updateTask()

	triggerButton = var_5

	var_5(arg_1_0.btnAll, true)

	return
end

function var_0_0.showTaskByType(arg_7_0, arg_7_1)
	arg_7_0.tagType = arg_7_1
	arg_7_0.showTasks = {}

	if arg_7_1 then
		ipairs = var_2

		for iter_7_0, iter_7_1 in var_2(arg_7_0.allDisplayTask) do
			if iter_7_1:getConfig("priority_type") == arg_7_1 then
				table = var_7

				var_7.insert(arg_7_0.showTasks, iter_7_1)
			end
		end
	else
		arg_7_0.showTasks = arg_7_0.allDisplayTask
	end

	if arg_7_0.enterTaskId and arg_7_0.enterTaskId > 0 then
		for iter_7_2 = 1, #arg_7_0.showTasks do
			if arg_7_0.showTasks[iter_7_2].id == arg_7_0.enterTaskId then
				arg_7_0.scrollIndex = iter_7_2
			end
		end
	end

	local var_7_0 = arg_7_0.scrollRect

	var_2.SetTotalCount(var_7_0, #arg_7_0.showTasks, 0)

	if arg_7_0.scrollIndex ~= nil then
		local var_7_1 = arg_7_0.scrollRect
		local var_7_2 = var_2.HeadIndexToValue(var_7_1, arg_7_0.scrollIndex - 1)
		local var_7_3 = arg_7_0.scrollRect

		var_3.ScrollTo(var_7_3, var_7_2)
	end

	return
end

function var_0_0.clearTagBtn(arg_8_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_8_0.btnAll, "bg_selected"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_8_0.btnDaily, "bg_selected"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_8_0.btnMain, "bg_selected"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_8_0.btnMain, "text_selected"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_8_0.btnDaily, "text_selected"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_8_0.btnAll, "text_selected"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_8_0.btnMain, "text"), true)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_8_0.btnDaily, "text"), true)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_8_0.btnAll, "text"), true)

	setImageColor = var_1_10001
	findTF = var_3

	local var_8_0 = var_3(arg_8_0.btnMain, "bg")

	Color = var_4

	var_1_10001(var_8_0, var_4.New(0.7372549019607844, 0.6352941176470588, 0.5882352941176471, 1))

	setImageColor = var_1_10001
	findTF = var_8_0

	local var_8_1 = var_8_0(arg_8_0.btnDaily, "bg")

	Color = var_4

	var_1_10001(var_8_1, var_4.New(0.7372549019607844, 0.6352941176470588, 0.5882352941176471, 1))

	setImageColor = var_1_10001
	findTF = var_8_1

	local var_8_2 = var_8_1(arg_8_0.btnAll, "bg")

	Color = var_4

	var_1_10001(var_8_2, var_4.New(0.7372549019607844, 0.6352941176470588, 0.5882352941176471, 1))

	return
end

function var_0_0.onUpdateTaskItem(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0.exitFlag then
		return
	end

	arg_9_1 = arg_9_1 + 1

	local var_9_0 = arg_9_0.showTasks[arg_9_1].id
	local var_9_1 = var_3:getProgress()
	local var_9_2 = var_3:getConfig("desc")
	local var_9_3 = var_3:getConfig("ryza_icon")
	local var_9_4 = var_3:isOver()
	local var_9_5 = var_3:isFinish()
	local var_9_6 = var_3:getTarget()
	local var_9_7 = var_3:isCircle()
	local var_9_8 = var_3:isDaily()
	local var_9_9 = var_3:isSubmit()
	local var_9_10 = var_3:getConfig("sub_type")
	local var_9_11 = var_3
	local var_9_12 = var_3.getConfig(var_9_11, "type")
	local var_9_13 = var_3
	local var_9_14 = var_3.getConfig(var_9_13, "priority_type")

	setScrollText = var_9_11
	findTF = var_19

	var_9_11(var_19(arg_9_2, "desc/text"), var_9_2)

	PLATFORM_CODE = var_9_11
	PLATFORM_CH = var_9_13

	if var_9_11 ~= var_9_13 then
		-- block empty
	end

	local var_9_15

	if not var_9_4 then
		setText = var_9_11
		findTF = var_9_15
		var_9_15 = var_9_15(arg_9_2, "progressDesc/text")
		setColorStr = var_20

		local var_9_16 = var_20(var_9_1, "#51382E")
		local var_9_17 = " / "

		setColorStr = var_22

		var_9_11(var_9_15, var_9_16 .. var_9_17 .. var_22(var_9_6, "#51382E"))
	else
		setText = var_9_11
		findTF = var_9_15

		var_9_11(var_9_15(arg_9_2, "progressDesc/text"), "--/--")
	end

	setSlider = var_9_11
	findTF = var_9_15

	var_9_11(var_9_15(arg_9_2, "progressBar"), 0, 1, var_9_4 and 1 or var_9_1 / var_9_6)

	pg = var_9_11

	local var_9_18 = var_9_11.task_data_template[var_9_0].award_display

	findTF = var_19

	if var_19(arg_9_2, "awardDisplay/viewport/content").childCount < #var_9_18 then
		local var_9_19 = #var_9_18 - var_20

		for iter_9_0 = 1, var_9_19 do
			tf = var_1_10026
			Instantiate = var_1_10028
			var_1_10026 = var_1_10026(var_1_10028(arg_9_0.iconTpl))
			setParent = var_1_10027

			var_1_10027(var_1_10026, var_19)

			setActive = var_1_10027

			var_1_10027(var_1_10026, true)
		end
	end

	for iter_9_1 = 1, var_19.childCount do
		local var_9_20 = var_19:GetChild(iter_9_1 - 1)
		local var_9_21

		if iter_9_1 <= #var_9_18 then
			var_9_21 = var_9_18[iter_9_1]

			local var_9_22 = {
				type = var_9_21[1],
				id = var_9_21[2],
				count = var_9_21[3]
			}

			updateDrop = var_28

			var_28(var_9_20, var_9_22)

			onButton = var_28

			local var_9_23 = arg_9_0._event
			local var_9_24 = var_9_20

			local function var_9_25()
				local var_10_0 = arg_9_0._event
				local var_10_1 = var_0.emit

				BaseUI = var_2_10003

				var_10_1(var_10_0, var_2_10003.ON_DROP, var_9_22)

				return
			end

			SFX_PANEL = var_1_10033

			var_28(var_9_23, var_9_24, var_9_25, var_1_10033)

			setActive = var_28

			var_28(var_9_20, true)
		else
			setActive = var_9_21

			var_9_21(var_9_20, false)
		end
	end

	setActive = var_21
	findTF = var_23

	var_21(var_23(arg_9_2, "btnGo"), not var_9_4 and not var_9_5 and var_9_10 ~= 1006)

	setActive = var_21
	findTF = var_23

	var_21(var_23(arg_9_2, "btnGet"), not var_9_4 and var_9_5 and not var_9_9)

	setActive = var_21
	findTF = var_23

	var_21(var_23(arg_9_2, "btnGot"), var_9_5)

	setSlider = var_21
	findTF = var_23

	var_21(var_23(arg_9_2, "progressBar"), 0, 1, var_9_1 / var_9_6)

	local var_9_26

	if var_9_14 == var_0_1 then
		if var_9_12 == 16 and var_9_10 == 20 then
			var_9_26 = var_0_5
		else
			var_9_26 = var_0_3
		end
	else
		var_9_26 = var_0_4
	end

	setText = var_22
	findTF = var_24

	local var_9_27 = var_24(arg_9_2, "tag/text")

	i18n = var_25

	var_22(var_9_27, var_25(var_9_26))

	onButton = var_22

	local var_9_28 = arg_9_0._event

	findTF = var_25

	local var_9_29 = var_25(arg_9_2, "btnGo")

	local function var_9_30()
		local var_11_0 = arg_9_0._event
		local var_11_1 = var_0.emit

		OtherWorldTaskMediator = var_2_10003

		var_11_1(var_11_0, var_2_10003.TASK_GO, {
			taskVO = var_0
		})

		return
	end

	SFX_CONFIRM = var_27

	var_22(var_9_28, var_9_29, var_9_30, var_27)

	onButton = var_22

	local var_9_31 = arg_9_0._event

	findTF = var_9_29

	local var_9_32 = var_9_29(arg_9_2, "btnGet")

	local function var_9_33()
		local var_12_0 = var_0
		local var_12_1 = var_0.getConfig(var_12_0, "priority_type")
		local var_12_2 = var_0
		local var_12_3 = var_1.getConfig(var_12_2, "sub_type")
		local var_12_4 = arg_9_0._event
		local var_12_5 = var_2.emit

		OtherWorldTaskMediator = var_2_10005

		var_12_5(var_12_4, var_2_10005.SUBMIT_TASK, {
			activityId = arg_9_0.activityId,
			id = var_0.id
		})

		return
	end

	SFX_CONFIRM = var_27

	var_22(var_9_31, var_9_32, var_9_33, var_27)

	if arg_9_1 == 1 then
		arg_9_0.scrollIndex = nil
	end

	if arg_9_0.enterTaskId ~= nil and arg_9_0.enterTaskId > 0 then
		if var_9_0 == arg_9_0.enterTaskId then
			arg_9_0.enterTaskId = nil
			arg_9_0.scrollIndex = nil
		end
	elseif arg_9_0.enterTaskIds and #arg_9_0.enterTaskIds > 0 then
		ipairs = var_22

		for iter_9_2, iter_9_3 in var_22(arg_9_0.enterTaskIds) do
			if var_9_0 == iter_9_3 then
				arg_9_0.enterTaskIds = nil
				arg_9_0.scrollIndex = nil
			end
		end
	end

	return
end

function var_0_0.updateTask(arg_13_0, arg_13_1)
	arg_13_0.displayTask = {}
	arg_13_0.allDisplayTask = {}
	getProxy = var_2
	ActivityTaskProxy = var_1_10004

	local var_13_0 = var_2(var_1_10004)
	local var_13_1 = var_2.getTaskById(var_13_0, arg_13_0.activityId)

	arg_13_0.getAllTasks = {}

	for iter_13_0 = 1, #var_13_1 do
		local var_13_2 = var_13_1[iter_13_0].id

		table = var_1_10009

		if not var_1_10009.contains(arg_13_0.hideTask, var_13_2) then
			var_1_10011 = var_7
			var_1_10009 = var_7.getProgress(var_1_10011)
			var_1_10010 = var_7:getTarget()
			var_1_10011 = var_7:getConfig("priority_type")

			local var_13_3

			if not arg_13_0.displayTask[var_1_10011] then
				var_13_3 = arg_13_0.displayTask
				var_13_3[var_1_10011] = {}
			end

			table = var_13_3

			var_13_3.insert(arg_13_0.displayTask[var_1_10011], var_7)

			table = var_12

			var_12.insert(arg_13_0.allDisplayTask, var_7)

			if var_7:isFinish() and not var_7:isOver() then
				table = var_12

				var_12.insert(arg_13_0.getAllTasks, var_13_2)
			end
		end
	end

	getProxy = var_3
	ActivityProxy = var_5

	local var_13_4 = var_3(var_5)
	local var_13_5 = var_3.getActivityById(var_13_4, arg_13_0.activityId)
	local var_13_6 = {}

	if var_13_5 then
		var_13_6 = var_13_5.data1_list
	end

	if var_13_6 then
		local var_13_7 = #var_13_6

		if 0 < var_13_7 then
			for iter_13_1 = 1, #var_13_6 do
				local var_13_8 = var_13_6[iter_13_1]

				ActivityTask = var_1_10010

				local var_13_9 = var_1_10010.New(arg_13_0.activityId, {
					progress = 0,
					id = var_13_8
				})

				var_1_10010.setOver(var_13_9)

				if var_1_10010:getConfig("ryza_type") > 0 then
					local var_13_10

					if not arg_13_0.displayTask[var_1_10011] then
						var_13_10 = arg_13_0.displayTask
						var_13_10[var_1_10011] = {}
					end

					table = var_13_10

					var_13_10.insert(arg_13_0.displayTask[var_1_10011], var_1_10010)

					table = var_12

					var_12.insert(arg_13_0.allDisplayTask, var_1_10010)
				end
			end
		end
	end

	local function var_13_11(arg_14_0, arg_14_1)
		if arg_14_0:isOver() and not arg_14_1:isOver() then
			return false
		elseif not arg_14_0:isOver() and arg_14_1:isOver() then
			return true
		end

		if arg_14_0:isFinish() and not arg_14_1:isFinish() then
			return true
		elseif not arg_14_0:isFinish() and arg_14_1:isFinish() then
			return false
		end

		local var_14_0 = arg_14_0:getConfig("priority_type")
		local var_14_1 = arg_14_1:getConfig("priority_type")

		if var_14_0 == var_0_2 and var_14_1 == var_0_1 then
			return true
		elseif var_14_0 == var_0_1 and var_14_1 == var_0_2 then
			return false
		end

		if arg_14_0:isNew() and not arg_14_1:isNew() then
			return true
		elseif not arg_14_0:isNew() and arg_14_1:isNew() then
			return false
		end

		if arg_14_0.id > arg_14_1.id then
			return false
		elseif arg_14_0.id < arg_14_1.id then
			return true
		end

		return
	end

	pairs = var_6

	for iter_13_2, iter_13_3 in var_6(arg_13_0.displayTask) do
		table = var_1_10011

		var_1_10011.sort(iter_13_3, var_13_11)
	end

	table = var_6

	var_6.sort(arg_13_0.allDisplayTask, var_13_11)

	if arg_13_1 then
		arg_13_0:showTaskByType(arg_13_0.tagType)
	end

	if #arg_13_0.getAllTasks > 0 then
		setActive = var_6

		var_6(arg_13_0.btnGetAll, true)
	else
		setActive = var_6

		var_6(arg_13_0.btnGetAll, false)
	end

	return
end

function var_0_0.setActive(arg_15_0, arg_15_1)
	setActive = var_1_10002

	var_1_10002(arg_15_0.taskPage, arg_15_1)

	return
end

function var_0_0.dispose(arg_16_0)
	arg_16_0.exitFlag = true

	for iter_16_0 = 1, #arg_16_0.allDisplayTask do
		local var_16_0 = arg_16_0.allDisplayTask[iter_16_0]

		if var_5.isNew(var_16_0) then
			var_5:changeNew()
		end
	end

	return
end

return var_0_0
