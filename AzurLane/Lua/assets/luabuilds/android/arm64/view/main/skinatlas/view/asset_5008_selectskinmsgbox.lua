class = var_0_10000

local var_0_0 = "SelectSkinMsgbox"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "SelectSkinMsgboxUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "window/top/btnBack")

	local var_2_1 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_1, "window/button_container/cancel")

	local var_2_2 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_2, "window/button_container/confirm")

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "window/frame/content")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.contentTxt = var_2_5(var_2_4, var_4(var_1_10006))

	local var_2_6 = arg_2_0._tf

	arg_2_0.leftItemTr = var_1.Find(var_2_6, "window/frame/left")

	local var_2_7 = arg_2_0._tf

	arg_2_0.rightItemTr = var_1.Find(var_2_7, "window/frame/right")

	local var_2_8 = arg_2_0.leftItemTr
	local var_2_9 = var_1.Find(var_2_8, "name_bg/Text")
	local var_2_10 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.leftNameTxt = var_2_10(var_2_9, var_4(var_1_10006))

	local var_2_11 = arg_2_0.rightItemTr
	local var_2_12 = var_1.Find(var_2_11, "name_bg/Text")
	local var_2_13 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.rightNameTxt = var_2_13(var_2_12, var_4(var_1_10006))
	setText = var_1

	local var_2_14 = arg_2_0.cancelBtn
	local var_2_15 = var_3.Find(var_2_14, "pic")

	i18n = var_4

	var_1(var_2_15, var_4("msgbox_text_cancel"))

	setText = var_1

	local var_2_16 = arg_2_0.confirmBtn
	local var_2_17 = var_3.Find(var_2_16, "pic")

	i18n = var_4

	var_1(var_2_17, var_4("msgbox_text_confirm"))

	setText = var_1

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_3.Find(var_2_18, "window/top/bg/infomation/title")

	i18n = var_4

	var_1(var_2_19, var_4("title_info"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "bg")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.closeBtn

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_4, var_3_5, var_3_6, var_3_1)

	onButton = var_1_10001

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.cancelBtn

	local function var_3_9()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_7, var_3_8, var_3_9, var_3_1)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	var_0_1.super.Show(arg_7_0)

	pg = var_2

	local var_7_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_7_0, arg_7_0._tf)

	local var_7_1 = arg_7_0.contentTxt

	var_7_1.text = arg_7_1.content
	updateDrop = var_7_1

	var_7_1(arg_7_0.leftItemTr, arg_7_1.leftDrop)

	updateDrop = var_7_1

	var_7_1(arg_7_0.rightItemTr, arg_7_1.rightDrop)

	local var_7_2 = arg_7_0.leftNameTxt
	local var_7_3 = arg_7_1.leftDrop

	var_7_2.text = var_3.getConfig(var_7_3, "name")

	local var_7_4 = arg_7_0.rightNameTxt
	local var_7_5 = arg_7_1.rightDrop

	var_7_4.text = var_3.getConfig(var_7_5, "name")
	onButton = var_7_4

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.confirmBtn

	local function var_7_8()
		local var_8_0 = arg_7_0

		var_0.Hide(var_8_0)

		if arg_7_1.onYes then
			arg_7_1.onYes()
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_7_4(var_7_6, var_7_7, var_7_8, var_1_10007)

	return
end

function var_0_1.Hide(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_9_0, arg_9_0._tf, arg_9_0._parentTf)
	var_0_1.super.Hide(arg_9_0)

	return
end

function var_0_1.OnDestroy(arg_10_0)
	if arg_10_0:isShowing() then
		arg_10_0:Hide()
	end

	return
end

return var_0_1
