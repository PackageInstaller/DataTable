class = var_0_10000

local var_0_0 = "OriginShopSingleWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ShopsUISinglebox"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.itemTF = var_1.Find(var_2_0, "window/item")

	local var_2_1 = arg_2_0.itemTF
	local var_2_2 = var_1.Find(var_2_1, "display_panel/name_container/name/Text")
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameTF = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0.itemTF
	local var_2_5 = var_1.Find(var_2_4, "display_panel/desc/Text")
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.descTF = var_2_6(var_2_5, var_3(var_1_10004))

	local var_2_7 = arg_2_0.itemTF

	arg_2_0.itemOwnTF = var_1.Find(var_2_7, "left/own")

	local var_2_8 = arg_2_0.itemTF

	arg_2_0.itemDetailTF = var_1.Find(var_2_8, "left/detail")

	local var_2_9 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_9, "window/actions/confirm_btn")
	setText = var_1

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_2.Find(var_2_10, "window/actions/cancel_btn/pic")

	i18n = var_2_10

	var_1(var_2_11, var_2_10("shop_word_cancel"))

	setText = var_1

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_2.Find(var_2_12, "window/actions/confirm_btn/pic")

	i18n = var_2_12

	var_1(var_2_13, var_2_12("shop_word_exchange"))

	setText = var_1

	local var_2_14 = arg_2_0.itemTF
	local var_2_15 = var_2.Find(var_2_14, "ship_group/locked/Text")

	i18n = var_2_14

	var_1(var_2_15, var_2_14("tag_ship_locked"))

	setText = var_1

	local var_2_16 = arg_2_0.itemTF
	local var_2_17 = var_2.Find(var_2_16, "ship_group/unlocked/Text")

	i18n = var_2_16

	var_1(var_2_17, var_2_16("tag_ship_unlocked"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_3.Find(var_3_1, "window/actions/cancel_btn")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Close(var_4_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_3.Find(var_3_5, "bg")

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.Close(var_5_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_5)

	onButton = var_1_10001

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0._tf
	local var_3_10 = var_3.Find(var_3_9, "window/top/btnBack")

	local function var_3_11()
		local var_6_0 = arg_3_0

		var_0.Close(var_6_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_3_8, var_3_10, var_3_11, var_5)

	return
end

function var_0_1.Open(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.opening = true

	arg_7_0:Show()

	pg = var_3

	local var_7_0 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_7_0, arg_7_0._tf)
	arg_7_0:InitWindow(arg_7_1, arg_7_2)

	return
end

function var_0_1.InitWindow(arg_8_0, arg_8_1, arg_8_2)
	isa = var_1_10003

	local var_8_0 = arg_8_1

	WorldNShopCommodity = var_1_10005

	if var_1_10003(var_8_0, var_1_10005) then
		var_8_0 = arg_8_1

		local var_8_1

		if not arg_8_1.GetDropInfo(var_8_0) then
			var_8_0 = arg_8_1
			var_8_1 = arg_8_1.getDropInfo(var_8_0)
		end

		updateDrop = var_8_0

		local var_8_2 = arg_8_0.itemTF

		var_8_0(var_5.Find(var_8_2, "left/IconTpl"), var_8_1)

		UpdateOwnDisplay = var_8_0

		var_8_0(arg_8_0.itemOwnTF, var_8_1)

		RegisterDetailButton = var_8_0

		var_8_0(arg_8_0, arg_8_0.itemDetailTF, var_8_1)

		onButton = var_8_0

		local var_8_3 = arg_8_0
		local var_8_4 = arg_8_0.confirmBtn

		local function var_8_5()
			existCall = var_2_10000

			var_2_10000(arg_8_2, arg_8_1, 1)

			local var_9_0 = arg_8_0

			var_0.Close(var_9_0)

			return
		end

		SFX_CANCEL = var_1_10008

		var_8_0(var_8_3, var_8_4, var_8_5, var_1_10008)

		local var_8_6 = var_8_1.type

		DROP_TYPE_SHIP = var_8_3

		local var_8_7 = var_8_6 == var_8_3
		local var_8_8 = arg_8_0.itemTF
		local var_8_9 = var_5.Find(var_8_8, "ship_group")

		SetActive = var_8_8

		var_8_8(var_8_9, var_8_7)

		if var_8_7 then
			tobool = var_8_8
			getProxy = var_7
			CollectionProxy = var_8

			local var_8_10 = var_7(var_8)
			local var_8_11 = var_7.getShipGroup

			pg = var_1_10009

			local var_8_12 = var_8_8(var_8_11(var_8_10, var_1_10009.ship_data_template[var_8_1.id].group_type))

			SetActive = var_7

			var_7(var_8_9:Find("unlocked"), var_8_12)

			SetActive = var_7

			var_7(var_8_9:Find("locked"), not var_8_12)
		end

		local var_8_13 = arg_8_0.descTF
		local var_8_14

		if not var_8_1.desc then
			var_8_14 = var_8_1:getConfig("desc")
		end

		var_8_13.text = var_8_14
		arg_8_0.nameTF.text = var_8_1:getConfig("name")

		return
	end
end

function var_0_1.Close(arg_10_0)
	if arg_10_0.opening then
		arg_10_0.opening = false
		pg = var_1

		local var_10_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_10_0, arg_10_0._tf, arg_10_0._parentTf)
		arg_10_0:Hide()
	end

	return
end

function var_0_1.OnDestroy(arg_11_0)
	if arg_11_0.opening then
		arg_11_0:Close()
	end

	return
end

return var_0_1
