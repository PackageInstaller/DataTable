class = var_0_10000

local var_0_0 = "AirForceActivityPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.btnBattle = var_1.Find(var_1_1, "battle_btn")

	local var_1_2 = arg_1_0.bg

	arg_1_0.iconAward = var_1.Find(var_1_2, "award")

	local var_1_3 = arg_1_0.bg

	arg_1_0.iconGot = var_1.Find(var_1_3, "got_btn")

	local var_1_4 = arg_1_0.bg

	arg_1_0.textStep = var_1.Find(var_1_4, "step")

	local var_1_5 = arg_1_0.bg

	arg_1_0.textCount = var_1.Find(var_1_5, "count")

	local var_1_6 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_6, "items")

	local var_1_7 = arg_1_0._tf

	arg_1_0.blur = var_1.Find(var_1_7, "Blur")

	local var_1_8 = arg_1_0.blur

	arg_1_0.window = var_1.Find(var_1_8, "window")

	local var_1_9 = arg_1_0.window

	arg_1_0.textTitle = var_1.Find(var_1_9, "title")

	local var_1_10 = arg_1_0.window

	arg_1_0.textContent = var_1.Find(var_1_10, "content")
	setActive = var_1

	var_1(arg_1_0.blur, false)

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)
	local var_2_1 = var_1.getActivityById
	local var_2_2 = arg_2_0.activity

	arg_2_0.linkActivity = var_2_1(var_2_0, var_3.getConfig(var_2_2, "config_client").linkActID)

	local var_2_3 = arg_2_0.linkActivity

	arg_2_0.taskIds = var_1.getConfig(var_2_3, "config_data")
	_ = var_1

	local var_2_4 = var_1.map(arg_2_0.taskIds, function(arg_3_0)
		getProxy = var_2_10001
		TaskProxy = var_2_10002

		local var_3_0 = var_2_10001(var_2_10002)
		local var_3_1

		if not var_1.getTaskVO(var_3_0, arg_3_0) then
			Task = var_3_1
			var_3_1 = var_3_1.New({
				id = arg_3_0
			})
		end

		return var_3_1
	end)

	_ = var_2
	arg_2_0.summaryTask = var_2.detect(var_2_4, function(arg_4_0)
		return arg_4_0:getConfig("sub_type") == 90
	end)
	_ = var_2
	arg_2_0.subTasks = var_2.select(var_2_4, function(arg_5_0)
		return arg_5_0:getConfig("sub_type") ~= 90
	end)

	return
end

function var_0_1.TrySubmitTask(arg_6_0)
	if not arg_6_0.summaryTask then
		return
	end

	local var_6_0 = arg_6_0.summaryTask

	if var_1.isFinish(var_6_0) then
		local var_6_1 = arg_6_0.summaryTask

		if not var_1.isReceive(var_6_1) then
			pg = var_1

			local var_6_2 = var_1.m02
			local var_6_3 = var_1.sendNotification

			GAME = var_1_10003

			var_6_3(var_6_2, var_1_10003.SUBMIT_TASK, arg_6_0.summaryTask.id)

			return true
		end
	end

	return
end

