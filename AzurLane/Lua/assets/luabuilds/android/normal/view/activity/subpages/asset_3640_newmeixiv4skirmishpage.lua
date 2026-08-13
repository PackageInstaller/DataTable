class = var_0_10000

local var_0_0 = "NewMeixiV4SkirmishPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.battleBtn = var_1.Find(var_1_1, "battle_btn")

	local var_1_2 = arg_1_0.bg

	arg_1_0.progressBar = var_1.Find(var_1_2, "progress/bar")

	local var_1_3 = arg_1_0.bg

	arg_1_0.curNum = var_1.Find(var_1_3, "progress/cur_num")

	local var_1_4 = arg_1_0.bg

	arg_1_0.curSection = var_1.Find(var_1_4, "progress/cur_section")

	local var_1_5 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_5, "scrollview/item")

	local var_1_6 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_6, "scrollview/items")
	UIItemList = var_1
	arg_1_0.uilist = var_1.New(arg_1_0.items, arg_1_0.item)

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	arg_2_0:initTaskData()

	updateActivityTaskStatus = var_1

	return var_1(arg_2_0.activity)
end

function var_0_1.initTaskData(arg_3_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002
	arg_3_0.taskProxy = var_1_10001(var_1_10002)
	pg = var_1

	local var_3_0 = var_1.activity_template

	ActivityConst = var_1_10002
	arg_3_0.taskGroup = var_3_0[var_1_10002.NEWMEIXIV4_SKIRMISH_ID].config_data
	arg_3_0.taskList = {}
	ipairs = var_2

	for iter_3_0, iter_3_1 in var_2(arg_3_0.taskGroup) do
		ipairs = var_1_10007

		for iter_3_2, iter_3_3 in var_1_10007(iter_3_1) do
			table = var_1_10012

			var_1_10012.insert(arg_3_0.taskList, iter_3_3)
		end
	end

	arg_3_0:SetClearNum()
	arg_3_0:SetCurIndex()

	return
end

function var_0_1.SetClearNum(arg_4_0)
	arg_4_0.clearTaskNum = 0
	ipairs = var_1

	for iter_4_0, iter_4_1 in var_1(arg_4_0.taskList) do
		local var_4_0 = arg_4_0.taskProxy
		local var_4_2

		if not var_6.getTaskById(var_4_0, iter_4_1) then
			local var_4_1 = arg_4_0.taskProxy

			var_4_2 = var_6.getFinishTaskById(var_4_1, iter_4_1)
		end

		if var_4_2 then
			arg_4_0.clearTaskNum = iter_4_0 - 1

			return
		end
	end

	return
end

function var_0_1.SetCurIndex(arg_5_0)
	arg_5_0.curTaskIndex = 1
	ipairs = var_1

	for iter_5_0, iter_5_1 in var_1(arg_5_0.taskList) do
		local var_5_0 = arg_5_0.taskProxy
		local var_5_2

		if not var_6.getTaskById(var_5_0, iter_5_1) then
			local var_5_1 = arg_5_0.taskProxy

			var_5_2 = var_6.getFinishTaskById(var_5_1, iter_5_1)
		end

		local var_5_3 = arg_5_0.taskList[iter_5_0 + 1]
		local var_5_4 = arg_5_0.taskProxy
		local var_5_6

		if not var_8.getTaskById(var_5_4, var_5_3) then
			local var_5_5 = arg_5_0.taskProxy

			var_5_6 = var_8.getFinishTaskById(var_5_5, var_5_3)
		end

		if var_5_2 and var_5_2:getTaskStatus() == 2 then
			arg_5_0.curTaskIndex = arg_5_0.curTaskIndex + 1

			if not var_5_3 or not var_5_6 then
				arg_5_0.curTaskIndex = arg_5_0.curTaskIndex - 1
			end
		end
	end

	arg_5_0.curTaskIndex = arg_5_0.curTaskIndex + arg_5_0.clearTaskNum

	return
end

function var_0_1.OnFirstFlush(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.battleBtn

	local function var_6_2()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_7_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_7_1(var_7_0, var_7_2, var_2_10003.NEWMEIXIV4_SKIRMISH, {
			taskList = arg_6_0.taskList
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10005)

	local var_6_3 = arg_6_0.uilist

	var_1.make(var_6_3, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = arg_8_1 + 1
			local var_8_1 = arg_8_2:Find("item")
			local var_8_2 = arg_6_0.taskList[var_8_0]
			local var_8_3 = arg_6_0.taskProxy
			local var_8_4

			if not var_6.getTaskById(var_8_3, var_8_2) then
				var_8_3 = arg_6_0.taskProxy
				var_8_4 = var_6.getFinishTaskById(var_8_3, var_8_2)
			end

			setActive = var_8_3

			var_8_3(arg_8_2:Find("finish"), var_8_4 and var_8_4:getTaskStatus() == 2 or var_8_0 <= arg_6_0.clearTaskNum)

			setActive = var_8_3

			var_8_3(arg_8_2:Find("lock"), false)

			setText = var_8_3

			var_8_3(arg_8_2:Find("title"), "P" .. var_8_0)
		end

		return
	end)

	local var_6_4 = arg_6_0.uilist

	var_1.align(var_6_4, #arg_6_0.taskList)

	return
end

function var_0_1.OnUpdateFlush(arg_9_0)
	arg_9_0:SetCurIndex()

	setText = var_1

	local var_9_0 = arg_9_0.curNum

	string = var_1_10003

	var_1(var_9_0, var_1_10003.format("%02d", arg_9_0.curTaskIndex))

	setText = var_1

	local var_9_1 = arg_9_0.curSection
	local var_9_2 = "POSITION "

	string = var_4

	var_1(var_9_1, var_9_2 .. var_4.format("%02d", arg_9_0.curTaskIndex))

	local var_9_3 = arg_9_0.progressBar
	local var_9_4 = var_1.GetComponent

	typeof = var_3
	Image = var_4
	var_9_4(var_9_3, var_3(var_4)).fillAmount = arg_9_0.curTaskIndex / #arg_9_0.taskList
	arg_9_0.items.anchoredPosition = {
		x = 0,
		y = 55 * (arg_9_0.curTaskIndex - 1)
	}

	return
end

function var_0_1.IsShowRed()
	getProxy = var_1_10000
	TaskProxy = var_1_10001

	local var_10_0 = var_1_10000(var_1_10001)

	pg = var_1_10001

	local var_10_1 = var_1_10001.activity_template

	ActivityConst = var_1_10002

	local var_10_2 = var_10_1[var_1_10002.NEWMEIXIV4_SKIRMISH_ID].config_data
	local var_10_3 = {}

	ipairs = var_1_10004

	for iter_10_0, iter_10_1 in var_1_10004(var_10_2) do
		ipairs = var_1_10009

		for iter_10_2, iter_10_3 in var_1_10009(iter_10_1) do
			table = var_1_10014

			var_1_10014.insert(var_10_3, iter_10_3)
		end
	end

	local function var_10_4()
		ipairs = var_2_10000

		for iter_11_0, iter_11_1 in var_2_10000(var_10_3) do
			local var_11_0 = var_10_0
			local var_11_2

			if not var_5.getTaskById(var_11_0, iter_11_1) then
				local var_11_1 = var_10_0

				var_11_2 = var_5.getFinishTaskById(var_11_1, iter_11_1)
			end

			if var_11_2 then
				return iter_11_0 - 1
			end
		end

		return 0
	end

	local var_10_5 = 1

	ipairs = var_6

	for iter_10_4, iter_10_5 in var_6(var_10_3) do
		local var_10_6

		if not var_10_0:getTaskById(iter_10_5) then
			var_10_6 = var_10_0:getFinishTaskById(iter_10_5)
		end

		local var_10_7 = var_10_3[iter_10_4 + 1]
		local var_10_8

		if not var_10_0:getTaskById(var_10_7) then
			var_10_8 = var_10_0:getFinishTaskById(var_10_7)
		end

		if var_10_6 and var_10_6:getTaskStatus() == 2 then
			var_10_5 = var_10_5 + 1

			if not var_10_7 or not var_10_8 then
				var_10_5 = var_10_5 - 1
			end
		end
	end

	local var_10_9 = var_10_3[var_10_5 + var_10_4()]
	local var_10_10

	if not var_10_0:getTaskById(var_10_9) then
		var_10_10 = var_10_0:getFinishTaskById(var_10_9)
	end

	return var_10_10 and var_10_10:getTaskStatus() == 1
end

return var_0_1
