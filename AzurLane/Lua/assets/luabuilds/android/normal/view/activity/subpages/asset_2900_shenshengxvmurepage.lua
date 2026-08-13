class = var_0_10000

local var_0_0 = "ShenshengxvmuRePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.step = var_1.Find(var_1_1, "step")

	local var_1_2 = arg_1_0.bg

	arg_1_0.progress = var_1.Find(var_1_2, "progress")

	local var_1_3 = arg_1_0.bg

	arg_1_0.displayBtn = var_1.Find(var_1_3, "display_btn")

	local var_1_4 = arg_1_0.bg

	arg_1_0.awardTF = var_1.Find(var_1_4, "award")

	local var_1_5 = arg_1_0.bg

	arg_1_0.battleBtn = var_1.Find(var_1_5, "battle_btn")

	local var_1_6 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_6, "get_btn")

	local var_1_7 = arg_1_0.bg

	arg_1_0.gotBtn = var_1.Find(var_1_7, "got_btn")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	setActive = var_1

	var_1(arg_2_0.displayBtn, false)

	setActive = var_1

	var_1(arg_2_0.awardTF, false)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.battleBtn

	local function var_2_2()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_3_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_3_1(var_3_0, var_3_2, var_2_10003.TASK, {
			page = "activity"
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_0, var_2_1, var_2_2, var_1_10005)

	local var_2_3 = arg_2_0._tf

	arg_2_0.step = var_1.Find(var_2_3, "AD/step")

	local var_2_4 = arg_2_0._tf

	arg_2_0.progress = var_1.Find(var_2_4, "AD/progress")

	local var_2_5 = arg_2_0._tf

	arg_2_0.bar = var_1.Find(var_2_5, "AD/slider/bar")
	pg = var_1

	local var_2_6 = var_1.activity_event_avatarframe
	local var_2_7 = arg_2_0.activity
	local var_2_9, var_2_10

	if var_2_6[var_2.getConfig(var_2_7, "config_id")].start_time == "stop" then
		arg_2_0.inTime = false
	else
		pg = var_2_9

		local var_2_8 = var_2_9.TimeMgr.GetInstance()

		var_2_9 = var_2_9.Table2ServerTime(var_2_8, {
			year = var_1[1][1],
			month = var_1[1][2],
			day = var_1[1][3],
			hour = var_1[2][1],
			min = var_1[2][2],
			sec = var_1[2][3]
		})
		pg = var_2_8
		var_2_10 = var_2_8.TimeMgr.GetInstance()

		local var_2_11 = var_3.GetServerTime(var_2_10) - var_2_9

		arg_2_0.inTime = 0 < var_2_11
	end

	setActive = var_2_9

	local var_2_12 = arg_2_0.battleBtn

	isActive = var_2_10

	local var_2_13

	if var_2_10(arg_2_0.battleBtn) then
		var_2_13 = arg_2_0.inTime
	end

	var_2_9(var_2_12, var_2_13)

	return
end

function var_0_1.Switch(arg_4_0, arg_4_1)
	arg_4_0:UpdateAwardGot()

	onButton = var_2

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.getBtn

	local function var_4_2()
		local var_5_0 = arg_4_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_4_0.activity.id
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_4_0, var_4_1, var_4_2, var_1_10006)

	return
end

function var_0_1.UpdateAwardGot(arg_6_0)
	local var_6_0 = arg_6_0.activity.data2 >= 1
	local var_6_1 = arg_6_0._tf
	local var_6_2 = var_2.Find(var_6_1, "AD/got")

	setActive = var_6_1

	var_6_1(var_6_2, var_6_0)

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	local var_7_0 = arg_7_0.activity

	setActive = var_1_10002

	local var_7_1 = arg_7_0.battleBtn

	isActive = var_1_10004

	local var_7_2

	if var_1_10004(arg_7_0.battleBtn) then
		var_7_2 = arg_7_0.inTime
	end

	var_1_10002(var_7_1, var_7_2)

	local var_7_3 = arg_7_0

	arg_7_0.UpdateAwardGot(var_7_3)

	local var_7_4 = arg_7_0.activity.data1

	pg = var_7_3

	local var_7_5 = var_7_3.activity_event_avatarframe
	local var_7_6 = arg_7_0.activity

	if var_7_5[var_4.getConfig(var_7_6, "config_id")].target < var_7_4 then
		var_7_4 = var_3
	end

	local var_7_7 = var_7_4 / var_3

	setText = var_7_6

	local var_7_8 = arg_7_0.step

	if 1 <= var_7_7 then
		setColorStr = var_7

		local var_7_9

		if not var_7(var_7_4, "#487CFFFF") then
			var_7_9 = var_7_4
		end

		var_7_6(var_7_8, var_7_9)

		setText = var_7_6

		var_7_6(arg_7_0.progress, "/" .. var_3)

		setFillAmount = var_7_6

		var_7_6(arg_7_0.bar, var_7_4 / var_3)

		local var_7_10 = var_3 <= var_7_4
		local var_7_11 = arg_7_0.activity.data2
		local var_7_12 = 1 <= var_7_11

		setActive = var_7

		var_7(arg_7_0.battleBtn, not var_7_12 and not var_7_10 and arg_7_0.inTime)

		setActive = var_7

		var_7(arg_7_0.getBtn, var_7_10 and not var_7_12)

		setActive = var_7

		var_7(arg_7_0.gotBtn, var_7_12)

		return
	end
end

return var_0_1
