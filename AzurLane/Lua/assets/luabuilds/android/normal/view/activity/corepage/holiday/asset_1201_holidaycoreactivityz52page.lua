class = var_0_10000

local var_0_0 = "HolidayCoreActivityZ52Page"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.progTF = var_1.Find(var_1_0, "bg/prog")

	local var_1_1 = arg_1_0._tf

	arg_1_0.btnLock = var_1.Find(var_1_1, "bg/btnLock")

	local var_1_2 = arg_1_0.btnLock

	arg_1_0.lock = var_1.Find(var_1_2, "lock")

	local var_1_3 = arg_1_0._tf

	arg_1_0.btnGo = var_1.Find(var_1_3, "bg/btnGo")

	local var_1_4 = arg_1_0._tf

	arg_1_0.btnSign = var_1.Find(var_1_4, "bg/btnSign")

	local var_1_5 = arg_1_0.btnSign

	arg_1_0.tipSign = var_1.Find(var_1_5, "tip")

	local var_1_6 = arg_1_0.btnSign

	arg_1_0.remainTimes = var_1.Find(var_1_6, "remainTimes")
	arg_1_0.prog = {}

	for iter_1_0 = 1, arg_1_0.progTF.childCount do
		local var_1_7 = arg_1_0.prog
		local var_1_8 = arg_1_0
		local var_1_9 = arg_1_0.createProg
		local var_1_10 = arg_1_0.progTF

		var_1_7[iter_1_0] = var_1_9(var_1_8, var_8.Find(var_1_10, "prog_" .. iter_1_0))
	end

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	arg_2_0.curDay = 0
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
	local var_3_1 = arg_3_0.btnSign

	local function var_3_2()
		if not arg_3_0.enableSign then
			return
		end

		seriesAsync = var_0

		var_0({
			function(arg_5_0)
				local var_5_0 = arg_3_0.activity
				local var_5_1 = var_1.getConfig(var_5_0, "config_client").story

				checkExist = var_5_0

				if var_5_0(var_5_1, {
					arg_3_0.curDay
				}, {
					1
				}) then
					pg = var_2

					local var_5_2 = var_2.NewStoryMgr.GetInstance()

					var_2.Play(var_5_2, var_5_1[arg_3_0.curDay][1], arg_5_0)
				else
					arg_5_0()
				end

				return
			end,
			function(arg_6_0)
				if arg_3_0.curTaskVO then
					local var_6_0 = arg_3_0.curTaskVO

					if var_1.getTaskStatus(var_6_0) == 1 then
						local var_6_1 = arg_3_0
						local var_6_2 = var_1.emit

						ActivityMediator = var_3_10003

						var_6_2(var_6_1, var_3_10003.ON_TASK_SUBMIT, arg_3_0.curTaskVO, arg_6_0)

						goto label_6_0
					end
				end

				arg_6_0()

				::label_6_0::

				return
			end
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.btnGo

	local function var_3_5()
		local var_7_0 = arg_3_0

		if var_0.isTargetLocking(var_7_0) then
			return
		end

		pg = var_0

		local var_7_1 = var_0.m02
		local var_7_2 = var_0.sendNotification

		GAME = var_2_10002

		local var_7_3 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_7_2(var_7_1, var_7_3, var_2_10003.MALL_MAP)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	setText = var_1_10001

	local var_3_6 = arg_3_0.lock

	i18n = var_3_4

	var_1_10001(var_3_6, var_3_4("20260514_story_unlock_tip"))

	return
end

function var_0_1.OnUpdateFlush(arg_8_0)
	arg_8_0.curDay = arg_8_0.activity.data3
	arg_8_0.enableSign = false

	local var_8_0 = arg_8_0:isAllSigned()
	local var_8_1 = arg_8_0
	local var_8_2 = arg_8_0.isTargetLocking(var_8_1)

	setActive = var_8_1

	var_8_1(arg_8_0.btnSign, not var_8_0)

	setActive = var_8_1

	var_8_1(arg_8_0.btnLock, var_8_2 and var_8_0)

	setActive = var_8_1

	var_8_1(arg_8_0.btnGo, not var_8_2 and var_8_0)

	if not var_8_0 then
		local var_8_3 = arg_8_0.taskGroup[arg_8_0.curDay]

		math = var_4

		local var_8_4 = var_4.min
		local var_8_5 = arg_8_0.activity
		local var_8_6 = var_8_4(var_5.getDayIndex(var_8_5), #arg_8_0.taskGroup)
		local var_8_7 = arg_8_0.taskProxy
		local var_8_9

		if not var_5.getTaskById(var_8_7, var_8_3) then
			local var_8_8 = arg_8_0.taskProxy

			var_8_9 = var_5.getFinishTaskById(var_8_8, var_8_3)
		end

		arg_8_0.curTaskVO = var_8_9
		math = var_8_9
		arg_8_0.remain = var_8_9.max(var_8_6 - arg_8_0.curDay, 0)

		local var_8_10 = arg_8_0.curTaskVO

		if var_5.getTaskStatus(var_8_10) == 1 then
			arg_8_0.remain = arg_8_0.remain + 1
		end

		arg_8_0.enableSign = arg_8_0.remain > 0
		setText = var_5

		var_5(arg_8_0.remainTimes, arg_8_0.remain)
	end

	local var_8_11

	if not arg_8_0.enableSign or not (arg_8_0.curDay - 1) then
		var_8_11 = arg_8_0.curDay
	end

	for iter_8_0 = 1, var_8_11 do
		local var_8_12 = arg_8_0.prog[iter_8_0]

		setActive = var_1_10009

		var_1_10009(var_8_12.signed, iter_8_0 <= var_8_11)

		setActive = var_1_10009

		var_1_10009(var_8_12.current, iter_8_0 == var_8_11 and not var_8_0)
	end

	setActive = var_4

	var_4(arg_8_0.tipSign, arg_8_0.enableSign)

	setGray = var_4

	var_4(arg_8_0.btnSign, not arg_8_0.enableSign, true)

	return
end

function var_0_1.createProg(arg_9_0, arg_9_1)
	local var_9_0 = {
		current = arg_9_1:Find("current"),
		signed = arg_9_1:Find("signed")
	}

	setActive = var_3

	var_3(var_9_0.current, false)

	setActive = var_3

	var_3(var_9_0.signed, false)

	return var_9_0
end

function var_0_1.getTargetID(arg_10_0)
	return 50619
end

function var_0_1.isTargetLocking(arg_11_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_11_0 = var_1_10001(var_1_10002)

	return not var_1.getActivityById(var_11_0, arg_11_0:getTargetID()) or var_1:isEnd()
end

function var_0_1.isAllSigned(arg_12_0)
	local var_12_0 = arg_12_0.taskGroup[#arg_12_0.taskGroup]
	local var_12_1 = arg_12_0.taskProxy
	local var_12_3

	if not var_2.getTaskById(var_12_1, var_12_0) then
		local var_12_2 = arg_12_0.taskProxy

		var_12_3 = var_2.getFinishTaskById(var_12_2, var_12_0)
	end

	return var_12_3 and var_12_3:getTaskStatus() == 2
end

return var_0_1
