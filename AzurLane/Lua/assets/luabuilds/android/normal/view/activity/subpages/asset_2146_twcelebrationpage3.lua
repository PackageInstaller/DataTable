class = var_0_10000

local var_0_0 = "TWCelebrationPage3"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0._tf

	arg_1_0.getBtn = var_1.Find(var_1_1, "AD/get")

	local var_1_2 = arg_1_0._tf

	arg_1_0.gotBtn = var_1.Find(var_1_2, "AD/got")

	local var_1_3 = arg_1_0._tf

	arg_1_0.share = var_1.Find(var_1_3, "AD/share")

	local var_1_4 = arg_1_0._tf

	arg_1_0.mask = var_1.Find(var_1_4, "AD/mask")

	local var_1_5 = arg_1_0._tf

	arg_1_0.finished = var_1.Find(var_1_5, "AD/finished")

	local var_1_6 = arg_1_0._tf

	arg_1_0.unfinished = var_1.Find(var_1_6, "AD/unfinished")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	local var_3_0 = arg_3_0.activity
	local var_3_1 = var_1.getConfig(var_3_0, "config_data")[1]

	getProxy = var_3_0
	TaskProxy = var_3

	local var_3_2 = var_3_0(var_3)
	local var_3_3

	if not var_2.getTaskById(var_3_2, var_3_1) and not var_2:getFinishTaskById(var_3_1) then
		Task = var_3_3
		var_3_3 = var_3_3.New({
			id = var_3_1
		})
	end

	local var_3_4 = var_3_3:isFinish()
	local var_3_5 = var_3_3
	local var_3_6 = var_3_3.isReceive(var_3_5)

	setActive = var_3_5

	var_3_5(arg_3_0.getBtn, var_3_3 and var_3_4 and not var_3_6)

	setActive = var_3_5

	var_3_5(arg_3_0.gotBtn, var_3_3 and var_3_6)

	setActive = var_3_5

	var_3_5(arg_3_0.mark, var_3_3 and var_3_6)

	setActive = var_3_5

	var_3_5(arg_3_0.share, var_3_3 and not var_3_4)

	setActive = var_3_5

	var_3_5(arg_3_0.finished, var_3_3 and var_3_4)

	setActive = var_3_5

	var_3_5(arg_3_0.unfinished, var_3_3 and not var_3_4)

	onButton = var_3_5

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.share

	local function var_3_9()
		local var_4_0 = arg_3_0

		var_0.share(var_4_0)

		return
	end

	SFX_PANEL = var_1_10010

	var_3_5(var_3_7, var_3_8, var_3_9, var_1_10010)

	onButton = var_3_5

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0.getBtn

	local function var_3_12()
		if var_3_3 and var_3_4 and not var_3_6 then
			local var_5_0 = arg_3_0
			local var_5_1 = var_0.emit

			ActivityMediator = var_2_10002

			var_5_1(var_5_0, var_2_10002.ON_TASK_SUBMIT, var_3_3)
		end

		return
	end

	SFX_PANEL = var_1_10010

	var_3_5(var_3_10, var_3_11, var_3_12, var_1_10010)

	return
end

function var_0_1.share(arg_6_0)
	arg_6_0:initShare()

	return
end

function var_0_1.initShare(arg_7_0)
	PoolMgr = var_1_10001

	local var_7_0 = var_1_10001.GetInstance()

	var_1.GetUI(var_7_0, "TWCelebrationShare", false, function(arg_8_0)
		GameObject = var_2_10001

		local var_8_0 = var_2_10001.Find("UICamera")
		local var_8_1 = var_1.GetComponent

		typeof = var_2_10003
		Camera = var_2_10004

		local var_8_2 = var_8_1(var_8_0, var_2_10003(var_2_10004)).transform
		local var_8_3 = var_2.GetChild(var_8_2, 0)

		SetParent = var_8_2

		var_8_2(arg_8_0, var_8_3, false)

		return
	end)

	return
end

return var_0_1
