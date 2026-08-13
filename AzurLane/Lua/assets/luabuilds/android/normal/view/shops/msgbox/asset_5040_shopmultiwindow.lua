class = var_0_10000

local var_0_0 = "ShopMultiWindow"

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

	local var_2_9 = arg_2_0.topItem

	arg_2_0.timeLimitTF = var_1.Find(var_2_9, "time_limit")

	local var_2_10 = arg_2_0._tf

	arg_2_0.bottomItem = var_1.Find(var_2_10, "got/panel_bg/list/item")

	local var_2_11 = arg_2_0.bottomItem
	local var_2_12 = var_1.Find(var_2_11, "icon_bg/count")
	local var_2_13 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.itemCountTF = var_2_13(var_2_12, var_3(var_1_10004))

	local var_2_14 = arg_2_0._tf

	arg_2_0.maxBtn = var_1.Find(var_2_14, "count/max")

	local var_2_15 = arg_2_0._tf

	arg_2_0.leftBtn = var_1.Find(var_2_15, "count/number_panel/left")

	local var_2_16 = arg_2_0._tf

	arg_2_0.rightBtn = var_1.Find(var_2_16, "count/number_panel/right")

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_1.Find(var_2_17, "count/number_panel/value")
	local var_2_19 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.countTF = var_2_19(var_2_18, var_3(var_1_10004))

	local var_2_20 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_20, "actions/cancel_button")

	local var_2_21 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_21, "actions/confirm_button")
	setText = var_1

	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_2.Find(var_2_22, "got/panel_bg/got_text")

	i18n = var_2_22

	var_1(var_2_23, var_2_22("shops_msgbox_output"))

	setText = var_1

	local var_2_24 = arg_2_0._tf
	local var_2_25 = var_2.Find(var_2_24, "count/image_text")

	i18n = var_2_24

	var_1(var_2_25, var_2_24("shops_msgbox_exchange_count"))

	setText = var_1

	local var_2_26 = arg_2_0._tf
	local var_2_27 = var_2.Find(var_2_26, "actions/cancel_button/label")

	i18n = var_2_26

	var_1(var_2_27, var_2_26("shop_word_cancel"))

	setText = var_1

	local var_2_28 = arg_2_0._tf
	local var_2_29 = var_2.Find(var_2_28, "actions/confirm_button/label")

	i18n = var_2_28

	var_1(var_2_29, var_2_28("shop_word_exchange"))

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
	local var_7_0 = {
		id = arg_7_1:getConfig("commodity_id"),
		type = arg_7_1:getConfig("commodity_type"),
		count = arg_7_1:getConfig("num")
	}

	isa = var_4

	local var_7_1 = arg_7_1

	ActivityCommodity = var_6

	local var_7_2

	if var_4(var_7_1, var_6) then
		local var_7_3, var_7_4

		var_7_2, var_7_3, var_7_4 = arg_7_1:CheckTimeLimit()
		setActive = var_1_10007

		var_1_10007(arg_7_0.timeLimitTF, var_7_2)

		if var_7_2 and var_7_3 then
			getProxy = var_1_10007
			ActivityProxy = var_8

			local var_7_5 = var_1_10007(var_8)
			local var_7_6 = var_7.getActivityById

			Item = var_1_10010

			local var_7_7 = var_7_6(var_7_5, var_1_10010.getConfigData(var_7_0.id).link_id)
			local var_7_8 = var_8.IsMaintenanceFinish(var_7_7) and "eventshop_time_hint" or "eventshop_time_hint2"

			setText = var_7_7

			local var_7_9 = arg_7_0.timeLimitTF

			var_1_10011 = var_1_10011.Find(var_7_9, "Text")
			i18n = var_7_9

			local var_7_10 = var_7_8

			pg = var_1_10014

			local var_7_11 = var_1_10014.TimeMgr.GetInstance()

			var_7_7(var_1_10011, var_7_9(var_7_10, var_14.STimeDescS(var_7_11, var_8.stopTime, "%m.%d")))
		end
	end

	Drop = var_7_2

	local var_7_12 = var_7_2.New({
		type = arg_7_1:getConfig("resource_category"),
		id = arg_7_1:getConfig("resource_type")
	})
	local var_7_13 = var_4.getOwnedCount(var_7_12)

	math = var_7_12

	local var_7_14 = var_7_12.max

	math = var_6

	local var_7_15 = var_7_14(var_6.floor(var_7_13 / arg_7_1:getConfig("resource_num")), 1)

	if arg_7_1:getConfig("num_limit") == 0 then
		isa = var_6

		local var_7_16 = arg_7_1

		QuotaCommodity = var_8

		if var_6(var_7_16, var_8) then
			local var_7_17 = arg_7_1
			local var_7_18 = arg_7_1.GetPurchasableCnt(var_7_17)

			math = var_7_17

			local var_7_19 = var_7_17.min
			local var_7_20 = var_7_15

			math = var_9
			var_7_15 = var_7_19(var_7_20, var_9.max(0, var_7_18))
		end

		;(function(arg_8_0)
			math = var_2_10001
			arg_8_0 = var_2_10001.max(arg_8_0, 1)
			math = var_1
			arg_8_0 = var_1.min(arg_8_0, var_7_15)
			arg_7_0.countTF.text = arg_8_0
			arg_7_0.curCount = arg_8_0

			local var_8_0 = arg_7_0.itemCountTF
			local var_8_1 = arg_7_1

			var_8_0.text = arg_8_0 * var_2.getConfig(var_8_1, "num")

			return
		end)(1)

		updateDrop = var_7

		local var_7_21 = arg_7_0.topItem

		var_7(var_8.Find(var_7_21, "left/IconTpl"), var_7_0)

		UpdateOwnDisplay = var_7

		var_7(arg_7_0.ownerTF, var_7_0)

		RegisterDetailButton = var_7

		var_7(arg_7_0, arg_7_0.detailTF, var_7_0)

		arg_7_0.nameTF.text = var_7_0:getConfig("name")

		local var_7_22 = arg_7_0.descTF

		HXSet = var_8

		local var_7_23 = var_8.hxLan
		local var_7_24

		if not var_7_0.desc then
			var_7_24 = var_7_0:getConfig("desc")
		end

		var_7_22.text = var_7_23(var_7_24)
		updateDrop = var_7_22

		var_7_22(arg_7_0.bottomItem, var_7_0)

		onButton = var_7_22

		local var_7_25 = arg_7_0
		local var_7_26 = arg_7_0.confirmBtn

		local function var_7_27()
			if arg_7_2 then
				local var_9_0 = arg_7_2
				local var_9_1 = arg_7_1
				local var_9_2 = arg_7_0.curCount
				local var_9_3 = var_7_0

				var_9_0(var_9_1, var_9_2, var_3.getConfig(var_9_3, "name"))
			end

			local var_9_4 = arg_7_0

			var_0.Close(var_9_4)

			return
		end

		SFX_PANEL = var_1_10011

		var_7_22(var_7_25, var_7_26, var_7_27, var_1_10011)

		onButton = var_7_22

		var_7_22(arg_7_0, arg_7_0.leftBtn, function()
			var_0(arg_7_0.curCount - 1)

			return
		end)

		onButton = var_7_22

		var_7_22(arg_7_0, arg_7_0.rightBtn, function()
			var_0(arg_7_0.curCount + 1)

			return
		end)

		onButton = var_7_22

		var_7_22(arg_7_0, arg_7_0.maxBtn, function()
			var_0(var_7_15)

			return
		end)

		return
	end
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
