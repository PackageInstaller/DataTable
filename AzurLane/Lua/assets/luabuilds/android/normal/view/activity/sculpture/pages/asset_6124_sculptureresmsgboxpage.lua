class = var_0_10000

local var_0_0 = "SculptureResMsgBoxPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "SculptureResMsgBoxUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "frame/close")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "frame/icon/Image")
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.icon = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "frame/name")
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.name = var_2_6(var_2_5, var_3(var_1_10004))

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "frame/scrollrect/desc")
	local var_2_9 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.desc = var_2_9(var_2_8, var_3(var_1_10004))

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_1.Find(var_2_10, "frame/output/Text")
	local var_2_12 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.outPut = var_2_12(var_2_11, var_3(var_1_10004))

	local var_2_13 = arg_2_0._tf

	arg_2_0.goBtn = var_1.Find(var_2_13, "frame/output/btn")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.closeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	return
end

function var_0_1.Show(arg_6_0, arg_6_1)
	var_0_1.super.Show(arg_6_0)

	arg_6_0.id = arg_6_1

	arg_6_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.activity_workbench_item[arg_7_0.id]
	local var_7_1 = arg_7_0.icon

	LoadSprite = var_1_10003
	var_7_1.sprite = var_1_10003("props/" .. var_7_0.icon)

	local var_7_2 = arg_7_0.icon

	var_2.SetNativeSize(var_7_2)

	arg_7_0.name.text = var_7_0.name
	arg_7_0.desc.text = var_7_0.display

	local var_7_3 = arg_7_0.outPut

	var_7_3.text = var_7_0.get_access[1]
	onButton = var_7_3

	local var_7_4 = arg_7_0
	local var_7_5 = arg_7_0.goBtn

	local function var_7_6()
		pg = var_2_10000

		local var_8_0 = var_2_10000.m02
		local var_8_1 = var_0.sendNotification

		GAME = var_2_10002

		var_8_1(var_8_0, var_2_10002.WORKBENCH_ITEM_GO, arg_7_0.id)

		return
	end

	SFX_PANEL = var_1_10006

	var_7_3(var_7_4, var_7_5, var_7_6, var_1_10006)

	return
end

function var_0_1.OnDestroy(arg_9_0)
	return
end

return var_0_1
