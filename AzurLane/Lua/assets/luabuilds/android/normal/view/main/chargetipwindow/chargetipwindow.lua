class = var_0_10000

local var_0_0 = "ChargeTipWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

var_0_1.TYPE_MONTH_CARD = "MonthCard"
var_0_1.TYPE_GIFTPACKAGE = "GiftPackage"
var_0_1.TYPE_CURSING = "Crusing"

function var_0_1.getUIName(arg_1_0)
	return "ChargeTipUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.container = var_1.Find(var_2_0, "frame/window")

	local var_2_1 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_1, "frame/top/btnBack")

	local var_2_2 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_2, "frame/confirm")
	setText = var_1

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_2.Find(var_2_3, "frame/top/title")

	i18n = var_2_3

	var_1(var_2_4, var_2_3("words_information"))

	setText = var_1

	local var_2_5 = arg_2_0.confirmBtn
	local var_2_6 = var_2.Find(var_2_5, "Text")

	i18n = var_2_5

	var_1(var_2_6, var_2_5("msgbox_text_confirm"))

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0.window = {}

	return
end

local function var_0_2(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.getConfig(var_4_0, "extra_service")

	Goods = var_4_0

	if var_4_1 == var_4_0.MONTH_CARD then
		return var_0_1.TYPE_MONTH_CARD
	else
		Goods = var_2

		if var_4_1 == var_2.ITEM_BOX then
			return var_0_1.TYPE_GIFTPACKAGE
		else
			Goods = var_2

			if var_4_1 == var_2.PASS_ITEM then
				return var_0_1.TYPE_CURSING
			end
		end
	end

	return
end

function var_0_1.Show(arg_5_0, arg_5_1)
	assert = var_1_10002

	var_1_10002(arg_5_1:isChargeType())
	var_0_1.super.Show(arg_5_0)

	arg_5_0.chargeCommodity = arg_5_1

	if not var_0_2(arg_5_1) then
		arg_5_0:Hide()

		return
	end

	seriesAsync = var_3

	var_3({
		function(arg_6_0)
			local var_6_0 = arg_5_0

			var_1.LoadWindow(var_6_0, var_0, arg_6_0)

			return
		end,
		function(arg_7_0)
			local var_7_0 = arg_5_0

			var_1.UpdateWindow(var_7_0, var_0, arg_7_0)

			return
		end
	}, function()
		local var_8_0 = arg_5_0

		var_0.RegisterEvent(var_8_0)

		return
	end)

	pg = var_3

	local var_5_0 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_5_0, arg_5_0._tf)

	return
end

