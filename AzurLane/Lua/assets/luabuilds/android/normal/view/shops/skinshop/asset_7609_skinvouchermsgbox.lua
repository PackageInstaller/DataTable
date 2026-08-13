class = var_0_10000

local var_0_0 = "SkinVoucherMsgBox"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SkinCouponMsgBox"))
local var_0_2 = 0
local var_0_3 = 1

function var_0_1.getUIName(arg_1_0)
	return "SkinVoucherMsgBoxUI"
end

function var_0_1.OnLoaded(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.OverlayPanel(var_2_0, arg_2_0._tf)

	local var_2_1 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_1, "window/top/btnBack")

	local var_2_2 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_2, "window/button_container/cancel")

	local var_2_3 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_3, "window/button_container/confirm")

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "window/frame/Text")
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.label1 = var_2_6(var_2_5, var_3(var_1_10004))

	local var_2_7 = arg_2_0._tf

	arg_2_0.leftItemTr = var_1.Find(var_2_7, "window/frame/left")

	local var_2_8 = arg_2_0.leftItemTr
	local var_2_9 = var_1.Find(var_2_8, "name_bg/Text")
	local var_2_10 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameTxt = var_2_10(var_2_9, var_3(var_1_10004))
	setText = var_1

	local var_2_11 = arg_2_0.cancelBtn
	local var_2_12 = var_2.Find(var_2_11, "pic")

	i18n = var_2_11

	var_1(var_2_12, var_2_11("msgbox_text_cancel"))

	setText = var_1

	local var_2_13 = arg_2_0.confirmBtn
	local var_2_14 = var_2.Find(var_2_13, "pic")

	i18n = var_2_13

	var_1(var_2_14, var_2_13("msgbox_text_confirm"))

	setText = var_1

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_2.Find(var_2_15, "window/top/bg/infomation/title")

	i18n = var_2_15

	var_1(var_2_16, var_2_15("words_information"))

	setActive = var_1

	var_1(arg_2_0.confirmBtn, false)

	local var_2_17 = arg_2_0._tf

	arg_2_0.realPriceBtn = var_1.Find(var_2_17, "window/button_container/real_price")

	local var_2_18 = arg_2_0._tf

	arg_2_0.discountPriceBtn = var_1.Find(var_2_18, "window/button_container/discount_price")
	setText = var_1

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_2.Find(var_2_19, "window/top/bg/infomation/title")

	i18n = var_2_19

	var_1(var_2_20, var_2_19("title_info"))

	local var_2_21 = arg_2_0._tf

	arg_2_0.nonUseBtn = var_1.Find(var_2_21, "window/frame/option/nonuse")

	local var_2_22 = arg_2_0._tf

	arg_2_0.useBtn = var_1.Find(var_2_22, "window/frame/option/use")

	local var_2_23 = arg_2_0._tf

	arg_2_0.scrollrect = var_1.Find(var_2_23, "window/frame/scrollrect")

	local var_2_24 = arg_2_0._tf

	arg_2_0.optionTr = var_1.Find(var_2_24, "window/frame/option")

	local var_2_25 = arg_2_0._tf

	arg_2_0.switchBtn = var_1.Find(var_2_25, "window/frame/option/use/link")

	local var_2_26 = arg_2_0._tf

	arg_2_0.tipBar = var_1.Find(var_2_26, "window/frame/tipBar")

	local var_2_27 = arg_2_0.tipBar

	arg_2_0.tipText = var_1.Find(var_2_27, "Text")

	local var_2_28 = arg_2_0._tf
	local var_2_29 = var_1.Find(var_2_28, "window/frame/option/use/link/Text")
	local var_2_30 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.linkText = var_2_30(var_2_29, var_3(var_4))
	setText = var_1

	local var_2_31 = arg_2_0._tf
	local var_2_32 = var_2.Find(var_2_31, "window/frame/option/nonuse/Text")

	i18n = var_2_31

	var_1(var_2_32, var_2_31("skin_shop_nonuse_label"))

	setText = var_1

	local var_2_33 = arg_2_0._tf
	local var_2_34 = var_2.Find(var_2_33, "window/frame/option/use/Text")

	i18n = var_2_33

	var_1(var_2_34, var_2_33("skin_shop_use_label"))

	return
end

