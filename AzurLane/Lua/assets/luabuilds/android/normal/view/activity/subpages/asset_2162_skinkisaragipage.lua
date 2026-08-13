class = var_0_10000

local var_0_0 = "SkinKisaragiPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.textProgress = var_1.Find(var_1_1, "progress_text")

	local var_1_2 = arg_1_0.bg

	arg_1_0.btnGo = var_1.Find(var_1_2, "btn_go")

	local var_1_3 = arg_1_0.bg

	arg_1_0.markGot = var_1.Find(var_1_3, "got")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)
	local var_2_1 = arg_2_0.activity

	arg_2_0.taskList = var_2.getConfig(var_2_1, "config_data")
	arg_2_0.taskIndex = #arg_2_0.taskList
	arg_2_0.taskVO = nil

	while arg_2_0.taskIndex > 0 do
		arg_2_0.taskVO = var_2_0:getTaskVO(arg_2_0.taskList[arg_2_0.taskIndex])

		if arg_2_0.taskVO then
			break
		end

		arg_2_0.taskIndex = arg_2_0.taskIndex - 1
	end

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.btnGo

	local function var_3_2()
		if arg_3_0.taskVO then
			local var_4_0 = arg_3_0.taskVO

			if not var_0.isReceive(var_4_0) then
				local var_4_1 = arg_3_0
				local var_4_2 = var_0.emit

				ActivityMediator = var_2_10002
				var_2_10002 = var_2_10002.EVENT_GO_SCENE
				SCENE = var_2_10003

				var_4_2(var_4_1, var_2_10002, var_2_10003.TASK)

				goto label_4_0
			end
		end

		do
			local var_4_3 = arg_3_0
			local var_4_4 = var_0.emit

			ActivityMediator = var_2_10002

			local var_4_5 = var_2_10002.EVENT_GO_SCENE

			SCENE = var_2_10003

			var_4_4(var_4_3, var_4_5, var_2_10003.NAVALACADEMYSCENE)
		end

		::label_4_0::

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	setText = var_1_10001

	var_1_10001(arg_5_0.textProgress, arg_5_0.taskIndex .. "/" .. #arg_5_0.taskList)

	setActive = var_1_10001

	var_1_10001(arg_5_0.btnGo, arg_5_0.taskIndex < #arg_5_0.taskList)

	setActive = var_1_10001

	var_1_10001(arg_5_0.markGot, arg_5_0.taskIndex == #arg_5_0.taskList)

	return
end

function var_0_1.OnDestroy(arg_6_0)
	return
end

return var_0_1
