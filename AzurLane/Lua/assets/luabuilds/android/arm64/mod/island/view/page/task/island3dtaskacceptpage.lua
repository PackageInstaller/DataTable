class = var_0_10000

local var_0_0 = "Island3dTaskAcceptPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "Island3dTaskAcceptUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.chapterText = var_1.Find(var_2_0, "frame/chapter")

	local var_2_1 = arg_2_0._tf

	arg_2_0.nameText = var_1.Find(var_2_1, "frame/name")

	local var_2_2 = arg_2_0._tf

	arg_2_0.tipText = var_1.Find(var_2_2, "frame/tip/Text")
	setText = var_1

	local var_2_3 = arg_2_0.tipText

	i18n = var_4

	var_1(var_2_3, var_4("island_task_open"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.TouchEvent(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	return
end

function var_0_1.TouchEvent(arg_5_0)
	local var_5_0 = arg_5_0._tf
	local var_5_1 = var_1.GetComponent

	typeof = var_1_10004
	Animation = var_1_10006

	local var_5_2 = var_5_1(var_5_0, var_1_10004(var_1_10006))
	local var_5_3 = arg_5_0._tf
	local var_5_4 = var_2.GetComponent

	typeof = var_1_10005
	DftAniEvent = var_1_10007

	local var_5_5 = var_5_4(var_5_3, var_1_10005(var_1_10007))

	var_2.SetEndEvent(var_5_5, function()
		local var_6_0 = var_0

		var_0.SetEndEvent(var_6_0, nil)

		if arg_5_0.onExit then
			arg_5_0.onExit()

			arg_5_0.onExit = nil
		end

		local var_6_1 = arg_5_0.taskId

		IslandGuideChecker = var_2_10001

		if var_6_1 == var_2_10001.FIRST_TASK_ID then
			IslandGuideChecker = var_6_1

			var_6_1.CheckGuide("ISLAND_GUIDE_4")
		end

		local var_6_2 = arg_5_0

		var_0.Hide(var_6_2)

		return
	end)
	var_5_2:Play("Anim_Island3dTaskAcceptUI_out")

	return
end

function var_0_1.Show(arg_7_0, arg_7_1, arg_7_2)
	var_0_1.super.Show(arg_7_0)

	arg_7_0.taskId = arg_7_1
	getProxy = var_3
	IslandProxy = var_5

	local var_7_0 = var_3(var_5)
	local var_7_1 = var_3.GetIsland(var_7_0)
	local var_7_2 = var_3.GetTaskAgency(var_7_1)
	local var_7_3 = var_3.GetTask(var_7_2, arg_7_0.taskId)

	setText = var_1_10004

	var_1_10004(arg_7_0.chapterText, var_7_3:getConfig("series"))

	setText = var_1_10004

	var_1_10004(arg_7_0.nameText, var_7_3:getConfig("series_name"))

	arg_7_0.onExit = arg_7_2

	return
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

return var_0_1
