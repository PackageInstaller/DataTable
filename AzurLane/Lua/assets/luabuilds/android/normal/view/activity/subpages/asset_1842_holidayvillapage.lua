class = var_0_10000

local var_0_0 = "HolidayVillaPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.signTF = var_1.Find(var_1_1, "sign")

	local var_1_2 = arg_1_0.signTF

	arg_1_0.getBtn = var_1.Find(var_1_2, "get")

	local var_1_3 = arg_1_0.signTF

	arg_1_0.got = var_1.Find(var_1_3, "got")

	local var_1_4 = arg_1_0.signTF

	arg_1_0.getBtn_tip = var_1.Find(var_1_4, "get/tip")

	local var_1_5 = arg_1_0.signTF

	arg_1_0.countbg = var_1.Find(var_1_5, "count_bg")

	local var_1_6 = arg_1_0.signTF

	arg_1_0.countText = var_1.Find(var_1_6, "count_bg/count")

	local var_1_7 = arg_1_0.signTF

	arg_1_0.go = var_1.Find(var_1_7, "go_btn")

	local var_1_8 = arg_1_0.signTF

	arg_1_0.Notbtn = var_1.Find(var_1_8, "Not_unlocked")

	local var_1_9 = {}
	local var_1_10 = arg_1_0.signTF

	var_1_9[1] = var_2.Find(var_1_10, "list/unfinished_1")

	local var_1_11 = arg_1_0.signTF

	var_1_9[2] = var_2.Find(var_1_11, "list/unfinished_2")

	local var_1_12 = arg_1_0.signTF

	var_1_9[3] = var_2.Find(var_1_12, "list/unfinished_3")

	local var_1_13 = arg_1_0.signTF

	var_1_9[4] = var_2.Find(var_1_13, "list/unfinished_4")

	local var_1_14 = arg_1_0.signTF

	var_1_9[5] = var_2.Find(var_1_14, "list/unfinished_5")
	arg_1_0.list = var_1_9
	setActive = var_1_9

	var_1_9(arg_1_0.go, false)

	setActive = var_1_9

	var_1_9(arg_1_0.Notbtn, false)

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	arg_2_0.nday = 0
	getProxy = var_1
	TaskProxy = var_1_10002
	arg_2_0.taskProxy = var_1(var_1_10002)
	underscore = var_1

	local var_2_0 = var_1.flatten
	local var_2_1 = arg_2_0.activity

	arg_2_0.taskGroup = var_2_0(var_2.getConfig(var_2_1, "config_data"))

	local var_2_2 = arg_2_0.activity

	arg_2_0.preStory = var_1.getConfig(var_2_2, "config_client").preStory
	updateActivityTaskStatus = var_1

	return var_1(arg_2_0.activity)
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.getBtn

	local function var_3_2()
		if not arg_3_0.remainCnt or arg_3_0.remainCnt <= 0 then
			return
		end

		seriesAsync = var_0

		var_0({
			function(arg_5_0)
				local var_5_0 = arg_3_0.activity
				local var_5_1 = var_1.getConfig(var_5_0, "config_client").story

				checkExist = var_5_0

				if var_5_0(var_5_1, {
					arg_3_0.nday
				}, {
					1
				}) then
					pg = var_2

					local var_5_2 = var_2.NewStoryMgr.GetInstance()

					var_2.Play(var_5_2, var_5_1[arg_3_0.nday][1], arg_5_0)
				else
					arg_5_0()
				end

				return
			end,
			function(arg_6_0)
				local var_6_0 = arg_3_0.curTaskVO

				if var_1.getTaskStatus(var_6_0) == 1 then
					local var_6_1 = arg_3_0
					local var_6_2 = var_1.emit

					ActivityMediator = var_3_10003

					var_6_2(var_6_1, var_3_10003.ON_TASK_SUBMIT, arg_3_0.curTaskVO, arg_6_0)
				else
					arg_6_0()
				end

				return
			end
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.go

	local function var_3_5()
		local var_7_0 = arg_3_0

		if var_0.IsLockLiner(var_7_0) then
			return
		end

		local var_7_1 = arg_3_0
		local var_7_2 = var_0.emit

		ActivityMediator = var_2_10002

		local var_7_3 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_7_2(var_7_1, var_7_3, var_2_10003.HOLIDAY_VILLA_MAP)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	return
end

function var_0_1.OnUpdateFlush(arg_8_0)
	arg_8_0.nday = arg_8_0.activity.data3

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.IsFinishSign(var_8_0)

	setActive = var_8_0

	var_8_0(arg_8_0.got, false)

	setActive = var_8_0

	var_8_0(arg_8_0.go, not arg_8_0:IsLockLiner() and var_8_1)

	setActive = var_8_0

	var_8_0(arg_8_0.Notbtn, arg_8_0:IsLockLiner())

	if not var_8_1 then
		setActive = var_8_0

		var_8_0(arg_8_0.Notbtn, false)

		var_8_0 = arg_8_0.taskGroup[arg_8_0.nday]

		local var_8_2 = arg_8_0.taskProxy
		local var_8_4

		if not var_3.getTaskById(var_8_2, var_8_0) then
			local var_8_3 = arg_8_0.taskProxy

			var_8_4 = var_3.getFinishTaskById(var_8_3, var_8_0)
		end

		arg_8_0.curTaskVO = var_8_4
		math = var_8_4

		local var_8_5 = var_8_4.min
		local var_8_6 = arg_8_0.activity

		arg_8_0.remainCnt = var_8_5(var_4.getDayIndex(var_8_6), #arg_8_0.taskGroup) - arg_8_0.nday

		local var_8_7 = arg_8_0.curTaskVO

		if var_4.getTaskStatus(var_8_7) == 1 then
			arg_8_0.remainCnt = arg_8_0.remainCnt + 1
		end

		warning = var_4

		var_4("self.remainCnt   :", arg_8_0.remainCnt)

		setActive = var_4

		local var_8_8 = arg_8_0.getBtn_tip
		local var_8_9 = arg_8_0.remainCnt

		var_4(var_8_8, 0 < var_8_9)

		setActive = var_4

		local var_8_10 = arg_8_0.getBtn
		local var_8_11 = arg_8_0.remainCnt

		var_4(var_8_10, 0 < var_8_11)

		setActive = var_4

		var_4(arg_8_0.got, arg_8_0.remainCnt == 0)

		setActive = var_4

		var_4(arg_8_0.countbg, true)

		setText = var_4

		local var_8_12 = arg_8_0.countText

		i18n = var_6

		var_4(var_8_12, var_6("liner_sign_cnt_tip") .. arg_8_0.remainCnt)
	else
		setActive = var_8_0

		var_8_0(arg_8_0.countbg, false)

		setActive = var_8_0

		var_8_0(arg_8_0.getBtn, false)
	end

	ipairs = var_8_0

	for iter_8_0, iter_8_1 in var_8_0(arg_8_0.list) do
		setActive = var_1_10007

		local var_8_13 = arg_8_0.list[iter_8_0]

		var_1_10007(var_8.Find(var_8_13, "accomplish"), var_8_1 or iter_8_0 < arg_8_0.nday)

		setImageAlpha = var_1_10007

		var_1_10007(iter_8_1, (var_8_1 or iter_8_0 < arg_8_0.nday) and 0 or 1)

		setActive = var_1_10007

		local var_8_14 = arg_8_0.list[iter_8_0]

		var_1_10007(var_8.Find(var_8_14, "Check_point"), not var_8_1 and iter_8_0 == arg_8_0.nday)
	end

	return
end

function var_0_1.IsFinishSign(arg_9_0)
	local var_9_0 = arg_9_0.taskGroup[#arg_9_0.taskGroup]
	local var_9_1 = arg_9_0.taskProxy
	local var_9_3

	if not var_2.getTaskById(var_9_1, var_9_0) then
		local var_9_2 = arg_9_0.taskProxy

		var_9_3 = var_2.getFinishTaskById(var_9_2, var_9_0)
	end

	return var_9_3 and var_9_3:getTaskStatus() == 2
end

function var_0_1.IsLockLiner(arg_10_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_10_0 = var_1_10001(var_1_10002)
	local var_10_1 = var_1.getActivityById

	ActivityConst = var_1_10003

	return not var_10_1(var_10_0, var_1_10003.HOLIDAY_ACT_ID) or var_1:isEnd()
end

return var_0_1
