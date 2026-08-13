class = var_0_10000

local var_0_0 = "SkinCouponMultiMsgBox"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.shops.skinShop.SkinCouponMsgBox"))
local var_0_2 = 0
local var_0_3 = 1

function var_0_1.getUIName(arg_1_0)
	return "SkinVoucherMsgBoxUI"
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

	setActive = var_1

	var_1(arg_2_0.confirmBtn, false)

	local var_2_16 = arg_2_0._tf

	arg_2_0.realPriceBtn = var_1.Find(var_2_16, "window/button_container/real_price")

	local var_2_17 = arg_2_0._tf

	arg_2_0.discountPriceBtn = var_1.Find(var_2_17, "window/button_container/discount_price")
	setText = var_1

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_2.Find(var_2_18, "window/top/bg/infomation/title")

	i18n = var_2_18

	var_1(var_2_19, var_2_18("title_info"))

	local var_2_20 = arg_2_0._tf

	arg_2_0.nonUseBtn = var_1.Find(var_2_20, "window/frame/option/nonuse")

	local var_2_21 = arg_2_0._tf

	arg_2_0.useBtn = var_1.Find(var_2_21, "window/frame/option/use")

	local var_2_22 = arg_2_0._tf

	arg_2_0.scrollrect = var_1.Find(var_2_22, "window/frame/scrollrect")

	local var_2_23 = arg_2_0._tf

	arg_2_0.optionTr = var_1.Find(var_2_23, "window/frame/option")

	local var_2_24 = arg_2_0._tf

	arg_2_0.switchBtn = var_1.Find(var_2_24, "window/frame/option/use/link")

	local var_2_25 = arg_2_0._tf

	arg_2_0.tipBar = var_1.Find(var_2_25, "window/frame/tipBar")

	local var_2_26 = arg_2_0.tipBar

	arg_2_0.tipText = var_1.Find(var_2_26, "Text")

	local var_2_27 = arg_2_0._tf
	local var_2_28 = var_1.Find(var_2_27, "window/frame/option/use/link/Text")
	local var_2_29 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.linkText = var_2_29(var_2_28, var_3(var_4))
	setText = var_1

	local var_2_30 = arg_2_0._tf
	local var_2_31 = var_2.Find(var_2_30, "window/frame/option/nonuse/Text")

	i18n = var_2_30

	var_1(var_2_31, var_2_30("skin_shop_nonuse_label"))

	setText = var_1

	local var_2_32 = arg_2_0._tf
	local var_2_33 = var_2.Find(var_2_32, "window/frame/option/use/Text")

	i18n = var_2_32

	var_1(var_2_33, var_2_32("skin_shop_use_label"))

	return
end

function var_0_1.RegisterBtn(arg_3_0, arg_3_1)
	onButton = var_1_10002

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.discountPriceBtn

	local function var_3_2()
		if not arg_3_0.prevSelected then
			return
		end

		if arg_3_1.onYes then
			arg_3_1.onYes(arg_3_0.prevSelected)
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
			arg_3_0.prevSelected = nil

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

			var_10_0.prevSelected = var_2.GetDefaultItem(var_10_1)

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
	local var_11_0

	if not arg_11_0.selectedItem then
		var_11_0 = arg_11_0.settings.itemList[1]
	end

	arg_11_0.selectedItem = var_11_0

	return arg_11_0.selectedItem
end

