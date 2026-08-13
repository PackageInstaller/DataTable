class = var_0_10000

local var_0_0 = "SaDingFrameRePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.battleBtn = var_1.Find(var_1_1, "battle_btn")

	local var_1_2 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_2, "get_btn")

	local var_1_3 = arg_1_0.bg

	arg_1_0.gotBtn = var_1.Find(var_1_3, "got_btn")
	GetComponent = var_1

	local var_1_4 = arg_1_0._tf
	local var_1_5 = var_2.Find(var_1_4, "AD/switcher/phase2/barContent")

	typeof = var_1_4
	Slider = var_4
	arg_1_0.bar = var_1(var_1_5, var_1_4(var_4))

	local var_1_6 = arg_1_0._tf

	arg_1_0.cur = var_1.Find(var_1_6, "AD/switcher/phase2/progress/step")

	local var_1_7 = arg_1_0._tf

	arg_1_0.target = var_1.Find(var_1_7, "AD/switcher/phase2/progress/all")

	local var_1_8 = arg_1_0._tf

	arg_1_0.getTag = var_1.Find(var_1_8, "AD/switcher/phase2/get")

	local var_1_9 = arg_1_0._tf

	arg_1_0.gotTag = var_1.Find(var_1_9, "AD/switcher/phase2/got")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.activity_event_avatarframe
	local var_2_1 = arg_2_0.activity

	arg_2_0.avatarConfig = var_2_0[var_2.getConfig(var_2_1, "config_id")]

	if arg_2_0.avatarConfig.start_time == "stop" then
		arg_2_0.timeStamp = nil
	else
		pg = var_2

		local var_2_2 = var_2.TimeMgr.GetInstance()

		arg_2_0.timeStamp = var_2.parseTimeFromConfig(var_2_2, var_1)
	end

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.battleBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_4_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_4_1(var_4_0, var_4_2, var_2_10003.TASK)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.getBtn

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_3_0.activity.id
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	local var_3_7

	if arg_3_0.timeStamp then
		pg = var_3_7

		local var_3_6 = var_3_7.TimeMgr.GetInstance()

		var_3_7 = var_3_7.GetServerTime(var_3_6) - arg_3_0.timeStamp > 0
	end

	arg_3_0.inPhase2 = var_3_7

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	local var_6_0 = arg_6_0.activity.data1

	var_6_0 = arg_6_0.avatarConfig.target < var_6_0 and var_2 or var_6_0

	local var_6_1 = var_6_0 / var_2

	setText = var_1_10004

	local var_6_2 = arg_6_0.cur

	if 1 <= var_6_1 then
		setColorStr = var_6

		local var_6_3 = var_6_0

		COLOR_GREEN = var_1_10008

		local var_6_4

		if not var_6(var_6_3, var_1_10008) then
			var_6_4 = var_6_0
		end

		var_1_10004(var_6_2, var_6_4)

		setText = var_1_10004

		var_1_10004(arg_6_0.target, "/" .. var_2)

		setSlider = var_1_10004

		var_1_10004(arg_6_0.bar, 0, var_2, var_6_0)

		local var_6_5 = var_2 <= var_6_0
		local var_6_6 = arg_6_0.activity.data2
		local var_6_7 = 1 <= var_6_6

		setActive = var_6

		local var_6_8 = arg_6_0.battleBtn
		local var_6_9

		if arg_6_0.inPhase2 then
			var_6_9 = not var_6_5
		end

		var_6(var_6_8, var_6_9)

		setActive = var_6

		local var_6_10 = arg_6_0.getBtn
		local var_6_11

		if arg_6_0.inPhase2 then
			var_6_11 = not var_6_7 and var_6_5
		end

		var_6(var_6_10, var_6_11)

		setActive = var_6

		local var_6_12 = arg_6_0.gotBtn
		local var_6_13

		if arg_6_0.inPhase2 then
			var_6_13 = var_6_7
		end

		var_6(var_6_12, var_6_13)

		setActive = var_6

		local var_6_14 = arg_6_0.getTag
		local var_6_15

		if arg_6_0.inPhase2 then
			var_6_15 = not var_6_7 and var_6_5
		end

		var_6(var_6_14, var_6_15)

		setActive = var_6

		local var_6_16 = arg_6_0.gotTag
		local var_6_17

		if arg_6_0.inPhase2 then
			var_6_17 = var_6_7
		end

		var_6(var_6_16, var_6_17)

		setActive = var_6

		local var_6_18 = arg_6_0._tf

		var_6(var_7.Find(var_6_18, "AD/switcher/phase2/progress"), not var_6_7)

		return
	end
end

return var_0_1
