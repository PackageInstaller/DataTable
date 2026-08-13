class = var_0_10000

local var_0_0 = "SkinGuide3Page"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))
local var_0_2 = "ui/activityuipage/skinguide3page_atlas"
local var_0_3 = {
	{
		50,
		-50
	},
	{
		426,
		-50
	},
	{
		794,
		-50
	}
}

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.countTF = var_1.Find(var_1_1, "count")

	local var_1_2 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_2, "item")

	local var_1_3 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_3, "items")
	UIItemList = var_1
	arg_1_0.itemList = var_1.New(arg_1_0.items, arg_1_0.item)

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003
	arg_2_0.taskProxy = var_1_10001(var_1_10003)

	local var_2_0 = arg_2_0.activity

	arg_2_0.taskList = var_1.getConfig(var_2_0, "config_data")
	arg_2_0.totalCnt = #arg_2_0.taskList

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	local var_3_0 = arg_3_0.activity

	arg_3_0.usedCnt = var_1.getData1(var_3_0)
	pg = var_1

	local var_3_1 = var_1.TimeMgr.GetInstance()
	local var_3_2 = var_1.DiffDay
	local var_3_3 = arg_3_0.activity
	local var_3_4 = var_4.getStartTime(var_3_3)

	pg = var_1_10005

	local var_3_5 = var_1_10005.TimeMgr.GetInstance()

	arg_3_0.unlockCnt = var_3_2(var_3_1, var_3_4, var_5.GetServerTime(var_3_5)) + 1

	local var_3_6

	if not (arg_3_0.unlockCnt > arg_3_0.totalCnt) or not arg_3_0.totalCnt then
		var_3_6 = arg_3_0.unlockCnt
	end

	arg_3_0.unlockCnt = var_3_6
	arg_3_0.remainCnt = arg_3_0.usedCnt >= arg_3_0.totalCnt and 0 or arg_3_0.unlockCnt - arg_3_0.usedCnt
	setActive = var_1

	var_1(arg_3_0.item, false)

	local var_3_7 = arg_3_0.itemList

	var_1.make(var_3_7, function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		local var_4_0 = arg_3_0.taskList[arg_4_1]
		local var_4_1 = arg_3_0.taskProxy
		local var_4_2

		if not var_4.getTaskById(var_4_1, var_4_0) then
			var_4_1 = arg_3_0.taskProxy
			var_4_2 = var_4.getFinishTaskById(var_4_1, var_4_0)
		end

		assert = var_2_10005

		var_2_10005(var_4_2, "without this task by id: " .. var_4_0)

		UIItemList = var_2_10005

		local var_4_3

		if arg_4_0 == var_2_10005.EventInit then
			var_4_3 = arg_4_2:Find("item")
			Vector2 = var_4_1
			arg_4_2.anchoredPosition = var_4_1(var_0_3[arg_4_1][1], var_0_3[arg_4_1][2])

			local var_4_4 = var_4_2:getConfig("award_display")[1]
			local var_4_5 = {
				type = var_4_4[1],
				id = var_4_4[2],
				count = var_4_4[3]
			}

			updateDrop = var_8

			var_8(var_4_3, var_4_5)

			onButton = var_8

			local var_4_6 = arg_3_0
			local var_4_7 = arg_4_2

			local function var_4_8()
				local var_5_0 = arg_3_0
				local var_5_1 = var_0.emit

				BaseUI = var_3_10003

				var_5_1(var_5_0, var_3_10003.ON_DROP, var_4_5)

				return
			end

			SFX_PANEL = var_2_10013

			var_8(var_4_6, var_4_7, var_4_8, var_2_10013)
		else
			UIItemList = var_4_3

			if arg_4_0 == var_4_3.EventUpdate then
				local var_4_9 = var_4_2:getTaskStatus()
				local var_4_10 = arg_4_2
				local var_4_11 = arg_4_2.Find(var_4_10, "got")
				local var_4_12 = arg_4_2:Find("get")

				setActive = var_4_10

				var_4_10(var_4_12, var_4_9 == 1 and arg_3_0.remainCnt > 0)

				setActive = var_4_10

				var_4_10(var_4_11, var_4_9 == 2)

				onButton = var_4_10

				local var_4_13 = arg_3_0
				local var_4_14 = var_4_12

				local function var_4_15()
					local var_6_0 = arg_3_0
					local var_6_1 = var_0.emit

					ActivityMediator = var_3_10003

					var_6_1(var_6_0, var_3_10003.ON_TASK_SUBMIT, var_4_2)

					return
				end

				SFX_PANEL = var_2_10013

				var_4_10(var_4_13, var_4_14, var_4_15, var_2_10013)
			end
		end

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	local var_7_0 = 0

	ipairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(arg_7_0.taskList) do
		var_1_10009 = arg_7_0.taskProxy

		if var_7.getFinishTaskById(var_1_10009, iter_7_1) ~= nil then
			var_7_0 = var_7_0 + 1
		end
	end

	local var_7_1

	if arg_7_0.usedCnt ~= var_7_0 then
		arg_7_0.usedCnt = var_7_0
		var_7_1 = arg_7_0.activity
		var_7_1.data1 = arg_7_0.usedCnt
		getProxy = var_3
		ActivityProxy = iter_7_0

		local var_7_2 = var_3(iter_7_0)

		var_3.updateActivity(var_7_2, var_7_1)
	end

	pg = var_7_1

	local var_7_3 = var_7_1.TimeMgr.GetInstance()
	local var_7_4 = var_2.DiffDay
	local var_7_5 = arg_7_0.activity
	local var_7_6 = var_5.getStartTime(var_7_5)

	pg = iter_7_1

	local var_7_7 = iter_7_1.TimeMgr.GetInstance()
	local var_7_8 = var_7_4(var_7_3, var_7_6, var_6.GetServerTime(var_7_7)) + 1
	local var_7_9 = arg_7_0.activity

	arg_7_0.unlockCnt = var_7_8 * var_3.getConfig(var_7_9, "config_id")

	local var_7_10

	if not (arg_7_0.unlockCnt > arg_7_0.totalCnt) or not arg_7_0.totalCnt then
		var_7_10 = arg_7_0.unlockCnt
	end

	arg_7_0.unlockCnt = var_7_10

	local var_7_11 = arg_7_0.usedCnt

	arg_7_0.remainCnt = arg_7_0.totalCnt <= var_7_11 and 0 or arg_7_0.unlockCnt - arg_7_0.usedCnt
	setText = var_2

	local var_7_12 = arg_7_0.countTF

	string = var_7_9

	var_2(var_7_12, var_7_9.format("%02d", arg_7_0.remainCnt))

	local var_7_13 = arg_7_0.activity
	local var_7_14 = var_2.getConfig(var_7_13, "config_client").story

	ipairs = var_3

	for iter_7_2, iter_7_3 in var_3(arg_7_0.taskList) do
		local var_7_15 = arg_7_0.taskProxy

		if var_8.getFinishTaskById(var_7_15, iter_7_3) then
			checkExist = var_1_10009

			if var_1_10009(var_7_14, {
				iter_7_2
			}, {
				1
			}) then
				pg = var_1_10009

				local var_7_16 = var_1_10009.NewStoryMgr.GetInstance()

				var_1_10009.Play(var_7_16, var_7_14[iter_7_2][1])
			end
		end
	end

	local var_7_17 = arg_7_0.itemList

	var_3.align(var_7_17, #arg_7_0.taskList)

	return
end

function var_0_1.OnShowFlush(arg_8_0)
	local var_8_0 = arg_8_0.itemList

	var_1.each(var_8_0, function(arg_9_0, arg_9_1)
		setActive = var_2_10002

		var_2_10002(arg_9_1, true)

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_10_0)
	return
end

return var_0_1