function var_0_1.RegisterBtn(arg_3_0, arg_3_1)
	onButton = var_1_10002

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.discountPriceBtn

	local function var_3_2()
		if not arg_3_0.prevSelId then
			return
		end

		if arg_3_1.onYes then
			arg_3_1.onYes(arg_3_0.prevSelId)
		end

		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10002

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.realPriceBtn

	local function var_3_5()
		if arg_3_1.onYes then
			arg_3_1.onYes()
		end

		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10002

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.switchBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.UpdateStyle(var_6_0, 1 - arg_3_0.style)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1_10002

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.confirmBtn

	local function var_3_11()
		local var_7_0 = arg_3_0

		var_0.UpdateStyle(var_7_0, 1 - arg_3_0.style)

		triggerToggle = var_0

		var_0(arg_3_0.useBtn, true)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_3_9, var_3_10, var_3_11, var_1_10006)

	onButton = var_1_10002

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.cancelBtn

	local function var_3_14()
		if arg_3_0.style == var_0_3 then
			local var_8_0 = arg_3_0

			var_0.UpdateStyle(var_8_0, 1 - arg_3_0.style)
		else
			local var_8_1 = arg_3_0

			var_0.Hide(var_8_1)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_3_12, var_3_13, var_3_14, var_1_10006)

	onToggle = var_1_10002

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.nonUseBtn

	local function var_3_17(arg_9_0)
		if arg_9_0 then
			arg_3_0.prevSelId = nil

			local var_9_0 = arg_3_0

			var_1.UpdateContent(var_9_0, arg_3_0.settings)

			local var_9_1 = arg_3_0

			var_1.UpdateStyle(var_9_1, arg_3_0.style)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_3_15, var_3_16, var_3_17, var_1_10006)

	onToggle = var_1_10002

	local var_3_18 = arg_3_0
	local var_3_19 = arg_3_0.useBtn

	local function var_3_20(arg_10_0)
		if arg_10_0 then
			local var_10_0 = arg_3_0
			local var_10_1 = arg_3_0

			var_10_0.prevSelId = var_2.GetDefaultItem(var_10_1)

			local var_10_2 = arg_3_0

			var_1.UpdateContent(var_10_2, arg_3_0.settings)

			local var_10_3 = arg_3_0

			var_1.UpdateStyle(var_10_3, arg_3_0.style)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_3_18, var_3_19, var_3_20, var_1_10006)

	return
end

function var_0_1.GetDefaultItem(arg_11_0)
	local function var_11_0()
		_ = var_2_10000

		if #var_2_10000.map(arg_11_0.settings.itemList, function(arg_13_0)
			pg = var_3_10001

			local var_13_0

			if not var_3_10001.item_data_statistics[arg_13_0].usage_arg[2] then
				var_13_0 = 0
			end

			local var_13_1 = {
				gem = var_13_0,
				id = arg_13_0
			}

			pg = var_3_10003
			var_13_1.time = var_3_10003.item_data_statistics[arg_13_0].time_limit

			return var_13_1
		end) == 0 then
			return nil
		end

		table = var_1

		var_1.sort(var_0, function(arg_14_0, arg_14_1)
			if arg_14_0.time ~= arg_14_1.time then
				return arg_14_0.time > arg_14_1.time
			else
				return arg_14_0.gem > arg_14_1.gem
			end

			return
		end)

		return var_0[1].id
	end

	local var_11_1

	if not arg_11_0.selectedItemId then
		var_11_1 = var_11_0()
	end

	arg_11_0.selectedItemId = var_11_1

	return arg_11_0.selectedItemId
end

