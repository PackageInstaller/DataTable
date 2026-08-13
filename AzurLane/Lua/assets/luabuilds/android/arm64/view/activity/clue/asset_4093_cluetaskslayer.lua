class = var_0_10000

local var_0_0 = "ClueTasksLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ClueTasksUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.white_closebtn = var_1.Find(var_2_0, "white_close")

	local var_2_1 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_1, "BG")

	local var_2_2 = arg_2_0.bg

	arg_2_0.Close = var_1.Find(var_2_2, "close")

	local var_2_3 = arg_2_0.bg

	arg_2_0.list = var_1.Find(var_2_3, "panel/list")

	local var_2_4 = arg_2_0.bg

	arg_2_0.frame = var_1.Find(var_2_4, "frame")
	UIItemList = var_1
	arg_2_0.UIlist = var_1.New(arg_2_0.list, arg_2_0.frame)

	local var_2_5 = arg_2_0.bg

	arg_2_0.getall = var_1.Find(var_2_5, "get_all")

	return
end

function var_0_1.ShouldShowTip()
	ActivityConst = var_1_10000

	local var_3_0 = var_1_10000.Valleyhospital_TASK

	getProxy = var_1_10001
	TaskProxy = var_1_10003

	local var_3_1 = var_1_10001(var_1_10003)

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_3_2 = var_1_10002(var_1_10004)
	local var_3_3 = var_2.getActivityById(var_3_2, var_3_0)
	local var_3_4 = var_2.getConfig(var_3_3, "config_data")

	for iter_3_0 = 1, #var_3_4 do
		local var_3_5 = var_3_1:getTaskVO(var_3_4[iter_3_0])

		if var_8.getTaskStatus(var_3_5) == 1 then
			return true
		end
	end

	return false
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:InitData()

	setActive = var_1

	var_1(arg_4_0.frame, false)

	onButton = var_1

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.Close

	local function var_4_2()
		local var_5_0 = arg_4_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_4_0, var_4_1, var_4_2, var_1_10006)

	onButton = var_1

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.white_closebtn

	local function var_4_5()
		local var_6_0 = arg_4_0

		var_0.closeView(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_4_3, var_4_4, var_4_5, var_1_10006)
	arg_4_0:UpdateView()

	onButton = var_1

	var_1(arg_4_0, arg_4_0.getall, function()
		local var_7_0 = arg_4_0

		var_0.GetAllAward(var_7_0)

		return
	end)

	setText = var_1

	local var_4_6 = arg_4_0.getall
	local var_4_7 = var_3.Find(var_4_6, "Text")

	i18n = var_4

	var_1(var_4_7, var_4("other_world_task_get_all"))

	pg = var_1

	local var_4_8 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_4_8, arg_4_0._tf)

	return
end