function var_0_1.LoadWindow(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0.window[arg_9_1] then
		arg_9_2()

		return
	end

	ResourceMgr = var_1_10004

	local var_9_0 = var_1_10004.Inst
	local var_9_1 = var_4.getAssetAsync
	local var_9_2 = "ui/" .. arg_9_1 .. "TipWindow"
	local var_9_3 = ""

	UnityEngine = var_8

	var_9_1(var_9_0, var_9_2, var_9_3, var_8.Events.UnityAction_UnityEngine_Object(function(arg_10_0)
		local var_10_0 = arg_9_0.window
		local var_10_1 = arg_9_1

		Object = var_2_10003
		var_10_0[var_10_1] = var_2_10003.Instantiate(arg_10_0, arg_9_0.container).transform

		arg_9_2()

		return
	end), true, true)

	return
end

function var_0_1.UpdateWindow(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.window[arg_11_1]

	setActive = var_1_10004

	var_1_10004(var_11_0, true)

	if arg_11_0["Update" .. arg_11_1] then
		var_4(arg_11_0, var_11_0)
	end

	arg_11_2()

	return
end

local function var_0_3(arg_12_0, arg_12_1)
	UIItemList = var_1_10002

	local var_12_0 = var_1_10002.New(arg_12_0:Find("awards"), arg_12_0:Find("awards/award"))

	var_2.make(var_12_0, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventUpdate then
			local var_13_0 = arg_12_1[arg_13_1 + 1]
			local var_13_1 = {
				type = var_13_0[1],
				id = var_13_0[2],
				count = var_13_0[3]
			}

			updateDrop = var_5

			var_5(arg_13_2, var_13_1)
		end

		return
	end)
	var_2:align(#arg_12_1)

	return
end

function var_0_1.UpdateMonthCard(arg_14_0, arg_14_1)
	setText = var_1_10002

	local var_14_0 = arg_14_1
	local var_14_1 = arg_14_1.Find(var_14_0, "title/label/txt")

	i18n = var_14_0

	var_1_10002(var_14_1, var_14_0("chargetip_monthcard_1"))

	local var_14_2 = arg_14_0.chargeCommodity
	local var_14_3 = var_2.getConfig(var_14_2, "gem")
	local var_14_4 = arg_14_0.chargeCommodity
	local var_14_5 = var_14_3 + var_3.getConfig(var_14_4, "extra_gem")

	setText = var_3

	var_3(arg_14_1:Find("title/Text"), "X" .. var_14_5)

	setText = var_3

	local var_14_6 = arg_14_1
	local var_14_7 = arg_14_1.Find(var_14_6, "sub_title")

	i18n = var_14_6

	var_3(var_14_7, var_14_6("chargetip_monthcard_2"))

	local var_14_8 = arg_14_0.chargeCommodity
	local var_14_9 = var_3.getConfig(var_14_8, "display")

	var_0_3(arg_14_1, var_14_9)

	setAnchoredPosition = var_4

	var_4(arg_14_0.confirmBtn, {
		y = -540
	})

	return
end

function var_0_1.UpdateGiftPackage(arg_15_0, arg_15_1)
	setText = var_1_10002

	local var_15_0 = arg_15_1
	local var_15_1 = arg_15_1.Find(var_15_0, "title")

	i18n = var_15_0

	var_1_10002(var_15_1, var_15_0("chargetip_giftpackage"))

	local var_15_2 = arg_15_0.chargeCommodity
	local var_15_3 = var_2.GetDropItem(var_15_2)

	UIItemList = var_15_2

	local var_15_4 = var_15_2.New(arg_15_1:Find("list/content"), arg_15_1:Find("list/content/award"))

	var_3.make(var_15_4, function(arg_16_0, arg_16_1, arg_16_2)
		UIItemList = var_2_10003

		if arg_16_0 == var_2_10003.EventUpdate then
			local var_16_0 = var_15_3[arg_16_1 + 1]
			local var_16_1 = {
				type = var_16_0[1],
				id = var_16_0[2],
				count = var_16_0[3]
			}

			updateDrop = var_5

			var_5(arg_16_2, var_16_1)
		end

		return
	end)
	var_3:align(#var_15_3)

	setActive = var_4

	var_4(arg_15_1:Find("icon"), false)

	setAnchoredPosition = var_4

	var_4(arg_15_0.confirmBtn, {
		y = -550
	})

	return
end

function var_0_1.UpdateCrusing(arg_17_0, arg_17_1)
	setText = var_1_10002

	local var_17_0 = arg_17_1
	local var_17_1 = arg_17_1.Find(var_17_0, "title")

	i18n = var_17_0

	var_1_10002(var_17_1, var_17_0("chargetip_crusing"))

	setText = var_1_10002

	local var_17_2 = arg_17_1
	local var_17_3 = arg_17_1.Find(var_17_2, "sub_title")

	i18n = var_17_2

	var_1_10002(var_17_3, var_17_2("charge_tip_crusing_label"))

	local var_17_4 = arg_17_0.chargeCommodity
	local var_17_5 = var_2.getConfig(var_17_4, "display")

	var_0_3(arg_17_1, var_17_5)

	setAnchoredPosition = var_3

	var_3(arg_17_0.confirmBtn, {
		y = -550
	})

	return
end

function var_0_1.RegisterEvent(arg_18_0)
	onButton = var_1_10001

	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0._tf

	local function var_18_2()
		local var_19_0 = arg_18_0

		var_0.Hide(var_19_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_18_0, var_18_1, var_18_2, var_1_10005)

	onButton = var_1_10001

	local var_18_3 = arg_18_0
	local var_18_4 = arg_18_0.closeBtn

	local function var_18_5()
		local var_20_0 = arg_18_0

		var_0.Hide(var_20_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_18_3, var_18_4, var_18_5, var_1_10005)

	onButton = var_1_10001

	local var_18_6 = arg_18_0
	local var_18_7 = arg_18_0.confirmBtn

	local function var_18_8()
		local var_21_0 = arg_18_0

		var_0.Hide(var_21_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_18_6, var_18_7, var_18_8, var_1_10005)

	return
end

function var_0_1.Hide(arg_22_0)
	var_0_1.super.Hide(arg_22_0)

	removeOnButton = var_1

	var_1(arg_22_0._tf)

	removeOnButton = var_1

	var_1(arg_22_0.closeBtn)

	removeOnButton = var_1

	var_1(arg_22_0.confirmBtn)

	pairs = var_1

	for iter_22_0, iter_22_1 in var_1(arg_22_0.window) do
		IsNil = var_1_10006

		if not var_1_10006(iter_22_1) then
			setActive = var_1_10006

			var_1_10006(iter_22_1, false)
		end
	end

	pg = var_1

	local var_22_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_22_0, arg_22_0._tf, arg_22_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_23_0)
	if arg_23_0:isShowing() then
		arg_23_0:Hide()
	end

	pairs = var_1

	for iter_23_0, iter_23_1 in var_1(arg_23_0.window) do
		IsNil = var_1_10006

		if not var_1_10006(iter_23_1) then
			Object = var_1_10006

			var_1_10006.Destroy(iter_23_1.gameObject)
		end
	end

	arg_23_0.window = {}

	return
end

return var_0_1
