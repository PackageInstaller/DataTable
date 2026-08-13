class = var_0_10000

local var_0_0 = "FeastResWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "FeastResWindow"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/item/icon")
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.icon = var_2_2(var_2_1, var_4(var_1_10006))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "frame/name/Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.name = var_2_5(var_2_4, var_4(var_1_10006))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "frame/Text")
	local var_2_8 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.desc = var_2_8(var_2_7, var_4(var_1_10006))

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_1.Find(var_2_9, "frame/output/Text")
	local var_2_11 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.outPut = var_2_11(var_2_10, var_4(var_1_10006))

	local var_2_12 = arg_2_0._tf

	arg_2_0.goBtn = var_1.Find(var_2_12, "frame/go")
	setText = var_1

	local var_2_13 = arg_2_0.goBtn
	local var_2_14 = var_3.Find(var_2_13, "Text")

	i18n = var_4

	var_1(var_2_14, var_4("feast_res_window_go_label"))

	setText = var_1

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_3.Find(var_2_15, "frame/title")

	i18n = var_4

	var_1(var_2_16, var_4("feast_res_window_title"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	return
end

function var_0_1.Show(arg_5_0, arg_5_1)
	var_0_1.super.Show(arg_5_0)

	arg_5_0.id = arg_5_1

	arg_5_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.activity_workbench_item[arg_6_0.id]
	local var_6_1 = arg_6_0.icon

	LoadSprite = var_1_10003
	var_6_1.sprite = var_1_10003("props/" .. var_6_0.icon)

	local var_6_2 = arg_6_0.icon

	var_2.SetNativeSize(var_6_2)

	arg_6_0.name.text = var_6_0.name
	arg_6_0.desc.text = var_6_0.display

	local var_6_3 = arg_6_0.outPut

	var_6_3.text = var_6_0.get_access[1]
	onButton = var_6_3

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0.goBtn

	local function var_6_6()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10003

		var_7_1(var_7_0, var_2_10003.WORKBENCH_ITEM_GO, arg_6_0.id)

		return
	end

	SFX_PANEL = var_1_10007

	var_6_3(var_6_4, var_6_5, var_6_6, var_1_10007)

	return
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

return var_0_1