function var_0_1.OnFirstFlush(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.btnBattle

	local function var_7_2()
		local var_8_0 = arg_7_0
		local var_8_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_8_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_8_1(var_8_0, var_8_2, var_2_10003.AIRFORCE_DRAGONEMPERY)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10005)

	onButton = var_1_10001

	var_1_10001(arg_7_0, arg_7_0.blur, function()
		local var_9_0 = arg_7_0

		var_0.CloseWindow(var_9_0)

		local var_9_1 = arg_7_0

		var_0.TrySubmitTask(var_9_1)

		return
	end)

	for iter_7_0 = 1, #arg_7_0.subTasks do
		onButton = var_1_10005

		local var_7_3 = arg_7_0
		local var_7_4 = arg_7_0.items

		var_1_10007 = var_1_10007.GetChild(var_7_4, iter_7_0 - 1)

		local function var_7_5()
			local var_10_0 = arg_7_0.subTasks[iter_7_0]

			if not var_0.isReceive(var_10_0) then
				pg = var_10_0

				local var_10_1 = var_10_0.m02

				var_10_0 = var_10_0.sendNotification
				GAME = var_2_10004

				var_10_0(var_10_1, var_2_10004.SUBMIT_TASK, var_0.id)
			end

			setText = var_10_0

			local var_10_2 = arg_7_0.textTitle

			i18n = var_2_10004

			var_10_0(var_10_2, var_2_10004("airforce_title_" .. iter_7_0))

			setText = var_10_0

			local var_10_3 = arg_7_0.textContent

			i18n = var_4

			var_10_0(var_10_3, var_4("airforce_desc_" .. iter_7_0))

			pg = var_10_0

			local var_10_4 = var_10_0.UIMgr.GetInstance()

			var_2.OverlayPanel(var_10_4, arg_7_0.blur, {
				pbList = {
					arg_7_0.blur
				}
			})

			setActive = var_2

			var_2(arg_7_0.blur, true)

			return
		end

		SFX_PANEL = var_9

		var_1_10005(var_7_3, var_1_10007, var_7_5, var_9)
	end

	local var_7_6 = arg_7_0.summaryTask
	local var_7_7 = var_1.getConfig(var_7_6, "award_display")[1]

	Drop = var_7_6

	local var_7_8 = var_7_6.New({
		type = var_7_7[1],
		id = var_7_7[2],
		count = var_7_7[3]
	})

	updateDrop = var_3

	var_3(arg_7_0.iconAward, var_7_8)

	onButton = var_3

	local var_7_9 = arg_7_0
	local var_7_10 = arg_7_0.iconAward

	local function var_7_11()
		local var_11_0 = arg_7_0
		local var_11_1 = var_0.emit

		BaseUI = var_2_10002

		var_11_1(var_11_0, var_2_10002.ON_DROP, var_7_8)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_7_9, var_7_10, var_7_11, var_1_10007)
	arg_7_0:TrySubmitTask()

	return
end

function var_0_1.OnUpdateFlush(arg_12_0)
	local var_12_0 = arg_12_0.subTasks
	local var_12_1 = 0

	for iter_12_0 = 1, #var_12_0 do
		local var_12_2 = var_12_0[iter_12_0]
		local var_12_3 = var_7.isReceive(var_12_2)

		setActive = var_12_2

		local var_12_4 = arg_12_0.items
		local var_12_5 = var_9.GetChild(var_12_4, iter_12_0 - 1)

		var_12_2(var_9.Find(var_12_5, "viewed"), var_12_3)

		if var_12_3 then
			var_12_1 = var_12_1 + 1
		end
	end

	setText = var_3

	var_3(arg_12_0.textStep, var_12_1 .. "/" .. #var_12_0)

	setText = var_3

	var_3(arg_12_0.textCount, arg_12_0:GetFightCount())

	setActive = var_3

	local var_12_6 = arg_12_0.iconGot
	local var_12_7 = arg_12_0.summaryTask

	var_3(var_12_6, var_5.isReceive(var_12_7))

	setActive = var_3

	local var_12_8 = arg_12_0.btnBattle
	local var_12_9 = var_4.Find(var_12_8, "tip")
	local var_12_10 = arg_12_0.activity

	var_3(var_12_9, var_5.readyToAchieve(var_12_10))

	return
end

function var_0_1.GetFightCount(arg_13_0)
	local var_13_0 = arg_13_0.activity
	local var_13_1 = var_1.GetMaxProgress(var_13_0)
	local var_13_2 = var_1:GetPerDayCount()
	local var_13_3 = 0
	local var_13_4 = var_1:GetLevelCount()

	for iter_13_0 = 1, var_13_4 do
		local var_13_5

		if not var_1:getKVPList(1, iter_13_0) then
			var_13_5 = 0
		end

		var_13_3 = var_13_3 + var_13_5
	end

	pg = var_6

	local var_13_6 = var_6.TimeMgr.GetInstance()
	local var_13_7 = var_6.DiffDay(var_13_6, var_1.data1, var_6:GetServerTime()) + 1

	math = var_13_6

	return var_13_6.min(var_13_7 * var_13_2, var_13_1) - var_13_3
end

function var_0_1.CloseWindow(arg_14_0)
	setActive = var_1_10001

	var_1_10001(arg_14_0.blur, false)

	pg = var_1_10001

	local var_14_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_14_0, arg_14_0.blur, arg_14_0._tf)

	return
end

function var_0_1.ShowOrHide(arg_15_0, arg_15_1)
	if not arg_15_1 then
		isActive = var_1_10002

		if var_1_10002(arg_15_0.blur) then
			arg_15_0:CloseWindow()
		end
	end

	var_0_1.super.ShowOrHide(arg_15_0, arg_15_1)

	return
end

function var_0_1.OnDestroy(arg_16_0)
	isActive = var_1_10001

	if var_1_10001(arg_16_0.blur) then
		arg_16_0:CloseWindow()
	end

	var_0_1.super.OnDestroy(arg_16_0)

	return
end

return var_0_1
