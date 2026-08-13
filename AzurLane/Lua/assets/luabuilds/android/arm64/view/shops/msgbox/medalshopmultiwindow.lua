class = var_0_10000

local var_0_0 = "MedalShopMultiWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ShopsUIMsgbox"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.topItem = var_1.Find(var_2_0, "item/panel_bg")

	local var_2_1 = arg_2_0.topItem

	arg_2_0.ownerTF = var_1.Find(var_2_1, "left/own")

	local var_2_2 = arg_2_0.topItem

	arg_2_0.detailTF = var_1.Find(var_2_2, "left/detail")

	local var_2_3 = arg_2_0.topItem
	local var_2_4 = var_1.Find(var_2_3, "display_panel/name_container/name/Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.nameTF = var_2_5(var_2_4, var_4(var_1_10006))

	local var_2_6 = arg_2_0.topItem
	local var_2_7 = var_1.Find(var_2_6, "display_panel/desc/Text")
	local var_2_8 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.descTF = var_2_8(var_2_7, var_4(var_1_10006))

	local var_2_9 = arg_2_0._tf

	arg_2_0.bottomItem = var_1.Find(var_2_9, "got/panel_bg/list/item")

	local var_2_10 = arg_2_0.bottomItem
	local var_2_11 = var_1.Find(var_2_10, "icon_bg/count")
	local var_2_12 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.itemCountTF = var_2_12(var_2_11, var_4(var_1_10006))

	local var_2_13 = arg_2_0._tf

	arg_2_0.maxBtn = var_1.Find(var_2_13, "count/max")

	local var_2_14 = arg_2_0._tf

	arg_2_0.leftBtn = var_1.Find(var_2_14, "count/number_panel/left")

	local var_2_15 = arg_2_0._tf

	arg_2_0.rightBtn = var_1.Find(var_2_15, "count/number_panel/right")

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_1.Find(var_2_16, "count/number_panel/value")
	local var_2_18 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.countTF = var_2_18(var_2_17, var_4(var_1_10006))

	local var_2_19 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_19, "actions/cancel_button")

	local var_2_20 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_20, "actions/confirm_button")
	setText = var_1

	local var_2_21 = arg_2_0._tf
	local var_2_22 = var_3.Find(var_2_21, "got/panel_bg/got_text")

	i18n = var_4

	var_1(var_2_22, var_4("shops_msgbox_output"))

	setText = var_1

	local var_2_23 = arg_2_0._tf
	local var_2_24 = var_3.Find(var_2_23, "count/image_text")

	i18n = var_4

	var_1(var_2_24, var_4("shops_msgbox_exchange_count"))

	setText = var_1

	local var_2_25 = arg_2_0._tf
	local var_2_26 = var_3.Find(var_2_25, "actions/cancel_button/label")

	i18n = var_4

	var_1(var_2_26, var_4("shop_word_cancel"))

	setText = var_1

	local var_2_27 = arg_2_0._tf
	local var_2_28 = var_3.Find(var_2_27, "actions/confirm_button/label")

	i18n = var_4

	var_1(var_2_28, var_4("shop_word_exchange"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.cancelBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf
	local var_3_5 = var_4.Find(var_3_4, "bg")

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_3_4

	var_1_10001(var_3_3, var_3_5, var_3_6, var_3_4)

	return
end

function var_0_1.Show(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:InitWindow(arg_6_1, arg_6_2)

	pg = var_3

	local var_6_0 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_6_0, arg_6_0._tf)
	var_0_1.super.Show(arg_6_0)

	return
end

function var_0_1.Hide(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_7_0, arg_7_0._tf, arg_7_0._parentTf)
	var_0_1.super.Hide(arg_7_0)

	return
end

function var_0_1.InitWindow(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.GetDropInfo(var_8_0)

	getProxy = var_1_10004
	BagProxy = var_1_10006

	local var_8_2 = var_1_10004(var_1_10006)
	local var_8_3 = var_4.getItemCountById

	ITEM_ID_SILVER_HOOK = var_1_10007

	local var_8_4 = var_8_3(var_8_2, var_1_10007)

	math = var_8_0

	local var_8_5 = var_8_0.max

	math = var_1_10007

	local var_8_6 = var_8_5(var_1_10007.floor(var_8_4 / arg_8_1:getConfig("price")), 1)

	if arg_8_1:GetLimit() ~= 0 then
		math = var_7
		var_8_6 = var_7.min(var_8_6, arg_8_1:GetMaxCnt())
	end

	;(function(arg_9_0)
		math = var_2_10001
		arg_9_0 = var_2_10001.max(arg_9_0, 1)
		math = var_1
		arg_9_0 = var_1.min(arg_9_0, var_8_6)
		arg_8_0.countTF.text = arg_9_0
		arg_8_0.curCount = arg_9_0

		local var_9_0 = arg_8_0.itemCountTF
		local var_9_1 = arg_8_1

		var_9_0.text = arg_9_0 * var_2.getConfig(var_9_1, "num")

		return
	end)(1)

	updateDrop = var_8

	local var_8_7 = arg_8_0.topItem

	var_8(var_10.Find(var_8_7, "left/IconTpl"), var_8_1)

	UpdateOwnDisplay = var_8

	var_8(arg_8_0.ownerTF, var_8_1)

	RegisterDetailButton = var_8

	var_8(arg_8_0, arg_8_0.detailTF, var_8_1)

	arg_8_0.nameTF.text = var_8_1:getConfig("name")

	local var_8_8 = arg_8_0.descTF
	local var_8_9

	if not var_8_1.desc then
		var_8_9 = var_8_1:getConfig("desc")
	end

	var_8_8.text = var_8_9
	updateDrop = var_8_8

	var_8_8(arg_8_0.bottomItem, var_8_1)

	onButton = var_8_8

	local var_8_10 = arg_8_0
	local var_8_11 = arg_8_0.confirmBtn

	local function var_8_12()
		if arg_8_2 then
			arg_8_2(arg_8_0.curCount)
		end

		local var_10_0 = arg_8_0

		var_0.Hide(var_10_0)

		return
	end

	SFX_PANEL = var_13

	var_8_8(var_8_10, var_8_11, var_8_12, var_13)

	onButton = var_8_8

	var_8_8(arg_8_0, arg_8_0.leftBtn, function()
		var_0(arg_8_0.curCount - 1)

		return
	end)

	onButton = var_8_8

	var_8_8(arg_8_0, arg_8_0.rightBtn, function()
		var_0(arg_8_0.curCount + 1)

		return
	end)

	onButton = var_8_8

	var_8_8(arg_8_0, arg_8_0.maxBtn, function()
		var_0(var_8_6)

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_14_0)
	if arg_14_0:isShowing() then
		arg_14_0:Hide()
	end

	return
end

return var_0_1
