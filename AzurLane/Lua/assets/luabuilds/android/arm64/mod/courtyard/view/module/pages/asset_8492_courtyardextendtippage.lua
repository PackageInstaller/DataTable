class = var_0_10000

local var_0_0 = "CourtYardExtendTipPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardBaseSubPage"))

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
	local var_2_1 = var_3.Find(var_2_0, "Text")

	i18n = var_4

	var_1(var_2_1, var_4("word_ok"))

	setText = var_1

	local var_2_2 = arg_2_0.cancelBtn
	local var_2_3 = var_3.Find(var_2_2, "Text")

	i18n = var_4

	var_1(var_2_3, var_4("word_cancel"))

	setText = var_1

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_3.Find(var_2_4, "frame/tip_1/text_1")

	i18n = var_4

	var_1(var_2_5, var_4("backyard_extend_tip_1"))

	setText = var_1

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_3.Find(var_2_6, "frame/tip_1/text_2")

	i18n = var_4

	var_1(var_2_7, var_4("backyard_extend_tip_2"))

	setText = var_1

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_3.Find(var_2_8, "frame/tip_2/text_1")

	i18n = var_4

	var_1(var_2_9, var_4("backyard_extend_tip_3"))

	setText = var_1

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_3.Find(var_2_10, "frame/tip_2/text_2")

	i18n = var_4

	var_1(var_2_11, var_4("backyard_extend_tip_4"))

	setText = var_1

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_3.Find(var_2_12, "frame/title")

	i18n = var_4

	var_1(var_2_13, var_4("words_information"))

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

	SFX_CONFIRM = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.cancelBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0._tf

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.closeBtn

	local function var_3_11()
		local var_7_0 = arg_3_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10006)

	return
end

function var_0_1.Show(arg_8_0)
	getProxy = var_1_10001
	BagProxy = var_1_10003

	local var_8_0 = var_1_10001(var_1_10003)
	local var_8_1 = var_1.getItemById

	ITEM_BACKYARD_AREA_EXTEND = var_1_10004

	local var_8_2

	if not var_8_1(var_8_0, var_1_10004) then
		Item = var_8_2
		var_8_2 = var_8_2.New

		local var_8_3 = {
			count = 0
		}

		ITEM_BACKYARD_AREA_EXTEND = var_1_10004
		var_8_3.id = var_1_10004
		var_8_2 = var_8_2(var_8_3)
	end

	i18n = var_1_10002

	local var_8_4 = var_1_10002("backyard_extendArea_tip", 1, var_8_2.count)
	local var_8_5 = {}

	ipairs = var_4
	string = var_6

	for iter_8_0, iter_8_1 in var_4(var_6.split(var_8_4, "||")) do
		var_8_5["text" .. iter_8_0] = iter_8_1
	end

	setActive = var_4

	var_4(arg_8_0._tf, true)

	local var_8_6 = {}

	DROP_TYPE_ITEM = var_5
	var_8_6.type = var_5
	var_8_6.id = var_8_2.id
	setText = var_5

	var_5(arg_8_0.text1, var_8_5.text1)

	setText = var_5

	local var_8_7 = arg_8_0.text2

	setColorStr = var_8

	var_5(var_8_7, var_8(var_8_5.text2, "#72bc42"))

	setText = var_5

	var_5(arg_8_0.text3, var_8_5.text3)

	setText = var_5

	var_5(arg_8_0.text4, var_8_5.text4)

	tonumber = var_5

	if var_5(var_8_2.count) <= 0 then
		setColorStr = var_8_9

		local var_8_8 = var_8_2.count

		COLOR_RED = var_8

		local var_8_9

		if not var_8_9(var_8_8, var_8) then
			setColorStr = var_8_9
			var_8_9 = var_8_9(var_8_2.count, "#72bc42")
		end

		setText = var_6

		var_6(arg_8_0.valueTxt, var_8_9)

		setText = var_6

		var_6(arg_8_0.text5, var_8_5.text6)

		updateDrop = var_6

		var_6(arg_8_0.itemTF, var_8_6)

		pg = var_6

		local var_8_10 = var_6.UIMgr.GetInstance()

		var_6.OverlayPanel(var_8_10, arg_8_0._tf)

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
