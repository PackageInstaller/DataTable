class = var_0_10000

local var_0_0 = "SkinCouponMsgBox"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "SkinCouponMsgBoxUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "window/top/btnBack")

	local var_2_1 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_1, "window/button_container/cancel")

	local var_2_2 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_2, "window/button_container/confirm")

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "window/frame/Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.label1 = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0._tf

	arg_2_0.leftItemTr = var_1.Find(var_2_6, "window/frame/left")

	local var_2_7 = arg_2_0.leftItemTr
	local var_2_8 = var_1.Find(var_2_7, "name_bg/Text")
	local var_2_9 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameTxt = var_2_9(var_2_8, var_3(var_1_10004))
	setText = var_1

	local var_2_10 = arg_2_0.cancelBtn
	local var_2_11 = var_2.Find(var_2_10, "pic")

	i18n = var_2_10

	var_1(var_2_11, var_2_10("msgbox_text_cancel"))

	setText = var_1

	local var_2_12 = arg_2_0.confirmBtn
	local var_2_13 = var_2.Find(var_2_12, "pic")

	i18n = var_2_12

	var_1(var_2_13, var_2_12("msgbox_text_confirm"))

	setText = var_1

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_2.Find(var_2_14, "window/top/bg/infomation/title")

	i18n = var_2_14

	var_1(var_2_15, var_2_14("words_information"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_3.Find(var_3_1, "bg")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.closeBtn

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_4, var_3_5, var_3_6, var_5)

	onButton = var_1_10001

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.cancelBtn

	local function var_3_9()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_7, var_3_8, var_3_9, var_5)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	var_0_1.super.Show(arg_7_0)

	arg_7_0.settings = arg_7_1

	arg_7_0:UpdateItem(arg_7_1)
	arg_7_0:RegisterBtn(arg_7_1)
	arg_7_0:UpdateContent(arg_7_1)

	return
end

function var_0_1.RegisterBtn(arg_8_0, arg_8_1)
	onButton = var_1_10002

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.confirmBtn

	local function var_8_2()
		if arg_8_1.onYes then
			arg_8_1.onYes()
		end

		local var_9_0 = arg_8_0

		var_0.Hide(var_9_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_8_0, var_8_1, var_8_2, var_1_10006)

	return
end

function var_0_1.UpdateContent(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.drop
	local var_10_1 = arg_10_1.skinName
	local var_10_2 = arg_10_1.price
	local var_10_3 = arg_10_0.label1

	i18n = var_1_10006
	var_10_3.text = var_1_10006("skin_purchase_confirm", var_10_0:getName(), var_10_2, var_10_1)
	setActive = var_10_3

	var_10_3(arg_10_0.label1, false)

	setActive = var_10_3

	var_10_3(arg_10_0.label1, true)

	arg_10_0.nameTxt.text = var_10_0:getName()

	return
end

function var_0_1.UpdateItem(arg_11_0, arg_11_1)
	updateDrop = var_1_10002

	var_1_10002(arg_11_0.leftItemTr, arg_11_1.drop)

	return
end

function var_0_1.Hide(arg_12_0)
	arg_12_0.settings = nil

	var_0_1.super.Hide(arg_12_0)
	arg_12_0:Destroy()

	return
end

function var_0_1.OnDestroy(arg_13_0)
	return
end

return var_0_1
