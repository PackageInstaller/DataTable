class = var_0_10000

local var_0_0 = "OtherWorldTaskLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.sub_item_warning = "sub_item_warning"

local var_0_2 = "other_world_task_title"

function var_0_1.getUIName(arg_1_0)
	return "OtherWorldTaskUI"
end

function var_0_1.init(arg_2_0)
	ActivityConst = var_1_10001
	arg_2_0.activityId = var_1_10001.OTHER_WORLD_TASK_ID
	findTF = var_1

	local var_2_0 = var_1(arg_2_0._tf, "ad")

	findTF = var_2
	arg_2_0.btnBack = var_2(var_2_0, "btnBack")
	OtherWorldTaskPage = var_2

	local var_2_1 = var_2.New

	findTF = var_3

	local var_2_2 = var_3(var_2_0, "pages/taskPage")
	local var_2_3 = arg_2_0.contextData

	findTF = var_5
	arg_2_0.taskPage = var_2_1(var_2_2, var_2_3, var_5(var_2_0, "tpl"), arg_2_0)
	pg = var_2

	local var_2_4 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_2_4, arg_2_0._tf)

	local var_2_5 = arg_2_0.taskPage

	var_2.setActive(var_2_5, true)

	return
end

function var_0_1.didEnter(arg_3_0)
	setText = var_1_10001
	findTF = var_1_10002

	local var_3_0 = var_1_10002(arg_3_0._tf, "ad/title/text")

	i18n = var_3

	var_1_10001(var_3_0, var_3(var_0_2))

	onButton = var_1_10001

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.btnBack

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_3_1, var_3_2, var_3_3, var_1_10005)

	onButton = var_1_10001

	local var_3_4 = arg_3_0

	findTF = var_3_2

	local var_3_5 = var_3_2(arg_3_0._tf, "ad/pages/taskPage/clickClose")

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_3_4, var_3_5, var_3_6, var_5)

	return
end

function var_0_1.updateTask(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.taskPage

	var_2.updateTask(var_6_0, arg_6_1)

	return
end

function var_0_1.willExit(arg_7_0)
	local var_7_0 = arg_7_0.taskPage

	var_1.dispose(var_7_0)

	pg = var_1

	local var_7_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_7_1, arg_7_0._tf)

	return
end

return var_0_1