function var_0_1.UpdateView(arg_8_0)
	setActive = var_1_10001

	var_1_10001(arg_8_0.getall, arg_8_0.ShouldShowTip())

	local var_8_0 = arg_8_0.UIlist

	var_1.make(var_8_0, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			local var_9_0 = arg_8_0

			var_3.UpdateList(var_9_0, arg_9_1, arg_9_2, arg_8_0.config_data)
		end

		return
	end)

	local var_8_1 = arg_8_0.UIlist

	var_1.align(var_8_1, #arg_8_0.config_data)

	return
end

function var_0_1.GetAllAward(arg_10_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_10_0 = var_1_10001(var_1_10003)
	local var_10_1 = {}

	pairs = var_1_10003

	for iter_10_0, iter_10_1 in var_1_10003(arg_10_0.config_data) do
		local var_10_2 = arg_10_0.taskProxy

		arg_10_0.taskvo = var_8.getFinishTaskById(var_10_2, arg_10_0.config_data[iter_10_0])

		local var_10_3 = arg_10_0.taskProxy

		arg_10_0.task = var_8.getTaskVO(var_10_3, arg_10_0.config_data[iter_10_0])

		local var_10_4 = arg_10_0.task

		if var_8.getTaskStatus(var_10_4) == 1 then
			table = var_8

			var_8.insert(var_10_1, arg_10_0.config_data[iter_10_0])
		end
	end

	local var_10_5 = arg_10_0
	local var_10_6 = arg_10_0.emit

	ClueTasksMediator = iter_10_0

	var_10_6(var_10_5, iter_10_0.ON_TASK_SUBMIT_ONESTEP, arg_10_0.taskActivityId, var_10_1)

	return
end

function var_0_1.InitData(arg_11_0)
	ActivityConst = var_1_10001
	arg_11_0.taskActivityId = var_1_10001.Valleyhospital_TASK
	getProxy = var_1
	TaskProxy = var_1_10003
	arg_11_0.taskProxy = var_1(var_1_10003)
	getProxy = var_1
	ActivityProxy = var_1_10003

	local var_11_0 = var_1(var_1_10003)

	arg_11_0.activity = var_1.getActivityById(var_11_0, arg_11_0.taskActivityId)

	local var_11_1 = arg_11_0.activity

	arg_11_0.config_data = var_1.getConfig(var_11_1, "config_data")

	return
end

function var_0_1.UpdateList(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_1 + 1
	local var_12_1 = arg_12_2:Find("frame")
	local var_12_2 = arg_12_0.taskProxy
	local var_12_3 = var_6.getTaskVO(var_12_2, arg_12_3[var_12_0])
	local var_12_4 = arg_12_2:Find("desc")

	setText = var_12_2

	var_12_2(var_12_4, var_12_3:getConfig("desc"))

	local var_12_5 = var_12_3
	local var_12_6 = var_12_3.getProgress(var_12_5)
	local var_12_7 = var_12_3:getConfig("target_num")

	setText = var_12_5

	var_12_5(arg_12_2:Find("progress"), var_12_6 .. "/" .. var_12_7)

	setSlider = var_12_5

	var_12_5(arg_12_2:Find("slider"), 0, var_12_7, var_12_6)

	local var_12_8 = arg_12_2:GetChild(0)
	local var_12_9 = arg_12_2:Find("awards")

	arg_12_0:updateAwards(var_12_3:getConfig("award_display"), var_12_9, var_12_8)

	local var_12_10 = arg_12_2:Find("go_btn")
	local var_12_11 = arg_12_2:Find("get_btn")
	local var_12_12 = arg_12_2
	local var_12_13 = arg_12_2.Find(var_12_12, "got_btn")
	local var_12_14 = var_12_3:getTaskStatus()

	setActive = var_12_12

	var_12_12(var_12_10, var_12_14 == 0)

	setActive = var_12_12

	var_12_12(var_12_11, var_12_14 == 1)

	setActive = var_12_12

	var_12_12(var_12_13, var_12_14 == 2)

	SetActive = var_12_12

	var_12_12(arg_12_2:Find("tip"), var_12_14 == 1)

	onButton = var_12_12

	local var_12_15 = arg_12_0
	local var_12_16 = var_12_11

	local function var_12_17()
		local var_13_0 = arg_12_0
		local var_13_1 = var_0.emit

		ClueTasksMediator = var_2_10003

		var_13_1(var_13_0, var_2_10003.ON_TASK_SUBMIT_ONESTEP, arg_12_0.taskActivityId, {
			var_12_3.id
		})

		return
	end

	SFX_PANEL = var_21

	var_12_12(var_12_15, var_12_16, var_12_17, var_21)

	onButton = var_12_12

	local var_12_18 = arg_12_0
	local var_12_19 = var_12_10

	local function var_12_20()
		local var_14_0 = arg_12_0
		local var_14_1 = var_0.emit

		ClueTasksMediator = var_2_10003

		var_14_1(var_14_0, var_2_10003.ON_TASK_GO, var_12_3)

		return
	end

	SFX_PANEL = var_21

	var_12_12(var_12_18, var_12_19, var_12_20, var_21)

	return
end

function var_0_1.updateAwards(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	_ = var_1_10004

	local var_15_0 = var_1_10004.slice(arg_15_1, 1, 3)

	for iter_15_0 = arg_15_2.childCount, #var_15_0 - 1 do
		cloneTplTo = var_1_10010

		var_1_10010(arg_15_3, arg_15_2)
	end

	local var_15_1 = arg_15_2.childCount

	for iter_15_1 = 1, var_15_1 do
		local var_15_2 = arg_15_2
		local var_15_3 = arg_15_2.GetChild(var_15_2, iter_15_1 - 1)
		local var_15_4 = iter_15_1 <= #var_15_0

		setActive = var_15_2

		var_15_2(var_15_3, var_15_4)

		if var_15_4 then
			local var_15_5 = var_15_0[iter_15_1]
			local var_15_6 = {
				type = var_15_5[1],
				id = var_15_5[2],
				count = var_15_5[3]
			}

			updateDrop = var_14
			findTF = var_1_10016

			var_14(var_1_10016(var_15_3, "mask"), var_15_6)

			onButton = var_14
			var_1_10016 = arg_15_0

			local var_15_7 = var_15_3
			local var_15_8 = var_15_3.Find(var_15_7, "mask")

			local function var_15_9()
				local var_16_0 = arg_15_0
				local var_16_1 = var_0.emit

				BaseUI = var_2_10003

				var_16_1(var_16_0, var_2_10003.ON_DROP, var_15_6)

				return
			end

			SFX_PANEL = var_15_7

			var_14(var_1_10016, var_15_8, var_15_9, var_15_7)
		end
	end

	return
end

return var_0_1
