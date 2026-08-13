class = var_0_10000

local var_0_0 = "HalloweenSkinPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0._tf
	local var_1_2 = var_1.Find(var_1_1, "AD/Text")
	local var_1_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_1_0.stage = var_1_3(var_1_2, var_4(var_1_10006))

	local var_1_4 = arg_1_0._tf

	arg_1_0.goBtn = var_1.Find(var_1_4, "AD/go_btn")

	local var_1_5 = arg_1_0._tf

	arg_1_0.gotBtn = var_1.Find(var_1_5, "AD/got_btn")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	_ = var_1_10001

	local var_2_0 = var_1_10001.flatten
	local var_2_1 = arg_2_0.activity

	arg_2_0.tasks = var_2_0(var_3.getConfig(var_2_1, "config_data"))
	onButton = var_1

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.goBtn

	local function var_2_4()
		local var_3_0 = arg_2_0

		if var_0.LastTaskBeFinished(var_3_0) then
			return
		end

		local var_3_1 = arg_2_0
		local var_3_2 = var_0.emit

		ActivityMediator = var_2_10003

		local var_3_3 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_3_2(var_3_1, var_3_3, var_2_10004.NAVALACADEMYSCENE)

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_2, var_2_3, var_2_4, var_6)

	return
end

function var_0_1.LastTaskBeFinished(arg_4_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)
	local var_4_1 = arg_4_0.tasks[#arg_4_0.tasks]

	if var_4_0:getTaskVO(var_4_1) and var_3:isReceive() then
		return true
	end

	return false
end

function var_0_1.OnUpdateFlush(arg_5_0)
	local var_5_0 = arg_5_0.activity
	local var_5_1 = 0

	getProxy = var_1_10003
	TaskProxy = var_1_10005

	local var_5_2 = var_1_10003(var_1_10005)

	for iter_5_0 = #arg_5_0.tasks, 1, -1 do
		local var_5_3 = arg_5_0.tasks[iter_5_0]

		if var_5_2:getTaskVO(var_5_3) and var_9:isReceive() then
			var_5_1 = iter_5_0
		elseif var_9 and not var_9:isReceive() then
			var_5_1 = iter_5_0 - 1
		end
	end

	arg_5_0.stage.text = var_5_1 .. "/" .. #arg_5_0.tasks

	local var_5_4 = arg_5_0:LastTaskBeFinished()

	setActive = var_5

	var_5(arg_5_0.gotBtn, var_5_4)

	return
end

function var_0_1.OnDestroy(arg_6_0)
	return
end

return var_0_1
