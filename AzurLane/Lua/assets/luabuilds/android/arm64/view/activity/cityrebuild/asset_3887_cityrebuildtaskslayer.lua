class = var_0_10000

local var_0_0 = "CityRebuildTasksLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "CityRebuildTasksUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0.bg = arg_2_0:findTF("BG")

	local var_2_0 = arg_2_0.bg

	arg_2_0.Close = var_1.Find(var_2_0, "close")

	local var_2_1 = arg_2_0.bg

	arg_2_0.list = var_1.Find(var_2_1, "panel/list")

	local var_2_2 = arg_2_0.bg

	arg_2_0.frame = var_1.Find(var_2_2, "frame")
	arg_2_0.white_closebtn = arg_2_0:findTF("white_close")
	UIItemList = var_1
	arg_2_0.UIlist = var_1.New(arg_2_0.list, arg_2_0.frame)

	local var_2_3 = arg_2_0.bg

	arg_2_0.getall = var_1.Find(var_2_3, "get_all")

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:InitData()

	setActive = var_1

	var_1(arg_3_0.frame, false)

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.Close

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.white_closebtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1

	var_1(arg_3_0, arg_3_0.getall, function()
		local var_6_0 = arg_3_0

		var_0.GetAllAward(var_6_0)

		return
	end)

	setText = var_1

	local var_3_6 = arg_3_0.getall
	local var_3_7 = var_3.Find(var_3_6, "Text")

	i18n = var_4

	var_1(var_3_7, var_4("other_world_task_get_all"))

	pg = var_1

	local var_3_8 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_8, arg_3_0._tf)

	return
end

function var_0_1.ShouldShowTip()
	ActivityConst = var_1_10000

	local var_7_0 = var_1_10000.NINJA_CITY_SP_TASK

	getProxy = var_1_10001
	TaskProxy = var_1_10003

	local var_7_1 = var_1_10001(var_1_10003)

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_7_2 = var_1_10002(var_1_10004)
	local var_7_3 = var_2.getActivityById(var_7_2, var_7_0)
	local var_7_4 = var_2.getConfig(var_7_3, "config_data")

	if var_2.data3 then
		return false
	end

	if var_2.data3 == 0 or var_4 == nil then
		return false
	end

	for iter_7_0 = 1, #var_7_4[var_4] do
		local var_7_5 = var_7_1:getTaskVO(var_7_4[var_4][iter_7_0])

		if var_9.getTaskStatus(var_7_5) == 1 then
			return true
		end
	end

	ActivityConst = var_5

	local var_7_6 = var_5.NINJA_CITY_NORMAL_ACTIVITY_TASK

	getProxy = var_6
	ActivityProxy = iter_7_0

	local var_7_7 = var_6(iter_7_0)
	local var_7_8 = var_6.getActivityById(var_7_7, var_7_6)
	local var_7_9 = var_6.getConfig(var_7_8, "config_data")

	for iter_7_1 = 1, #var_7_9 do
		local var_7_10 = var_7_1:getTaskVO(var_7_9[iter_7_1])

		if var_12.getTaskStatus(var_7_10) == 1 then
			return true
		end
	end

	return false
end

