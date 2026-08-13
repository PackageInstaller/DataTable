class = var_0_10000

local var_0_0 = "OriginShopMultiWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

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

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameTF = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0.topItem
	local var_2_7 = var_1.Find(var_2_6, "display_panel/desc/Text")
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.descTF = var_2_8(var_2_7, var_3(var_1_10004))

	local var_2_9 = arg_2_0._tf

	arg_2_0.bottomItem = var_1.Find(var_2_9, "got/panel_bg/list/item")

	local var_2_10 = arg_2_0.bottomItem
	local var_2_11 = var_1.Find(var_2_10, "icon_bg/count")
	local var_2_12 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.itemCountTF = var_2_12(var_2_11, var_3(var_1_10004))

	local var_2_13 = arg_2_0._tf

	arg_2_0.maxBtn = var_1.Find(var_2_13, "count/max")

	local var_2_14 = arg_2_0._tf

	arg_2_0.leftBtn = var_1.Find(var_2_14, "count/number_panel/left")

	local var_2_15 = arg_2_0._tf

	arg_2_0.rightBtn = var_1.Find(var_2_15, "count/number_panel/right")

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_1.Find(var_2_16, "count/number_panel/value")
	local var_2_18 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.countTF = var_2_18(var_2_17, var_3(var_1_10004))

	local var_2_19 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_19, "actions/cancel_button")

	local var_2_20 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_20, "actions/confirm_button")
	setText = var_1

	local var_2_21 = arg_2_0._tf
	local var_2_22 = var_2.Find(var_2_21, "got/panel_bg/got_text")

	i18n = var_2_21

	var_1(var_2_22, var_2_21("shops_msgbox_output"))

	setText = var_1

	local var_2_23 = arg_2_0._tf
	local var_2_24 = var_2.Find(var_2_23, "count/image_text")

	i18n = var_2_23

	var_1(var_2_24, var_2_23("shops_msgbox_exchange_count"))

	setText = var_1

	local var_2_25 = arg_2_0._tf
	local var_2_26 = var_2.Find(var_2_25, "actions/cancel_button/label")

	i18n = var_2_25

	var_1(var_2_26, var_2_25("shop_word_cancel"))

	setText = var_1

	local var_2_27 = arg_2_0._tf
	local var_2_28 = var_2.Find(var_2_27, "actions/confirm_button/label")

	i18n = var_2_27

	var_1(var_2_28, var_2_27("shop_word_exchange"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.cancelBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Close(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf
	local var_3_5 = var_3.Find(var_3_4, "bg")

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.Close(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_3, var_3_5, var_3_6, var_5)

	return
end

function var_0_1.Open(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.opening = true
	pg = var_3

	local var_6_0 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_6_0, arg_6_0._tf)
	arg_6_0:InitWindow(arg_6_1, arg_6_2)
	arg_6_0:Show()

	return
end

function var_0_1.InitWindow(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0
	local var_7_1
	local var_7_2

	isa = var_1_10006

	local var_7_3 = arg_7_1

	WorldNShopCommodity = var_1_10008

	local var_7_4

	if var_1_10006(var_7_3, var_1_10008) then
		var_7_3 = arg_7_1
		var_7_0 = arg_7_1.GetDropInfo(var_7_3)
		var_7_3 = arg_7_1
		var_7_1 = arg_7_1.GetPriceInfo(var_7_3)
		var_7_3 = arg_7_1
		var_7_2 = arg_7_1.GetLimitGoodCount(var_7_3)
	else
		var_7_3 = arg_7_1
		var_7_0 = arg_7_1.getDropInfo(var_7_3)
		Drop = var_7_4
		var_7_4 = var_7_4.New
		var_7_3 = {}
		DROP_TYPE_RESOURCE = var_1_10008
		var_7_3.type = var_1_10008
		var_7_3.id = arg_7_1:getConfig("resource_type")
		var_7_3.count = arg_7_1:getConfig("resource_num")
		var_7_1 = var_7_4(var_7_3)
		var_7_3 = arg_7_1
		var_7_2 = arg_7_1.getLimitCount(var_7_3)
	end

	math = var_7_4

	local var_7_5 = var_7_4.max

	math = var_7_3

	local var_7_6 = var_7_5(var_7_3.floor(var_7_1:getOwnedCount() / var_7_1.count), 1)

	if var_7_2 ~= 0 then
		math = var_7
		var_7_6 = var_7.min(var_7_6, var_7_2 - arg_7_1.buyCount)
	end

	;(function(arg_8_0)
		math = var_2_10001
		arg_8_0 = var_2_10001.max(arg_8_0, 1)
		math = var_1
		arg_8_0 = var_1.min(arg_8_0, var_7_6)
		arg_7_0.countTF.text = arg_8_0
		arg_7_0.curCount = arg_8_0
		arg_7_0.itemCountTF.text = arg_8_0 * var_7_0.count

		return
	end)(1)

	updateDrop = var_8

	local var_7_7 = arg_7_0.topItem

	var_8(var_9.Find(var_7_7, "left/IconTpl"), var_7_0)

	UpdateOwnDisplay = var_8

	var_8(arg_7_0.ownerTF, var_7_0)

	RegisterDetailButton = var_8

	var_8(arg_7_0, arg_7_0.detailTF, var_7_0)

	arg_7_0.nameTF.text = var_7_0:getConfig("name")

	local var_7_8 = arg_7_0.descTF
	local var_7_9

	if not var_7_0.desc then
		var_7_9 = var_7_0:getConfig("desc")
	end

	var_7_8.text = var_7_9
	updateDrop = var_7_8

	var_7_8(arg_7_0.bottomItem, var_7_0)

	onButton = var_7_8

	local var_7_10 = arg_7_0
	local var_7_11 = arg_7_0.confirmBtn

	local function var_7_12()
		existCall = var_2_10000

		var_2_10000(arg_7_2, arg_7_1, arg_7_0.curCount)

		local var_9_0 = arg_7_0

		var_0.Close(var_9_0)

		return
	end

	SFX_PANEL = var_1_10012

	var_7_8(var_7_10, var_7_11, var_7_12, var_1_10012)

	onButton = var_7_8

	var_7_8(arg_7_0, arg_7_0.leftBtn, function()
		var_0(arg_7_0.curCount - 1)

		return
	end)

	onButton = var_7_8

	var_7_8(arg_7_0, arg_7_0.rightBtn, function()
		var_0(arg_7_0.curCount + 1)

		return
	end)

	onButton = var_7_8

	var_7_8(arg_7_0, arg_7_0.maxBtn, function()
		var_0(var_7_6)

		return
	end)

	return
end

function var_0_1.Close(arg_13_0)
	if arg_13_0.opening then
		pg = var_1

		local var_13_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_13_0, arg_13_0._tf, arg_13_0._parentTf)
		arg_13_0:Hide()

		arg_13_0.opening = false
	end

	return
end

function var_0_1.OnDestroy(arg_14_0)
	if arg_14_0.opening then
		arg_14_0:Close()
	end

	return
end

return var_0_1
