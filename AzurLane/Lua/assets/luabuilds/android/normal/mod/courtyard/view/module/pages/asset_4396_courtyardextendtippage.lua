class = var_0_10000

local var_0_0 = "CourtYardExtendTipPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardBaseSubPage"))

function var_0_1.getUIName(arg_1_0)
	return "CourtYardExtendTipUI"
end

function var_0_1.OnLoaded(arg_2_0)
	findTF = var_1_10001
	arg_2_0.valueTxt = var_1_10001(arg_2_0._tf, "frame/tip_2/value_bg/Text")
	findTF = var_1
	arg_2_0.text1 = var_1(arg_2_0._tf, "frame/tip_1/text_1")
	findTF = var_1
	arg_2_0.text2 = var_1(arg_2_0._tf, "frame/tip_1/value_bg/Text")
	findTF = var_1
	arg_2_0.text3 = var_1(arg_2_0._tf, "frame/tip_1/text_2")
	findTF = var_1
	arg_2_0.text4 = var_1(arg_2_0._tf, "frame/tip_2/text_1")
	findTF = var_1
	arg_2_0.text5 = var_1(arg_2_0._tf, "frame/tip_2/text_2")
	findTF = var_1
	arg_2_0.itemTF = var_1(arg_2_0._tf, "frame")
	findTF = var_1
	arg_2_0.okBtn = var_1(arg_2_0._tf, "frame/ok_btn")
	findTF = var_1
	arg_2_0.cancelBtn = var_1(arg_2_0._tf, "frame/cancel_btn")
	findTF = var_1
	arg_2_0.closeBtn = var_1(arg_2_0._tf, "frame/close")
	arg_2_0._parent = arg_2_0._tf.parent
	setText = var_1

	local var_2_0 = arg_2_0.okBtn
	local var_2_1 = var_2.Find(var_2_0, "Text")

	i18n = var_2_0

	var_1(var_2_1, var_2_0("word_ok"))

	setText = var_1

	local var_2_2 = arg_2_0.cancelBtn
	local var_2_3 = var_2.Find(var_2_2, "Text")

	i18n = var_2_2

	var_1(var_2_3, var_2_2("word_cancel"))

	setText = var_1

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_2.Find(var_2_4, "frame/tip_1/text_1")

	i18n = var_2_4

	var_1(var_2_5, var_2_4("backyard_extend_tip_1"))

	setText = var_1

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_2.Find(var_2_6, "frame/tip_1/text_2")

	i18n = var_2_6

	var_1(var_2_7, var_2_6("backyard_extend_tip_2"))

	setText = var_1

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_2.Find(var_2_8, "frame/tip_2/text_1")

	i18n = var_2_8

	var_1(var_2_9, var_2_8("backyard_extend_tip_3"))

	setText = var_1

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_2.Find(var_2_10, "frame/tip_2/text_2")

	i18n = var_2_10

	var_1(var_2_11, var_2_10("backyard_extend_tip_4"))

	setText = var_1

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_2.Find(var_2_12, "frame/title")

	i18n = var_2_12

	var_1(var_2_13, var_2_12("words_information"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.okBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Emit(var_4_0, "Extend")

		local var_4_1 = arg_3_0

		var_0.Hide(var_4_1)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.cancelBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0._tf

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.closeBtn

	local function var_3_11()
		local var_7_0 = arg_3_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10005)

	return
end

function var_0_1.Show(arg_8_0)
	getProxy = var_1_10001
	BagProxy = var_1_10002

	local var_8_0 = var_1_10001(var_1_10002)
	local var_8_1 = var_1.getItemById

	ITEM_BACKYARD_AREA_EXTEND = var_1_10003

	local var_8_2

	if not var_8_1(var_8_0, var_1_10003) then
		Item = var_8_2
		var_8_2 = var_8_2.New
		var_8_0 = {
			count = 0
		}
		ITEM_BACKYARD_AREA_EXTEND = var_1_10003
		var_8_0.id = var_1_10003
		var_8_2 = var_8_2(var_8_0)
	end

	i18n = var_8_0

	local var_8_3 = var_8_0("backyard_extendArea_tip", 1, var_8_2.count)
	local var_8_4 = {}

	ipairs = var_4
	string = var_5

	for iter_8_0, iter_8_1 in var_4(var_5.split(var_8_3, "||")) do
		var_8_4["text" .. iter_8_0] = iter_8_1
	end

	setActive = var_4

	var_4(arg_8_0._tf, true)

	local var_8_5 = {}

	DROP_TYPE_ITEM = var_5
	var_8_5.type = var_5
	var_8_5.id = var_8_2.id
	setText = var_5

	var_5(arg_8_0.text1, var_8_4.text1)

	setText = var_5

	local var_8_6 = arg_8_0.text2

	setColorStr = var_7

	var_5(var_8_6, var_7(var_8_4.text2, "#72bc42"))

	setText = var_5

	var_5(arg_8_0.text3, var_8_4.text3)

	setText = var_5

	var_5(arg_8_0.text4, var_8_4.text4)

	tonumber = var_5

	if var_5(var_8_2.count) <= 0 then
		setColorStr = var_8_8

		local var_8_7 = var_8_2.count

		COLOR_RED = var_7

		local var_8_8

		if not var_8_8(var_8_7, var_7) then
			setColorStr = var_8_8
			var_8_8 = var_8_8(var_8_2.count, "#72bc42")
		end

		setText = var_8_7

		var_8_7(arg_8_0.valueTxt, var_8_8)

		setText = var_8_7

		var_8_7(arg_8_0.text5, var_8_4.text6)

		updateDrop = var_8_7

		var_8_7(arg_8_0.itemTF, var_8_5)

		pg = var_8_7

		local var_8_9 = var_8_7.UIMgr.GetInstance()

		var_6.OverlayPanel(var_8_9, arg_8_0._tf)

		arg_8_0.showing = true

		return
	end
end

function var_0_1.Hide(arg_9_0)
	if arg_9_0.showing == true then
		arg_9_0.showing = false
		setActive = var_1

		var_1(arg_9_0._tf, false)

		pg = var_1

		local var_9_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_9_0, arg_9_0._tf, arg_9_0._parent)
	end

	return
end

function var_0_1.OnDestroy(arg_10_0)
	arg_10_0:Hide()

	return
end

return var_0_1
