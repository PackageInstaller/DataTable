class = var_0_10000

local var_0_0 = "NewSkinShopPurchaseView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "NewSkinShopPurchaseUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_0, "frame/cancel")

	local var_2_1 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_1, "frame/confirm")

	local var_2_2 = arg_2_0._tf

	arg_2_0.toggle = var_1.Find(var_2_2, "frame")

	local var_2_3 = arg_2_0._tf

	arg_2_0.title = var_1.Find(var_2_3, "frame/title")

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "frame/bg/Text")
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.text = var_2_6(var_2_5, var_3(var_1_10004))

	local var_2_7 = arg_2_0._tf

	arg_2_0.tipText = var_1.Find(var_2_7, "frame/bg/tipText")

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "frame/gift_bg/Text")
	local var_2_10 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.textWithGift = var_2_10(var_2_9, var_3(var_1_10004))
	UIItemList = var_1

	local var_2_11 = var_1.New
	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_2.Find(var_2_12, "frame/gift_bg/gift/drops")
	local var_2_14 = arg_2_0._tf

	arg_2_0.dropsList = var_2_11(var_2_13, var_3.Find(var_2_14, "frame/gift_bg/gift/drops/item"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.cancelBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.confirmBtn

	local function var_3_8()
		if arg_3_0.commodity then
			local var_6_0 = arg_3_0
			local var_6_1 = var_0.emit

			NewSkinShopMainView = var_2_10002

			var_6_1(var_6_0, var_2_10002.EVT_ON_PURCHASE, arg_3_0.commodity)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	var_0_1.super.Show(arg_7_0)

	arg_7_0.commodity = arg_7_1

	arg_7_0:Flush(arg_7_1)

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.emit

	NewSkinShopMainView = var_4

	var_7_1(var_7_0, var_4.EVT_SHOW_OR_HIDE_PURCHASE_VIEW, true)

	return
end

function var_0_1.GetText(arg_8_0, arg_8_1)
	local var_8_0

	if not arg_8_1 or not arg_8_0.textWithGift then
		var_8_0 = arg_8_0.text
	end

	return var_8_0
end

function var_0_1.Flush(arg_9_0, arg_9_1)
	local var_9_0 = #arg_9_1:GetGiftList()
	local var_9_1 = 0 < var_9_0

	triggerToggle = var_4

	var_4(arg_9_0.toggle, var_9_1)

	local var_9_2 = arg_9_0
	local var_9_3 = arg_9_0.GetText(var_9_2, var_9_1)

	setAnchoredPosition = var_9_2

	var_9_2(arg_9_0.title, {
		y = var_9_1 and 460 or 401
	})

	local var_9_4 = arg_9_1
	local var_9_5 = arg_9_1.GetPrice(var_9_4)

	pg = var_9_4

	local var_9_6 = var_9_4.ship_skin_template
	local var_9_7 = arg_9_1
	local var_9_8 = var_9_6[arg_9_1.getSkinId(var_9_7)].name

	getProxy = var_7
	PlayerProxy = var_9_7

	local var_9_9 = var_7(var_9_7)
	local var_9_10 = var_7.getRawData(var_9_9)

	if var_9_5 <= var_7.getChargeGem(var_9_10) then
		COLOR_GREEN = var_9_10

		if not var_9_10 then
			COLOR_RED = var_9_10
		end

		i18n = var_1_10009
		var_9_3.text = var_1_10009("skin_shop_buy_confirm", var_9_10, var_9_5, var_9_8)

		arg_9_0:SetTipText(arg_9_1:getSkinId())
		arg_9_0:FlushGift(var_2)

		return
	end
end

function var_0_1.FlushGift(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.dropsList

	var_2.make(var_10_0, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = arg_10_1[arg_11_1 + 1]
			local var_11_1 = {
				type = var_11_0.type,
				id = var_11_0.id,
				count = var_11_0.count
			}

			updateDrop = var_5

			var_5(arg_11_2, var_11_1)

			onButton = var_5

			local var_11_2 = arg_10_0
			local var_11_3 = arg_11_2

			local function var_11_4()
				local var_12_0 = arg_10_0
				local var_12_1 = var_0.emit

				BaseUI = var_3_10002

				var_12_1(var_12_0, var_3_10002.ON_DROP, var_11_1)

				return
			end

			SFX_PANEL = var_2_10009

			var_5(var_11_2, var_11_3, var_11_4, var_2_10009)
		end

		return
	end)

	local var_10_1 = arg_10_0.dropsList

	var_2.align(var_10_1, #arg_10_1)

	return
end

function var_0_1.SetTipText(arg_13_0, arg_13_1)
	pg = var_1_10002

	local var_13_0 = var_1_10002.ship_skin_template[arg_13_1].ship_group

	pg = var_1_10003

	local var_13_1 = var_1_10003.gameset.no_share_skin_tip.description
	local var_13_2
	local var_13_3

	ipairs = var_1_10006

	for iter_13_0, iter_13_1 in var_1_10006(var_13_1) do
		ipairs = var_1_10011

		for iter_13_2, iter_13_3 in var_1_10011(iter_13_1) do
			if var_13_0 == iter_13_3[1] then
				var_13_2 = iter_13_1
				var_13_3 = iter_13_2

				break
			end
		end
	end

	setActive = var_6

	var_6(arg_13_0.tipText, var_13_3)

	if var_13_3 then
		local var_13_4 = ""

		ipairs = var_7

		for iter_13_4, iter_13_5 in var_7(var_13_2) do
			if iter_13_4 ~= var_13_3 then
				if var_13_4 == "" then
					i18n = var_1_10012
					var_13_4 = var_1_10012(iter_13_5[2])
				else
					var_1_10012 = var_13_4

					local var_13_5 = "、"

					i18n = iter_13_2
					var_13_4 = var_1_10012 .. var_13_5 .. iter_13_2(iter_13_5[2])
				end
			end
		end

		setText = var_7

		local var_13_6 = arg_13_0.tipText

		i18n = var_9

		local var_13_7 = "no_share_skin_gametip"

		i18n = iter_13_5

		var_7(var_13_6, var_9(var_13_7, iter_13_5(var_13_2[var_13_3][2]), var_13_4))
	end

	return
end

function var_0_1.Hide(arg_14_0)
	var_0_1.super.Hide(arg_14_0)

	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.emit

	NewSkinShopMainView = var_1_10003

	var_14_1(var_14_0, var_1_10003.EVT_SHOW_OR_HIDE_PURCHASE_VIEW, false)

	arg_14_0.commodity = nil

	return
end

function var_0_1.OnDestroy(arg_15_0)
	return
end

return var_0_1