function var_0_1.InitData(arg_8_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003
	arg_8_0.taskProxy = var_1_10001(var_1_10003)
	ActivityConst = var_1
	arg_8_0.taskActivityId = var_1.NINJA_CITY_SP_TASK
	ActivityConst = var_1
	arg_8_0.taskActivityId_2 = var_1.NINJA_CITY_NORMAL_ACTIVITY_TASK
	getProxy = var_1
	ActivityProxy = var_1_10003

	local var_8_0 = var_1(var_1_10003)

	arg_8_0.activity = var_1.getActivityById(var_8_0, arg_8_0.taskActivityId)
	getProxy = var_1
	ActivityProxy = var_8_0

	local var_8_1 = var_1(var_8_0)

	arg_8_0.activity_2 = var_1.getActivityById(var_8_1, arg_8_0.taskActivityId_2)

	local var_8_2 = arg_8_0.activity

	arg_8_0.data = var_1.getConfig(var_8_2, "config_data")

	local var_8_3 = arg_8_0.activity_2

	arg_8_0.data2 = var_1.getConfig(var_8_3, "config_data")
	updateActivityTaskStatus = var_1

	var_1(arg_8_0.activity)

	arg_8_0.config_datas = {}
	arg_8_0.nday = arg_8_0.activity.data3

	if not arg_8_0.config_datas then
		table = var_1

		var_1.clean(arg_8_0.config_datas)
	end

	for iter_8_0 = 1, #arg_8_0.data[arg_8_0.nday] do
		table = var_1_10005

		var_1_10005.insert(arg_8_0.config_datas, arg_8_0.data[arg_8_0.nday][iter_8_0])
	end

	for iter_8_1 = 1, #arg_8_0.data2 do
		table = var_1_10005

		var_1_10005.insert(arg_8_0.config_datas, arg_8_0.data2[iter_8_1])
	end

	arg_8_0:OnSort()
	arg_8_0:UpdateView()

	return
end

function var_0_1.OnSort(arg_9_0)
	arg_9_0.config_data = {}

	if not arg_9_0.config_data then
		table = var_1

		var_1.clean(arg_9_0.config_data)
	end

	for iter_9_0 = 1, #arg_9_0.config_datas do
		local var_9_0 = arg_9_0.taskProxy

		arg_9_0.tasks = var_5.getTaskVO(var_9_0, arg_9_0.config_datas[iter_9_0])

		local var_9_1 = arg_9_0.tasks

		if var_5.getTaskStatus(var_9_1) == 1 then
			table = var_5

			var_5.insert(arg_9_0.config_data, arg_9_0.config_datas[iter_9_0])
		end
	end

	for iter_9_1 = 1, #arg_9_0.config_datas do
		local var_9_2 = arg_9_0.taskProxy

		arg_9_0.tasks = var_5.getTaskVO(var_9_2, arg_9_0.config_datas[iter_9_1])

		local var_9_3 = arg_9_0.tasks

		if var_5.getTaskStatus(var_9_3) == 0 then
			table = var_5

			var_5.insert(arg_9_0.config_data, arg_9_0.config_datas[iter_9_1])
		end
	end

	for iter_9_2 = 1, #arg_9_0.config_datas do
		local var_9_4 = arg_9_0.taskProxy

		arg_9_0.tasks = var_5.getTaskVO(var_9_4, arg_9_0.config_datas[iter_9_2])

		local var_9_5 = arg_9_0.tasks

		if var_5.getTaskStatus(var_9_5) == 2 then
			table = var_5

			var_5.insert(arg_9_0.config_data, arg_9_0.config_datas[iter_9_2])
		end
	end

	return
end

function var_0_1.UpdateView(arg_10_0)
	setActive = var_1_10001

	var_1_10001(arg_10_0.getall, arg_10_0.ShouldShowTip())

	local var_10_0 = arg_10_0.UIlist

	var_1.make(var_10_0, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = arg_10_0

			var_3.UpdateList(var_11_0, arg_11_1, arg_11_2, arg_10_0.config_data)
		end

		return
	end)

	local var_10_1 = arg_10_0.UIlist

	var_1.align(var_10_1, #arg_10_0.config_data)

	return
end

function var_0_1.GetAllAward(arg_12_0)
	arg_12_0.indexTask = 0
	getProxy = var_1
	PlayerProxy = var_1_10003

	local var_12_0 = var_1(var_1_10003)
	local var_12_1 = {}
	local var_12_2 = {}

	pairs = var_1_10004

	for iter_12_0, iter_12_1 in var_1_10004(arg_12_0.config_data) do
		var_1_10011 = arg_12_0.taskProxy
		arg_12_0.taskvo = var_9.getFinishTaskById(var_1_10011, arg_12_0.config_data[iter_12_0])
		var_1_10011 = arg_12_0.taskProxy
		arg_12_0.task = var_9.getTaskVO(var_1_10011, arg_12_0.config_data[iter_12_0])
		var_1_10011 = arg_12_0.task

		if var_9.getTaskStatus(var_1_10011) == 1 then
			for iter_12_2 = 1, #arg_12_0.data2 do
				if arg_12_0.task.id == arg_12_0.data2[iter_12_2] then
					table = var_13

					var_13.insert(var_12_1, arg_12_0.config_data[iter_12_0])
				end
			end

			for iter_12_3 = 1, #arg_12_0.data[arg_12_0.nday] do
				if arg_12_0.task.id == arg_12_0.data[arg_12_0.nday][iter_12_3] then
					table = var_13

					var_13.insert(var_12_2, arg_12_0.task.id)
				end
			end
		end
	end

	for iter_12_4 = 1, #var_12_2 do
		local var_12_3 = arg_12_0
		local var_12_4 = arg_12_0.emit

		CityRebuildTasksMediator = var_1_10011

		var_12_4(var_12_3, var_1_10011.ON_SUBMIT_TASK, var_12_2[iter_12_4])
	end

	local var_12_5 = arg_12_0
	local var_12_6 = arg_12_0.emit

	CityRebuildTasksMediator = iter_12_4

	var_12_6(var_12_5, iter_12_4.ON_TASK_SUBMIT_ONESTEP, arg_12_0.taskActivityId_2, var_12_1)

	return
end

function var_0_1.UpdateList(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1 + 1
	local var_13_1 = arg_13_2:Find("frame")
	local var_13_2 = arg_13_0.taskProxy
	local var_13_3 = var_6.getTaskVO(var_13_2, arg_13_3[var_13_0])
	local var_13_4

	var_13_4, setText = arg_13_2:Find("desc"), var_13_2

	local var_13_5 = var_13_3

	var_13_2(var_13_4, var_13_3.getConfig(var_13_5, "desc"))

	local var_13_6 = var_13_3
	local var_13_7 = var_13_3.getProgress(var_13_6)
	local var_13_8 = var_13_3:getConfig("target_num")

	setText = var_13_6

	local var_13_9 = arg_13_2:Find("progress")

	setColorStr = var_13_5

	var_13_6(var_13_9, var_13_5(var_13_7, "#000000") .. "/" .. var_13_8)

	setSlider = var_13_6

	var_13_6(arg_13_2:Find("slider"), 0, var_13_8, var_13_7)

	local var_13_10 = arg_13_2:GetChild(0)
	local var_13_11 = arg_13_2:Find("awards")

	arg_13_0:updateAwards(var_13_3:getConfig("award_display"), var_13_11, var_13_10)

	local var_13_12 = arg_13_2:Find("go_btn")
	local var_13_13 = arg_13_2:Find("get_btn")
	local var_13_14 = arg_13_2
	local var_13_15 = arg_13_2.Find(var_13_14, "got_btn")
	local var_13_16 = var_13_3:getTaskStatus()

	setActive = var_13_14

	var_13_14(var_13_12, var_13_16 == 0)

	setActive = var_13_14

	var_13_14(var_13_13, var_13_16 == 1)

	setActive = var_13_14

	var_13_14(var_13_15, var_13_16 == 2)

	SetActive = var_13_14

	var_13_14(arg_13_2:Find("tip"), var_13_16 == 1)

	onButton = var_13_14

	local var_13_17 = arg_13_0
	local var_13_18 = var_13_13

	local function var_13_19()
		for iter_14_0 = 1, #arg_13_0.data[arg_13_0.nday] do
			if var_13_3.id == arg_13_0.data[arg_13_0.nday][iter_14_0] then
				local var_14_0 = arg_13_0
				local var_14_1 = var_4.emit

				CityRebuildTasksMediator = var_2_10007

				var_14_1(var_14_0, var_2_10007.ON_SUBMIT_TASK, var_13_3.id)
			end
		end

		for iter_14_1 = 1, #arg_13_0.data2 do
			if var_13_3.id == arg_13_0.data2[iter_14_1] then
				local var_14_2 = arg_13_0
				local var_14_3 = var_4.emit

				CityRebuildTasksMediator = var_2_10007

				var_14_3(var_14_2, var_2_10007.ON_TASK_SUBMIT_ONESTEP, arg_13_0.taskActivityId_2, {
					var_13_3.id
				})
			end
		end

		return
	end

	SFX_PANEL = var_21

	var_13_14(var_13_17, var_13_18, var_13_19, var_21)

	onButton = var_13_14

	local var_13_20 = arg_13_0
	local var_13_21 = var_13_12

	local function var_13_22()
		local var_15_0 = arg_13_0
		local var_15_1 = var_0.emit

		CityRebuildTasksMediator = var_2_10003

		var_15_1(var_15_0, var_2_10003.ON_TASK_GO, var_13_3)

		return
	end

	SFX_PANEL = var_21

	var_13_14(var_13_20, var_13_21, var_13_22, var_21)

	return
end

function var_0_1.updateAwards(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	_ = var_1_10004

	local var_16_0 = var_1_10004.slice(arg_16_1, 1, 3)

	for iter_16_0 = arg_16_2.childCount, #var_16_0 - 1 do
		cloneTplTo = var_1_10010

		var_1_10010(arg_16_3, arg_16_2)
	end

	local var_16_1 = arg_16_2.childCount

	for iter_16_1 = 1, var_16_1 do
		local var_16_2 = arg_16_2
		local var_16_3 = arg_16_2.GetChild(var_16_2, iter_16_1 - 1)
		local var_16_4 = iter_16_1 <= #var_16_0

		setActive = var_16_2

		var_16_2(var_16_3, var_16_4)

		if var_16_4 then
			local var_16_5 = var_16_0[iter_16_1]
			local var_16_6 = {
				type = var_16_5[1],
				id = var_16_5[2],
				count = var_16_5[3]
			}

			updateDrop = var_14
			findTF = var_1_10016

			var_14(var_1_10016(var_16_3, "mask"), var_16_6)

			onButton = var_14
			var_1_10016 = arg_16_0

			local var_16_7 = var_16_3
			local var_16_8 = var_16_3.Find(var_16_7, "mask")

			local function var_16_9()
				local var_17_0 = arg_16_0
				local var_17_1 = var_0.emit

				BaseUI = var_2_10003

				var_17_1(var_17_0, var_2_10003.ON_DROP, var_16_6)

				return
			end

			SFX_PANEL = var_16_7

			var_14(var_1_10016, var_16_8, var_16_9, var_16_7)
		end
	end

	return
end

return var_0_1