function var_0_1.UpdateContent(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.skinName
	local var_15_1 = arg_15_1.price

	if arg_15_0.prevSelId then
		pg = var_4
		var_1_10005 = var_4.item_data_statistics[arg_15_0.prevSelId].usage_arg[2]
		math = var_1_10006

		local var_15_2 = var_1_10006.max(0, var_15_1 - var_1_10005)
		local var_15_3 = arg_15_0.label1

		i18n = var_8
		var_15_3.text = var_8(var_15_2 > 0 and "skin_purchase_confirm" or "skin_purchase_over_price", var_4.name, var_15_2, var_15_0)
	else
		local var_15_4 = arg_15_0.label1

		i18n = var_1_10005
		var_15_4.text = var_1_10005("charge_scene_buy_confirm", var_15_1, var_15_0)
	end

	arg_15_0:UpdateLink()
	arg_15_0:SetTipText(arg_15_1.skinId)

	return
end

function var_0_1.UpdateLink(arg_16_0)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.GetDefaultItem(var_16_0)

	pg = var_16_0

	local var_16_2

	if not var_16_0.item_data_statistics[var_16_1].usage_arg[2] then
		var_16_2 = 0
	end

	local var_16_3 = arg_16_0.linkText

	i18n = var_1_10004
	var_16_3.text = var_1_10004("skin_shop_discount_item_link", var_16_2)

	return
end

function var_0_1.UpdateItem(arg_17_0, arg_17_1)
	arg_17_0.itemTrs = {}

	local var_17_0 = arg_17_1.itemList

	UIItemList = var_1_10003

	local var_17_1 = var_1_10003.StaticAlign
	local var_17_2 = arg_17_0._tf
	local var_17_3 = var_4.Find(var_17_2, "window/frame/scrollrect/list")
	local var_17_4 = arg_17_0._tf

	var_17_1(var_17_3, var_5.Find(var_17_4, "window/frame/left"), #var_17_0, function(arg_18_0, arg_18_1, arg_18_2)
		UIItemList = var_2_10003

		if arg_18_0 == var_2_10003.EventUpdate then
			local var_18_0 = arg_17_0

			var_3.FlushItem(var_18_0, var_17_0[arg_18_1 + 1], arg_18_2)
		end

		return
	end)

	return
end

function var_0_1.FlushItem(arg_19_0, arg_19_1, arg_19_2)
	updateDrop = var_1_10003

	local var_19_0 = arg_19_2
	local var_19_1 = {
		count = 1
	}

	DROP_TYPE_ITEM = var_1_10006
	var_19_1.type = var_1_10006
	var_19_1.id = arg_19_1

	var_1_10003(var_19_0, var_19_1)

	pg = var_1_10003

	local var_19_2 = var_1_10003.item_data_statistics[arg_19_1].name

	setText = var_19_0

	var_19_0(arg_19_2:Find("name_bg/Text"), var_19_2)

	onToggle = var_19_0

	local var_19_3 = arg_19_0
	local var_19_4 = arg_19_2

	local function var_19_5(arg_20_0)
		if arg_20_0 then
			arg_19_0.selectedItemId = arg_19_1
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_19_0(var_19_3, var_19_4, var_19_5, var_1_10008)

	arg_19_0.itemTrs[arg_19_1] = arg_19_2

	return
end

function var_0_1.ClearPrevSel(arg_21_0)
	arg_21_0.prevSelId = nil

	return
end

function var_0_1.Show(arg_22_0, arg_22_1)
	setActive = var_1_10002

	var_1_10002(arg_22_0._tf, true)

	arg_22_0.settings = arg_22_1

	arg_22_0:UpdateItem(arg_22_1)
	arg_22_0:RegisterBtn(arg_22_1)
	arg_22_0:UpdateContent(arg_22_1)
	arg_22_0:UpdateStyle(var_0_2)

	triggerToggle = var_2

	var_2(arg_22_0.useBtn, true)

	return
end

function var_0_1.UpdateStyle(arg_23_0, arg_23_1)
	setActive = var_1_10002

	var_1_10002(arg_23_0.label1, arg_23_1 == var_0_2)

	setActive = var_1_10002

	var_1_10002(arg_23_0.optionTr, arg_23_1 == var_0_2)

	setActive = var_1_10002

	var_1_10002(arg_23_0.realPriceBtn, arg_23_1 == var_0_2 and not arg_23_0.prevSelId)

	setActive = var_1_10002

	var_1_10002(arg_23_0.discountPriceBtn, arg_23_1 == var_0_2 and arg_23_0.prevSelId)

	setActive = var_1_10002

	var_1_10002(arg_23_0.confirmBtn, arg_23_1 == var_0_3)

	setActive = var_1_10002

	var_1_10002(arg_23_0.scrollrect, arg_23_1 == var_0_3)

	local var_23_0 = arg_23_0
	local var_23_1 = arg_23_0.GetDefaultItem(var_23_0)

	triggerToggle = var_23_0

	var_23_0(arg_23_0.itemTrs[var_23_1], true)

	arg_23_0.style = arg_23_1

	return
end

function var_0_1.Hide(arg_24_0)
	arg_24_0.settings = nil
	arg_24_0.selectedItemId = nil
	setActive = var_1

	var_1(arg_24_0._tf, false)
	arg_24_0:ClearPrevSel()

	pairs = var_1

	for iter_24_0, iter_24_1 in var_1(arg_24_0.itemTrs) do
		removeOnToggle = var_1_10006

		var_1_10006(iter_24_1)

		triggerToggle = var_1_10006

		var_1_10006(iter_24_1, false)
	end

	return
end

function var_0_1.SetTipText(arg_25_0, arg_25_1)
	pg = var_1_10002

	local var_25_0 = var_1_10002.ship_skin_template[arg_25_1].ship_group

	pg = var_1_10003

	local var_25_1 = var_1_10003.gameset.no_share_skin_tip.description
	local var_25_2
	local var_25_3

	ipairs = var_1_10006

	for iter_25_0, iter_25_1 in var_1_10006(var_25_1) do
		ipairs = var_1_10011

		for iter_25_2, iter_25_3 in var_1_10011(iter_25_1) do
			if var_25_0 == iter_25_3[1] then
				var_25_2 = iter_25_1
				var_25_3 = iter_25_2

				break
			end
		end
	end

	setActive = var_6

	var_6(arg_25_0.tipBar, var_25_3)

	if var_25_3 then
		local var_25_4 = ""

		ipairs = var_7

		for iter_25_4, iter_25_5 in var_7(var_25_2) do
			if iter_25_4 ~= var_25_3 then
				if var_25_4 == "" then
					i18n = var_1_10012
					var_25_4 = var_1_10012(iter_25_5[2])
				else
					var_1_10012 = var_25_4

					local var_25_5 = "、"

					i18n = iter_25_2
					var_25_4 = var_1_10012 .. var_25_5 .. iter_25_2(iter_25_5[2])
				end
			end
		end

		setText = var_7

		local var_25_6 = arg_25_0.tipText

		i18n = var_9

		local var_25_7 = "no_share_skin_gametip"

		i18n = iter_25_5

		var_7(var_25_6, var_9(var_25_7, iter_25_5(var_25_2[var_25_3][2]), var_25_4))
	end

	return
end

function var_0_1.OnDestroy(arg_26_0)
	local var_26_0 = arg_26_0.super

	var_1.OnDestroy(var_26_0)

	pg = var_1

	local var_26_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_26_1, arg_26_0._tf)

	return
end

return var_0_1