function var_0_1.UpdateContent(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.skinName
	local var_12_1 = arg_12_1.price

	if arg_12_0.prevSelected then
		local var_12_2 = arg_12_0.prevSelected.discount

		math = var_1_10005
		var_1_10005 = var_1_10005.max(0, var_12_1 - var_12_2)

		local var_12_3 = arg_12_0.label1

		i18n = var_7

		local var_12_4 = var_1_10005 > 0 and "skin_purchase_confirm" or "skin_purchase_over_price"
		local var_12_5 = arg_12_0.prevSelected.drop

		var_12_3.text = var_7(var_12_4, var_9.getName(var_12_5), var_1_10005, var_12_0)
	else
		local var_12_6 = arg_12_0.label1

		i18n = var_1_10005
		var_12_6.text = var_1_10005("charge_scene_buy_confirm", var_12_1, var_12_0)
	end

	arg_12_0:UpdateLink()
	arg_12_0:SetTipText(arg_12_1.skinId)

	return
end

function var_0_1.UpdateLink(arg_13_0)
	local var_13_0 = arg_13_0.linkText

	i18n = var_1_10002
	var_13_0.text = var_1_10002("skin_shop_discount_item_link", arg_13_0:GetDefaultItem().discount)

	return
end

function var_0_1.UpdateItem(arg_14_0, arg_14_1)
	arg_14_0.itemTrs = {}

	local var_14_0 = arg_14_1.itemList

	UIItemList = var_1_10003

	local var_14_1 = var_1_10003.StaticAlign
	local var_14_2 = arg_14_0._tf
	local var_14_3 = var_4.Find(var_14_2, "window/frame/scrollrect/list")
	local var_14_4 = arg_14_0._tf

	var_14_1(var_14_3, var_5.Find(var_14_4, "window/frame/left"), #var_14_0, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			local var_15_0 = arg_14_0

			var_3.FlushItem(var_15_0, var_14_0[arg_15_1 + 1], arg_15_2)
		end

		return
	end)

	return
end

function var_0_1.FlushItem(arg_16_0, arg_16_1, arg_16_2)
	updateDrop = var_1_10003

	var_1_10003(arg_16_2, arg_16_1.drop)

	setText = var_1_10003

	local var_16_0 = arg_16_2:Find("name_bg/Text")
	local var_16_1 = arg_16_1.drop

	var_1_10003(var_16_0, var_5.getName(var_16_1))

	onToggle = var_1_10003

	local var_16_2 = arg_16_0
	local var_16_3 = arg_16_2

	local function var_16_4(arg_17_0)
		if arg_17_0 then
			arg_16_0.selectedItem = arg_16_1
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10003(var_16_2, var_16_3, var_16_4, var_1_10007)

	arg_16_0.itemTrs[arg_16_1] = arg_16_2

	return
end

function var_0_1.ClearPrevSel(arg_18_0)
	arg_18_0.prevSelected = nil

	return
end

function var_0_1.Show(arg_19_0, arg_19_1)
	setActive = var_1_10002

	var_1_10002(arg_19_0._tf, true)

	arg_19_0.settings = arg_19_1

	arg_19_0:UpdateItem(arg_19_1)
	arg_19_0:RegisterBtn(arg_19_1)
	arg_19_0:UpdateContent(arg_19_1)
	arg_19_0:UpdateStyle(var_0_2)

	setActive = var_2

	var_2(arg_19_0.nonUseBtn, false)

	triggerToggle = var_2

	var_2(arg_19_0.useBtn, true)

	return
end

function var_0_1.UpdateStyle(arg_20_0, arg_20_1)
	setActive = var_1_10002

	var_1_10002(arg_20_0.label1, arg_20_1 == var_0_2)

	setActive = var_1_10002

	var_1_10002(arg_20_0.optionTr, arg_20_1 == var_0_2)

	setActive = var_1_10002

	var_1_10002(arg_20_0.realPriceBtn, arg_20_1 == var_0_2 and not arg_20_0.prevSelected)

	setActive = var_1_10002

	var_1_10002(arg_20_0.discountPriceBtn, arg_20_1 == var_0_2 and arg_20_0.prevSelected)

	setActive = var_1_10002

	var_1_10002(arg_20_0.confirmBtn, arg_20_1 == var_0_3)

	setActive = var_1_10002

	var_1_10002(arg_20_0.scrollrect, arg_20_1 == var_0_3)

	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.GetDefaultItem(var_20_0)

	triggerToggle = var_20_0

	var_20_0(arg_20_0.itemTrs[var_20_1], true)

	arg_20_0.style = arg_20_1

	return
end

function var_0_1.Hide(arg_21_0)
	arg_21_0.settings = nil
	arg_21_0.selectedItem = nil
	setActive = var_1

	var_1(arg_21_0._tf, false)
	arg_21_0:ClearPrevSel()

	pairs = var_1

	for iter_21_0, iter_21_1 in var_1(arg_21_0.itemTrs) do
		removeOnToggle = var_1_10006

		var_1_10006(iter_21_1)

		triggerToggle = var_1_10006

		var_1_10006(iter_21_1, false)
	end

	return
end

function var_0_1.SetTipText(arg_22_0, arg_22_1)
	pg = var_1_10002

	local var_22_0 = var_1_10002.ship_skin_template[arg_22_1].ship_group

	pg = var_1_10003

	local var_22_1 = var_1_10003.gameset.no_share_skin_tip.description
	local var_22_2
	local var_22_3

	ipairs = var_1_10006

	for iter_22_0, iter_22_1 in var_1_10006(var_22_1) do
		ipairs = var_1_10011

		for iter_22_2, iter_22_3 in var_1_10011(iter_22_1) do
			if var_22_0 == iter_22_3[1] then
				var_22_2 = iter_22_1
				var_22_3 = iter_22_2

				break
			end
		end
	end

	setActive = var_6

	var_6(arg_22_0.tipBar, var_22_3)

	if var_22_3 then
		local var_22_4 = ""

		ipairs = var_7

		for iter_22_4, iter_22_5 in var_7(var_22_2) do
			if iter_22_4 ~= var_22_3 then
				if var_22_4 == "" then
					i18n = var_1_10012
					var_22_4 = var_1_10012(iter_22_5[2])
				else
					var_1_10012 = var_22_4

					local var_22_5 = "、"

					i18n = iter_22_2
					var_22_4 = var_1_10012 .. var_22_5 .. iter_22_2(iter_22_5[2])
				end
			end
		end

		setText = var_7

		local var_22_6 = arg_22_0.tipText

		i18n = var_9

		local var_22_7 = "no_share_skin_gametip"

		i18n = iter_22_5

		var_7(var_22_6, var_9(var_22_7, iter_22_5(var_22_2[var_22_3][2]), var_22_4))
	end

	return
end

return var_0_1
