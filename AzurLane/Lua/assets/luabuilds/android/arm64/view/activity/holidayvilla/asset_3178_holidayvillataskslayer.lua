class = var_0_10000

local var_0_0 = "HolidayVillaTasksLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "HolidayVillaTasksUI"
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

	local var_3_0 = var_1_10000.HOLIDAY_TASK

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
	arg_4_0:SortData()

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
	for iter_8_0 = 1, #arg_8_0.config_client do
		for iter_8_1 = 1, #arg_8_0.config_client[iter_8_0] do
			local var_8_0 = arg_8_0.taskProxy

			arg_8_0.task = var_9.getTaskVO(var_8_0, arg_8_0.config_client[iter_8_0][iter_8_1])
			arg_8_0.isGottask = arg_8_0:ISGot(arg_8_0.task, arg_8_0.config_client[iter_8_0][iter_8_1])

			if arg_8_0.isGottask ~= 2 then
				table = var_9

				var_9.insert(arg_8_0.config_data, arg_8_0.config_client[iter_8_0][iter_8_1])

				break
			elseif arg_8_0.isGottask == 2 and iter_8_1 == #arg_8_0.config_client[iter_8_0] then
				table = var_9

				var_9.insert(arg_8_0.config_data, arg_8_0.config_client[iter_8_0][iter_8_1])
			end
		end
	end

	arg_8_0:SortData()

	setActive = var_1

	var_1(arg_8_0.getall, arg_8_0.ShouldShowTip())

	local var_8_1 = arg_8_0.UIlist

	var_1.make(var_8_1, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			local var_9_0 = arg_8_0

			var_3.UpdateList(var_9_0, arg_9_1, arg_9_2, arg_8_0.config_data)
		end

		return
	end)

	local var_8_2 = arg_8_0.UIlist

	var_1.align(var_8_2, #arg_8_0.config_data)

	return
end

function var_0_1.SortData(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = {}

	for iter_10_0 = 1, #arg_10_0.config_data do
		local var_10_3 = arg_10_0.taskProxy

		arg_10_0.taskvo = var_1_10008.getFinishTaskById(var_10_3, arg_10_0.config_data[iter_10_0])

		local var_10_4 = arg_10_0.taskProxy

		arg_10_0.task = var_1_10008.getTaskVO(var_10_4, arg_10_0.config_data[iter_10_0])

		local var_10_5 = arg_10_0.task

		if var_1_10008.getTaskStatus(var_10_5) == 1 then
			table = var_1_10008

			var_1_10008.insert(var_10_0, arg_10_0.config_data[iter_10_0])
		else
			local var_10_6 = arg_10_0.task

			if var_1_10008.getTaskStatus(var_10_6) == 0 then
				table = var_1_10008

				var_1_10008.insert(var_10_2, arg_10_0.config_data[iter_10_0])
			else
				local var_10_7 = arg_10_0.task

				if var_1_10008.getTaskStatus(var_10_7) == 2 then
					table = var_1_10008

					var_1_10008.insert(var_10_1, arg_10_0.config_data[iter_10_0])
				end
			end
		end
	end

	for iter_10_1 = 1, #arg_10_0.config_data do
		table = var_1_10008

		var_1_10008.remove(arg_10_0.config_data)
	end

	for iter_10_2 = 1, #var_10_0 do
		table = var_1_10008

		var_1_10008.insert(arg_10_0.config_data, var_10_0[iter_10_2])
	end

	for iter_10_3 = 1, #var_10_2 do
		table = var_1_10008

		var_1_10008.insert(arg_10_0.config_data, var_10_2[iter_10_3])
	end

	for iter_10_4 = 1, #var_10_1 do
		table = var_1_10008

		var_1_10008.insert(arg_10_0.config_data, var_10_1[iter_10_4])
	end

	return
end

function var_0_1.GetAllAward(arg_11_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_11_0 = var_1_10001(var_1_10003)
	local var_11_1 = {}

	pairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(arg_11_0.config_data) do
		local var_11_2 = arg_11_0.taskProxy

		arg_11_0.taskvo = var_8.getFinishTaskById(var_11_2, arg_11_0.config_data[iter_11_0])

		local var_11_3 = arg_11_0.taskProxy

		arg_11_0.task = var_8.getTaskVO(var_11_3, arg_11_0.config_data[iter_11_0])

		local var_11_4 = arg_11_0.task

		if var_8.getTaskStatus(var_11_4) == 1 then
			table = var_8

			var_8.insert(var_11_1, arg_11_0.config_data[iter_11_0])
		end
	end

	local var_11_5 = arg_11_0
	local var_11_6 = arg_11_0.emit

	HolidayVillaTasksMediator = iter_11_0

	var_11_6(var_11_5, iter_11_0.ON_TASK_SUBMIT_ONESTEP, arg_11_0.taskActivityId, var_11_1)

	return
end

function var_0_1.ISGot(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.taskProxy
	local var_12_1 = var_3.getTaskVO(var_12_0, arg_12_2)

	return arg_12_1.getTaskStatus(var_12_1)
end

function var_0_1.InitData(arg_13_0)
	ActivityConst = var_1_10001
	arg_13_0.taskActivityId = var_1_10001.HOLIDAY_TASK
	getProxy = var_1
	TaskProxy = var_1_10003
	arg_13_0.taskProxy = var_1(var_1_10003)
	getProxy = var_1
	ActivityProxy = var_1_10003

	local var_13_0 = var_1(var_1_10003)

	arg_13_0.activity = var_1.getActivityById(var_13_0, arg_13_0.taskActivityId)
	arg_13_0.config_data = {}

	if #arg_13_0.config_data == 0 then
		-- block empty
	else
		for iter_13_0 = 1, #arg_13_0.config_data do
			table = var_1_10005

			var_1_10005.remove(arg_13_0.config_data)
		end
	end

	local var_13_1 = arg_13_0.activity

	arg_13_0.config_client = var_1.getConfig(var_13_1, "config_client").task

	arg_13_0:UpdateView()

	return
end

function var_0_1.UpdateList(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_1 + 1
	local var_14_1 = arg_14_2:Find("frame")
	local var_14_2 = arg_14_0.taskProxy
	local var_14_3 = var_6.getTaskVO(var_14_2, arg_14_3[var_14_0])
	local var_14_4 = arg_14_2:Find("desc")

	setText = var_14_2

	var_14_2(var_14_4, var_14_3:getConfig("desc"))

	local var_14_5 = var_14_3
	local var_14_6 = var_14_3.getProgress(var_14_5)
	local var_14_7 = var_14_3:getConfig("target_num")

	setText = var_14_5

	var_14_5(arg_14_2:Find("progress"), var_14_6 .. "/" .. var_14_7)

	setSlider = var_14_5

	var_14_5(arg_14_2:Find("slider"), 0, var_14_7, var_14_6)

	local var_14_8 = arg_14_2:GetChild(0)
	local var_14_9 = arg_14_2:Find("awards")

	arg_14_0:updateAwards(var_14_3:getConfig("award_display"), var_14_9, var_14_8)

	local var_14_10 = arg_14_2:Find("go_btn")
	local var_14_11 = arg_14_2
	local var_14_12 = arg_14_2.Find(var_14_11, "get_btn")
	local var_14_13 = arg_14_2
	local var_14_14 = arg_14_2.Find(var_14_13, "got_btn")

	setText = var_14_11

	local var_14_15 = arg_14_2:Find("go_btn/text")

	i18n = var_18

	var_14_11(var_14_15, var_18("other_world_task_go"))

	setText = var_14_11

	local var_14_16 = arg_14_2:Find("get_btn/text")

	i18n = var_18

	var_14_11(var_14_16, var_18("other_world_task_get"))

	setText = var_14_11

	local var_14_17 = arg_14_2:Find("got_btn/text")

	i18n = var_18

	var_14_11(var_14_17, var_18("other_world_task_got"))

	local var_14_18 = var_14_3:getTaskStatus()

	setActive = var_14_13

	var_14_13(var_14_10, var_14_18 == 0)

	setActive = var_14_13

	var_14_13(var_14_12, var_14_18 == 1)

	setActive = var_14_13

	var_14_13(var_14_14, var_14_18 == 2)

	SetActive = var_14_13

	var_14_13(arg_14_2:Find("tip"), var_14_18 == 1)

	onButton = var_14_13

	local var_14_19 = arg_14_0
	local var_14_20 = var_14_12

	local function var_14_21()
		local var_15_0 = arg_14_0
		local var_15_1 = var_0.emit

		HolidayVillaTasksMediator = var_2_10003

		var_15_1(var_15_0, var_2_10003.ON_TASK_SUBMIT_ONESTEP, arg_14_0.taskActivityId, {
			var_14_3.id
		})

		return
	end

	SFX_PANEL = var_21

	var_14_13(var_14_19, var_14_20, var_14_21, var_21)

	onButton = var_14_13

	local var_14_22 = arg_14_0
	local var_14_23 = var_14_10

	local function var_14_24()
		local var_16_0 = arg_14_0
		local var_16_1 = var_0.emit

		HolidayVillaTasksMediator = var_2_10003

		var_16_1(var_16_0, var_2_10003.ON_TASK_GO, var_14_3)

		return
	end

	SFX_PANEL = var_21

	var_14_13(var_14_22, var_14_23, var_14_24, var_21)

	return
end

function var_0_1.updateAwards(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	_ = var_1_10004

	local var_17_0 = var_1_10004.slice(arg_17_1, 1, 3)

	for iter_17_0 = arg_17_2.childCount, #var_17_0 - 1 do
		cloneTplTo = var_1_10010

		var_1_10010(arg_17_3, arg_17_2)
	end

	local var_17_1 = arg_17_2.childCount

	for iter_17_1 = 1, var_17_1 do
		local var_17_2 = arg_17_2
		local var_17_3 = arg_17_2.GetChild(var_17_2, iter_17_1 - 1)
		local var_17_4 = iter_17_1 <= #var_17_0

		setActive = var_17_2

		var_17_2(var_17_3, var_17_4)

		if var_17_4 then
			local var_17_5 = var_17_0[iter_17_1]
			local var_17_6 = {
				type = var_17_5[1],
				id = var_17_5[2],
				count = var_17_5[3]
			}

			updateDrop = var_14
			findTF = var_1_10016

			var_14(var_1_10016(var_17_3, "mask"), var_17_6)

			onButton = var_14
			var_1_10016 = arg_17_0

			local var_17_7 = var_17_3
			local var_17_8 = var_17_3.Find(var_17_7, "mask")

			local function var_17_9()
				local var_18_0 = arg_17_0
				local var_18_1 = var_0.emit

				BaseUI = var_2_10003

				var_18_1(var_18_0, var_2_10003.ON_ITEM, var_17_6)

				return
			end

			SFX_PANEL = var_17_7

			var_14(var_1_10016, var_17_8, var_17_9, var_17_7)
		end
	end

	return
end

return var_0_1
